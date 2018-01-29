//
//  RXTabBarItemButton.h
//  Toon
//
//  Created by dgs on 13-12-16.
//  Copyright (c) 2013年 dgsmac rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumImageView.h"

@class TabBarItem;
@interface TabBarItemButton : UIButton

@property (nonatomic, strong) NumImageView *numView;
@property (nonatomic, strong) UIView *pointView;
@property (nonatomic, strong) TabBarItem *item;

- (id)initWithFrame:(CGRect)frame item:(TabBarItem *)item;//btn信息
-(void)setNum:(NSString *)aNum;

@end
