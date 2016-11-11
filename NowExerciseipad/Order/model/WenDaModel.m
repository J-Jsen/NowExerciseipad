//
//  WenDaModel.m
//  NowExerciseipad
//
//  Created by mac on 16/11/2.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "WenDaModel.h"

@implementation WenDaModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _ID = (NSInteger)value;
        
        
    }
    
}


@end
