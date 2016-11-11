//
//  trainModel.m
//  NowExerciseipad
//
//  Created by mac on 16/11/8.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "trainModel.h"

@implementation trainModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        _Description = value;
    }
    
}

@end
