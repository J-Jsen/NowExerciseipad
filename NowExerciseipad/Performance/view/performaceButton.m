//
//  performaceButton.m
//  NowExerciseipad
//
//  Created by mac on 16/11/18.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "performaceButton.h"

@interface performaceButton()
{
    UILabel * titleL;
    UILabel * timeL;
    
}

@end

@implementation performaceButton

- (instancetype)init{
    if (self = [super init]) {
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = WENDA_COLOR.CGColor;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        titleL = [[UILabel alloc]init];
        timeL = [[UILabel alloc]init];
        
        [self addSubview:titleL];
        [self addSubview:timeL];
        
        titleL.text = @"  时间";
        titleL.textColor = WENDA_COLOR;
        titleL.font = [UIFont systemFontOfSize:18];
        titleL.backgroundColor = WINDOW_backgroundColor;
        
        timeL.text = @"本 周";
        timeL.textColor = [UIColor whiteColor];
        timeL.textAlignment = NSTextAlignmentCenter;
        timeL.backgroundColor = WINDOW_backgroundColor;
        
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.bottom.offset(0);
            make.width.mas_equalTo(50);
            
        }];
        
        [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleL.mas_right);
            make.right.and.bottom.and.top.offset(0);
            
        }];
    }
    return self;
}

- (void)createBtnWithTimeString:(NSString *)timeStr{
    
    timeL.text = timeStr;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
