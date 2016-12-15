//
//  QWNevrCollectionViewCell.h
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/7.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWNearModel.h"
@interface QWNevrCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *level;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property(nonatomic,strong) QWNearModel *nModel;
@end
