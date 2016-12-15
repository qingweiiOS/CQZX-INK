//
//  QWNavTitleView.m
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "QWNavTitleView.h"
@interface QWNavTitleView()
///标题数组
@property (strong, nonatomic) NSArray *titleArray;
///保存当前选中项
@property (strong, nonatomic) UIButton *selectBtn;
@property (strong, nonatomic) UIImageView *hotImg;

@end
@implementation QWNavTitleView
- (NSArray *)titleArray
{
    if(!_titleArray) {
        _titleArray = @[@"关注",@"热门",@"附近",@"才艺"];
    }
    return _titleArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}
- (void)initUI
{
    //得到每个按钮的宽度 高度为30
    NSInteger count = [self.titleArray count];
    CGFloat width = self.width/count;
    //循环创建按钮
    for(int i = 0;i<count;i++)
    {
        UIButton *item = [[UIButton alloc] init];
        item.frame = CGRectMake(i*width, 0, width, 44);
        [item setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        item.backgroundColor = [UIColor clearColor];
        item.titleLabel.font = [UIFont systemFontOfSize:14];
        item.tag = 100 + i;
        //默认选中
        if(i==1)
        {
            item.transform = CGAffineTransformMakeScale(1.3, 1.3);
            self.selectBtn = item;
            _hotImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*width, 35, width, 7)];
            _hotImg.image = IMG(@"hot");
            _hotImg.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:_hotImg];
        }
        [self addSubview:item];
        [item addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)clickBtn:(UIButton *)btn
{
    if(btn.tag != 101) {
        [self.hotImg removeFromSuperview];
    }
    else {
        [self addSubview:self.hotImg];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.selectBtn.transform = CGAffineTransformIdentity;
        btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    }];
    self.selectBtn = btn;
    [self.delegate selectPage:btn.tag-100];
}
- (void)selectItem:(NSInteger )index
{
    
    if( index != 1) {
        [self.hotImg removeFromSuperview];
    }
    else {
        [self addSubview:self.hotImg];
    }
    UIButton *btn = [self viewWithTag:index+100];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.selectBtn.transform = CGAffineTransformIdentity;
        btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    }];
    self.selectBtn = btn;
}
@end
