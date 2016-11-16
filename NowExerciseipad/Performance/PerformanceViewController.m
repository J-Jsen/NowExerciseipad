//
//  PerformanceViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "PerformanceViewController.h"

@interface PerformanceViewController ()
@property (nonatomic , strong) UIView * backgroundV;

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

    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
