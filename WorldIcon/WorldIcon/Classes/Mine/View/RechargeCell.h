//
//  RechargeCell.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/20.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardModel.h"

typedef void(^didClickBlock)(NSString *str);

@interface RechargeCell : UITableViewCell

@property (nonatomic,copy)didClickBlock block;

@property (nonatomic,strong)CardModel *model;

@end
