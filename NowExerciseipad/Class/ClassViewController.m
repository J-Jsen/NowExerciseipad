//
//  ClassViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "ClassViewController.h"
#import "ClassModel.h"
#import "ClassCell.h"
#import "FenLeiButton.h"
#import "FenleiView.h"

#import "CustomButton.h"

@interface ClassViewController ()<UITableViewDelegate,UITableViewDataSource,FenLeidelegate>

@property (nonatomic , strong) UIView * Backgroundview;
@property (nonatomic , strong) UIView * HeaderView;
@property (nonatomic , strong) FenleiView * fenleiV;

@property (nonatomic , strong) UITableView * tableV;

@property (nonatomic , strong) ClassCell * lastcell;
@property (nonatomic , strong) NSIndexPath * lastindexpath;

@property (nonatomic , strong) UITextView * TextV;


Arrayproperty(daraArr)
Arrayproperty(FenLeiArr)
Arrayproperty(deleteFenleiArr)
@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    //菜单栏出现消失通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menunoti:) name:@"xuanxiang" object:nil];

    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    _daraArr = [NSMutableArray array];
    self.view.layer.masksToBounds = YES;
    _deleteFenleiArr = [NSMutableArray array];
    [self createUI];
    [self createRect];
    [self loadData];

    
    // Do any additional setup after loading the view.
}
- (void)loadData{
    NSString * url = [NSString stringWithFormat:@"%@pad/?method=coach.my_training",BASEURL];
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        if (data && [dic[@"rc"] integerValue] == 0) {
            NSLog(@"data:%@",data);
            
            NSArray * datarr = dic[@"data"];
            
            for (NSDictionary * dic in datarr) {
                ClassModel * model = [[ClassModel alloc]init];
                model.icon = [dic valueForKey:@"icon"];
                model.train_type = [dic valueForKey:@"train_type"];
                model.plan = [dic valueForKey:@"plan"];
                NSLog(@"%@",model.icon);
                [_daraArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableV reloadData];
            });
        }else if(dic[@"msg"]){
            [HttpRequest showAlertCatController:self andmessage:dic[@"msg"]];
        }
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlertCatController:self andmessage:@"网络错误"];
    }];

}
- (void)createUI{
    _Backgroundview = [[UIView alloc]init];
    _Backgroundview.backgroundColor = WINDOW_backgroundColor;
    _Backgroundview.layer.cornerRadius = 5;
    _Backgroundview.layer.masksToBounds = YES;
    _Backgroundview.layer.borderWidth = 1;
    _Backgroundview.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_Backgroundview];

    _tableV = [[UITableView alloc]init];
    _tableV.dataSource = self;
    _tableV.delegate = self;
    _tableV.bounces = NO;

    _tableV.layer.borderWidth = 1;
    _tableV.layer.borderColor = LEFTBTN_BACKGROUNDCOLOR.CGColor;
    [_tableV setSeparatorColor:[UIColor clearColor]];
    
    _tableV.backgroundColor = WINDOW_backgroundColor;
    [_Backgroundview addSubview:_tableV];
    [_tableV registerClass:[ClassCell class] forCellReuseIdentifier:@"classID"];
    
    
    _HeaderView = [[UIView alloc]init];
//    _HeaderView.layer.borderWidth = 1;
//    _HeaderView.layer.borderColor = [UIColor grayColor].CGColor;
//    _HeaderView.layer.cornerRadius = 10;
//    _HeaderView.layer.masksToBounds = YES;
    [_Backgroundview addSubview:_HeaderView];
    
    _TextV = [[UITextView alloc]init];
    _TextV.backgroundColor = WINDOW_backgroundColor;
    _TextV.textColor = [UIColor whiteColor];
    _TextV.font = [UIFont fontWithName:@"American Typewriter" size:27.0];
//    NSArray * family = [UIFont familyNames];
    _TextV.scrollEnabled = YES;
    _TextV.editable = NO;
