//
//  performHeaderView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/17.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "performHeaderView.h"

@interface performHeaderView()

{
    UILabel * label1;
    UILabel * label2;
    UILabel * label3;
    UILabel * label4;
    UILabel * label5;

}

@end

@implementation performHeaderView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = LEFTBTNTEXT_BACKGROUNDCOLOR;
        
        label1 = [[UILabel alloc]init];
        label2 = [[UILabel alloc]init];
        label3 = [[UILabel alloc]init];
        label4 = [[UILabel alloc]init];
        label5 = [[UILabel alloc]init];

        [self addSubview:label1];
        [self addSubview:label2];
        [self addSubview:label3];
        [self addSubview:label4];
        [self addSubview:label5];
    __weak typeof(self) weakSelf = self;
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.bottom.and.top.offset(0);
            make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(1 / 5.0f);
        }];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.offset(0);
            make.left.mas_equalTo(label1.mas_right);
            make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(1 / 5.0f);

        }];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.offset(0);
            make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(1 / 5.0f);
            make.left.mas_equalTo(label2.mas_right);

        }];
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.offset(0);
            make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(1 / 5.0f);
            make.left.mas_equalTo(label3.mas_right);

        }];
        [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.and.right.offset(0);
            make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(1 / 5.0f);

        }];
        
        label1.text = @"时  间";
        label2.text = @"会  员";
        label3.text = @"课  程";
        label4.text = @"价  格";
        label5.text = @"课 程 费";

        label1.textColor = [UIColor whiteColor];
        label2.textColor = [UIColor whiteColor];
        label3.textColor = [UIColor whiteColor];
        label4.textColor = [UIColor whiteColor];
        label5.textColor = [UIColor whiteColor];
        
        label1.layer.borderWidth = 1;
        label2.layer.borderWidth = 1;
        label3.layer.borderWidth = 1;
        label4.layer.borderWidth = 1;
        label5.layer.borderWidth = 1;
        
        label1.layer.borderColor = WENDA_COLOR.CGColor;
        label2.layer.borderColor = WENDA_COLOR.CGColor;
        label3.layer.borderColor = WENDA_COLOR.CGColor;
        label4.layer.borderColor = WENDA_COLOR.CGColor;
        label5.layer.borderColor = WENDA_COLOR.CGColor;
        
        label1.textAlignment = NSTextAlignmentCenter;
        label2.textAlignment = NSTextAlignmentCenter;
        label3.textAlignment = NSTextAlignmentCenter;
        label4.textAlignment = NSTextAlignmentCenter;
        label5.textAlignment = NSTextAlignmentCenter;

        label1.backgroundColor = WINDOW_backgroundColor;
        label2.backgroundColor = WINDOW_backgroundColor;
        label3.backgroundColor = WINDOW_backgroundColor;
        label4.backgroundColor = WINDOW_backgroundColor;
        label5.backgroundColor = WINDOW_backgroundColor;
        
        label1.font = [UIFont systemFontOfSize:20];
        label2.font = [UIFont systemFontOfSize:20];
        label3.font = [UIFont systemFontOfSize:20];
        label4.font = [UIFont systemFontOfSize:20];
        label5.font = [UIFont systemFontOfSize:20];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
