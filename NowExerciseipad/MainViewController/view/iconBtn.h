//
//  iconBtn.h
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iconBtn : UIButton

@property (nonatomic , strong) UIImageView * iconV;

@property (nonatomic , strong) UILabel * namelabel;

- (instancetype)init;
- (void)createiconWithiconUrl:(NSString *)url name:(NSString *)name;


@end
