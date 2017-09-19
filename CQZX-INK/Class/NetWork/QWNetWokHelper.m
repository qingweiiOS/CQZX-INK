


//
//  QWNetWokHelper.m
//  My-Project
//
//  Created by teacher on 16-10-28.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "QWNetWokHelper.h"
static QWNetWokHelper *helper;
@implementation QWNetWokHelper
+ (id)qwNetWorkHelper
{
    
    if(!helper)
    {
        helper = [[QWNetWokHelper alloc] init];
    }
    return helper;
}

- (void)getRequest:(NSString *)url turnRound:(void(^)(id obj,NSError *error))block
{
    //1、构建网络路径
    NSURL *urlStr = [NSURL URLWithString:url];
    //2、构建请求
    NSURLRequest *request = [NSURLRequest  requestWithURL:urlStr cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:1.0];
    //3、发送请求
   
    //3.1 构建会话
    NSURLSession *session = [NSURLSession sharedSession];
    //3.2 构建请求任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //99% json
//        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        block(data,error);
   
    }];
    //3.3 执行任务 发送请求
    [task resume];
}
- (void)postRequest:(NSString *)url andDict:(NSDictionary *)dict turnRound:(void(^)(id obj,NSError *error))block
{
    //1、构建网络路径
    NSURL *urlStr = [NSURL URLWithString:url];
    
    
    //2、构建请求
    NSMutableURLRequest *request = [NSMutableURLRequest  requestWithURL:urlStr cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:1.0];
    //2、1设置请求方式
     request.HTTPMethod = @"POST";
    //2.2 设置请求体
    NSMutableString *bodyStr = [NSMutableString string];
    NSData *data;
    for (NSString *key in dict) {
     
        [bodyStr appendFormat:@"%@=%@&",key,dict[key]];

    }
    if(bodyStr.length>0)
    {
        //去掉最后一个取地址符
        [bodyStr setString:[bodyStr substringToIndex:bodyStr.length-1]];
        //讲NSString转化为Data
         data = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
        //设置请求体
         request.HTTPBody = data;
    }
    //3、发送请求
    
    //3.1 构建会话
    NSURLSession *session = [NSURLSession sharedSession];
    //3.2 构建请求任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        block(data,error);
    }];
    //3.3 执行任务 发送请求
    [task resume];
}
@end
