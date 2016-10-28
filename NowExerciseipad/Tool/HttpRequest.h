//
//  HttpRequest.h
//  NowExerciseipad
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//typedef void(^progressBlock)(NSProgress * downloadProgress);
//typedef void(^successBlock)(id data);
//typedef void(^failBlock)(NSError * error);



@interface HttpRequest : NSObject

+ (void)GetHttpwithUrl:(NSString *)url parameters:(NSDictionary *)parameters andsuccessBlock:(void(^)(NSData * data))successBlock andfailBlock:(void(^)(NSError * error))failBlock;


+ (void)PostHttpwithUrl:(NSString *)url andparameters:(NSDictionary *)parameters andProgress:(void(^)(NSProgress *progress))progress andsuccessBlock:(void(^)(NSData * data))successBlock andfailBlock:(void(^)(NSError * error))failBlock;





@end
