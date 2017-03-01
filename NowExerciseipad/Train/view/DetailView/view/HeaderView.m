//
//  HeaderView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/10.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView()

@property (nonatomic , strong) UILabel * label;
@property (nonatomic , strong) UILabel * yuanL;

@end

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    if (self = [super init]) {
    
        self.backgroundColor = WINDOW_backgroundColor;
        _label = [[UILabel alloc]init];
        _yuanL = [[UILabel alloc]init];
        
        _label.textColor = WENDA_COLOR;
        _label.font = [UIFont fontWithName:@"American Typewriter" size:17];
        _yuanL.backgroundColor = WENDA_COLOR;
        _yuanL.layer.cornerRadius = 10;
        _yuanL.layer.masksToBounds = YES;
        
        [self addSubview:_label];
        [self addSubview:_yuanL];
       // __weak typeof (self) weakSelf = self;
        
        [_yuanL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.centerY.offset(0);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(5);
            make.left.mas_equalTo(_yuanL.mas_right).offset(5);
            make.bottom.offset(-5);
            make.width.mas_equalTo(100);
            
        }];

        
    }
    return self;
    
}
- (void)CreateHeaderViewWithString:(NSString *)str{
    
    _label.text = str;
    
}
@end
