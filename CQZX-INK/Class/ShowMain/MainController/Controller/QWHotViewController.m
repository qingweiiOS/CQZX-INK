//
//  QWHotViewController.m
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "QWHotViewController.h"
#import "QWCoverTableViewCell.h"
#import "MainNetWork.h"
#import "QWLiveModel.h"
#import "QWShowLiveViewController.h"
#import "MJRefresh.h"
#import "SDCycleScrollView.h"
#import "QWBannerModel.h"

@interface QWHotViewController ()<SDCycleScrollViewDelegate>
{
    NSArray *bannerArray;
    NSString *bannerPath;
}
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@end
@implementation QWHotViewController

- (SDCycleScrollView *)bannerView{

    if(!_bannerView){
        
        bannerArray = [NSKeyedUnarchiver unarchiveObjectWithFile:bannerPath];
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_W/3) delegate:self placeholderImage:DEFAULTIMAGE];
        _bannerView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        NSMutableArray *tempArray = [NSMutableArray array];
        for(int i = 0;i<bannerArray.count;i++)
        {
            NSLog(@"读取缓存成功");
            //            WDXMBannerModel *model = bannerArray[i];
            //            [tempArray addObject:model.img_url];
        }
        self.bannerView.imageURLStringsGroup = tempArray;
        
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _bannerView.pageControlDotSize = CGSizeMake(7.0, 7.0);
        _bannerView.delegate = self;

    }
    return _bannerView;
}
- (NSMutableArray *)dataList
{
    
     if(!_dataList)
     {
         _dataList = [NSMutableArray array];
     }
    return _dataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)loadData
{
    [MainNetWork getTopData:nil success:^(id obj) {
        [self.tableView.mj_header endRefreshing];
        [self performSelectorOnMainThread:@selector(refreshUI:) withObject:obj waitUntilDone:YES];
    } faile:^(id error) {
        [self.tableView.mj_header endRefreshing];

    } ];
    
  [MainNetWork getBannerData:nil success:^(id obj) {
      bannerArray = obj;
      if(bannerArray.count == 0){
      
          self.tableView.tableHeaderView = [UIView new];
      }
      else{
          GCD_MAIN((^{
              NSMutableArray *tempArray = [NSMutableArray array];
              for(int i = 0;i<bannerArray.count;i++)
              {
                  QWBannerModel *model = bannerArray[i];
                  [tempArray addObject:model.image];
              }
              self.bannerView.imageURLStringsGroup = tempArray;
              
          }));
          
      }
  } faile:^(id error) {
      
  }];
}
- (void)refreshUI:(id)obj
{
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray:obj];
//    self.navigationController.hidesBarsOnSwipe = YES;
    [self.tableView reloadData];
}
- (void)initUI
{
    self.tableView.separatorStyle = UITextBorderStyleNone;
     [self.tableView  registerNib:[UINib nibWithNibName:@"QWCoverTableViewCell" bundle:nil] forCellReuseIdentifier:@"QWCoverTableViewCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.tableHeaderView = self.bannerView;
    [self.tableView.mj_header beginRefreshing];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QWCoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QWCoverTableViewCell" forIndexPath:indexPath];
    cell.lModel = self.dataList[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QWShowLiveViewController *showLiveVC = [[QWShowLiveViewController alloc] init];
    showLiveVC.lModel = self.dataList[indexPath.row];
    showLiveVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:showLiveVC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64+SCREEN_W;
}
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
//    
//  }
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    QWBannerModel *model = [bannerArray objectAtIndex:index];
    
    NSLog(@"%@ \n  %@  \n %@",model.atom,model.image,model.link);
 
}
@end
