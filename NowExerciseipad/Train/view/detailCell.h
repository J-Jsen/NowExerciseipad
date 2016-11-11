//
//  detailCell.h
//  NowExerciseipad
//
//  Created by mac on 16/11/8.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "detailModel.h"
@interface detailCell : UITableViewCell

@property (nonatomic , strong) UILabel * nameL;
@property (nonatomic , strong) UILabel * daylabel;

@property (nonatomic , strong) UILabel * detailL;

- (void)createCellWithModel:(detailModel *)model andTitle:(NSString *)title;
@end
