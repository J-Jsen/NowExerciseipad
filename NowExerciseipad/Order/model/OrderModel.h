//
//  OldOrderModel.h
//  NowExerciseipad
//
//  Created by mac on 16/10/31.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

Stringproperty(name)//名字
Boolproperty(Process)//课程是否完成
Intagerproperty(course_number)//上课人数
Stringproperty(order_id)//订单id
Stringproperty(pre_time)//约课时间
Stringproperty(gender)//性别 1为男
Stringproperty(place)//地址
Stringproperty(course)//课程名字
Stringproperty(order_type)//订单类别
Stringproperty(number)//会员点好号码
Intagerproperty(personal_id)//私人订制
Boolproperty(newOrder)//是否是新订单

//Stringproperty(body_id)//身体测试id

@end
