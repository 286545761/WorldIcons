//
//  CurrentProgressCell.h
//  WorldIcon
//
//  Created by 陈潇 on 17/10/31.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXCTModel.h"
@interface CurrentProgressCell : UITableViewCell

@property (nonatomic,copy)void(^confirmBlock)();

@property (nonatomic,strong)UILabel *line;
@property (nonatomic,strong)UIButton *confirmBtn;
@property (nonatomic,strong)UILabel *rightBottomLabel;

@property (nonatomic,strong)ReAppStatus *model;

@end
