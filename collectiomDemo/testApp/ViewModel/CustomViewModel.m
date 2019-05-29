//
//  CustomViewModel.m
//  testApp
//
//  Created by 刘恋 on 2018/8/24.
//  Copyright © 2018年 刘恋. All rights reserved.
//

#import "CustomViewModel.h"
#import "CustomModel.h"

@interface CustomViewModel ()

@end


@implementation CustomViewModel


- (void)headerRefreshRequestWithCallback:(callback)callback
{
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //               主线程刷新视图
            NSMutableArray *arr=[NSMutableArray array];
            for (int i=0; i<16; i++) {
                int x = arc4random() % 100;
                CustomModel *model=[[CustomModel alloc] init];
                model.nickName= [NSString stringWithFormat:@"随机数(random%d)",x];;
                model.content = @"君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！君子性非异也，善假于物也！";
                [arr addObject:model];
            }
            callback(arr);
        });
    });
}

- (void )footerRefreshRequestWithCallback:(callback)callback
{
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            //               主线程刷新视图
            NSMutableArray *arr=[NSMutableArray array];
            for (int i=0; i<16; i++) {
                int x = arc4random() % 100;
                CustomModel *model=[[CustomModel alloc] init];
                model.nickName= [NSString stringWithFormat:@"随机数(random%d)",x];;
                model.content = @"君子性非异也，善假于物也！";
                [arr addObject:model];
            }
            callback(arr);
        });
    });
}

@end
