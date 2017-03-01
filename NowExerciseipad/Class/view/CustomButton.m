//
//  CustomButton.m
//  NowExerciseipad
//
//  Created by mac on 16/11/23.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "CustomButton.h"

@interface CustomButton()
{
    UILabel * line;
}

@end


@implementation CustomButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        line = [[UILabel alloc]init];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.and.left.and.right.offset(0);
            make.height.mas_equalTo(2);
            
        }];
        
        line.backgroundColor = [UIColor orangeColor];
        line.hidden = YES;
    }
    return self;
    
}

- (void)select{
    line.hidden = NO;
    
}
- (void)disselect{
    line.hidden = YES;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
