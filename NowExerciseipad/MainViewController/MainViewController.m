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

#warning 设置代理控制图片样式


@interface MainViewController ()

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


#pragma mark 布局
- (void)createUI{
    _navV = [[NavView alloc]init];
    _OptionV = [[UIView alloc]init];
    _mainV = [[UIView alloc]init];
    
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


    _OptionV.backgroundColor = [UIColor greenColor];
    _mainV.backgroundColor = [UIColor redColor];
    _navV.backgroundColor = [UIColor blackColor];

    
    [self.view addSubview:_navV];
    [self.view addSubview:_mainV];
    [self.view addSubview:_OptionV];
    
    
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
    __weak typeof (self) weakSelf = self;
   //上方导航栏
    [_navV mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(84.0);
        
    }];
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

#pragma mark 通知的处理
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    __weak typeof (self) weakSelf = self;

        [_navV mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(84.0);
                    
        }];
    
    
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
                
                
                _OrderBtn.Classtitlelabel.hidden = YES;
                _ClassBtn.Classtitlelabel.hidden = YES;
                _TrainBtn.Classtitlelabel.hidden = YES;
                _PerformanceBtn.Classtitlelabel.hidden = YES;
                
                
                [_OptionV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_navV.mas_bottom);
                    make.left.mas_equalTo(0);
                    make.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(LEFT_OPTION_L / 2.0);
                    
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

    
    
    NSLog(@"转屏了");
    NSLog(@"%f",LEFT_OPTION_L);
    
    
    
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
