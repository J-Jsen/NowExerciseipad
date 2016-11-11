//
//  ClassCell.h
//  NowExerciseipad
//
//  Created by mac on 16/11/4.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassModel.h"
@interface ClassCell : UITableViewCell

@property (nonatomic , strong) UIImageView * imageV;

@property (nonatomic , strong) UILabel * label;

//@property (nonatomic , assign) BOOL isselect;
@property (nonatomic , strong) ClassModel * model1;
- (void)creatCellWithClassModel:(ClassModel *)model;

- (void)changeColor;

- (void)backColor;


@end
