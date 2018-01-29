//
//  MachineShopCell.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MachinesModel.h"

typedef void(^BuyBlock)();
@interface MachineShopCell : UITableViewCell

@property (nonatomic,copy)BuyBlock block;

@property (nonatomic,strong)MachinesModel *model;

@end
