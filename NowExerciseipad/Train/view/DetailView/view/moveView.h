//
//  moveView.h
//  NowExerciseipad
//
//  Created by mac on 16/11/9.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol movedelegate <NSObject>

- (void)showAlertWithString:(NSString *)str;

- (void)moveCellToplace:(NSIndexPath *)indexpath;

@end

@interface moveView : UIView

@property (nonatomic , assign) id<movedelegate> delegate;

@end
