//
//  CTOrderCell.h
//  WorldIcon
//
//  Created by 陈潇 on 17/10/24.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXCTModel.h"

@interface CTOrderCell : UITableViewCell

@property (nonatomic,strong)UIButton *reciveBtn;

@property (nonatomic,strong)GXCTModel *model;

@property (nonatomic,copy)void(^supreappBlock) ();

@end
