//
//  ApplicationViewController.h
//  WorldIcon
//
//  Created by 陈潇 on 17/11/6.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "LXSegmentController.h"
#import "YUFoldingTableView.h"

@interface ApplicationViewController : LXSegmentController
@property (nonatomic , copy) void(^showLoading)();

@end
