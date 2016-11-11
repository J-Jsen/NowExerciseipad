//
//  FenLeiButton.m
//  NowExerciseipad
//
//  Created by mac on 16/11/4.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "FenLeiButton.h"

@implementation FenLeiButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    if (self = [super init]) {
        _label = [[UILabel alloc]init];
        _imageV = [[UIImageView alloc]init];
        
        [self addSubview:_label];
        [self addSubview:_imageV];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:20.0];
        _label.textAlignment = NSTextAlignmentCenter;
        
        _imageV.image = [UIImage imageNamed:@""];
        
        [self creatUI];
        
        
    }
    return self;
}
- (void)creatUI{
        __weak typeof (self) weakSelf = self;

    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.left.and.bottom.mas_offset(0);
        make.width.mas_equalTo(CGRectGetMaxX(weakSelf.frame)-CGRectGetMaxY(weakSelf.frame));
        
    }];
    
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.offset(0);
        make.width.mas_equalTo(weakSelf.mas_height);
        
    }];
    
}
@end
