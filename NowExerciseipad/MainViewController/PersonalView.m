//
//  PersonalView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/15.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "PersonalView.h"
#import "LoginViewController.h"
@interface PersonalView()
{
    UIImageView * iconimageV;
    UILabel * nameL;
    UIButton * changeUserBtn;
    
    UILabel * classLabel;
    UILabel * placeLabel;
    UILabel * personIDlabel;
    
    UILabel * classL;
    UILabel * placeL;
    UILabel * personIDL;
    
}

@end
@implementation PersonalView


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
        
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * name = [defaults valueForKey:@"username"];
        NSString * place = [defaults valueForKey:@"place"];
        NSString * IDcard = [defaults valueForKey:@"personID"];
        NSString * classtimes = [defaults valueForKey:@"classtime"];
        NSString * iconurl = [defaults valueForKey:@"iconurl"];
        
        
        iconimageV = [[UIImageView alloc]init];
        nameL = [[UILabel alloc]init];
        changeUserBtn = [[UIButton alloc]init];
        
        
        iconimageV.backgroundColor = WINDOW_backgroundColor;
        iconimageV.layer.cornerRadius = 100;
        iconimageV.layer.masksToBounds = YES;
        iconimageV.layer.borderWidth = 1;
        iconimageV.layer.borderColor = [UIColor whiteColor].CGColor;
        
        nameL.textColor = [UIColor whiteColor];
        nameL.font = [UIFont systemFontOfSize:20];
        nameL.textAlignment = NSTextAlignmentCenter;
        
        //下划线
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"更换账号登入"];
        NSRange strRange = {0,[str length]};
//        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        NSDictionary * dic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor orangeColor]};
        
        [str addAttributes:dic range:strRange];
        [changeUserBtn setAttributedTitle:str forState:UIControlStateNormal];
        
        [changeUserBtn addTarget:self action:@selector(changeUserBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        
//赋值
        [iconimageV setImageWithURL:[NSURL URLWithString:iconurl]];
        nameL.text = name;
        
        
        [self addSubview:iconimageV];
        [self addSubview:nameL];
        [self addSubview:changeUserBtn];
        
#pragma mark 定

        
        classLabel = [[UILabel alloc]init];
        placeLabel = [[UILabel alloc]init];
        personIDlabel = [[UILabel alloc]init];
        
        classLabel.text = [NSString stringWithFormat:@"出课数: %@",classtimes];
        
        placeLabel.text = [NSString stringWithFormat:@"所在地址: %@",place];
        personIDlabel.text = [NSString stringWithFormat:@"身份证号 :%@",IDcard];
        
        classLabel.textColor = [UIColor whiteColor];
        placeLabel.textColor = [UIColor whiteColor];
        personIDlabel.textColor = [UIColor whiteColor];
        
        classLabel.font = [UIFont systemFontOfSize:20];
        placeLabel.font = [UIFont systemFontOfSize:20];
        personIDlabel.font = [UIFont systemFontOfSize:20];
        
        [self addSubview:classLabel];
        [self addSubview:placeLabel];
        [self addSubview:personIDlabel];
        
        
#pragma mark 参数
        classL = [[UILabel alloc]init];
        placeL = [[UILabel alloc]init];
        personIDL = [[UILabel alloc]init];
        
        
        [self createUI];
        
        
    }
    return self;
}

- (void)changeUserBtnclick:(UIButton *)btn{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
    
    
}
- (void)createUI{
    [iconimageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(-200);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(200);
        
    }];
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(iconimageV.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        
    }];
    [changeUserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(nameL.mas_bottom).offset(50);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
        
    }];
    
    [personIDlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-50);
        make.left.offset(100);
        make.width.mas_equalTo(400);
        make.height.mas_equalTo(40);
        
    }];
    [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(personIDlabel.mas_top).offset(-20);
        make.left.mas_equalTo(personIDlabel.mas_left);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(nameL.mas_height);
    }];
    
    [classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(placeLabel.mas_top).offset(-20);
        make.left.mas_equalTo(placeLabel.mas_left);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(placeLabel.mas_height);
        
    }];
}
@end
