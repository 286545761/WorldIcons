//
//  UIFont+adaptive.m
//  ymm
//
//  Created by 白亚策 on 15/12/27.
//  Copyright © 2015年 ymm. All rights reserved.
//

#import "UIFont+adaptive.h"

@implementation UIFont (adaptive)
+ (UIFont *)fontWithAdaptiveIphone5Size:(CGFloat)fontSize
{
//    NSLog(@"%f",KScreenFrameWidth);
    if (kScreenWidth >= 414.0f) {
        fontSize += 2;
    }
    return [UIFont systemFontOfSize:fontSize];
    
}

@end
