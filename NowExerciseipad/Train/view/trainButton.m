//
//  trainButton.m
//  NowExerciseipad
//
//  Created by mac on 16/11/9.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "trainButton.h"

@implementation trainButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithtitlename:(NSString *)title andimagename:(NSString *)name{
    
    if (self = [super init]) {
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = LEFTBTNTEXT_BACKGROUNDCOLOR.CGColor;
        
        
        _imageV = [[UIImageView alloc]init];
        _imageV.image = [UIImage imageNamed:name];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imageV];
        
        _label = [[UILabel alloc]init];
        _label.textColor = WENDA_COLOR;
        _label.text = title;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:15];
        [self addSubview:_label];
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(25);
            make.right.offset(-25);
            make.top.offset(25);
            make.bottom.offset(-35);
            
        }];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.offset(0);
            make.top.mas_equalTo(_imageV.mas_bottom).offset(5);
            make.bottom.offset(-5);
            
        }];
    }
    return self;
}


- (void)changeColorWithimagename:(NSString *)name{
    
    _imageV.image = [UIImage imageNamed:name];
    _label.textColor = [UIColor orangeColor];
    
    
}
- (void)backColorWithimagename:(NSString *)name{
    
    _imageV.image = [UIImage imageNamed:name];
    _label.textColor = WENDA_COLOR;
    
    
}
@end
