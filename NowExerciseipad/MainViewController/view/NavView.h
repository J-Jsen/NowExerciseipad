//
//  NavView.h
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iconBtn.h"

@protocol NavViewdelegate <NSObject>

- (void)MenuBtnclick:(UIButton *)btn;


@end


@interface NavView : UIView

@property (nonatomic , strong) UIButton * menuBtn;//菜单按钮
@property (nonatomic , strong) iconBtn * IconBtn;//头像按钮
@property (nonatomic , strong) UITextField * searchTF; //搜索框
@property (nonatomic , strong) UIButton * searchBtn;//搜索按钮
@property (nonatomic , strong) UIButton * messageBtn;//消息按钮

@property  (nonatomic , strong) id<NavViewdelegate> delegate;

- (instancetype)init;



@end
