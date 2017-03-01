//
//  searchView.h
//  NowExerciseipad
//
//  Created by mac on 16/11/18.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchDetailView.h"

@interface searchView : UIView
{
//    searchDetailView * detailV;

}
@property (nonatomic , strong) searchDetailView *detaiV;

- (void)seturlWithString:(NSString *)str;

@end
