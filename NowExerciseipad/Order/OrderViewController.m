//
//  OrderViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController
//初始化frame大小
- (instancetype)init{
    
    
    if (self = [super init]) {
        
//        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//            
//        }];
        
        self.view.frame = CGRectMake(0, 0, UISCREEN_W - LEFT_OPTION_L, UISCREEN_H - 84);
        
        
        
        
    }
    return self;
    
}
#pragma mark 添加屏幕通知
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0,0, UISCREEN_W - LEFT_OPTION_L, UISCREEN_H - 84)];
    lab.backgroundColor = [UIColor magentaColor];
    
    [self.view addSubview:lab];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark 通知实现方法

- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
//    [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//        
//    }];
    
    
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
