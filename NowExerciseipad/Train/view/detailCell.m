//
//  detailCell.m
//  NowExerciseipad
//
//  Created by mac on 16/11/8.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "detailCell.h"

@interface detailCell()

@property (nonatomic , strong) UILabel * line;


@end


@implementation detailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WINDOW_backgroundColor;
        self.userInteractionEnabled = NO;
        _nameL = [[UILabel alloc]init];
        _nameL.textColor = WENDA_COLOR;

        [_nameL setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [self addSubview:_nameL];
        
        _daylabel = [[UILabel alloc]init];
        _daylabel.font = [UIFont systemFontOfSize:21];
        _daylabel.textColor = WENDA_COLOR;
        
        [self addSubview:_daylabel];
        
        _detailL = [[UILabel alloc]init];
        _detailL.textColor = [UIColor whiteColor];
        _detailL.numberOfLines = 0;
        _detailL.font = [UIFont fontWithName:@"American Typewriter" size:17.0];
        [self addSubview:_detailL];
        
        _line = [[UILabel alloc]init];
        _line.layer.cornerRadius = 0.5;
        _line.layer.masksToBounds = YES;
        _line.backgroundColor = WENDA_COLOR;
        
        [self addSubview:_line];
        
        [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
            
        }];
        [_daylabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameL.mas_right).offset(5);
            make.top.mas_equalTo(_nameL.mas_top);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(30);
            
        }];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameL.mas_bottom);
            make.left.offset(10);
            make.right.offset(-10);
            make.height.mas_equalTo(1);
            
        }];
        [_detailL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(0);
            make.left.offset(10);
            make.right.offset(-10);
            make.top.mas_equalTo(_nameL.mas_bottom).offset(11);
            
        }];
        
        
    }
    return self;
}

- (void)createCellWithModel:(detailModel *)model andTitle:(NSString *)title{
    
    _nameL.text = title;
    _daylabel.text = model.name;
    
    _detailL.text = model.content;
    
//    CGRect r = [model.content boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"ArialUnicodeMS" size:17.1]} context:nil];
//    model.label_heiht = r.size.height + 20;
    
}
@end
