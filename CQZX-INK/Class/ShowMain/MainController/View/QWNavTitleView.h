//
//  QWNavTitleView.h
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import <UIKit/UIKit.h>

//选中后的回调 不想去定义枚举了
@protocol QWNavTitleViewDelegate <NSObject>
- (void)selectPage:(NSInteger) index;
@end
@interface QWNavTitleView : UIView
@property(nonatomic,strong) id <QWNavTitleViewDelegate> delegate;
- (void)selectItem:(NSInteger )index;
@end
