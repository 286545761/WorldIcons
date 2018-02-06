//
//  MineralCell.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didClickBlock)(NSIndexPath *index);

@interface MineralCell : UITableViewCell

@property (nonatomic,copy)didClickBlock btnBlock;
@property (nonatomic,strong)UILabel *kmLabel;
@property (nonatomic,strong)UILabel *zlLabel;
@property (nonatomic,strong)UILabel *zrclLabel;
@property (nonatomic,strong)UIButton *complexBtn;
@property (nonatomic,strong)NSIndexPath *index;
@end
