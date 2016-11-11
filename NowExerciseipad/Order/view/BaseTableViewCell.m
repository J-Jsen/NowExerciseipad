//
//  BaseTableViewCell.m
//  NowExerciseipad
//
//  Created by mac on 16/11/3.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleL = [[Mylabel alloc]init];
        _titleL.textColor = WENDA_COLOR;
        
        _nameL = [[Mylabel alloc]init];
        _nameTF = [[Mytextfield alloc]init];
        
        _sexL = [[Mylabel alloc]init];
        _sexTF = [[Mytextfield alloc]init];
        
        _birthdayL = [[Mylabel alloc]init];
        _birthdayTF = [[Mytextfield alloc]init];
        
        _phonenumberL = [[Mylabel alloc]init];
        _phonenumberTF = [[Mytextfield alloc]init];
        
        _targetL = [[Mylabel alloc]init];
        _targetTF = [[Mytextfield alloc]init];
        
        _targettimeL = [[Mylabel alloc]init];
        _targettimeTF = [[Mytextfield alloc]init];
        
        _upordownL = [[Mylabel alloc]init];
        _upordownTF = [[Mytextfield alloc]init];
        
        _changeL = [[Mylabel alloc]init];
        _ischangebtn = [[xuanzeBTN alloc]init];
        _notchangebtn = [[xuanzeBTN alloc]init];
        
        _changenumberL = [[Mylabel alloc]init];
        _changenumberTF = [[Mytextfield alloc]init];
        
 
        [self addSubview:_titleL];
        [self addSubview:_nameL];
        [self addSubview:_nameTF];
        [self addSubview:_sexL];
        [self addSubview:_sexTF];
        [self addSubview:_birthdayL];
        [self addSubview:_birthdayTF];
        [self addSubview:_phonenumberL];
        [self addSubview:_phonenumberTF];
        [self addSubview:_targettimeL];
        [self addSubview:_targettimeTF];
        [self addSubview:_targetL];
        [self addSubview:_targetTF];
        [self addSubview:_upordownL];
        [self addSubview:_upordownTF];
        [self addSubview:_changeL];
        [self addSubview:_ischangebtn];
        [self addSubview:_notchangebtn];
        [self addSubview: _changenumberL];
        [self addSubview:_changenumberTF];

        [self createUI];
        
    }
    return self;
}

- (void)createUI{
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_offset(10);
        make.width.mas_equalTo(80.0);
        make.height.mas_equalTo(40);
        
    }];
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(WEN_JIANGE_L);
        make.top.mas_equalTo(_titleL.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameL.mas_right).offset(WEN_JIANGE_L * 2);
        make.top.mas_equalTo(_nameL.mas_top);
        make.bottom.mas_equalTo(_nameL.mas_bottom);
        make.width.mas_equalTo(WEN_JIANGE_L * 30);
        
    }];
    [_sexL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleL.mas_bottom).offset(2 * WEN_JIANGE_L);
        make.left.mas_equalTo(_nameTF.mas_right).offset(2 * WEN_JIANGE_L);
        make.width.mas_equalTo(_nameL.mas_width);
        make.height.mas_equalTo(_nameL.mas_height);
        
    }];
    
    [_sexTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sexL.mas_top);
        make.left.mas_equalTo(_sexL.mas_right).offset(WEN_JIANGE_L);
        make.bottom.mas_equalTo(_sexL.mas_bottom);
        make.width.mas_equalTo(30 * WEN_JIANGE_L);
        
    }];
    [_birthdayL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameL.mas_bottom).offset(WEN_JIANGE_L);
        make.left.offset(WEN_JIANGE_L);
        make.width.mas_equalTo(_nameL.mas_width);
        make.height.mas_equalTo(_nameL.mas_height);
        
    }];
    [_birthdayTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_birthdayL.mas_top);
        make.bottom.mas_equalTo(_birthdayL.mas_bottom);
        make.width.mas_equalTo(_nameTF.mas_width);
        make.left.mas_equalTo(_birthdayL.mas_right).offset(WEN_JIANGE_L);
        
    }];
    
    [_phonenumberL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sexL.mas_bottom).offset(WEN_JIANGE_L);
        make.left.mas_equalTo(_sexL.mas_left);
        make.width.mas_equalTo(_sexL.mas_width);
        make.height.mas_equalTo(_sexL.mas_width);
        
    }];
    [_phonenumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phonenumberL.mas_top);
        make.left.mas_equalTo(_phonenumberTF.mas_right).offset(WEN_JIANGE_L);
        make.width.mas_equalTo(_sexTF.mas_width);
        make.height.mas_equalTo(_sexTF.mas_height);
        
    }];
    
}

- (void)creatCellWithdata:(NSMutableDictionary *)dic{
    
    _titleL.text = dic[@"name"];
    
    
    
    
    
    
    
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
