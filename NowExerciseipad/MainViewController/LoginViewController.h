//
//  LoginViewController.h
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Logindelegate <NSObject>

- (void)LoginSuecces;

@end


@interface LoginViewController : UIViewController


@property (nonatomic , strong) UIImageView * iconImageV;

@property (nonatomic , strong) UITextField * nameTF;

@property (nonatomic , strong) UITextField * passwordTF;

@property (nonatomic, strong) UIButton * LoginBtn;

@property (nonatomic , assign) id<Logindelegate> delegate;


@end
