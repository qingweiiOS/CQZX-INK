//
//  QWNevrCollectionViewCell.m
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/7.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "QWNevrCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation QWNevrCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setNModel:(QWNearModel *)nModel
{
    _nModel = nModel;
    self.distance.text = _nModel.distance;
    //设置头像
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",_nModel.creator[@"portrait"]]] placeholderImage:DEFAULTIMAGE];
}
@end
