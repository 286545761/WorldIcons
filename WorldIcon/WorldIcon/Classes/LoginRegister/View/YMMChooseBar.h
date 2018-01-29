//
//  YMMChooseBar.h
//  ymm
//
//  Created by 白亚策 on 15/12/26.
//  Copyright © 2015年 ymm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMMChooseBar : UIView
@property (nonatomic, copy) void (^indexChangeBlock)(NSUInteger index);
@property (nonatomic, strong) NSArray * titleArray;
@end
