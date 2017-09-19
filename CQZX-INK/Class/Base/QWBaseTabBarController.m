
//
//  QWBaseTabBarController.m
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "QWBaseTabBarController.h"
#import "QWBaseNavigatonController.h"
#import "QWTabBar.h"

@interface QWBaseTabBarController ()<QWTabBarDelegate>
@property(strong,nonatomic) QWTabBar *myTabBar;
//蒙板 点击中间按钮弹出的蒙板
@property(strong,nonatomic)UIView *maskBlackView;
//弹出选择视图
@property(strong,nonatomic)UIView *OptionView;
///直播按钮
@property(strong,nonatomic)UIButton *liveBtn;
///短视频
@property(strong,nonatomic)UIButton *shortVideoBtn;
@property(strong,nonatomic)UIButton *closeBtn;
@end

@implementation QWBaseTabBarController
- (UIView *)OptionView
{
    if(!_OptionView)
    {
        _OptionView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, SCREEN_W*3/5)];
        _OptionView.backgroundColor = [UIColor whiteColor];
        
        _liveBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W/2,_OptionView.height-40)];
        [_liveBtn setImage:IMG(@"LiveIcon") forState:UIControlStateNormal];
       _shortVideoBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W/2, 0, SCREEN_W/2,_OptionView.height-40)];
          [_shortVideoBtn setImage:IMG(@"shartVideo") forState:UIControlStateNormal];
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, _OptionView.height-40, _OptionView.width, 40)];
        [_closeBtn setImage:IMG(@"closePop") forState:UIControlStateNormal];
        _closeBtn.backgroundColor = RGB(220, 220, 220);
        [_closeBtn addTarget:self action:@selector(closePopLive) forControlEvents:UIControlEventTouchUpInside];
        [_OptionView addSubview:_closeBtn];
        [_OptionView addSubview:_liveBtn];
        [_OptionView addSubview:_shortVideoBtn];
    }
    return _OptionView;
}
- (UIView *)maskBlackView
{
    if(!_maskBlackView)
    {
        _maskBlackView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskBlackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePopLive)];
        [_maskBlackView addGestureRecognizer:tap];
    }
    return _maskBlackView;
}
//懒加载
- (QWTabBar *)myTabBar
{
    if(!_myTabBar)
    {
        _myTabBar = [[QWTabBar alloc] initWithFrame:self.tabBar.bounds];
        //设置委托  回调
        _myTabBar.delegate = self;
    }
    return _myTabBar;
}
//关闭底部弹出的 选择框
- (void)closePopLive
{
   [UIView animateWithDuration:0.4 animations:^{
       self.OptionView.frame = CGRectMake(0, SCREEN_H, self.OptionView.width, self.OptionView.height);
       self.maskBlackView.alpha = 0;
   } completion:^(BOOL finished) {
       self.maskBlackView.alpha = 1;
       [self.maskBlackView removeFromSuperview];
   }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *araay = @[@"中文",@"bushi"];
    NSLog(@"%@",@[@"中文",@"bushi"]);
    //添加子视图控制器
    [self addChildViewControllers];
    //此处自定义 工具栏
    [self addTabBar];
//    [self addTabBar];
}
- (void)addTabBar
{
    //此处 用的原理是 将一个视图覆盖在系统的tabbar上
    [self.tabBar addSubview:self.myTabBar];
    //设置背景 [去掉阴影线]
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
    
}
- (void)addChildViewControllers
{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"QWMainViewController",@"QWMeViewController", nil];
    for(int i=0;i<array.count;i++)
    {
        //创建子视图控制器
        UIViewController * subVC = [[NSClassFromString(array[i]) alloc] init];
        //包装一层导航栏控制器
        QWBaseNavigatonController *navVc = [[QWBaseNavigatonController alloc] initWithRootViewController:subVC];
        //替换数组元素
        [array replaceObjectAtIndex:i withObject:navVc];
    }
    self.viewControllers = array;
}

#pragma mark - 实现QWTabBarDelegate 中的方法
- (void)selectPage:(SelectState)index
{
    /*
     选中第二个按钮的时候并非是切换 视图而是弹出 一个视图
     需要判断
     */
    //弹出视图 直播选项
    if(index == LiveState)
    {
//        NSLog(@"我的直播");
        [self popUpliveOptions];
        return;
    }
    
    //切换页面
    if(index == MainState)
    {
        //主页
        [self setSelectedIndex:0];
    }
    else
    {
        //我的
        [self setSelectedIndex:1];
    }
   
}

- (void)popUpliveOptions
{
    [self.view addSubview:self.maskBlackView];
//    [self.view bringSubviewToFront:self.maskBlackView];
    [self.view addSubview:self.OptionView];
    [UIView animateWithDuration:0.4 animations:^{
        self.OptionView.frame = CGRectMake(0, SCREEN_H-self.OptionView.height, SCREEN_W, self.OptionView.height);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
