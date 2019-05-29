//
//  Global.h
//  testApp
//
//  Created by 刘恋 on 2018/8/24.
//  Copyright © 2018年 刘恋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject

//颜色转换 十六进制转RGB
+ (UIColor *)convertHexToRGB:(NSString *)hexString;
+ (UIColor *)convertHexToRGB:(NSString *)hexString withAlpha:(CGFloat)alpha;

@end
