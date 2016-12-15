//
//  QWTabBar.h
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

/*
 自定义工具栏
 */


#import <UIKit/UIKit.h>
//选中状态
typedef NS_ENUM(NSInteger,SelectState){

    MainState = 100,//选中主页
    LiveState,//选中  直播自己
    MEState,//选中我的
    UnknownState//未知
};
//选中某个 按钮 的回调 ［可以用Black回调,看自己习惯］
@protocol QWTabBarDelegate <NSObject>
- (void)selectPage:(SelectState)index;
@end
@interface QWTabBar : UIView
@property(nonatomic,assign) id <QWTabBarDelegate> delegate;
@end
