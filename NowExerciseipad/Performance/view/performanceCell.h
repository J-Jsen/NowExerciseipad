//
//  performanceCell.h
//  NowExerciseipad
//
//  Created by mac on 16/11/17.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "performanceModel.h"

@interface performanceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UILabel *VIPL;

@property (weak, nonatomic) IBOutlet UILabel *classL;
@property (weak, nonatomic) IBOutlet UILabel *paceL;

@property (weak, nonatomic) IBOutlet UILabel *classtimeL;

- (void)createCellWithModel:(performanceModel *)model;

@end
