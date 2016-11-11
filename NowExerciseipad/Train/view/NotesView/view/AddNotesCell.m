//
//  NotesCell.m
//  NowExerciseipad
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "AddNotesCell.h"

@interface AddNotesCell()
{
    
}
@end

@implementation AddNotesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)createCellWithModel:(AddNotesModel *)model{
    self.backgroundColor = WINDOW_backgroundColor;

    _nameTF.text = model.name;
    _fankuiTF.text = model.fankui;
    _qingkuangTF.text = model.qingkuang;
    _beizhuTF.text = model.beizhu;
    [_resultSeg setSelectedSegmentIndex:model.result];
    _saveBtn.layer.cornerRadius = 5;
    _saveBtn.layer.masksToBounds = YES;
    
}
- (IBAction)selectnumber:(id)sender {
    
    UISegmentedControl * seg = (UISegmentedControl *)sender;
    NSInteger selectI = seg.selectedSegmentIndex;
    NSLog(@"选中了:%ld",selectI);

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
