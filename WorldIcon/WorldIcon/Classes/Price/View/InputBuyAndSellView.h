//
//  InputBuyAndSellView.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/31.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputBuyAndSellViewDelegate <NSObject>
//- (void)prictTextChanged:(NSString *)content;
//- (void)amountTextChanged:(NSString *)content;
- (void)deleteBtnAction;
- (void)ensureBtnAction:(NSString *)type
          withprictText:(NSString *)price
         withamountText:(NSString *)amount;
@end

@interface InputBuyAndSellView : UIView
-(instancetype)initWithType:(NSString *)type
                  withCount:(NSString *)countStr
                  withPrice:(NSString *)PriceStr;
@property (nonatomic) id<InputBuyAndSellViewDelegate> delegate;
@property (nonatomic,assign)CGFloat amount;
@end
