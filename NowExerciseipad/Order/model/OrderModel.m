//
//  OldOrderModel.m
//  NowExerciseipad
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"process"]) {
        if ([value isEqualToString:@"true"]) {
            self.Process = YES;
        }else{
            self.Process = NO;
            
        }
    }
  
    
}


@end
