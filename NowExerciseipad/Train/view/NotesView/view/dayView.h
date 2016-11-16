//
//  dayView.h
//  NowExerciseipad
//
//  Created by mac on 16/11/14.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol daydelegate <NSObject>

- (void)dayselectNumber:(NSInteger)classID anddayL:(NSString *)daystr;


@end
@interface dayView : UIView
@property (nonatomic , assign) id<daydelegate> delegate;

- (instancetype)initWithArray:(NSArray *)arr;


@end
