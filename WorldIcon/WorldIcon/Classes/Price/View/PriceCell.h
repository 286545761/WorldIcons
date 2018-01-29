//
//  PriceCell.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/21.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceModel.h"

@interface PriceCell : UITableViewCell

@property (nonatomic,strong)UILabel *jyPrice;

@property (nonatomic,strong)SellModel *sellModel;
@property (nonatomic,strong)BuyModel  *buyModel;
@property (nonatomic,strong)NSString *index;
//@property (nonatomic,strong)UILabel *line;

@end
