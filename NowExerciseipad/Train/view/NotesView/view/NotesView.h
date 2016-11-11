//
//  NotesView.h
//  NowExerciseipad
//
//  Created by mac on 16/11/10.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface NotesView : UIView


- (void)seturlwithtype:(NSInteger)type filtertype:(NSString *)filtertype teacherID:(NSInteger)teacherID filterID:(NSInteger)fileterID ;
- (void)reloadData;


@end
