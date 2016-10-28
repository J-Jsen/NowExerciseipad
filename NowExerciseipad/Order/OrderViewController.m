//
//  OrderViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "OrderViewController.h"
#import "DetailOrderViewController.h"




@interface OrderViewController ()

@property (nonatomic , strong)  UITableView * OrdertableV;


@property (nonatomic , strong) NSMutableArray * dataArr;



@end

@implementation OrderViewController
//初始化frame大小
//- (instancetype)init{
//    
//    
//    if (self = [super init]) {
//        
//        self.view.frame = CGRectMake(0, 0, UISCREEN_W - LEFT_OPTION_L, UISCREEN_H - 84);
//        
//    }
//    return self;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark 添加屏幕通知

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];

    //菜单栏出现消失通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menunoti:) name:@"xuanxiang" object:nil];
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self reloadUI];
    
    
    // Do any additional setup after loading the view from its nib.
}


- (void)reloadUI{
    
    _OrdertableV = [[UITableView alloc]init];
    
    _OrdertableV.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_OrdertableV];
    
    
    
    [self createUI];
}
#pragma Mark masonry布局
- (void)createUI{
    
    if (ISSHUPING) {
        
        [_OrdertableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.mas_equalTo(0);
            make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L);
            make.height.mas_equalTo(UISCREEN_H - 84);
            
        }];
        
    }else{
        
        [_OrdertableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.mas_equalTo(0);
            make.width.mas_equalTo(UISCREEN_W - LEFT_OPTION_L / 3.0);
            make.height.mas_equalTo(UISCREEN_H - 84);
            
        }];
        

    }
    
    
    
}

#pragma mark 通知实现方法

- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    if (ISSHUPING) {
        
    }
    
    
}
- (void)menunoti:(NSNotification *)noti{
    
    NSString * Info = [noti.userInfo valueForKey:@"1"];
    
    if ([Info isEqualToString:@"出现"]) {
        
        
        
        
        
    }else if([Info isEqualToString:@"消失"]){
        
        
        
        
        
        
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
