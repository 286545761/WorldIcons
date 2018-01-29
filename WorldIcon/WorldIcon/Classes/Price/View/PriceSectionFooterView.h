//
//  PriceSectionFooterView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/21.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PriceSectionFooterViewDelegate <NSObject>

-(void)priceSectionViewFooterView:(UIView *)footerView didClickButton:(NSInteger)tag;

@end

@interface PriceSectionFooterView : UIView

@property (nonatomic,assign)id<PriceSectionFooterViewDelegate> delegate;

@end
