//
//  BTCShowCell.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2017/12/29.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTCPriceModel;
@interface BTCShowCell : UITableViewCell
-(void)reloadCell:(BTCPriceModel *)model;
@end
