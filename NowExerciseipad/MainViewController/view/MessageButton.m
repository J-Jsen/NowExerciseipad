//
//  MessageButton.m
//  NowExerciseipad
//
//  Created by mac on 16/11/22.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "MessageButton.h"

@implementation MessageButton

- (instancetype)init{
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNumber:) name:@"pushmessage" object:nil];
        
        _numberLabel = [[UILabel alloc]init];
        
        [self addSubview:_numberLabel];
        
        _numberLabel.layer.cornerRadius = 10;
        _numberLabel.layer.masksToBounds = YES;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont systemFontOfSize:14];
        _numberLabel.textColor = [UIColor whiteColor];
        
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(-5);
            make.right.offset(5);
            make.width.and.height.mas_equalTo(20);
        }];
        
    }
    return self;
}
- (void)changeNumber:(NSNotification *)noti{
//    NSLog(@"通知消息内容:%@",noti);
    NSString * number = [noti.userInfo valueForKey:@"number"];
    NSLog(@"收到推送通知 数量为:%@",number);
    
    [self changeMessageBtnNumber:number];
    
}
- (void)changeMessageBtnNumber:(NSString *)number{
    
    if ([number isEqualToString:@"0"]) {
        _numberLabel.text = @"";
        _numberLabel.backgroundColor = [UIColor clearColor];
    }else{
        _numberLabel.text = number;
        _numberLabel.backgroundColor = [UIColor redColor];
    }
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushmessage" object:nil];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
