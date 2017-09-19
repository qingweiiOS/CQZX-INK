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
#import "QWBannerModel.h"

@implementation MainNetWork

+ (void)getTopData:(NSDictionary *)dic success:(requestSuccess)Success faile:(requestFailed)faile
{
    
    NSString *url = [NSString stringWithFormat:@"%@", @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"];
    
    [[QWNetWokHelper qwNetWorkHelper] getRequest:url turnRound:^(id obj, NSError *error) {
        if(error)
        {
            NSLog(@"%@",error);
            faile(error);
        }
        else
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingAllowFragments error:nil];
            NSArray *models = [QWLiveModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"lives"]];
            Success(models);
        }
    }];
    
    
}
+ (void)getBannerData:(NSDictionary *)dic success:(requestSuccess)Success faile:(requestFailed)faile{

    NSString *url = [NSString stringWithFormat:@"%@", @"http://116.211.167.106/api/live/ticker?lc=0000000000000049&cc=TG0001&cv=IK3.8.10_Iphone&proto=7&idfa=2D707AF8-980F-415C-B443-6FED3E9BBE97&idfv=723152C7-9C98-43F8-947F-18331280D72F&devi=135ede19e251cd6512eb6ad4f418fbbde03c9266&osversion=ios_10.100000&ua=iPhone5_2&imei=&imsi=&uid=392716022&sid=20f7ZyQ3C09I3wDcU0i0bM5n3F8osSAui2L04fGf4WTHRgL9J8qi1&conn=wifi&mtid=87edd7144bd658132ae544d7c9a0eba8&mtxid=acbc329027f3&logid=133&s_sg=de3941864a42502fbbcb20b935a85427&s_sc=100&s_st=1488509570"];
    
    [[QWNetWokHelper qwNetWorkHelper] getRequest:url turnRound:^(id obj, NSError *error) {
        if(error)
        {
            NSLog(@"%@",error);
            faile(error);
        }
        else
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dic);
            NSArray *models = [QWBannerModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"ticker"]];
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
    NSString *url = [NSString stringWithFormat:@"%@%@?uid=273851210&latitude=%@&longitude=%@&gender=1",SERVER_HOST,API_NearLocation,[user objectForKey:@"la"],[user objectForKey:@"lo"]];
    
    NSLog(@"%@",url);
     [[QWNetWokHelper qwNetWorkHelper] getRequest:url turnRound:^(id obj, NSError *error) {
     
         if(error)
         {
             faile(error);
         }
         else
         {
             
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingAllowFragments error:nil];
             
          
             NSLog(@"%@",[dic objectForKey:@"lives"]);
             NSArray *models = [QWNearModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"lives"]];
             Success(models);
         }
         
     }];
    


    
    
}

@end
