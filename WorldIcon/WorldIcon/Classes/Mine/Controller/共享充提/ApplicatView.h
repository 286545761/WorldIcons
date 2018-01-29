//
//  ApplicatView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/10/23.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^APPLICATIONBLOCK)();

@interface ApplicatView : UIView

@property (nonatomic,copy)APPLICATIONBLOCK block;

@end
