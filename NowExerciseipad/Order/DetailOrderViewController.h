//
//  DetailOrderViewController.h
//  NowExerciseipad
//
//  Created by mac on 16/10/28.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailOrderViewController : UIViewController

@property (nonatomic , strong) NSString * orderID;

@property (nonatomic , assign) BOOL isopen;

//@property (nonatomic , assign) NSInteger status;
@property (nonatomic , assign) BOOL isdone;


- (void)createview;



@end
