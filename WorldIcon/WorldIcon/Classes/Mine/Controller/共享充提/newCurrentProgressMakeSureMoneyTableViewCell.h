//
//  newCurrentProgressMakeSureMoneyTableViewCell.h
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newCurrentProgressMakeSureMoneyTableViewCell : UITableViewCell
@property(nonatomic,copy)NSString *showTitile;

@property (nonatomic , copy) void(^makeSureBlock)();
@property (nonatomic , copy) void(^agreedBlock)();

@end
