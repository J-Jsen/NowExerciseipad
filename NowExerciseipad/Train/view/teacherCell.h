//
//  teacherCell.h
//  NowExerciseipad
//
//  Created by mac on 16/11/10.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TeacherModel.h"

@interface teacherCell : UITableViewCell

- (void)createCellWithModel:(TeacherModel *)model;
- (void)selectCellwithmodel:(TeacherModel *)model;
- (void)disselectCellwithmodel:(TeacherModel *)model;

@end
