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


@interface MainViewController ()<NavViewdelegate>

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

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WINDOW_backgroundColor;
    
    [self createUI];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    NSLog(@"123");
//    
//        [_mainV bringSubviewToFront:_orderVC.view];
//
//}
#pragma mark 布局
- (void)createUI{
    _navV = [[NavView alloc]init];
    _navV.delegate = self;//设置带代理
    
    [_navV.menuBtn addTarget:self action:@selector(MenuBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    _orderVC = [[OrderViewController alloc]init];
    _classVC = [[ClassViewController alloc]init];
    
    
    _OptionV = [[UIView alloc]init];
    _mainV = [[UIView alloc]init];
    _mainV.contentMode = UIViewContentModeScaleAspectFit;
    
    [_mainV addSubview:_orderVC.view];
    [_mainV addSubview:_classVC.view];
    
    NSLog(@"");
    _OrderBtn = [[OptionBtn alloc]initWithName:@"订单" andWithImageName:@"5.png"];
    _ClassBtn = [[OptionBtn alloc]initWithName:@"课程" andWithImageName:@"6.png"];
    _TrainBtn = [[OptionBtn alloc]initWithName:@"培训" andWithImageName:@"1.png"];
    _PerformanceBtn = [[OptionBtn alloc]initWithName:@"绩效" andWithImageName:@"7.png"];
    
    

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


//    [_mainV addSubview:login.view];

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

    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortraitUpsideDown) {
        
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
        

        
        
        
    }else{
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

#pragma mark 通知的处理
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    __weak typeof (self) weakSelf = self;

        [_navV mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(84.0);
                    
        }];
    
    [self changeUI];
    
    
    
    
    NSLog(@"转屏了");
    NSLog(@"%f",LEFT_OPTION_L);
    
    
    
}

- (void)changeUI{
    
    UIDevice *device = [UIDevice currentDevice];
    
    switch (device.orientation) {
        case UIDeviceOrientationFaceUp:
            NSLog(@"屏幕朝上平躺");
            
            
            break;
            
        case UIDeviceOrientationFaceDown:
            NSLog(@"屏幕朝下平躺");
            break;
            
            //系統無法判斷目前Device的方向，有可能是斜置
        case UIDeviceOrientationUnknown:
            NSLog(@"未知方向");
            break;
            
        case UIDeviceOrientationLandscapeLeft://屏幕向左横置
        case UIDeviceOrientationLandscapeRight://屏幕向右橫置
        {
            
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
            break;
            
        case UIDeviceOrientationPortrait://屏幕直立
        case UIDeviceOrientationPortraitUpsideDown://屏幕直立，上下顛倒
        {
            
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
            
            break;
            
        default:
            NSLog(@"无法辨识");
            break;
    }

    
    
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
            btn.imageV.image = [UIImage imageNamed:@"16.png"];
           
            
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
            
            
        }
            break;
        case 200:
            
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
            

            
            break;
        case 300:
            
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
            

            
            
            break;
        case 400:
            
            
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
            

            
            break;
            
        default:
            break;
    }
        
    }else{
//        btn.Classtitlelabel.textColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
        
        
        switch (btn.tag) {
            case 100://点击了订单按钮
            {


                

                
                
            }
                break;
            case 200:
                


               
                
                
                break;
            case 300:
                

                
                break;
            case 400:
                
                

                

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
    
    if (!btn.selected) {
        [UIView animateWithDuration:2.0 animations:^{
            [btn setImage:[UIImage imageNamed:@"caidanopen.png"] forState:UIControlStateNormal];

        }];
          [self OpetionOut];
        
        NSLog(@"出现");
        
    }else{
        [UIView animateWithDuration:2.0 animations:^{
            [btn setImage:[UIImage imageNamed:@"caidanclose.png"] forState:UIControlStateSelected];
            
        }];
        [self Opetiondismiss];

        
    }
    
    
    
    
}

#pragma mark 选项栏消失
- (void)Opetiondismiss{
    __weak typeof (self) weakSelf = self;

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
#pragma mark 选项栏出现

- (void)OpetionOut{
    
    if (ISHENGPING) {
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

    
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
