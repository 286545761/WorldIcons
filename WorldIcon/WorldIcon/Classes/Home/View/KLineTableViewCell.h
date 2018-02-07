//
//  KLineTableViewCell.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/2/7.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLineTableViewCell : UITableViewCell
+(CGFloat)getHeight;
-(void)reloadCell:(NSArray *)arr;
@end
