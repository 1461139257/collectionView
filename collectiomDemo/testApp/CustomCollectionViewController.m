//
//  CustomCollectionViewController.m
//  testApp
//
//  Created by 刘恋 on 2018/8/24.
//  Copyright © 2018年 刘恋. All rights reserved.
//

#import "CustomCollectionViewController.h"
#import "CustomCollectionViewCell.h"
#import "CustomCollectionViewModel.h"

#define customResuid @"CustomCollectionViewResuId"
#define customViewResuid @"CustomViewResuId"

@interface CustomCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *mainCollectionView;
@property(nonatomic,strong)CustomCollectionViewModel *customViewModel;
@property(nonatomic,strong)NSMutableArray *dateSourcArray;

@end

@implementation CustomCollectionViewController

-(NSMutableArray *)dateSourcArray{
    if(!_dateSourcArray){
        _dateSourcArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dateSourcArray;
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    self.title = @"大家好";
//
//
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 0);
//    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//    [self.view addSubview:self.mainCollectionView];
//    self.mainCollectionView.backgroundColor = [Global convertHexToRGB:@"dcdcdc"];
//    [self.mainCollectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:customResuid];
//    self.mainCollectionView.delegate = self;
//    self.mainCollectionView.dataSource = self;
//
////    初始化custViewModel
//    self.customViewModel=[[CustomCollectionViewModel alloc] init];
//
//    kWeakSelf(self);
//    self.mainCollectionView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
//        [weakself headerRefreshAction];
//    }];
//    self.mainCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakself footerRefreshAction] ;
//    }];
//    [self.mainCollectionView.mj_header beginRefreshing];
//
//
//}

#pragma mark ------- 下拉刷新
- (void)headerRefreshAction
{
    
    kWeakSelf(self);
    [self.customViewModel headerRefreshRequestWithCallback:^(NSArray *array){
        weakself.dateSourcArray=(NSMutableArray *)array;
        [weakself.mainCollectionView reloadData];
        [weakself endRefresh];
    }];
    
}

#pragma mark ------- 上拉刷新
- (void)footerRefreshAction
{
    kWeakSelf(self);
    [self.customViewModel footerRefreshRequestWithCallback:^(NSArray *array){
        [weakself.dateSourcArray addObjectsFromArray:array] ;
        [weakself.mainCollectionView reloadData];
        [weakself endRefresh];
    }];
    
}

#pragma mark ------ 结束刷新
-(void)endRefresh{
    
    kWeakSelf(self);
    if ([weakself.mainCollectionView.mj_header isRefreshing]) {
        [weakself.mainCollectionView.mj_header endRefreshing];
    }
    if ([weakself.mainCollectionView.mj_footer isRefreshing]) {
        [weakself.mainCollectionView.mj_footer endRefreshing];
    }
}

#pragma mark collectionView代理方法

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dateSourcArray.count>0?self.dateSourcArray.count:0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:customResuid forIndexPath:indexPath];
    cell.customModel = _dateSourcArray[indexPath.row];
    cell.backgroundColor = [Global convertHexToRGB:@"898989"];
    cell.clipsToBounds = YES;
    cell.layer.cornerRadius = 5.0 ;
    return cell;
}

#pragma mark ------- 设置  UICollectionView  item
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(PhotoWith, PhotoWith+50);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0,0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}



//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.customModel = _dateSourcArray[indexPath.row];
    NSString *msg = cell.customModel.name;
    NSLog(@"%@    %ld",msg,indexPath.row);
}







#pragma mark --------- 以下是设置头视图   尾视图的方法   可把viewdieload改成如下

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"大家好";
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 300);//增加1
    
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//    CGRectMake(0, 0, KScreenWidth, KScreenHeight  - SafeAreaBottomHeight)
    [self.view addSubview:self.mainCollectionView];
    

     kWeakSelf(self);
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(weakself.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.bottom.mas_equalTo(0);
        }
    }];
    

    self.mainCollectionView.backgroundColor = [Global convertHexToRGB:@"dcdcdc"];
    [self.mainCollectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:customResuid];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [self.mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:customViewResuid];//增加2
    
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    
    //    初始化custViewModel
    self.customViewModel=[[CustomCollectionViewModel alloc] init];
    
   
    self.mainCollectionView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        [weakself headerRefreshAction];
    }];
    self.mainCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself footerRefreshAction] ;
    }];
    [self.mainCollectionView.mj_header beginRefreshing];
    
    
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:customViewResuid forIndexPath:indexPath];
    
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 300)];
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [headerView addSubview:headImageView];
    headImageView.image = [UIImage imageNamed:@"666.jpeg"];

    return headerView;
}

////header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
