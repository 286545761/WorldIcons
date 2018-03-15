//
//  MyIncomeCell.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/3/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  IncomeModel;
@interface MyIncomeCell : UITableViewCell
+(CGFloat)getCellHeight;
-(void)reloadCellModel:(IncomeModel *)model;
@end
