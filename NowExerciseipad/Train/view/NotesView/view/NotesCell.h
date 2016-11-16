//
//  NotesCell.h
//  NowExerciseipad
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotesModel.h"

@interface NotesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UITextField *teacherTF;
@property (weak, nonatomic) IBOutlet UITextField *dankuiTF;
@property (weak, nonatomic) IBOutlet UITextField *qingkuangTF;
@property (weak, nonatomic) IBOutlet UITextField *beizhuTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *resultSeg;
- (void)createCellWithModel:(NotesModel *)model;
@end
