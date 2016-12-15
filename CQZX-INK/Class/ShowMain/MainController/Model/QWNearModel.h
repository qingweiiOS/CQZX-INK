//
//  QWNearModel.h
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/7.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QWNearModel : NSObject
/** 播放流地址 */
@property(nonatomic,copy)NSString * stream_addr;
/** 详情 */
@property(nonatomic,strong)NSDictionary * creator;
/** id */
@property(nonatomic,copy)NSString * id;
/** 分享地址 */
@property(nonatomic,copy) NSString *share_addr;
/** 距离 */
@property(nonatomic,copy) NSString *distance;
/** 热度 */
@property(nonatomic,copy) NSString *slot;
@end
