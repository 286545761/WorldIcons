//
//  MineUserInfoViewController.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WIBaseViewController.h"
#import "UserInfoModel.h"
@interface MineUserInfoViewController : WIBaseViewController
@property (nonatomic,strong)UserInfoModel *model;
@property (nonatomic , copy) void(^seleteBlock)();
@end