//    _TextV.layer.cornerRadius = 5;
//    _TextV.layer.masksToBounds = YES;
//    _TextV.layer.borderWidth = 1;
//    _TextV.layer.borderColor = [UIColor grayColor].CGColor;
    [_Backgroundview addSubview:_TextV];
    
    
}
- (void)createHeaderUIWith:(ClassModel *)model{
    [_HeaderView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_deleteFenleiArr removeAllObjects];
    NSArray * arr = model.plan;
    for (int i = 0; i < arr.count; i ++) {
        if (arr.count == 1) {
            CustomButton * btn = [[CustomButton alloc]init];
//WithFrame:CGRectMake((CGRectGetWidth(_HeaderView.frame) -100) / 2.0 , 5, 100, 40)];
            [btn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = [[arr[i] valueForKey:@"id"] intValue] + 200;
            [btn setTitle:[arr[i] valueForKey:@"plan_name"] forState:UIControlStateNormal];
//            btn.layer.cornerRadius = 10;
//            btn.layer.masksToBounds = YES;
//            btn.layer.borderWidth = 1;
//            btn.layer.borderColor = [UIColor grayColor].CGColor;
            [btn setTitleColor:WENDA_COLOR forState:UIControlStateNormal];
            [_HeaderView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(40);
                make.top.offset(15);
            }];
            [_deleteFenleiArr addObject:btn];
        }else{
            
            CustomButton * btn = [[CustomButton alloc]init];
//WithFrame:CGRectMake((CGRectGetWidth(_HeaderView.frame) - arr.count * 100)  / (arr.count +1) * (i +1) + 100 * i, 15, 100, 40)];
            
            [btn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = [[arr[i] valueForKey:@"id"] intValue] + 200;
            [btn setTitle:[arr[i] valueForKey:@"plan_name"] forState:UIControlStateNormal];
//            btn.layer.cornerRadius = 10;
//            btn.layer.masksToBounds = YES;
//            btn.layer.borderWidth = 1;
//            btn.layer.borderColor = [UIColor grayColor].CGColor;
            [btn setTitleColor:WENDA_COLOR forState:UIControlStateNormal];

            [_HeaderView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(40);
                make.top.offset(15);
//                NSLog(@"减去的长度为:%f",(CGRectGetWidth(_HeaderView.frame) / (float)[arr count] - 100) / 2.0);
                make.right.offset(-(CGRectGetWidth(_HeaderView.frame) / (float)[arr count] - 100) / 2.0).multipliedBy((i+1) / (float)[arr count]);
            }];
            [_deleteFenleiArr addObject:btn];
            
        }
    }

}
- (void)createRect{
    if (ISSHUPING) {
        if (_islook) {
            [_Backgroundview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L /3.0);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
            }];
            
        }else{
            [_Backgroundview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);

            }];
        }
        
    }else if(ISHENGPING){
        if (_islook) {
            [_Backgroundview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);

            }];
            
            
        }else{
            [_Backgroundview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);

            }];
            
        }
        
    }
    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.offset(0);
        make.width.mas_equalTo(170.25 / 2.0);
        
    }];
    [_HeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.offset(0);
        make.left.mas_equalTo(_tableV.mas_right);
        make.height.mas_equalTo(50);
        
    }];
    [_TextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(70);
        make.left.offset(170.25/2.0);
        make.right.offset(0);
        make.bottom.offset(0);
        
    }];

}
#pragma mark 通知实现方法

- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{

    if (ISSHUPING) {
        
        if (_islook) {
            [_Backgroundview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L /3.0);
                make.height.mas_equalTo(UISCREEN_H - 84);
                
            }];
            [_HeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.and.right.offset(0);
                make.left.offset(170.25 / 2.0);
                make.height.mas_equalTo(50);
                
            }];
        }else{
            [_Backgroundview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
            }];
            [_HeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.and.right.offset(0);
                make.left.offset(170.25 / 2.0);
                make.height.mas_equalTo(50);
                
            }];
        }
        [self screenChangAnimated];
        [self reloadClassBtn];

    }else if(ISHENGPING){
        if (_islook) {
            [_Backgroundview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
                make.height.mas_equalTo(UISCREEN_H - 84);
            }];
            [_HeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.and.right.offset(0);
                make.left.offset(170.25 / 2.0);
                make.height.mas_equalTo(50);
                
            }];
        }else{
            [_Backgroundview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                
            }];
            [_HeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.and.right.offset(0);
                make.left.offset(170.25 / 2.0);
                make.height.mas_equalTo(50);
                
            }];
        }
        [self screenChangAnimated];
//        [self createHeaderUIWith:_daraArr[_lastindexpath.row]];
        [self reloadClassBtn];

    }
}

- (void)reloadClassBtn{
//    NSLog(@"%ld",_deleteFenleiArr.count);
    if (_deleteFenleiArr.count == 1) {
        
    }else{
    for (int i = 0; i < _deleteFenleiArr.count; i ++) {
        CustomButton * btn = _deleteFenleiArr[i];
        
        [btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(40);
            make.top.offset(15);
//            NSLog(@"减去的长度为:%f",(CGRectGetWidth(_HeaderView.frame) / (float)[_deleteFenleiArr count] - 100) / 2.0);
            make.right.offset(-(CGRectGetWidth(_HeaderView.frame) / (float)[_deleteFenleiArr count] - 100) / 2.0).multipliedBy((i+1) / (float)[_deleteFenleiArr count]);
        }];
    }
    }
}

