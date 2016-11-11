//
//  Mytextfield.m
//  NowExerciseipad
//
//  Created by mac on 16/11/3.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "Mytextfield.h"

@implementation Mytextfield

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
    
}

@end
