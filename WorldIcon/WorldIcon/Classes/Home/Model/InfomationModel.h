//
//  InfomationModel.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface InfomationModel : JSONModel
@property (nonatomic,copy)NSString<Optional> *vi_id;
@property (nonatomic,copy)NSString<Optional> *vi_title;
@end
