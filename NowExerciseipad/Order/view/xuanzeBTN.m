//
//  xuanzeBTN.m
//  NowExerciseipad
//
//  Created by mac on 16/11/3.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "xuanzeBTN.h"

@implementation xuanzeBTN


- (instancetype)initWithMessage:(NSString *)message{
    
    if (self = [super init]) {
        
        _imageV = [[UIImageView alloc]init];
        _label = [[UILabel alloc]init];
        _label.textColor = [UIColor whiteColor];
        _label.text = message;
        _label.font = [UIFont systemFontOfSize:20];

        _imageV.image = [UIImage imageNamed:@"12.png"];
        
        
        [self addSubview:_imageV];
        [self addSubview:_label];
        
        [self createUI];
        
    }
    return self;
}

- (void)createUI{
    
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.offset(0);
        make.width.mas_equalTo(self.mas_height);
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imageV.mas_right).offset(5.0);
        make.top.and.bottom.and.right.offset(0);
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
