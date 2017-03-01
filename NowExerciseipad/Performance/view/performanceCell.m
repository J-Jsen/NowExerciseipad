//
//  performanceCell.m
//  NowExerciseipad
//
//  Created by mac on 16/11/17.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "performanceCell.h"

@implementation performanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)createCellWithModel:(performanceModel *)model{
    
    _timeL.layer.borderWidth = 1;
    _timeL.layer.borderColor = WENDA_COLOR.CGColor;
    
    _VIPL.layer.borderWidth = 1;
    _VIPL.layer.borderColor = WENDA_COLOR.CGColor;
    
    _classL.layer.borderWidth = 1;
    _classL.layer.borderColor = WENDA_COLOR.CGColor;
    
    _paceL.layer.borderWidth = 1;
    _paceL.layer.borderColor = WENDA_COLOR.CGColor;
    
    _classtimeL.layer.borderWidth = 1;
    _classtimeL.layer.borderColor = WENDA_COLOR.CGColor;
    
    
    _timeL.text = model.time;
    _VIPL.text = model.user_name;
    _classL.text = model.course_name;
    _paceL.text = [NSString stringWithFormat:@"%ld",(long)model.pay_amount];
    _classtimeL.text = [NSString stringWithFormat:@"%ld",(long)model.obtain_money];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
