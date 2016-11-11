//
//  detailheaderView.m
//  NowExerciseipad
//
//  Created by mac on 16/11/9.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "detailheaderView.h"

@interface detailheaderView()

@property (nonatomic , strong) UILabel * label;
@property (nonatomic , strong) UILabel * line;

@end

@implementation detailheaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithtitle:(NSString *)title{
    if (self = [super init]) {
        self.backgroundColor = WINDOW_backgroundColor;
        
        _label = [[UILabel alloc]init];
        _label.text = title;
        _label.textColor = WENDA_COLOR;
        _label.font = [UIFont fontWithName:@"American Typewriter" size:22.0];

        [self addSubview:_label];
        _line = [[UILabel alloc]init];
        _line.backgroundColor = WENDA_COLOR;
        _line.layer.cornerRadius = 0.5;
        _line.layer.masksToBounds = YES;
        
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(0);
            make.left.offset(10);
            make.right.offset(-10);
            
            make.height.mas_equalTo(1);
            
        }];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
    }
    return self;
}

@end
