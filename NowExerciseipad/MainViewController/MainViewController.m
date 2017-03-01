//
//  MainViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "MainViewController.h"
#import "NavView.h"//导航条视图
#import "LoginViewController.h"
#import "OptionBtn.h"
#import "ClassViewController.h"
#import "OrderViewController.h"
#import "TrainViewController.h"
#import "PerformanceViewController.h"

#import "PersonalView.h"//个人信息
#import "searchView.h"
@interface MainViewController ()<NavViewdelegate,UITextFieldDelegate>
{
    UIView * navPushView;
    UIView * searchBackgrondView;
    searchView * searchV;
}
@property (nonatomic ,strong) NavView * navV;
//右方主视图
@property (nonatomic , strong) UIView * mainV;
//左方选项视图
@property (nonatomic , strong) UIView * OptionV;

@property (nonatomic , strong) OptionBtn * OrderBtn;
@property (nonatomic , strong) OptionBtn * ClassBtn;
@property (nonatomic , strong) OptionBtn * TrainBtn;
@property (nonatomic , strong) OptionBtn * PerformanceBtn;

@property (nonatomic , strong) UILabel * line1;
@property (nonatomic , strong) UILabel * line2;
@property (nonatomic , strong) UILabel * line3;

@property (nonatomic , strong) OrderViewController * orderVC;
@property (nonatomic , strong) ClassViewController * classVC;
@property (nonatomic , strong) TrainViewController * trainVC;
@property (nonatomic , strong) PerformanceViewController * performanceVC;

@property (nonatomic , assign) BOOL isopen;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isopen = YES;
    
    self.view.backgroundColor = WINDOW_backgroundColor;
    self.navigationController.navigationBarHidden = YES;
    [self createUI];
    [self loaddata];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushMessage) name:@"neworder" object:nil];
    
}

#pragma mark 布局
- (void)createUI{
    _navV = [[NavView alloc]init];
    _navV.delegate = self;//设置带代理
    
    [_navV.menuBtn addTarget:self action:@selector(MenuBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [_navV.IconBtn addTarget:self action:@selector(IconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _navV.searchTF.delegate = self;
    [_navV.searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navV.messageBtn addTarget:self action:@selector(PushMessageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _orderVC = [[OrderViewController alloc]init];
   
    _OptionV = [[UIView alloc]init];
    _mainV = [[UIView alloc]init];
    _mainV.contentMode = UIViewContentModeScaleAspectFit;
    
    [_mainV addSubview:_orderVC.view];

    _OrderBtn = [[OptionBtn alloc]initWithName:@"订单" andWithImageName:@"5.png"];
    _ClassBtn = [[OptionBtn alloc]initWithName:@"课程" andWithImageName:@"6.png"];
    _TrainBtn = [[OptionBtn alloc]initWithName:@"培训" andWithImageName:@"1.png"];
    _PerformanceBtn = [[OptionBtn alloc]initWithName:@"绩效" andWithImageName:@"7.png"];
    
    _OrderBtn.selected = YES;
    _OrderBtn.imageV.image = [UIImage imageNamed:@"8.png"];
    _OrderBtn.Classtitlelabel.textColor = [UIColor orangeColor];

    //分割线
    
    _line1 = [[UILabel alloc]init];
    _line2 = [[UILabel alloc]init];
    _line3 = [[UILabel alloc]init];
    
    _line1.backgroundColor = WINDOW_backgroundColor;
    _line2.backgroundColor = WINDOW_backgroundColor;
    _line3.backgroundColor = WINDOW_backgroundColor;


    _OptionV.backgroundColor = LEFTBTN_BACKGROUNDCOLOR;
    _navV.backgroundColor = LEFTBTN_BACKGROUNDCOLOR;

    _mainV.backgroundColor = LEFTBTN_BACKGROUNDCOLOR;

    
    [self.view addSubview:_navV];
    [self.view addSubview:_mainV];
    [self.view addSubview:_OptionV];
 
    _OrderBtn.tag = 100;
    _ClassBtn.tag = 200;
    _TrainBtn.tag = 300;
    _PerformanceBtn.tag = 400;
    
    [_OrderBtn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [_ClassBtn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [_TrainBtn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [_PerformanceBtn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_OptionV addSubview:_OrderBtn];
    [_OptionV addSubview:_ClassBtn];
    [_OptionV addSubview:_TrainBtn];
    [_OptionV addSubview:_PerformanceBtn];
    
    [_OptionV addSubview:_line1];
    [_OptionV addSubview:_line2];
    [_OptionV addSubview:_line3];

    [self masonryUI];

}

#pragma mark masonry 布局
- (void)masonryUI{
   //上方导航栏
    [_navV mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(84.0);
        
    }];

    if (ISSHUPING) {
        
        [_OptionV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_navV.mas_bottom);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(LEFT_OPTION_L / 3.0);
            
        }];
        
        [_mainV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_navV.mas_bottom);
            make.left.mas_equalTo(_OptionV.mas_right);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        
        //**************************分别布局********************
        
        [_OrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(LEFT_OPTION_L);
            
        }];
        
        [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_OrderBtn.mas_bottom);
            make.left.mas_equalTo(2);
            make.right.mas_equalTo(-2);
            make.height.mas_equalTo(1);
            
        }];
        
        [_ClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(_line1.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(LEFT_OPTION_L);
            
        }];
        
        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_ClassBtn.mas_bottom);
            make.left.mas_equalTo(2);
            make.right.mas_equalTo(-2);
            make.height.mas_equalTo(1);
            
        }];
        
        [_TrainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_line2.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(LEFT_OPTION_L);
            
            
        }];
        [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_TrainBtn.mas_bottom);
            make.left.mas_equalTo(2);
            make.right.mas_equalTo(-2);
            make.height.mas_equalTo(1);
        }];
        
        [_PerformanceBtn mas_makeConstraints :^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_line3.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(LEFT_OPTION_L);
            
        }];
   
    }else if(ISHENGPING){
        //左方选项
        [_OptionV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_navV.mas_bottom);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(LEFT_OPTION_L);
            
        }];
        //右边主视图
        [_mainV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_navV.mas_bottom);
            make.left.mas_equalTo(_OptionV.mas_right);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
        
        //**************************分别布局********************
        
        [_OrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(LEFT_OPTION_L);
            
        }];
        
        [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_OrderBtn.mas_bottom);
            make.left.mas_equalTo(2);
            make.right.mas_equalTo(-2);
            make.height.mas_equalTo(1);
            
        }];
        
        [_ClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(_line1.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(LEFT_OPTION_L);
            
        }];
        
        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_ClassBtn.mas_bottom);
            make.left.mas_equalTo(2);
            make.right.mas_equalTo(-2);
            make.height.mas_equalTo(1);
            
        }];
        
        [_TrainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_line2.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(LEFT_OPTION_L);
            
            
        }];
        [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_TrainBtn.mas_bottom);
            make.left.mas_equalTo(2);
            make.right.mas_equalTo(-2);
            make.height.mas_equalTo(1);
            
        }];
        
        [_PerformanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_line3.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(LEFT_OPTION_L);
            
        }];
    }
    
    [[UIApplication sharedApplication] statusBarOrientation];

}

