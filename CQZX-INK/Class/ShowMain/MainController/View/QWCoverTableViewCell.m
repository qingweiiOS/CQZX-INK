//
//  QWCoverTableViewCell.m
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "QWCoverTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation QWCoverTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    


    
    self.headImg.layer.cornerRadius = self.headImg.height/2.0;
    self.headImg.layer.masksToBounds = YES;
    //btn 文字居左
    self.address.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.address.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}
- (void)setLModel:(QWLiveModel *)lModel
{
    _lModel = lModel;
   //城市
    if([_lModel.city isEqualToString:@""])
    {
        [self.address setTitle:@"主播在火星妮" forState:UIControlStateNormal];
    }else
    {
        [self.address setTitle:_lModel.city forState:UIControlStateNormal];
    }
    self.Cover.image = DEFAULTIMAGE;
    self.headImg.image = DEFAULTIMAGE;
    //设置头像
    [self.Cover sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",_lModel.creator[@"portrait"]]] placeholderImage:DEFAULTIMAGE completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      //封面
        self.headImg.image = [UIImage imageWithData:UIImageJPEGRepresentation(image, 0.25)];
    }];
    //多少人在看
    self.personNumber.text= _lModel.online_users;
    //主播名称
    self.name.text=_lModel.creator[@"nick"];
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
