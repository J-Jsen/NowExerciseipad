//
//  HistoryCell.h
//  NowExerciseipad
//
//  Created by mac on 16/12/27.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryModel.h"

@interface HistoryCell : UITableViewCell
@property (strong, nonatomic)  UILabel *dayLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  UILabel *touchLabel;
@property (strong, nonatomic)  UILabel *XinlvLabel;
@property (strong, nonatomic)  UILabel *BiaoxianLabel;
@property (strong, nonatomic)  UILabel *ReqingLabel;
@property (strong, nonatomic)  UILabel *NeirongLabel;

//需要设置自适应
@property (strong, nonatomic)  UILabel *JibingLabel;
@property (strong, nonatomic)  UILabel *ManyibufenLabel;
@property (strong, nonatomic)  UILabel *JinjiLabel;
@property (strong, nonatomic)  UILabel *JianyiLabel;
@property (strong, nonatomic)  UILabel *YinshiLabel;
@property (strong, nonatomic)  UILabel *NextZhuyiLabel;
@property (strong, nonatomic)  UILabel *DanyouLabel;
@property (strong, nonatomic)  UILabel *BianhuaLabel;
@property (strong, nonatomic)  UILabel *BeizhuLabel;



- (void)createCellWithModel:(HistoryModel *)model;


@end
