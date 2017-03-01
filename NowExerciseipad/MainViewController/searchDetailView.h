//
//  searchDetailView.h
//  NowExerciseipad
//
//  Created by mac on 16/11/18.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchDetailView : UIView
Intagerproperty(personal_id)
@property (nonatomic , assign) BOOL isopen;

@property (nonatomic , assign) BOOL isdone;
@property (nonatomic , copy) NSString * orderID;
- (void)postgoBtnStatus;
- (void)createUpdataBtn;

@end
