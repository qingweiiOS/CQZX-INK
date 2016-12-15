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

@interface QWHotViewController ()
{
   
}
@property (strong ,nonatomic) NSMutableArray *dataList;;
@end
@implementation QWHotViewController
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

@end
