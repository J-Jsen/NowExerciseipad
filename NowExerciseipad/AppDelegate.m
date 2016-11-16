//
//  AppDelegate.m
//  NowExerciseipad
//
//  Created by mac on 16/10/24.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"
#import "Reachability.h"
#import "LoginViewController.h"

@interface AppDelegate ()<Logindelegate>
@property (nonatomic , strong) LoginViewController * loginVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#pragma mark 添加网络监控通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(reachabilityChanged:)
     
                                                 name:kReachabilityChangedNotification
     
                                               object:nil];
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.guodongwl.com"];
    
    [reach startNotifier];

//    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
//    NSLog(@"APNS   %@",remoteNotification);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changerootview) name:@"login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginSuecces) name:@"main" object:nil];
    //横竖屏通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

    
    
   //***************************************************************************
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    _loginVC = [[LoginViewController alloc]init];

    UIViewController * viewc = [[UIViewController alloc]init];
    _window.rootViewController = viewc;
    
    NSUserDefaults * userdefult = [NSUserDefaults standardUserDefaults];
    NSString * name = [userdefult valueForKey:@"name"];
    NSString * mima = [userdefult valueForKey:@"mima"];
    NSLog(@"mingzi%@",name);
    NSString *url = [NSString stringWithFormat:@"%@gdlogin/?number=%@&passwd=%@",BASEURL,name,[mima MD5]];
    NSLog(@"%@",url);
    if (name.length != 0 && mima.length != 0) {
        [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:nil andsuccessBlock:^(id data) {
            if (data) {
                NSDictionary * dict = data;
                
                NSInteger rc = [[dict valueForKey:@"rc"] integerValue];
                
                if (rc == 0) {
                    _window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[MainViewController alloc]init]];
                }else{
                    _window.rootViewController = _loginVC;
                }
            }
        } andfailBlock:^(NSError *error) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                
            }]];
            _window.rootViewController = _loginVC;
            [_window.rootViewController presentViewController:alert animated:YES completion:nil];

        }];
        
    }else{
        
    self.window.rootViewController = _loginVC;
    }
    [self.window setBackgroundColor:WINDOW_backgroundColor];
    [self.window makeKeyAndVisible];
    
    //统一设置导航栏隐藏
//    UINavigationBar * appearance = [UINavigationBar appearance];
//    
//    appearance.hidden = YES;
//    
    
    
    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                       UIUserNotificationTypeSound |
//                                                       UIUserNotificationTypeAlert)
//                                           categories:nil];
//    } else {
//        //categories 必须为nil
//        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                       UIRemoteNotificationTypeSound |
//                                                       UIRemoteNotificationTypeAlert)
//                                           categories:nil];
//    }
//#else
//    //categories 必须为nil
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                   UIRemoteNotificationTypeSound |
//                                                   UIRemoteNotificationTypeAlert)
//                                       categories:nil];
//#endif

    
    
    // Override point for customization after application launch.
    return YES;
}
#pragma mark 登陆代理方法
-(void) LoginSuecces{
    
    _window.rootViewController = [[UINavigationController alloc]initWithRootViewController: [[MainViewController alloc]init]];
 
    
}
#pragma mark 更换用户
- (void)changerootview{
    _window.rootViewController = [[LoginViewController alloc]init];
    
    
}
#pragma mark 实现网络监控方法
-(void)reachabilityChanged:(NSNotification *)notification
{
    Reachability *reach = [notification object];
    
    if([reach isKindOfClass:[Reachability class]]){
        
        NetworkStatus statuWetwork = [reach currentReachabilityStatus];
        
        NSLog(@"statuWetwork  %ld",(long)statuWetwork);
        switch (statuWetwork) {
            case 0:
            {
                
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"网络连接中断" preferredStyle:UIAlertControllerStyleAlert];
                
              
                [alert addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    
                }]];
                
                
                [_window.rootViewController presentViewController:alert animated:YES completion:nil];
                
                
            }
                break;
                
            default:
                break;
        }
        //Insert your code here
        
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
