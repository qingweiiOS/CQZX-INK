//
//  QWCommonlyConst.m
//  CQZX-INK
//
//  Created by qingweiqw on 16/12/3.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "QWCommonlyConst.h"

@implementation QWCommonlyConst : NSObject 
  NSString * const SERVER_HOST =  @"http://service.ingkee.com/";
//图片服务器
  NSString * const IMAGE_SERVER_HOST  = @"http://img.meelive.cn/";
//热门数据
  NSString * const API_LiveGetTop =  @"api/live/gettop";
//广告地址
 NSString * const API_Advertise  =  @"advertise/get";
//热门话题
 NSString * const API_TopicIndex  = @"api/live/topicindex";
//附近的人
 NSString * const API_NearLocation = @"api/live/near_recommend";
//?uid= &latitude 经纬度 longitude;
@end
