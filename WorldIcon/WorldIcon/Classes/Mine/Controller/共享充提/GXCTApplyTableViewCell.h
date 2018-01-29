//
//  GXCTApplyTableViewCell.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/4.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SharingApplicationModel;

@interface GXCTApplyTableViewCell : UITableViewCell
@property(nonatomic,strong)NSIndexPath *index;
@property (nonatomic , copy) void(^selectBlock)(NSIndexPath *index);
/**
 *<##>
 */
@property(nonatomic,strong)SharingApplicationModel *model;

@end
