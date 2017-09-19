//
//  QWMainViewController.m
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "QWMainViewController.h"
#import "QWNavTitleView.h"

@interface QWMainViewController ()<QWNavTitleViewDelegate,UIScrollViewDelegate>
@property (strong,nonatomic) QWNavTitleView *titleView;
@property (strong,nonatomic) UIScrollView *mainScrollView;
@end
@implementation QWMainViewController
- (UIScrollView *)mainScrollView
{
    if(!_mainScrollView)
    {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
    }
    return _mainScrollView;
}
- (QWNavTitleView *)titleView
{
    if(!_titleView)
    {
        _titleView = [[QWNavTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W-100, 44)];
//        _titleView.backgroundColor = [UIColor redColor];
        _titleView.delegate = self;
    }
    return _titleView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///添加子试图控制器
    [self addChildViewControllers];
    
    [self initUI];
    
}
- (void)initUI
{
    //设置导航栏 样式
    [self setNavStle];
    //添加
    [self.view addSubview:self.mainScrollView];
    //处理滚动视图显示错位
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.mainScrollView setContentSize:CGSizeMake(self.childViewControllers.count*SCREEN_W, SCREEN_H)];
    
   
    
}
- (void)addChildViewControllers
{
    //关注 热门 附近 才艺
    NSArray *array = @[@"QWFocusTableViewController",@"QWHotViewController",@"QWNearCollectionViewController",@"QWTalentTableViewController"];
    for(int i =0 ;i <array.count;i++)
    {
        UIViewController *mainVC = [[NSClassFromString(array[i]) alloc] init];
        [self addChildViewController:mainVC];
    }
     //默认选中的 热门（第二个）QWHotViewController 所以展示热门
    [self.mainScrollView setContentOffset:CGPointMake(SCREEN_W, 0)];
    UIViewController *tempVc = self.childViewControllers[1];
    //设置未知和尺寸
    tempVc.view.frame = CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_H-44);
    //添加到滚动视图中
    [self.mainScrollView addSubview:tempVc.view];
    
}
- (void)setNavStle
{
    //定制导航栏 titleView
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:IMG(@"global_search") style:UIBarButtonItemStyleDone target:self action:@selector(popSearch)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:RGB(48, 209, 190)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:IMG(@"title_button_more") style:UIBarButtonItemStyleDone target:self action:@selector(pushMessage)];
    self.navigationItem.titleView = self.titleView;
}
- (void)pushMessage
{
    
}
- (void)popSearch
{
    
}

#pragma mark QWNavTitleViewDelegate
- (void)selectPage:(NSInteger)index
{
    [UIView animateWithDuration:0.4 animations:^{

        [self.mainScrollView setContentOffset:CGPointMake(index*SCREEN_W, 0)];
    }];
}
#pragma mark UIScrollViewDelegate
//减速完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //通过偏移量得到 当前在第几页
    NSInteger index = scrollView.contentOffset.x/SCREEN_W;
    UIViewController *vc = self.childViewControllers[index];
    //判断当前视图 是否加载过
    if(![vc isViewLoaded])
    {
        //如果没有加载过
        vc.view.frame = CGRectMake(SCREEN_W * index, 0, SCREEN_W, SCREEN_H-44);
        [self.mainScrollView addSubview:vc.view];
    }
    
    [self.titleView selectItem:index];
    
    
}

@end
