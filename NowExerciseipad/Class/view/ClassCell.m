//
//  ClassCell.m
//  NowExerciseipad
//
//  Created by mac on 16/11/4.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "ClassCell.h"

@implementation ClassCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WINDOW_backgroundColor;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        _label = [[UILabel alloc]init];
        _imageV = [[UIImageView alloc]init];
        [_imageV.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        _label.textColor = WENDA_COLOR;
        _label.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_label];
        [self addSubview:_imageV];
        
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(20);
            make.left.offset(30);
            make.right.offset(-30);
            make.bottom.offset(-40);
            
        }];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_imageV.mas_bottom).offset(5);
            make.left.offset(15);
            make.right.offset(-15);
            make.bottom.offset(-5);
            
        }];
        
    }
    return self;
}
- (void)creatCellWithClassModel:(ClassModel *)model{
    _model1 = model;
    _label.text = model.train_type;
    [_imageV setImageWithURL:[NSURL URLWithString:model.icon]];
    UIImage * image = _imageV.image;
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _imageV.image = image;
    [_imageV.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    _imageV.tintColor = [UIColor yellowColor];
    if (model.isselect) {
        [self changeColor];
    }else{
        [self backColor];
    }
    
}
- (void)changeColor{
    
    _label.textColor = [UIColor orangeColor];
    [_imageV setTintColor:[UIColor blueColor]];
    _model1.isselect = YES;
    
    
}
- (void)backColor{
    _model1.isselect = NO;
    _label.textColor = WENDA_COLOR;
    [_imageV setTintColor:[UIColor yellowColor]];
    
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
