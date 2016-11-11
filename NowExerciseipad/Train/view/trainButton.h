//
//  trainButton.h
//  NowExerciseipad
//
//  Created by mac on 16/11/9.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface trainButton : UIButton

@property (nonatomic , strong) UIImageView * imageV;
@property (nonatomic , strong) UILabel * label;
- (instancetype)initWithtitlename:(NSString *)title andimagename:(NSString *)name;

- (void)changeColorWithimagename:(NSString *)name;
- (void)backColorWithimagename:(NSString *)name;
@end
