//
//  MainNetWork.h
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainNetWork : NSObject
+ (void)getTopData:(NSDictionary *)dic success:(requestSuccess)Success faile:(requestFailed)faile;
+ (void)getNearPerson:(NSDictionary *)dic success:(requestSuccess)Success faile:(requestFailed)faile;
+ (void)getBannerData:(NSDictionary *)dic success:(requestSuccess)Success faile:(requestFailed)faile;
@end
