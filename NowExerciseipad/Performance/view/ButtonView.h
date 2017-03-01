//
//  ButtonView.h
//  NowExerciseipad
//
//  Created by mac on 16/11/18.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonViewDelegate <NSObject>

- (void)changeTimeWithString:(NSString *)str andindexpath_row:(NSInteger)row;

@end

@interface ButtonView : UIView

@property (nonatomic , assign) id<ButtonViewDelegate> delegate;

@end