#pragma mark 数据load个人信息
- (void)loaddata{
    
    NSString * url = [NSString stringWithFormat:@"%@pad/?method=coach.personal_info",BASEURL];
    
//    http://192.168.1.5/pad/?method=coach.personal_info
    
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
        NSLog(@"数据%@",data);
        NSLog(@"%@",[data class]);
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (data && [dic[@"rc"] integerValue] == 0) {
            NSDictionary * datadic = dic[@"data"];
            NSUserDefaults * defults = [NSUserDefaults standardUserDefaults];
            [defults setObject:datadic[@"uid"] forKey:@"uid"];
            [defults setObject:datadic[@"class_times"] forKey:@"classtime"];
            [defults setObject:datadic[@"headimg"] forKey:@"iconurl"];
            [defults setObject:datadic[@"city"] forKey:@"place"];
            [defults setObject:datadic[@"id_card"] forKey:@"personID"];
            [defults setObject:datadic[@"username"] forKey:@"username"];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_navV.IconBtn) {
                [_navV.IconBtn createiconWithiconUrl:datadic[@"headimg"] name:datadic[@"username"]];
                }
            });
            
        }else{
            [HttpRequest showAlertCatController:self andmessage:@"获取个人信息失败"];
        }
        
    } andfailBlock:^(NSError *error) {
        [HttpRequest showAlertCatController:self andmessage:@"服务器开小差了"];
    }];
    
    
}

#pragma mark 通知的处理
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    //__weak typeof (self) weakSelf = self;
        [_navV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(84.0);
        }];
    
    [self changeUI];
    NSLog(@"转屏了");

}

