//
//  YMMSetBarButtonItem.h
//  YMM
//
//  Created by DGS on 15/5/1.
//  Copyright (c) 2015年 Syswin. All rights reserved.
//

#define KBarButtonWidth 15
#define KBarButtonHeight 40
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YMMSetBarButtonItem : NSObject
+ (UIBarButtonItem *)barButtonItemWithTarget:(id)target
                                      action:(SEL)selector
                                 normalImage:(NSString *)normalImgName
                              highLightImage:(NSString *) highLightImageName
                                       title:(NSString *)title
                                  titleColor:(UIColor *)titleColor
                                       frame:(CGRect)frame;
+ (UIBarButtonItem *)headBarButtonItemWithTarget:(id)target
                                      action:(SEL)selector
                                 normalImage:(NSString *)normalImgName
                              highLightImage:(NSString *) highLightImageName
                                       title:(NSString *)title
                                  titleColor:(UIColor *)titleColor
                                       frame:(CGRect)frame;
@end
