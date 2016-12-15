//
//  QWCoverTableViewCell.h
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWLiveModel.h"

@interface QWCoverTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *personNumber;

@property (weak, nonatomic) IBOutlet UIImageView *Cover;
@property (weak, nonatomic) IBOutlet UIButton *address;
@property(nonatomic,strong) QWLiveModel *lModel;
@end