- (void)changeUI{
    if (ISHENGPING) {
        
            if (_isopen) {
                [_OptionV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_navV.mas_bottom);
                    make.left.mas_equalTo(0);
                    make.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(LEFT_OPTION_L);
                    
                }];
                
                [_mainV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_navV.mas_bottom);
                    make.left.mas_equalTo(_OptionV.mas_right);
                    make.bottom.mas_equalTo(0);
                    make.right.mas_equalTo(0);
                }];
            }else{
                [_OptionV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_navV.mas_bottom);
                    make.left.offset(-LEFT_OPTION_L);
                    make.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(LEFT_OPTION_L);
                    
                }];
                
                [_mainV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_navV.mas_bottom);
                    make.left.mas_equalTo(_OptionV.mas_right);
                    make.bottom.mas_equalTo(0);
                    make.right.mas_equalTo(0);
                }];
               
            }
            
                //**************************分别布局********************
                
                [_OrderBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(0);
                    make.right.mas_equalTo(0);
                    make.height.mas_equalTo(LEFT_OPTION_L);
                    
                }];
                
                [_line1 mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_OrderBtn.mas_bottom);
                    make.left.mas_equalTo(2);
                    make.right.mas_equalTo(-2);
                    make.height.mas_equalTo(1);
                    
                }];
                
                [_ClassBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.mas_equalTo(_line1.mas_bottom);
                    make.left.mas_equalTo(0);
                    make.right.mas_equalTo(0);
                    make.height.mas_equalTo(LEFT_OPTION_L);
                    
                }];
                
                [_line2 mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_ClassBtn.mas_bottom);
                    make.left.mas_equalTo(2);
                    make.right.mas_equalTo(-2);
                    make.height.mas_equalTo(1);
                    
                }];
                
                [_TrainBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_line2.mas_bottom);
                    make.left.mas_equalTo(0);
                    make.right.mas_equalTo(0);
                    make.height.mas_equalTo(LEFT_OPTION_L);
                    
                    
                }];
                [_line3 mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_TrainBtn.mas_bottom);
                    make.left.mas_equalTo(2);
                    make.right.mas_equalTo(-2);
                    make.height.mas_equalTo(1);
                    
                }];
                
                [_PerformanceBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_line3.mas_bottom);
                    make.left.mas_equalTo(0);
                    make.right.mas_equalTo(0);
                    make.height.mas_equalTo(LEFT_OPTION_L);
                    
                }];


            
        }else if(ISSHUPING){
            if (_isopen) {
                [_OptionV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_navV.mas_bottom);
                    make.left.mas_equalTo(0);
                    make.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(LEFT_OPTION_L / 3.0);
                    
                }];
                
                [_mainV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_navV.mas_bottom);
                    make.left.mas_equalTo(_OptionV.mas_right);
                    make.bottom.mas_equalTo(0);
                    make.right.mas_equalTo(0);
                }];

            }else{
                [_OptionV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_navV.mas_bottom);
                    make.left.offset(-LEFT_OPTION_L);
                    make.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(LEFT_OPTION_L);
                    
                }];
                
                [_mainV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_navV.mas_bottom);
                    make.left.mas_equalTo(_OptionV.mas_right);
                    make.bottom.mas_equalTo(0);
                    make.right.mas_equalTo(0);
                }];
            }
            //**************************分别布局********************
            [_OrderBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(LEFT_OPTION_L);
            }];
            [_line1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_OrderBtn.mas_bottom);
                make.left.mas_equalTo(2);
                make.right.mas_equalTo(-2);
                make.height.mas_equalTo(1);
            }];
            [_ClassBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_line1.mas_bottom);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(LEFT_OPTION_L);
            }];
            [_line2 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_ClassBtn.mas_bottom);
                make.left.mas_equalTo(2);
                make.right.mas_equalTo(-2);
                make.height.mas_equalTo(1);
            }];
            [_TrainBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_line2.mas_bottom);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(LEFT_OPTION_L);
            }];
            [_line3 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_TrainBtn.mas_bottom);
                make.left.mas_equalTo(2);
                make.right.mas_equalTo(-2);
                make.height.mas_equalTo(1);
            }];
            [_PerformanceBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_line3.mas_bottom);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(LEFT_OPTION_L);
                
            }];
    }
