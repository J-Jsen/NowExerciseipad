//
//  GoButton.h
//  NowExerciseipad
//
//  Created by mac on 16/11/1.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoButton : UIButton

@property (nonatomic , strong) UIImageView * imageV;

@property (nonatomic , strong) UIImageView * animaionimageV;

@property (nonatomic , strong) UILabel * titileLabel;

- (void)willGO;
- (void)doNew;
- (void)didEnd;




@end
