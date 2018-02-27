//
//  newCurrentProgressAViewController.h
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//  共享冲题当前进度

#import "WIBaseViewController.h"
#import "GXCTModel.h"

@interface newCurrentProgressAViewController : WIBaseViewController
@property (nonatomic,strong)ReApp  *newmodel;

@property (nonatomic,copy)NSString*fromString;// 0 共享者 1 个人
@property (nonatomic,copy)NSString*typeString;// 0 充值 1 提现
@property(nonatomic,assign)BOOL ShowMakeMoney;

@end