//动画
    [self screenChangAnimated];
}
#pragma 左方选项点击事件
- (void)btnclick:(OptionBtn *)btn{
    NSLog(@"点击了");
    NSArray * Btnarr = [NSArray arrayWithObjects:_OrderBtn,_ClassBtn,_TrainBtn,_PerformanceBtn,nil];
    OptionBtn * optionbtn = [[OptionBtn alloc]init];
    if (!btn.isSelected) {
    btn.Classtitlelabel.textColor = [UIColor orangeColor];
    switch (btn.tag) {
        case 100://点击了订单按钮
        {
            btn.imageV.image = [UIImage imageNamed:@"8.png"];
           
            _ClassBtn.imageV.image = [UIImage imageNamed:@"6.png"];
            _TrainBtn.imageV.image = [UIImage imageNamed:@"1.png"];
            _PerformanceBtn.imageV.image = [UIImage imageNamed:@"7.png"];
            _ClassBtn.selected = NO;
            _TrainBtn.selected = NO;
            _PerformanceBtn.selected = NO;

            for (int i = 0; i < Btnarr.count; i ++) {
                if (i != 0 ) {
                    optionbtn = Btnarr[i];
                    optionbtn.Classtitlelabel.textColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
                }
            }
            [_mainV bringSubviewToFront:_orderVC.view];
        }
            break;
        case 200://课程
        {
            btn.imageV.image = [UIImage imageNamed:@"9.png"];

            _OrderBtn.imageV.image = [UIImage imageNamed:@"5.png"];
            _TrainBtn.imageV.image = [UIImage imageNamed:@"1.png"];
            _PerformanceBtn.imageV.image = [UIImage imageNamed:@"7.png"];
            _OrderBtn.selected = NO;
            _TrainBtn.selected = NO;
            _PerformanceBtn.selected = NO;
            for (int i = 0; i < Btnarr.count; i ++) {
                if (i != 1 ) {
                    optionbtn = Btnarr[i];
                    optionbtn.Classtitlelabel.textColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
                }
            }
            if (_classVC) {
                [_mainV bringSubviewToFront:_classVC.view];
            }else{
            _classVC = [[ClassViewController alloc]init];
            _classVC.islook = _isopen;
            [_mainV addSubview:_classVC.view];
            }

        }
            break;
        case 300:
        {
            btn.imageV.image = [UIImage imageNamed:@"10.png"];
            _OrderBtn.imageV.image = [UIImage imageNamed:@"5.png"];
            _ClassBtn.imageV.image = [UIImage imageNamed:@"6.png"];
            _PerformanceBtn.imageV.image = [UIImage imageNamed:@"7.png"];
            _OrderBtn.selected = NO;
            _PerformanceBtn.selected = NO;
            _ClassBtn.selected = NO;

            for (int i = 0; i < Btnarr.count; i ++) {
                if (i != 2 ) {
                    optionbtn = Btnarr[i];
                    optionbtn.Classtitlelabel.textColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
                }
                
            }
            if (_trainVC) {
                [_mainV bringSubviewToFront:_trainVC.view];
                
            }else{
                _trainVC = [[TrainViewController alloc]init];
                _trainVC.islook = _isopen;
                [_mainV addSubview:_trainVC.view];
            }
            
        }
            break;
        case 400:
        {
            
            btn.imageV.image = [UIImage imageNamed:@"11.png"];
            _ClassBtn.imageV.image = [UIImage imageNamed:@"6.png"];
            _TrainBtn.imageV.image = [UIImage imageNamed:@"1.png"];
            _OrderBtn.imageV.image = [UIImage imageNamed:@"5.png"];
            _ClassBtn.selected = NO;
            _TrainBtn.selected = NO;
            _OrderBtn.selected = NO;
            for (int i = 0; i < Btnarr.count; i ++) {
                if (i != 3 ) {
                    optionbtn = Btnarr[i];
                    optionbtn.Classtitlelabel.textColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
                }
            }
            if (_performanceVC) {
                [_mainV bringSubviewToFront:_performanceVC.view];
            }else{
                _performanceVC = [[PerformanceViewController alloc]init];
                _performanceVC.islook = _isopen;
                
                [_mainV addSubview:_performanceVC.view];
            }
        }
            break;
            
        default:
            break;
    }
        
    }else{
//btn.Classtitlelabel.textColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
        switch (btn.tag) {
            case 100://点击了订单按钮
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"detailorderdismiss" object:nil];
                btn.selected = NO;
            }
                break;
            case 200://课程
                btn.selected = NO;
                break;
            case 300://培训
                break;
            case 400://绩效
                break;
            default:
                break;
        }
    }
    
     btn.selected = !btn.selected;
}
#pragma mark 实现菜单按钮代理方法

