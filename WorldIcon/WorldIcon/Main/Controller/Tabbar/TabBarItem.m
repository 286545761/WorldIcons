//
//  RXTabBarItem.m
//  Toon
//
//  Created by dgs on 13-12-16.
//  Copyright (c) 2013年 dgsmac rights reserved.
//

/**
 *  自定义TabbarItem
 *
 */
#import "TabBarItem.h"

@implementation TabBarItem

#pragma mark 根据标题、普通图片、高亮图片初始化按钮所用信息的类方法
+(id)tabBarItemWithTitle:(NSString*)title normalImage:(NSString*)normalImage highlightedImage:(NSString*)highlightedImage{
    
    TabBarItem *item = [[TabBarItem alloc] init];
    item.title = title;
    item.normalImage = normalImage;
    item.highlightedImage = highlightedImage;
    return item;
    
}

@end
