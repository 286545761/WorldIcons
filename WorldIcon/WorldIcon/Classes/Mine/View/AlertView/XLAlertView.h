//
//  XLAlertView.h
//  CustomAlertView
//
//  Created by 陈潇 on 17/6/30.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertResult)(NSInteger index);

@interface XLAlertView : UIView

@property (nonatomic,copy) AlertResult resultIndex;

- (instancetype)initWithMessage:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;

- (void)showXLAlertView;

@end
