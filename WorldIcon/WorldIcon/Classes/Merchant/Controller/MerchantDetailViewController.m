//
//  MerchantDetailViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MerchantDetailViewController.h"

@interface MerchantDetailViewController ()

@end

@implementation MerchantDetailViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navLabel.text = @"商家详情";
    
    [self setUpRightBarButton];

    [self setUpMainUI];
    
}
-(void)setUpMainUI{

    UIScrollView *mainScrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:mainScrolView];
    
    //商家图片
    UIImageView *sjImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    [sjImage sd_setImageWithURL:[NSURL URLWithString:[AppManager getPhotoUrlFileID:self.model.vm_img_url]] placeholderImage:[UIImage imageNamed:@"商家banner大图"]];
    [mainScrolView addSubview:sjImage];
    
    //商家信息
    UIView *content1 = [[UIView alloc]initWithFrame:CGRectMake(0, 250, kScreenWidth, 100)];
    content1.backgroundColor = [UIColor whiteColor];
    [mainScrolView addSubview:content1];
    
    //商家介绍
    UIView *content2 = [[UIView alloc]initWithFrame:CGRectMake(0, 360, kScreenWidth, 300)];
    content2.backgroundColor = [UIColor whiteColor];
    [mainScrolView addSubview:content2];
    
    //商家icon
    UIImageView *sjIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12.5, 25, 25)];
    [sjIcon sd_setImageWithURL:[NSURL URLWithString:[AppManager getPhotoUrlFileID:self.model.vm_img_logo]] placeholderImage:[UIImage imageNamed:@"龙创图标"]];
    [content1 addSubview:sjIcon];
    //商家名称
    UILabel *sjName = [UILabel gc_labelWithTitle:@"北京龙创时代科技有限公司" withTextColor:[UIColor gc_colorWithHexString:@"#858a90"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    sjName.frame = CGRectMake(40, 12.5, 150, 25);
    sjName.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    sjName.text = [NSString stringWithFormat:@"%@",self.model.vm_agent_name];
    [content1 addSubview:sjName];
    //分隔线
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(10, 49, kScreenWidth-20, 1)];
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
    [content1 addSubview:line];
    //地址
    UILabel *address = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentLeft)];
    address.frame = CGRectMake(10, 50, kScreenWidth-20, 45);
    address.text = @"地址:北京市朝阳区团结湖SOHO嘉盛中心";
    address.text = [NSString stringWithFormat:@"%@",self.model.vm_address];
    [content1 addSubview:address];
    //地图位置
    UIButton *locationIcon = [UIButton buttonWithType:(UIButtonTypeCustom)];
    locationIcon.frame = CGRectMake(kScreenWidth-10-45, 50, 45, 45);
    [locationIcon setImage:[UIImage imageNamed:@"地图图标"] forState:(UIControlStateNormal)];
    [content1 addSubview:locationIcon];
    
    //商家介绍
    UILabel *sjjsLabel = [UILabel gc_labelWithTitle:@"商家介绍" withTextColor:[UIColor gc_colorWithHexString:@"#858a90"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    sjjsLabel.frame = CGRectMake(10, 0, kScreenWidth-20, 50);
    sjjsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [content2 addSubview:sjjsLabel];
    
    UILabel *jsjsDetail = [UILabel gc_labelWithTitle:@"多核手机开会说JKGDJSHGDHSAJDGsjkh好的技术卡回复JASLHFJKLsahhdefhewiuhfie" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentLeft)];
    jsjsDetail.numberOfLines = 0;
//    CGFloat height = [AppManager autoCalculateWidthOrHeight:MAXFLOAT width:kScreenWidth-20 fontsize:14 content:jsjsDetail.text];
    jsjsDetail.frame = CGRectMake(10, 50, kScreenWidth-20, 40);
    jsjsDetail.text = [NSString stringWithFormat:@"%@",self.model.vm_introduce];
    [content2 addSubview:jsjsDetail];

}
#pragma mark -- 右侧搜藏
-(void)setUpRightBarButton{
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"收藏五角星"] style:(UIBarButtonItemStyleDone) target:self action:@selector(collectionAction)];
    btn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = btn;
    
}
#pragma mark -- 搜藏按钮
-(void)collectionAction{

}
@end