- (void)menunoti:(NSNotification *)noti{
    
    NSString * Info = [noti.userInfo valueForKey:@"1"];
    
    if ([Info isEqualToString:@"出现"]) {
        
        _islook = YES;
        
        [self handleDeviceOrientationDidChange:[[UIApplication sharedApplication] statusBarOrientation]];
        
    }else if([Info isEqualToString:@"消失"]){
        
        _islook = NO;
        
        [self handleDeviceOrientationDidChange:[[UIApplication sharedApplication] statusBarOrientation]];
        
    }
    
    
}
#pragma mark 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _daraArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassCell * cell = [[ClassCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"classID"];
    if (_daraArr.count != 0) {
        ClassModel * model = _daraArr[indexPath.row];
        [cell creatCellWithClassModel:model];
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ClassCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (_lastcell && cell != _lastcell) {
        [_lastcell backColor];
        [_tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_lastindexpath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    _lastcell = cell;
    _lastindexpath = indexPath;
    [cell changeColor];
    
    [_HeaderView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self fenleiVdismiss];
    
    [self createHeaderUIWith:_daraArr[indexPath.row]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170.25 / 2.0;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)show:(CustomButton *)btn{
    if (!btn.selected) {
        if (_fenleiV) {
            [_fenleiV removeFromSuperview];
            for (CustomButton * btn1 in _deleteFenleiArr) {
                if (btn1 != btn) {
                    btn1.selected = NO;
                    [btn1 disselect];
                    [btn1 setTitleColor:WENDA_COLOR forState:UIControlStateNormal];
                }
                
            }
        }
        [btn select];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        NSString * url = [NSString stringWithFormat:@"%@pad/?method=coach.training&plan_id=%d",BASEURL,(int)(btn.tag - 200)];
        [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
            NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            
            if (data && [dic[@"rc"] integerValue] == 0) {

                dispatch_async(dispatch_get_main_queue(), ^{
                    _fenleiV = [[FenleiView alloc]init];
                    _fenleiV.delegate = self;
                    _fenleiV.layer.masksToBounds = YES;
#pragma mark 添加动画
                    CATransition *transition = [CATransition animation];
                    transition.duration = 0.3f;
                    transition.type = kCATransitionReveal;
                    transition.subtype = kCATransitionFromBottom;
                    [_Backgroundview addSubview:_fenleiV];

                    [_fenleiV.layer addAnimation:transition forKey:@"animation"];
                    
                    [_fenleiV createUIWithArr:dic[@"data"]];

                    [_fenleiV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(_HeaderView.mas_bottom).offset(10);
                        make.left.mas_equalTo(_tableV.mas_right);
                        make.right.and.bottom.offset(0);
                        
                    }];
                    
                });
            }else{
                
                [HttpRequest showAlertCatController:self andmessage:dic[@"msg"]];
                
                
            }
        } andfailBlock:^(NSError *error) {
            [HttpRequest showAlertCatController:self andmessage:@"服务器开小差了"];
        }];
        btn.selected = !btn.selected;

    }else{
    if (_fenleiV) {
        [self fenleiVdismiss];
        
        for (CustomButton * btn1 in _deleteFenleiArr) {
            [btn1 disselect];
            [btn1 setTitleColor:WENDA_COLOR forState:UIControlStateNormal];
            btn1.selected = NO;
            
        }
    }
    }
    
}
#pragma mark 实现分类选项的代理
- (void)backdata:(NSString *)data{
    
    [_fenleiV removeFromSuperview];
    for (CustomButton * btn in _deleteFenleiArr) {
        btn.selected = NO; 
    }
    if (_TextV) {
        _TextV.text = data;
    }
}
#pragma mark  移除观察者
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"xuanxiang" object:nil];
    
}
#pragma mark 添加转屏动画
- (void)screenChangAnimated{
    [self.view setNeedsUpdateConstraints];
    [self.view updateFocusIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
        
    }];
}
#pragma mark 消失
- (void)fenleiVdismiss{
    if (_fenleiV) {
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [_fenleiV removeFromSuperview];
    
    [_fenleiV.layer addAnimation:transition forKey:@"animation"];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
