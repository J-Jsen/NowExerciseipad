//
//  DetailOrderViewController.h
//  NowExerciseipad
//
//  Created by mac on 16/10/28.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailOrderViewController : UIView

@property (nonatomic , strong) NSString * orderID;

@property (nonatomic , assign) BOOL isopen;

@property (nonatomic , assign) BOOL isdone;

@property (nonatomic , assign) NSInteger personal_id;
//状态回调

@property (nonatomic , assign) void(^detailBlock)(void);


- (void)createview;
- (void)postgoBtnStatus;
- (void)createUpdataBtn;
- (void)nothavepersonal;
- (void)ispersonal;
@end
