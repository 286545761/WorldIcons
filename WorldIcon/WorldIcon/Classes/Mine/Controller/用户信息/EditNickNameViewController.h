//
//  EditNickNameViewController.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/14.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WIBaseViewController.h"

typedef void(^BACKNICKNAME)(NSString *nickname);

@interface EditNickNameViewController : WIBaseViewController

@property (nonatomic,copy)NSString *nicknameStr;
@property (nonatomic,copy)BACKNICKNAME block;

@end
