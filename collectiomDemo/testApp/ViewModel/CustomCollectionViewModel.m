//
//  CustomCollectionViewModel.m
//  testApp
//
//  Created by 刘恋 on 2018/8/24.
//  Copyright © 2018年 刘恋. All rights reserved.
//

#import "CustomCollectionViewModel.h"
#import "CustomCollectModel.h"


@implementation CustomCollectionViewModel


- (void)headerRefreshRequestWithCallback:(callback)callback
{
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //               主线程刷新视图
            NSMutableArray *arr=[NSMutableArray array];
            for (int i=0; i<16; i++) {
                CustomCollectModel *model=[[CustomCollectModel alloc] init];
                model.imageUrl= @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535106251665&di=5a0c9037c06c3db25d327af96bd8856e&imgtype=0&src=http%3A%2F%2Fpic22.photophoto.cn%2F20120225%2F0034034432152602_b.jpg";
                model.name = @"你好老司机";
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
                CustomCollectModel *model=[[CustomCollectModel alloc] init];
                model.imageUrl= @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535106251665&di=336fc77da9f74d8800a15efdae566990&imgtype=0&src=http%3A%2F%2Fpic34.photophoto.cn%2F20150112%2F0034034439579927_b.jpg";
                model.name = @"老司机666";
                [arr addObject:model];
            }
            callback(arr);
        });
    });
}


@end
