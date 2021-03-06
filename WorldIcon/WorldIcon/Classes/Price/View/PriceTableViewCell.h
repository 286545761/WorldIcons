//
//  PriceTableViewCell.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/3.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PriceModel;
@class BuyModel;
@class SellModel;
@interface PriceTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,assign)CGFloat max;
-(void)reloadCellBuyModel:(BuyModel *)model
            withIndexpath:(NSIndexPath *)index;
-(void)reloadCellSellModel:(SellModel *)model
             withIndexpath:(NSInteger )index;
@end
