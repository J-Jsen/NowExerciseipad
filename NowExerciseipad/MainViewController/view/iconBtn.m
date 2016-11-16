//
//  iconBtn.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "iconBtn.h"

@implementation iconBtn

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _iconV = [[UIImageView alloc]init];
        _namelabel = [[UILabel alloc]init];
        
        _iconV.image = [UIImage imageNamed:@"icon.png"];
        _iconV.layer.cornerRadius = 17.0;
        _iconV.layer.masksToBounds = YES;
        
        
        _namelabel.text = @"未登录";
        _namelabel.textColor = [UIColor whiteColor];
        _namelabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        
        [self addSubview:_iconV];
        [self addSubview:_namelabel];
        
        
        [self createUI];
        
    }
    return self;
}
#pragma mark masonry 布局
- (void)createUI{


    [_iconV mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.offset(5.0);
        make.height.mas_equalTo(34);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(34);
        
    }];
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(_iconV.mas_right).offset(5.0);
        make.width.mas_equalTo(120 - 44);
   
    }];

}
- (void)createiconWithiconUrl:(NSString *)url name:(NSString *)name{
    NSLog(@"%@",url);
    
    [_iconV setImageWithURL:[NSURL URLWithString:url]];
    _namelabel.text = name;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
