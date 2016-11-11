//
//  FenleiView.h
//  NowExerciseipad
//
//  Created by mac on 16/11/8.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FenLeidelegate <NSObject>

- (void)backdata:(NSString *)data;

@end

@interface FenleiView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableV;

@property (nonatomic , strong) NSMutableArray * arr;

@property (nonatomic , assign) id<FenLeidelegate> delegate;
- (void)createUIWithArr:(NSMutableArray *)arr;

@end
