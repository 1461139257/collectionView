//
//  MVVMViewController.m
//  testApp
//
//  Created by 刘恋 on 2018/8/24.
//  Copyright © 2018年 刘恋. All rights reserved.
//

#import "MVVMViewController.h"
#import "CustomTableViewCell.h"
#import "CustomViewModel.h"

#define customTableViewCell @"CustomTableViewCell"

@interface MVVMViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)CustomViewModel *custViewModel;
@property(nonatomic,strong)NSMutableArray *dateSourcArray;

@end

@implementation MVVMViewController

-(NSMutableArray *)dateSourcArray{
    if(!_dateSourcArray){
        _dateSourcArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dateSourcArray;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView .rowHeight = 80;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView  registerClass:[CustomTableViewCell class] forCellReuseIdentifier:customTableViewCell];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"你好";
    
    
    kWeakSelf(self);
    

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(weakself.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.bottom.mas_equalTo(0);
        }
    }];
    

//    初始化custViewModel
    self.custViewModel=[[CustomViewModel alloc] init];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        [weakself headerRefreshAction];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself footerRefreshAction] ;
    }];
    [self.tableView.mj_header beginRefreshing];

}

#pragma mark ------- 下拉刷新
- (void)headerRefreshAction
{
    
    kWeakSelf(self);
    [self.custViewModel headerRefreshRequestWithCallback:^(NSArray *array){
        weakself.dateSourcArray=(NSMutableArray *)array;
        [weakself.tableView reloadData];
        [weakself endRefresh];
    }];
    
}

#pragma mark ------- 上拉刷新
- (void)footerRefreshAction
{
    kWeakSelf(self);
    [self.custViewModel footerRefreshRequestWithCallback:^(NSArray *array){
        [weakself.dateSourcArray addObjectsFromArray:array] ;
        [weakself.tableView reloadData];
        [weakself endRefresh];
    }];
    
}

#pragma mark ------ 结束刷新
-(void)endRefresh{
    
    kWeakSelf(self);
    if ([weakself.tableView.mj_header isRefreshing]) {
        [weakself.tableView.mj_header endRefreshing];
    }
    if ([weakself.tableView.mj_footer isRefreshing]) {
        [weakself.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - UITableViewDataSource  &&  UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dateSourcArray.count>0?_dateSourcArray.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customTableViewCell];
    cell.custModel = _dateSourcArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath   %ld",indexPath.row);
}

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
