//
//  ResultModel.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/13.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ResultModel : JSONModel

@property (nonatomic,copy)NSString *code;
@property (nonatomic,copy)NSString *info;
@property (nonatomic,copy)NSString *sid;
@property (nonatomic,copy)NSString *index;

@end
