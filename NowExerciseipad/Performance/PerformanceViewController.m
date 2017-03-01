//
//  PerformanceViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "PerformanceViewController.h"
#import "leftTrainerView.h"

#import "performaceButton.h"
#import "ButtonView.h"

#import "performanceCell.h"
#import "performanceModel.h"
#import "performHeaderView.h"
@interface PerformanceViewController ()<UITableViewDelegate,UITableViewDataSource,ButtonViewDelegate>
{
    NSString * beginString;
    NSString * endString;
    
    NSString * url;
    NSString * uid;
    UITableView * tableV;
    NSMutableArray * dataArr;
    
    performaceButton * performaceBtn;
    
    ButtonView * buttonV;
    
    
}
@property (nonatomic , strong) UIView * backgroundV;

@property (nonatomic , strong) leftTrainerView * leftV;

@end

@implementation PerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WINDOW_backgroundColor;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    //菜单栏出现消失通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menunoti:) name:@"xuanxiang" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTeacher:) name:@"teach" object:nil];
    

    dataArr = [NSMutableArray array];
    
    [self getNowDateBeginAndEndWith:[NSDate date] unit:0];
    [self createUI];
    [self createRect];
    
    
}
- (void)createUI{
    
    _backgroundV = [[UIView alloc]init];
    _backgroundV.layer.borderWidth = 1;
    _backgroundV.layer.borderColor = LEFTBTNTEXT_BACKGROUNDCOLOR.CGColor;
    
    [self.view addSubview:_backgroundV];
    
    
    _leftV = [[leftTrainerView alloc]init];
    [_backgroundV addSubview:_leftV];
    
    tableV = [[UITableView alloc]init];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.backgroundColor = WINDOW_backgroundColor;
    tableV.bounces = NO;
    
    tableV.separatorColor = [UIColor clearColor];
    [tableV registerNib:[UINib nibWithNibName:@"performanceCell" bundle:nil] forCellReuseIdentifier:@"performanceCell"];
    
    [_backgroundV addSubview:tableV];
    
    performaceBtn = [[performaceButton alloc]init];
    [performaceBtn addTarget:self action:@selector(performaceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_backgroundV addSubview:performaceBtn];
    
    
    
}
#pragma mark 时间按钮点击实现
- (void)performaceBtnClick:(performaceButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
    buttonV = [[ButtonView alloc]init];
    buttonV.delegate = self;
    [_backgroundV addSubview:buttonV];
    
    [buttonV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(performaceBtn.mas_bottom);
        make.left.mas_equalTo(performaceBtn.mas_left);
        make.right.mas_equalTo(performaceBtn.mas_right);
        make.height.mas_equalTo(160);
        
    }];
    }else{
        [buttonV removeFromSuperview];
        
    }
    
}
- (void)changeTimeWithString:(NSString *)str andindexpath_row:(NSInteger)row{
    [performaceBtn createBtnWithTimeString:str];
    [self getNowDateBeginAndEndWith:[NSDate date] unit:row];
    [self setUrl];

}
#pragma mark 通知实现
- (void)changeTeacher:(NSNotification *)noti{
    uid = [noti.userInfo valueForKey:@"uid"];
    [self setUrl];
    
}
#pragma mark 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    performanceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"performanceCell"];
    cell.userInteractionEnabled = NO;
    performanceModel * model = dataArr[indexPath.row];
    [cell createCellWithModel:model];
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
   return [[performHeaderView alloc]init];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
    
}
- (void)createRect{
    if (ISSHUPING) {
        if (_islook) {
            [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L /3.0);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
            }];
            
        }else{
            [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
                
            }];
        }
    }else if(ISHENGPING){
        if (_islook) {
            [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
                
            }];
            
            
        }else{
            [_backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
                
            }];
            
        }
        
    }
    [_leftV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.offset(0);
        make.width.mas_equalTo(170.25 / 2.0);
        
    }];
    
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.offset(170.25 / 2.0 + 20);
        make.top.offset(70);
        make.right.offset(-20);
    }];
    [performaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(tableV.mas_top).offset(-20);
        make.left.mas_equalTo(tableV.mas_left);
        make.width.mas_equalTo(200);
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    
    if (ISSHUPING) {
        if (_islook) {
            [_backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L /3.0);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
            }];
            
        }else{
            [_backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
                
            }];
        }
        
    }else if(ISHENGPING){
        if (_islook) {
            [_backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
                
            }];
            
        }else{
            [_backgroundV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(UISCREEN_W);
                make.height.mas_equalTo(UISCREEN_H - 84);
                make.top.and.left.offset(0);
                
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

#pragma mark  移除观察者
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"xuanxiang" object:nil];
    
}
- (void)setUrl{
    
    url = [NSString stringWithFormat:@"%@pad/?method=coach.course_recard&coach_id=%@&max_length=3&start_time=%@",BASEURL,uid,beginString];
    NSLog(@"%@",url);
    
    [self loadData];
    
}

- (void)loadData{
    
    [dataArr removeAllObjects];
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        NSLog(@"%@",data);
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        if (data && [dic[@"rc"] integerValue] == 0) {
       
            NSDictionary * datadic = dic[@"data"];
            NSArray * arr = datadic[@"recard_list"];
            for (NSDictionary * dic in arr) {
                performanceModel * model = [[performanceModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }else{
            [tableV reloadData];
            [HttpRequest showAlertCatController:self andmessage:dic[@"msg"]];
         }
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlertCatController:self andmessage:@"服务器开小差了"];
    }];
    
}
- (void)getNowDateBeginAndEndWith:(NSDate *)newDate unit:(NSInteger )integer{
    
    if (integer != 3) {
        if (newDate == nil) {
            newDate = [NSDate date];
        }
        double interval   = 0;
        NSDate *beginDate = nil;
//        NSDate *endDate   = nil;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        [calendar setFirstWeekday:2];//设定周一为周首日
        NSCalendarUnit unit;
        switch (integer) {
            case 0:
                unit = NSCalendarUnitWeekday;
                
                break;
            case 1:
                unit = NSCalendarUnitMonth;
                break;
                
            case 2:
                unit = NSCalendarUnitYear;
                break;
                
            default:
                break;
        }
        BOOL ok = [calendar rangeOfUnit:unit startDate:&beginDate interval:&interval forDate:newDate];
        //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
//        if (ok) {
//            endDate = [beginDate dateByAddingTimeInterval:interval-1];
//        }else {
//            return;
//        }
//        NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
//        [myDateFormatter setDateFormat:@"yyyy.MM.dd HH.mm.ss"];
        beginString = [NSString stringWithFormat:@"%.0f",[beginDate timeIntervalSince1970]];
    } else {
        beginString = @"0";
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
