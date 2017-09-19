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
    self.headImage.layer.cornerRadius = 5.0;
    self.headImage.layer.masksToBounds = YES;
    self.coverView.layer.cornerRadius = 5.0;
    // Initialization code
}
- (void)setNModel:(QWNearModel *)nModel
{
    _nModel = nModel;
    self.distance.text = _nModel.distance;
    NSString *imageUrl = _nModel.creator[@"portrait"];
//
    if(![imageUrl hasPrefix:@"http:"]){
    
        imageUrl = [NSString stringWithFormat:@"http://img.meelive.cn/%@",imageUrl];
    }
    //设置头像
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:DEFAULTIMAGE];
    //城市
    self.cityLab.text = _nModel.city;
    //昵称
    self.nickLab.text =  _nModel.creator[@"nick"];
    // 话题
    self.nameLab.text = _nModel.name;
}
@end
