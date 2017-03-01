//
//  HistoryModel.h
//  NowExerciseipad
//
//  Created by mac on 16/12/27.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject

Dictionaryproperty(base)
Arrayproperty(recard_remark)
//疾病集伤痛相关注意事项
@property (nonatomic , assign) CGFloat JibingL;
//会员运动喜好机满意部分
@property (nonatomic , assign) CGFloat ManyibufenL;
//运动禁忌
@property (nonatomic , assign) CGFloat JinjiL;
//运动内容及强度建议
@property (nonatomic , assign) CGFloat JianyiL;
//饮食建议
@property (nonatomic , assign) CGFloat YinshiL;
//下位教练需注意
@property (nonatomic , assign) CGFloat NextZhuyiL;
//担忧及问题
@property (nonatomic , assign) CGFloat DanyouL;
//会员变化
@property (nonatomic , assign) CGFloat BianhuaL;
//备注
@property (nonatomic , assign) CGFloat Beizhu;
//总高度
@property (nonatomic , assign) CGFloat AllHeight;


@end
