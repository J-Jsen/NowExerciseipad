//
//  BaseTableViewCell.h
//  NowExerciseipad
//
//  Created by mac on 16/11/3.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic , strong) Mylabel * titleL;
@property (nonatomic , strong) Mylabel * nameL;
@property (nonatomic , strong) Mytextfield * nameTF;

@property (nonatomic , strong) Mylabel * sexL;
@property (nonatomic , strong) Mytextfield * sexTF;

@property (nonatomic , strong) Mylabel * birthdayL;
@property (nonatomic , strong) Mytextfield * birthdayTF;

@property (nonatomic , strong) Mylabel * phonenumberL;
@property (nonatomic , strong) Mytextfield * phonenumberTF;

@property (nonatomic , strong) Mylabel * targetL;
@property (nonatomic , strong) Mytextfield * targetTF;

@property (nonatomic , strong) Mylabel * targettimeL;
@property (nonatomic , strong) Mytextfield * targettimeTF;

@property (nonatomic , strong) Mylabel * upordownL;
@property (nonatomic , strong) Mytextfield * upordownTF;


@property (nonatomic , strong) Mylabel * changeL;
@property (nonatomic , strong) xuanzeBTN * ischangebtn;
@property (nonatomic , strong) xuanzeBTN * notchangebtn;


@property (nonatomic , strong) Mylabel * changenumberL;
@property (nonatomic , strong) Mytextfield * changenumberTF;


- (void)creatCellWithdata:(NSMutableDictionary *)dic;


@end
