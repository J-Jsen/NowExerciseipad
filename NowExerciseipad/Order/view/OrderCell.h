//
//  OrderCell.h
//  NowExerciseipad
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@interface OrderCell : UITableViewCell


@property (nonatomic , strong) UILabel * nameLabel;
@property (nonatomic , strong) UILabel * sexLabel;
@property (nonatomic , strong) UILabel * classnameLabel;
@property (nonatomic , strong) UILabel * placeLabel;
@property (nonatomic , strong) UILabel * onclasstimeLabel;
@property (nonatomic , strong) UILabel * phonenumberLabel;
@property (nonatomic , strong) UILabel * StatusLabel;
@property (nonatomic , strong) UILabel * classtypeLabel;

@property (nonatomic , strong) UIView * backgroundV;

@property (nonatomic , strong) UIButton * doOrderBtn;
@property (nonatomic , strong) UIButton * cantOrderBtn;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


- (void)createCellWithmodel:(OrderModel *)model;

@end
