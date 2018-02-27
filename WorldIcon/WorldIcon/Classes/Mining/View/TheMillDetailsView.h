//
//  TheMillDetailsView.h
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/8.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MachineModel.h"
#import "MachinesModel.h"
@interface TheMillDetailsView : UIView
@property(nonatomic,copy)NSString *typeString;
-(void)showViewWithDataSource:(MachineModel*)dataSoure;
-(void)shopingShowViewWithDataSource:(MachinesModel*)shopingdataSoure;
@end
