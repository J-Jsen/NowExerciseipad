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

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


@interface AppDelegate ()<Logindelegate,JPUSHRegisterDelegate>
@property (nonatomic , strong) LoginViewController * loginVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#pragma mark 极光推送代码
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
             UIRemoteNotificationTypeSound |
             UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:@"92717e8bb6399be3bc7df6d3"
                          channel:@""
                 apsForProduction:0
            advertisingIdentifier:nil];
    
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
#pragma mark 入口代码
    //设置状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
        [HttpRequest GetHttpwithUrl:url parameters:nil andsuccessBlock:^(id data) {
            if (data) {
                NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
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

#pragma mark 极光推送代理方法
//注册成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
//注册失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
//支持版本 ios10
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        /*接收推送并处理*/
        [[NSNotificationCenter defaultCenter] postNotificationName:@"neworder" object:nil];
        [UIApplication sharedApplication].applicationIconBadgeNumber++;
        
        
    }
    completionHandler();  // 系统要求执行这个方法
}
//支持版本ios 7以上
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    /*接收推送并处理*/
    [[NSNotificationCenter defaultCenter] postNotificationName:@"neworder" object:nil];
    [UIApplication sharedApplication].applicationIconBadgeNumber++;

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    //ios 6 一下的
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
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
