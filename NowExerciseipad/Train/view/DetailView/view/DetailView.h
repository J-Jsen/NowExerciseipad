//
//  DetailView.h
//  NowExerciseipad
//
//  Created by mac on 16/11/9.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "moveView.h"

@protocol Detaildelegate <NSObject>

- (void)showAlertWithmessage:(NSString *)message;

@end


@interface DetailView : UIView

@property (nonatomic , strong) UITableView * tableV;
@property (nonatomic , strong) moveView * moveV;

@property (nonatomic , assign) id<Detaildelegate> delegate;


@end
