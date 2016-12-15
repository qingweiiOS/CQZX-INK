//
//  QWTabBar.m
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "QWTabBar.h"
//延展
@interface QWTabBar()
///tabBar的背景
@property (strong, nonatomic) UIImageView *bgView;
//按钮图片
@property (strong, nonatomic) NSArray *imgArray;
///保存当前选中按钮
@property (strong, nonnull) UIButton *selectBtn;

@end
@implementation QWTabBar

- (NSArray *)imgArray
{
    if(!_imgArray)
    {
        _imgArray = @[@"tab_live",@"tab_launch",@"tab_me"];
    }
    return _imgArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建自定义 bar 的视图
        [self initTabBarUI];
    }
    return self;
}
- (void)initTabBarUI
{
    /*
     设置背景
     */
    self.bgView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.bgView.image = IMG(@"global_tab_bg");
    [self addSubview:self.bgView];
    
    //计算每个按钮的宽度 高度为49
    NSInteger count  = self.imgArray.count;
    CGFloat width = SCREEN_W/count;
    
    //添加按钮
    for(int i = 0;i<count;i++)
    {
        UIButton *item;
        
        if(i == 1)
        {
            //中间 开启直播按钮特殊处理
            item = [UIButton buttonWithType:UIButtonTypeCustom];
            [item setImage:[UIImage imageNamed:self.imgArray[i]] forState:UIControlStateNormal];
            //自适应大小 根据内容 去定大小
            [item sizeToFit];
            //确定位置
            item.center = CGPointMake(self.frame.size.width/2,10);
//            item.backgroundColor = [UIColor redColor];
            
        }
        else
        {
            item = [[UIButton alloc] init];
            item.frame = CGRectMake(i*width, 0, width, 49);
            NSString *imgName = [NSString stringWithFormat:@"%@_p",self.imgArray[i]];
            [item setImage:[UIImage imageNamed:imgName] forState:UIControlStateSelected];
            [item setImage:[UIImage imageNamed:self.imgArray[i]] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
            
        }
        //取消高亮
        item.adjustsImageWhenHighlighted = NO;
        item.tag = MainState+i;
        //默认选中一个按钮
        if(i==0)
        {
            self.selectBtn = item;
            //设置为选中
            item.selected = YES;
        }
        //添加事件
        [item addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:item];
        
    }
}
- (void)clickBtn:(UIButton *)btn
{
    //通知工具栏控制起切换 页面
    [self.delegate selectPage:btn.tag];
    if(btn.tag == LiveState)
    {
        return ;
    }
    //动画效果
    [UIView animateWithDuration:0.2 animations:^{
        //点击后缩放
        btn.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            //还原
            btn.transform = CGAffineTransformIdentity;
        }];
    }];
    self.selectBtn.selected = NO;
    btn.selected = YES;
    self.selectBtn = btn;
}
@end