- (void)MenuBtnclick:(UIButton *)btn{
    btn.selected = !btn.selected;
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    if (!btn.selected) {
        [btn setImage:[UIImage imageNamed:@"caidanopen.png"] forState:UIControlStateNormal];
        [center postNotificationName:@"xuanxiang" object:nil userInfo:@{@"1":@"出现"}];
        _isopen = YES;
        
        if (navPushView) {
            [navPushView removeFromSuperview];
            _navV.IconBtn.userInteractionEnabled = YES;
        }
        if (searchBackgrondView) {
            [searchBackgrondView removeFromSuperview];
            searchV = nil;
            _navV.searchTF.text = @"";
        }
        NSLog(@"菜单出现");
        
    }else{
        [btn setImage:[UIImage imageNamed:@"caidanclose.png"] forState:UIControlStateSelected];
        [center postNotificationName:@"xuanxiang" object:nil userInfo:@{@"1":@"消失"}];
        _isopen = NO;
        
        NSLog(@"菜单消失");
        
    }
    [self handleDeviceOrientationDidChange:[[UIApplication sharedApplication] statusBarOrientation]];

}
#pragma mark 推送消息通知
- (void)PushMessage{
    [_orderVC loaddata];

}
#pragma mark 消息按钮点击事件
- (void)PushMessageBtnClick{
    if (_orderVC) {
        NSLog(@"刷新了订单视图");
        [_orderVC.OrdertableV.mj_header beginRefreshing];
        
        _OrderBtn.imageV.image = [UIImage imageNamed:@"8.png"];
        _OrderBtn.Classtitlelabel.textColor = [UIColor orangeColor];
        
        _ClassBtn.imageV.image = [UIImage imageNamed:@"6.png"];
        _TrainBtn.imageV.image = [UIImage imageNamed:@"1.png"];
        _PerformanceBtn.imageV.image = [UIImage imageNamed:@"7.png"];
        _ClassBtn.selected = NO;
        _TrainBtn.selected = NO;
        _PerformanceBtn.selected = NO;
        _ClassBtn.Classtitlelabel.textColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
        _TrainBtn.Classtitlelabel.textColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
        _PerformanceBtn.Classtitlelabel.textColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
        
        [_mainV bringSubviewToFront:_orderVC.view];

    }
}

#pragma mark 头像点击事件
- (void)IconBtnClick:(iconBtn *)btn{
    navPushView = [[UIView alloc]init];
    [self.view addSubview:navPushView];
    navPushView.backgroundColor = [UIColor redColor];
    
    PersonalView * personV = [[PersonalView alloc]init];
    [navPushView addSubview:personV];
    
    [navPushView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(80);
        make.left.and.right.and.bottom.offset(0);
        
    }];
    
    [personV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
        
    }];
    
    _navV.menuBtn.selected = NO;
    [self MenuBtnclick:_navV.menuBtn];
    btn.userInteractionEnabled = NO;
    
}
#pragma mark 搜索框代理
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _navV.searchTF) {
        if (searchV) {
        }else{
            searchBackgrondView = [[UIView alloc]init];
            [self.view addSubview:searchBackgrondView];
            [searchBackgrondView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(80);
                make.left.and.right.and.bottom.offset(0);
            }];
        searchV = [[searchView alloc]init];
        [searchBackgrondView addSubview:searchV];
        [searchV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        _navV.menuBtn.selected = NO;
        [self MenuBtnclick:_navV.menuBtn];
        }
        
        if (searchV.detaiV) {
            [searchV.detaiV removeFromSuperview];
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _navV.searchTF) {

    }
}
#pragma mark 搜索按钮点击事件
- (void)searchBtnClick:(UIButton *)btn{
    if (searchV) {
        [searchV seturlWithString:_navV.searchTF.text];
        [_navV.searchTF resignFirstResponder];
        
    }
}
#pragma mark 选项栏消失
- (void)Opetiondismiss{

    [_OptionV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navV.mas_bottom);
        make.left.offset(-LEFT_OPTION_L);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(LEFT_OPTION_L);
        
    }];
    
    [_mainV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navV.mas_bottom);
        make.left.mas_equalTo(_OptionV.mas_right);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    [self screenChangAnimated];
}
#pragma mark 选项栏出现
- (void)OpetionOut{
    
    if (ISSHUPING) {
        [_OptionV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_navV.mas_bottom);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(LEFT_OPTION_L / 3.0);
        }];
        
        [_mainV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_navV.mas_bottom);
            make.left.mas_equalTo(_OptionV.mas_right);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
           }else if(ISHENGPING){

        [_OptionV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_navV.mas_bottom);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(LEFT_OPTION_L);
                   
        }];
               
        [_mainV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_navV.mas_bottom);
            make.left.mas_equalTo(_OptionV.mas_right);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
    }

    [self screenChangAnimated];
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"neworder" object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 添加转屏动画
- (void)screenChangAnimated{
    [self.view setNeedsUpdateConstraints];
    [self.view updateFocusIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
        
    }];
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
