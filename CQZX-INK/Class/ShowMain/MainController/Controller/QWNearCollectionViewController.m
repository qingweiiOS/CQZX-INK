//
//  QWNearCollectionViewController.m
//  CQZX-INK
//
//  Created by qingweiqw on 16/11/6.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import "QWNearCollectionViewController.h"
#import "MainNetWork.h"
#import "MJRefresh.h"
#import <CoreLocation/CoreLocation.h>
#import "QWNevrCollectionViewCell.h"
#import "QWShowLiveViewController.h"
@interface QWNearCollectionViewController ()<CLLocationManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    CLLocationManager *_manager;
    
    NSInteger animationNumber;
}
@property (strong, nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) UICollectionView *collctionView;

@end

@implementation QWNearCollectionViewController



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
    //获取用户当前位置信息
    _manager = [[CLLocationManager alloc]init];
    if([[UIDevice currentDevice].systemVersion floatValue]>=8.0)
    {
        [_manager requestAlwaysAuthorization];
        [_manager requestWhenInUseAuthorization];
    }
    _manager.delegate = self;

    [_manager startUpdatingLocation];
}
- (void)initUI
{
     self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView * collctionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
     self.collctionView = collctionView;
     [self.view addSubview:self.collctionView];
     self.collctionView.backgroundColor = [UIColor whiteColor];
     [self.collctionView registerNib:[UINib nibWithNibName:@"QWNevrCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"QWNevrCollectionViewCell"];
    self.collctionView.delegate = self;
    self.collctionView.dataSource = self;
    self.collctionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.collctionView.mj_header beginRefreshing];
    
    animationNumber = 0;
}
#pragma mark - 检测应用是否开启定位服务
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [manager stopUpdatingLocation];
    switch([error code]) {
        case kCLErrorDenied:
            NSLog(@"不可用");
            break;
        case kCLErrorLocationUnknown:
            break;
        default:
            break;
    }
    [self loadData];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //停止定位
    [_manager stopUpdatingLocation];
    CLLocation *location = locations.lastObject;
    CLLocationCoordinate2D coord = location.coordinate;
    NSLog(@"%.2f %.2f",coord.latitude,coord.longitude);
    //将用户位置信息 保存  下次运行 如果定位失败 用本次的
    NSUserDefaults *defalults = [NSUserDefaults standardUserDefaults];
    
     [defalults setObject:@(coord.latitude) forKey:@"la"];
     [defalults setObject:@(coord.longitude) forKey:@"lo"];
    //同步
    [defalults synchronize];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    [MainNetWork getNearPerson:nil success:^(id obj) {
        [self.collctionView.mj_header endRefreshing];
        
             [self performSelectorOnMainThread:@selector(refreshUI:) withObject:obj waitUntilDone:YES];
    } faile:^(id error) {
        [self.collctionView.mj_header endRefreshing];
        
         NSLog(@"数据请求失败！！！");
    }];
}
- (void)refreshUI:(id )obj
{
    animationNumber=0;
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray:obj];
    [self.collctionView reloadData];
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataList.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_W/3-10, SCREEN_W/3+10);
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //已经执行过动画的Cell将不再执行
    if(cell.tag<animationNumber)
    {
        return;
    }
   
    //将要展示的时候执行动画 执行过动画就不执行动画了
    cell.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:1 animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
   
    //标记 执行了动画的cell最大 tag 大于该值的表示还没执行动画
    animationNumber = cell.tag;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QWNevrCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QWNevrCollectionViewCell" forIndexPath:indexPath];
    
    cell.nModel = self.dataList[indexPath.row];
    cell.tag = indexPath.row;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    QWShowLiveViewController *showLiveVC = [[QWShowLiveViewController alloc] init];
    showLiveVC.lModel = self.dataList[indexPath.row];
    showLiveVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:showLiveVC animated:YES];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
