//
//  MainNetWork.m
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "MainNetWork.h"

#import "QWLiveModel.h"
#import "QWNearModel.h"
#import "QWCommonlyConst.h"


@implementation MainNetWork

+ (void)getTopData:(NSDictionary *)dic success:(requestSuccess)Success faile:(requestFailed)faile
{
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_HOST,API_LiveGetTop];
    
    [[QWNetWokHelper qwNetWorkHelper] getRequest:url turnRound:^(id obj, NSError *error) {
        if(error)
        {
            NSLog(@"%@",error);
            faile(error);
        }
        else
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",[dic objectForKey:@"lives"]);
            NSArray *models = [QWLiveModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"lives"]];
            Success(models);
        }
    }];
    
    
}
+ (void)getNearPerson:(NSDictionary *)dic success:(requestSuccess)Success faile:(requestFailed)faile
{
    
//    @"uid":@"273851210",
//    @"latitude":@"40.090562",
//    @"longitude":@"116.413353"
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *url = [NSString stringWithFormat:@"%@%@?uid=273851210&latitude=%@&longitude=%@",SERVER_HOST,API_NearLocation,[user objectForKey:@"la"],[user objectForKey:@"lo"]];
    
    NSLog(@"%@",url);
     [[QWNetWokHelper qwNetWorkHelper] getRequest:url turnRound:^(id obj, NSError *error) {
     
         if(error)
         {
             faile(error);
         }
         else
         {
             
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingAllowFragments error:nil];
             
             NSLog(@"%@",dic);
             NSLog(@"%@",[dic objectForKey:@"lives"]);
             NSArray *models = [QWNearModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"lives"]];
             Success(models);
         }
         
     }];
    


    
    
}

@end
