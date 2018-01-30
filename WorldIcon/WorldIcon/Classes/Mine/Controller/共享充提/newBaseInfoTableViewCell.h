//
//  newBaseInfoTableViewCell.h
//  WorldIcon
//
//  Created by 韩铭文 on 2018/1/30.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newBaseInfoTableViewCell : UITableViewCell
@property(nonatomic,strong)NSIndexPath *index;
@property (nonatomic , copy) void(^editorBlock)(NSIndexPath *index);

@end
