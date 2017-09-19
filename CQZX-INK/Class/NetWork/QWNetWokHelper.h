//
//  QWNetWokHelper.h
//  My-Project
//
//  Created by teacher on 16-10-28.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^requestSuccess)(id obj);
typedef void(^requestFailed)(id error);
@interface QWNetWokHelper : NSObject
//单例
+ (id)qwNetWorkHelper;
// 异步 GET
- (void)getRequest:(NSString *)url turnRound:(void(^)(id obj,NSError *error))block;
//异步 POST
- (void)postRequest:(NSString *)url andDict:(NSDictionary *)dict turnRound:(void(^)(id obj,NSError *error))block;

@end
