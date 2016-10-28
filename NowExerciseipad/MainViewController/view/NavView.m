//
//  NavView.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "NavView.h"

@implementation NavView

- (instancetype)init{
    self = [super init];
    if (self) {
        _menuBtn = [[UIButton alloc]init];
        _IconBtn = [[iconBtn alloc]init];
        _searchTF = [[UITextField alloc]init];
        _searchBtn = [[UIButton alloc]init];
        _messageBtn = [[UIButton alloc]init];
        
//        _menuBtn.backgroundColor = [UIColor redColor];
        _IconBtn.backgroundColor = [UIColor greenColor];
        _searchTF.backgroundColor = [UIColor whiteColor];
        _searchBtn.backgroundColor = [UIColor yellowColor];
//        _messageBtn.backgroundColor = [UIColor blueColor];
       
        [_messageBtn setImage:[UIImage imageNamed:@"message.png"] forState:UIControlStateNormal];
        [_menuBtn setImage:[UIImage imageNamed:@"caidanopen.png"] forState:UIControlStateNormal];
        
        
        _menuBtn.imageView.contentMode = UIViewContentModeLeft;
        

        [self addSubview:_menuBtn];
        [self addSubview:_IconBtn];
        [self addSubview:_searchBtn];
        [self addSubview:_searchTF];
        [self addSubview:_messageBtn];
        
        [self createUI];

    }
    
    return self;
    
}

#pragma mark masonry 布局
- (void)createUI{
    __weak typeof (self) weakSelf = self;
    //菜单
    [_menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(30.0);
        make.left.mas_equalTo(weakSelf.mas_left).offset(20.0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-10.0);
        make.width.mas_equalTo(54);

    }];
    //搜索框
    [_searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(30.0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-10.0);
        make.centerX.mas_equalTo(-24);
        make.width.mas_equalTo(UISCREEN_W / 5.0);
        
        
    }];
    //头像
    [_IconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(30.0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-10.0);
        make.left.mas_equalTo(_menuBtn.mas_right).offset(UISCREEN_W / 15.0);
        make.width.mas_equalTo(150.0);
        
    }];

    //搜索按钮
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(30.0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-10.0);
        make.left.mas_equalTo(_searchTF.mas_right).offset(4);
        make.width.mas_equalTo(44);
        
        
    }];
    //消息按钮
    [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(32.0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-12.0);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-40);
        make.width.mas_equalTo(40);
        
        
        
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
