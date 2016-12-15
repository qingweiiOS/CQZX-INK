//
//  QWCommonlyConst.h
//  CQZX-INK
//
//  Created by qingweiqw on 16/12/3.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QWCommonlyConst : NSObject
//服务器地址
UIKIT_EXTERN  NSString * const SERVER_HOST;
//图片服务器
UIKIT_EXTERN  NSString * const IMAGE_SERVER_HOST;
//热门数据
UIKIT_EXTERN  NSString * const API_LiveGetTop;
//广告地址
UIKIT_EXTERN NSString * const API_Advertise;
//热门话题
UIKIT_EXTERN NSString * const API_TopicIndex;
//附近的人
UIKIT_EXTERN NSString * const API_NearLocation;
//?uid= &latitude 经纬度 longitude;ı
@end
