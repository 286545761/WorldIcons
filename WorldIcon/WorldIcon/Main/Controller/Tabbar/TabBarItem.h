//
//  RXTabBarItem.h
//  Toon
//
//  Created by dgs on 13-12-16.
//  Copyright (c) 2013年 dgsmac rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabBarItem : NSObject

@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* normalImage;
@property(nonatomic,copy) NSString* highlightedImage;
+(id)tabBarItemWithTitle:(NSString*)title normalImage:(NSString*)normalImage highlightedImage:(NSString*)highlightedImage;

@end
