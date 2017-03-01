//
//  moveCell.m
//  NowExerciseipad
//
//  Created by mac on 16/11/10.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "moveCell.h"

@interface moveCell()

@property (nonatomic , strong) UILabel * label;

@property (nonatomic , strong) UILabel * yuanL;


@end

@implementation moveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WINDOW_backgroundColor;
        _label = [[UILabel alloc]init];
        _yuanL = [[UILabel alloc]init];
        
        _label.textColor = WENDA_COLOR;
        _label.font = [UIFont fontWithName:@"American Typewriter" size:14];
        _yuanL.backgroundColor = WENDA_COLOR;
        _yuanL.layer.cornerRadius = 5;
        _yuanL.layer.masksToBounds = YES;
        
        [self addSubview:_label];
        [self addSubview:_yuanL];
      //  __weak typeof (self) weakSelf = self;

        [_yuanL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.centerY.offset(0);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(5);
            make.left.mas_equalTo(_yuanL.mas_right).offset(5);
            make.bottom.offset(-5);
            make.width.mas_equalTo(100);
            
        }];
    }
    return self;
}
- (void)CreateCellWithString:(NSString *)str{
    
    _label.text = str;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
