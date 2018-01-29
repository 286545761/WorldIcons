//
//  HZPOrderTableViewCell.h
//  洋妈妈
//
//  Created by 郭飞燕 on 17/3/31.
//  Copyright © 2017年 ymm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZPOrderTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *myOrderLable;
-(void)reloadViewTitleLable:(NSString *)titleStr
              WithShowLable:(NSString *)showstr;
-(void)reloadViewWithTitleLable1:(NSString *)titleStr
                  withRightLable:(NSArray *)array;
@end
