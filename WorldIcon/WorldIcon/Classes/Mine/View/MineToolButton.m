//
//  MineToolButton.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MineToolButton.h"

@implementation MineToolButton
//title的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, kScreenWidth/3 - 50 , kScreenWidth/3, 50);
}

//背景的位置
- (CGRect)backgroundRectForBounds:(CGRect)bounds{
    return CGRectMake((kScreenWidth/3 -33)/2, (kScreenWidth/3 -50)/2, 33, 33);
}
@end
