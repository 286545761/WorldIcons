//
//  MerchantSectionHeaderView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MerchantSectionHeaderView;

@protocol MerchantSectionHeaderViewDelegate <NSObject>

-(void)sectionHeaderView:(MerchantSectionHeaderView *)view didSelected:(NSString *)tool;

@end

@interface MerchantSectionHeaderView : UIView

@property (nonatomic,strong)UILabel *label;
@property (nonatomic,assign)id<MerchantSectionHeaderViewDelegate> delegate;
@end
