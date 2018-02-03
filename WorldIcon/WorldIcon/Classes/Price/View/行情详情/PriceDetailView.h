//
//  PriceDetailView.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/2/2.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PriceDetailViewDelegate <NSObject>
- (void)bottomPassBtnOnClick;
- (void)revokeBtnOnClick:(NSIndexPath *)index;
@end
@class BuySellModel;
@class ListModel;
@interface PriceDetailView : UIView
-(instancetype)initWithBuyModel:(BuySellModel *)model;
-(instancetype)initWithListModel:(ListModel *)model;
@property (nonatomic, weak) id<PriceDetailViewDelegate> delegate;
@property (nonatomic,assign)NSIndexPath *index;
@end
