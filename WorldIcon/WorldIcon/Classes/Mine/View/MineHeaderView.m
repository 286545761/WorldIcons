//
//  MineHeaderView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView ()

@property (nonatomic,strong)UIImageView *userPhoto;
@property (nonatomic,strong) UILabel *username;
@property (nonatomic,strong) UILabel *editLabel;
@property (nonatomic,strong) UIImageView *arrow;
@end

@implementation MineHeaderView
-(instancetype)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{

    //图片
    UIImageView *userPhoto = [[UIImageView alloc]init];//WithFrame:CGRectMake(10, 10, 55, 55)
    userPhoto.image = [UIImage imageNamed:kDefaultImg];
    userPhoto.layer.masksToBounds = YES;
    userPhoto.layer.cornerRadius = 27.5;
    [self addSubview:userPhoto];
    self.userPhoto = userPhoto;
    //名字
    UILabel *username = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor whiteColor] withTextFont:16 withTextAlignment:(NSTextAlignmentLeft)];//WithFrame:CGRectMake(75, 21, 150, 20)
    username.text = @"昵称";
    [self addSubview:username];
    self.username = username;
    //查看或编辑个人资料
    UILabel *editLabel = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor whiteColor] withTextFont:14 withTextAlignment:(NSTextAlignmentLeft)];//WithFrame:CGRectMake(75, 48, 150, 20)
    editLabel.text = @"查看或编辑个人资料";
    [self addSubview:editLabel];
    self.editLabel = editLabel;
    //右侧箭头
    UIImageView *arrow = [[UIImageView alloc]init];//WithFrame:CGRectMake(75, 48, 150, 20)
    arrow.image = [UIImage imageNamed:@"rightarrows"];
    [self addSubview:arrow];
    self.arrow = arrow;
}
-(void)setUserInfoModel:(UserInfoModel *)userInfoModel{
    [self.userPhoto sd_setImageWithURL:[NSURL URLWithString:[AppManager getPhotoUrlFileID:userInfoModel.user_detail.ud_photo_fileid]] placeholderImage:[UIImage imageNamed:kDefaultImg]];
    if (userInfoModel.user_detail.ud_nickname.length != 0) {
        self.username.text = userInfoModel.user_detail.ud_nickname;
    }
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.userPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(55, 55));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userPhoto.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 20));
        make.top.mas_equalTo(self).offset(17);
    }];
    
    [self.editLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userPhoto.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 20));
        make.top.mas_equalTo(self.username.mas_bottom).offset(7);
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(9, 16));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [super updateConstraints];
    
}
/**
 自动布局
 */
+(BOOL)requiresConstraintBasedLayout{
    return YES;
}

@end
