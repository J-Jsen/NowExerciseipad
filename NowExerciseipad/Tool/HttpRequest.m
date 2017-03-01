//
//  HttpRequest.m
//  NowExerciseipad
//
//  Created by mac on 16/10/27.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "HttpRequest.h"
@implementation HttpRequest


+ (AFHTTPSessionManager *)sharemanager{
    static AFHTTPSessionManager *sharemanager = nil;
             static dispatch_once_t predicate;
            dispatch_once(&predicate, ^{
                        sharemanager = [AFHTTPSessionManager manager];
                });
    
    sharemanager.requestSerializer.timeoutInterval = 10;
    sharemanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    [sharemanager.requestSerializer setValue:@"1.0.0" forHTTPHeaderField:@"appVersion"];
    return sharemanager;
    
    
}

//下载任务
//+ (void)downloadTaskWithURL:(NSString *)url andwithProgress:(progressBlock *)progress andwithpath:(NSString *)path andSuccess:(successBlock *)successBlock andfail:(failBlock)failBlock{
//    
//        //1.创建管理者对象
//    AFHTTPSessionManager * manager = [HttpRequest sharemanager];
//        //2.确定请求的URL地址
//    NSURL * URL = [NSURL URLWithString:url];
//        //3.创建请求对象
//    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
//    //下载任务
//    NSURLSessionTask * task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        
//        
//        
//        
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        
//        if (error) {
//            failBlock(error);
//        }else{
//  
//        }
//        
//    }];
//    
//    
//    
//}
//get请求
+ (void)GetHttpwithUrl:(NSString *)url parameters:(NSDictionary *)parameters andsuccessBlock:(void(^)(id data))successBlock andfailBlock:(void(^)(NSError * error))failBlock{
    
            // 1.创建管理者对象
        AFHTTPSessionManager * manager = [HttpRequest sharemanager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
   
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        successBlock(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        failBlock(error);
    }];
  
    
}
//post请求
+ (void)PostHttpwithUrl:(NSString *)url andparameters:(NSDictionary *)parameters andProgress:(void(^)(NSProgress *progress))progress andsuccessBlock:(void(^)(id data))successBlock andfailBlock:(void(^)(NSError * error))failBlock{
    
    AFHTTPSessionManager * manager = [HttpRequest sharemanager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
     

    }];
    

    
}
//上传本地文件
//+ (void)Postlocalfilewithurl:(NSString *)url andparameters:(NSDictionary *)parameters and

//无事件提示框
+ (void)showAlertCatController:(UIViewController *)viewcontroller andmessage:(NSString *)message{
    
    
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [alertC addAction:action];
    
    [viewcontroller presentViewController:alertC animated:YES completion:nil];
    
    
}

/// 根据指定文本,字体和最大宽度计算尺寸
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}



@end
