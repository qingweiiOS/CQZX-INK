//
//  Header.h
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//
/*
 
 Commonly used macro definition
 常用的宏定义
 
 */
#ifndef CommonlyMacro_h
#define CommonlyMacro_h

///屏幕宽度
#define SCREEN_W  [UIScreen mainScreen].bounds.size.width

///屏幕高度
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

/**
 *  RGBA 颜色
 *
 *  @param r 0.0f - 255.0f
 *  @param g 0.0f - 255.0f
 *  @param b 0.0f - 255.0f
 *  @param a 0.0f - 1.0f
 *
 *  @return UIColor
 */

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

/**
 *  得到图片对象
 *
 *  @param imgName 图片名称
 *
 *  @return UIImage
 */

#define IMG(imgName) [UIImage imageNamed:imgName]
#define DEFAULTIMAGE  IMG(@"default")
/**
 *  获取本地图片对象
 *
 *  @param imgName 图片名称
 *  @param type    图片类型
 *
 *  @return UIImage
 */
#define IMAGE(imgName,type) [UIImage imageWithContentsOfFile:［NSBundle mainBundle] pathForResource:A ofType:type］

/**
 *  得到资源文件
 *
 *  @param fileName 文件名称
 *  @param fileType 文件类型
 *
 *  @return NSString 文件路径
 */
#define  RESOUCE(fileName,fileType) [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];

/**
 *  回到主线程
 *
 *  @param block 语句快
 *
 *  @return Void
 */
#define GCD_MAIN(Block) dispatch_async(dispatch_get_main_queue(),Block)
//GCD - 一次性执行
#define GCD_ONCE(Block) static dispatch_once_t onceToken; dispatch_once(&onceToken, Block);


///得到系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]

///得到沙盒路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

///NSUserDefaults
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]



///NSLog
#ifdef DEBUG
#define NSLog(format, ...) do {                                                                          \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

#else
// 定义是输出Log
#define DLog(format, ...)
#endif
/// 常用结构体打印
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

#endif /* CommonlyMacro_h*/


