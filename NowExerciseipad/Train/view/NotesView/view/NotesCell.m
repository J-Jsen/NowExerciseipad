//
//  NotesCell.m
//  NowExerciseipad
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "NotesCell.h"
@implementation NotesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)createCellWithModel:(NotesModel *)model{
    
    _titleL.text = model.content;
    _timeL.text = model.time;
    _teacherTF.text = model.training_coach;
    _dankuiTF.text = model.feedback;
    _qingkuangTF.text = model.progress;
    _beizhuTF.text = model.remark;
    if ([model.result isEqualToString:@"优"]){
        _resultSeg.selectedSegmentIndex = 0;
        
    }else if([model.result isEqualToString:@"良"]){
        _resultSeg.selectedSegmentIndex = 1;

    }else if ([model.result isEqualToString:@"中"]){
        _resultSeg.selectedSegmentIndex = 2;

    }else if ([model.result isEqualToString:@"差"]){
        _resultSeg.selectedSegmentIndex = 3;

    }
    
}
@end
