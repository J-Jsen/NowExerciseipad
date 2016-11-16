//
//  NotesCell.h
//  NowExerciseipad
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNotesModel.h"

@protocol AddNotesCellDelegate <NSObject>

- (void)AddBtnclick:(AddNotesModel *)model;

@end

@interface AddNotesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *fankuiTF;
@property (weak, nonatomic) IBOutlet UITextField *qingkuangTF;
@property (weak, nonatomic) IBOutlet UITextField *beizhuTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *resultSeg;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@property (weak, nonatomic) IBOutlet UIButton *jieduanBtn;

@property (weak, nonatomic) IBOutlet UILabel *jieduanL;
@property (weak, nonatomic) IBOutlet UILabel *dayL;

@property (nonatomic , assign) id <AddNotesCellDelegate> delegate;

- (void)createCellWithModel:(AddNotesModel *)model;

@end
