//
//  QWLiveModel.h
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QWLiveModel : NSObject
/** 播放流地址 */
@property(nonatomic,copy)NSString * stream_addr;
/** 在线人数 */
@property(nonatomic,copy)NSString * online_users;
/** 详情 */
@property(nonatomic,strong)NSDictionary * creator;
/** id */
@property(nonatomic,copy)NSString * id;
/** 城市 */
@property(nonatomic,copy) NSString *city;


@end
