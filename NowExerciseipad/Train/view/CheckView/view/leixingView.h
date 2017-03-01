//
//  leixingView.h
//  NowExerciseipad
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol leixingViewDelegate <NSObject>

- (void)backleixingStr:(NSString *)str;


@end

@interface leixingView : UIView
@property (nonatomic , assign) id <leixingViewDelegate> delegate;

@end
