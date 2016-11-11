//
//  xuanzeBTN.h
//  NowExerciseipad
//
//  Created by mac on 16/11/3.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xuanzeBTN : UIButton

@property (nonatomic , strong) UIImageView * imageV;
@property (nonatomic , strong) UILabel * label;

- (instancetype)initWithMessage:(NSString *)message;


@end
