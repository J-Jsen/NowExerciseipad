//
//  GoButton.m
//  NowExerciseipad
//
//  Created by mac on 16/11/1.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "GoButton.h"

@implementation GoButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    
    if (self = [super init]) {
     
        _imageV = [[UIImageView alloc]init];
        _animaionimageV = [[UIImageView alloc]init];
        
        [self addSubview:_imageV];
        [self addSubview:_animaionimageV];
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(self.mas_width);
            make.width.mas_equalTo(self.mas_width);
            
        }];
        _imageV.image = [UIImage imageNamed:@"12.png"];
        
        
        
    }
    return self;
}


- (void)willGO{
    
    
    
}
- (void)doNew{
       _animaionimageV.image = [UIImage imageNamed:@"13.png"];
    
    [_animaionimageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.height.mas_equalTo(self.mas_width);
        make.width.mas_equalTo(self.mas_width);
        
    }];
    [_imageV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.height.mas_equalTo(130);
        make.width.mas_equalTo(130);
        
    }];
    _imageV.image = [UIImage imageNamed:@"14.png"];
    
    
    
//    NSTimer * time = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(transformimage) userInfo:nil repeats:YES];
//    _animaionimageV.layer.anchorPoint = CGPointMake(_imageV.center.x, _imageV.center.y);
    
    CABasicAnimation * layer = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    layer.toValue = @(2 * M_PI);
    layer.duration = 5;
    layer.removedOnCompletion = NO;
    layer.repeatCount = MAXFLOAT;
    [_animaionimageV.layer addAnimation:layer forKey:nil];
    
}

- (void)didEnd{
    [_animaionimageV removeFromSuperview];
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.height.mas_equalTo(self.mas_width);
        make.width.mas_equalTo(self.mas_width);
        
    }];
    _imageV.image = [UIImage imageNamed:@"15.png"];
    
    
}



@end
