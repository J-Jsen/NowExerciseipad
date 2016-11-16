//
//  jieduanView.h
//  NowExerciseipad
//
//  Created by mac on 16/11/14.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol jieduanDelegate <NSObject>

- (void)selectjieduanNumber:(NSInteger)row andjieduanStr:(NSString *)str;

@end

@interface jieduanView : UIView

@property (nonatomic , assign) id <jieduanDelegate>delegate;

- (instancetype)initWithArray:(NSMutableArray *)arr;


@end
