//
//  OptionBtn.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "OptionBtn.h"

@implementation OptionBtn


- (instancetype)initWithName:(NSString *)name andWithImageName:(NSString *)imageName{
    
    if (self = [super init]) {
     
        _imageV = [[UIImageView alloc]init];
        _Classtitlelabel = [[UILabel alloc]init];
        
        _Classtitlelabel.text = name;
        _Classtitlelabel.textAlignment = NSTextAlignmentCenter;
        _Classtitlelabel.font = [UIFont systemFontOfSize:17];
        
        _imageV.image = [UIImage imageNamed:imageName];
        
        
        [self addSubview:_Classtitlelabel];
        [self addSubview:_imageV];
        
        [self createUI];
        
        
    }
    return self;
}

- (void)createUI{
    
    
    __weak typeof (self) weakSelf = self;

    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(weakSelf.mas_top).offset(50);
        make.left.mas_equalTo(weakSelf.mas_left).offset(50.0*120.0/111.0);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-50.0*120.0/111.0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-50);
        
        
    }];
    
    
    [_Classtitlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(5);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-5);
        make.top.mas_equalTo(_imageV.mas_bottom).offset(5);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-5);
        
        
    }];
    
    
    
}





@end
