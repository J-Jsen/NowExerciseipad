//
//  NotesModel.m
//  NowExerciseipad
//
//  Created by mac on 16/11/11.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "NotesModel.h"

@implementation NotesModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = [value integerValue];
        
    }
}

@end
