//
//  TypePickerView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/15.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^TypeBlock)(NSString *type);

@interface TypePickerView : UIView

@property (nonatomic,copy) TypeBlock block;

@property (nonatomic,strong)NSArray * types;//分类数组

+ (id)shareInstance;

- (void)showBottomView;
@end
