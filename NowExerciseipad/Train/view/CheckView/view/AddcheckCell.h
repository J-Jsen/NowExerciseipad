//
//  AddcheckCell.h
//  NowExerciseipad
//
//  Created by mac on 16/11/21.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "checkModel.h"

@protocol AddcheckDelegate <NSObject>

- (void)savedataWithModel:(checkModel *)model;

@end

@interface AddcheckCell : UITableViewCell

@property (nonatomic , assign) id<AddcheckDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *jieduanL;
@property (weak, nonatomic) IBOutlet UIButton *jieduanBtn;
@property (weak, nonatomic) IBOutlet UILabel *leixingL;
@property (weak, nonatomic) IBOutlet UIButton *leixingBtn;
@property (weak, nonatomic) IBOutlet UILabel *leiixngL;

@property (weak, nonatomic) IBOutlet UITextField *timeTF;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (weak, nonatomic) IBOutlet UITextField *beizhuTF;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (void)createCellWithModel:(checkModel *)model;

@end
