//
//  checkCell.m
//  NowExerciseipad
//
//  Created by mac on 16/11/21.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "checkCell.h"

@implementation checkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)createCellWithModel:(checkModel *)model{
    _nameL.text = model.name;
    _timeL.text = model.time;
    _coachNameL.text = model.invigilation;
    if ([model.result isEqualToString:@"优"]) {
        _resultL.selectedSegmentIndex = 0;

    }else if ([model.result isEqualToString:@"良"]){
        _resultL.selectedSegmentIndex = 1;

    }else if ([model.result isEqualToString:@"中"]){
        _resultL.selectedSegmentIndex = 2;

    }else{
        _resultL.selectedSegmentIndex = 3;

    }
    _beizhuL.text = model.remark;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
