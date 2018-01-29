//
//  SharingApplicationModel.h
//  WorldIcon
//
//  Created by 韩铭文 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SharingApplicationModel : JSONModel
/**
 *title
 */
@property(nonatomic,copy)NSString *titile;
/**
 *titledetails
 */
@property(nonatomic,copy)NSString*titledetails;
@end
