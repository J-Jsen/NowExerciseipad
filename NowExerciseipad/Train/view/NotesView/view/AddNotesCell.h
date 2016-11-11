//
//  NotesCell.h
//  NowExerciseipad
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNotesModel.h"

@interface AddNotesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *fankuiTF;
@property (weak, nonatomic) IBOutlet UITextField *qingkuangTF;
@property (weak, nonatomic) IBOutlet UITextField *beizhuTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *resultSeg;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

- (void)createCellWithModel:(AddNotesModel *)model;

@end
