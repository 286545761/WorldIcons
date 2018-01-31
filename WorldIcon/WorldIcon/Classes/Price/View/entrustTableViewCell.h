//
//  entrustTableViewCell.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/3.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BuySellModel;
@interface entrustTableViewCell : UITableViewCell
-(void)reloadCellModel:(BuySellModel *)model;
@end
