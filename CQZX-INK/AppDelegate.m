//
//  AppDelegate.m
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "AppDelegate.h"
#import "QWBaseTabBarController.h"


@interface AppDelegate ()
{
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  //创建窗体 ［当你使用了Storyboard时可以不用创建］
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //创建tabBarController
    QWBaseTabBarController *tabBarCtl = [[QWBaseTabBarController alloc] init];
    //设置根视图控制器
    window.rootViewController = tabBarCtl;
    self.window = window;
    //让窗体可见
    [self.window makeKeyAndVisible];
    
    //请求 iOS8后必须请求 通知权限
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    [application registerUserNotificationSettings:settings];
    //添加通知
//    [self addNotificationPush];
    
    
    return YES;
}

- (void)addNotificationPush
{

    //创建 本地推送
    UILocalNotification *not = [[UILocalNotification alloc] init];
    //设置推送时间
    NSDate *dates = [NSDate dateWithTimeIntervalSinceNow:60];
    not.fireDate = dates;
//    设置时区
    not.timeZone = [NSTimeZone defaultTimeZone];
    //设置重复间隔
    not.repeatInterval = kCFCalendarUnitMinute;
    //推送声音
    not.soundName = UILocalNotificationDefaultSoundName;
    //设置推送内容
    not.alertBody = @"你关注的主播开播啦";
    //设置消息数目
    not.applicationIconBadgeNumber = 10;
    //点击推送内容后展示的图片
    not.alertLaunchImage = @"bg_zbfx";
    not.alertAction = @"UZI 首播啦";
    //将该推送加入应用程序中
    [[UIApplication sharedApplication] scheduleLocalNotification:not];
    
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"66666");
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
