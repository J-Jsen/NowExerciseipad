//
//  checkCell.h
//  NowExerciseipad
//
//  Created by mac on 16/11/21.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "checkModel.h"
@interface checkCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *coachNameL;

@property (weak, nonatomic) IBOutlet UISegmentedControl *resultL;
@property (weak, nonatomic) IBOutlet UILabel *beizhuL;
- (void)createCellWithModel:(checkModel *)model;

@end
