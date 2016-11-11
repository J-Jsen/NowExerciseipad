//
//  Mylabel.m
//  NowExerciseipad
//
//  Created by mac on 16/11/4.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "Mylabel.h"

@implementation Mylabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.font = [UIFont systemFontOfSize:20];
        
    }
    
    return self;
    
}

@end
