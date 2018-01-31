//
//  InputBuyAndSellView.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/31.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputBuyAndSellViewDelegate <NSObject>
- (void)prictTextChanged:(NSString *)content;
- (void)amountTextChanged:(NSString *)content;
- (void)deleteBtnAction;
- (void)ensureBtnAction:(NSString *)type;
@end

@interface InputBuyAndSellView : UIView
-(instancetype)initWithType:(NSString *)type
                  withCount:(NSString *)countStr;
@property (nonatomic) id<InputBuyAndSellViewDelegate> delegate;
@end
