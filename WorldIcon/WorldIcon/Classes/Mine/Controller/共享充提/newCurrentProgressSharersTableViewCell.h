//
//  newCurrentProgressSharersTableViewCell.h
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//  分享者

#import <UIKit/UIKit.h>

@interface newCurrentProgressSharersTableViewCell : UITableViewCell
@property(nonatomic,strong)NSMutableDictionary *appDic;
@property(nonatomic,assign)BOOL isShow;
@property (nonatomic , copy) void(^cancleBlock)();
@end
