//
//  UserPhotoRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/15.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface UserPhotoRequest : GCBaseRequest

@property (nonatomic, strong) NSArray<UIImage *> *images;

@end
