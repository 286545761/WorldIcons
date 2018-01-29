//
//  GCAlertView.h
//  CustomAlertView
//
//  Created by 陈潇 on 17/6/30.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 代理方法
@protocol GCAlertViewDelegate <NSObject>

// 可选执行方法
@optional
// 点击按钮下标时传递参数
- (void)didSelectAlertButton:(NSString *)title;
@end

@interface GCAlertView : NSObject
/** 单例 */
+ (GCAlertView *)singleClass;

/** 快速创建提示框*/
- (UIView *)quickAlertViewWithArray:(NSArray *)array;

// 代理属性
@property (assign, nonatomic)id<GCAlertViewDelegate>delegate;

@end

