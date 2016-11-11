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
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        
        
        _imageV = [[UIImageView alloc]init];
        _imageV.image = [UIImage imageNamed:name];
        
        [self addSubview:_imageV];
        
        _label = [[UILabel alloc]init];
        _label.textColor = WENDA_COLOR;
        
        [self addSubview:_label];
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.offset(-15);
            make.top.offset(5);
            make.bottom.offset(-25);
            
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
