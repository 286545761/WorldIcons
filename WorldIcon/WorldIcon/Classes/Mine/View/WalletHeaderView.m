//
//  WalletHeaderView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WalletHeaderView.h"

@implementation WalletHeaderView

-(instancetype)initWithFrame:(CGRect)frame withDic:(NSDictionary *)dic{
    if ([super initWithFrame:frame]) {
        [self setUpView:dic];
    }
    return self;
}
-(void)setUpView:(NSDictionary *)dic{
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake([UIView countBeforeWithIphone5Length:10], 10, kScreenWidth-[UIView countBeforeWithIphone5Length:20], self.frame.size.height-15)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius = 5;
    back.layer.masksToBounds = YES;
    [self addSubview:back];
    
    
    for (int i = 0; i < 2; i++) {
        
        UIView *v = [[UIView alloc]initWithFrame:CGRectZero];
        v.frame = CGRectMake(i*back.frame.size.width/2, 0, back.frame.size.width/2, 150);
        
        //欧力币
        UILabel *iconType = [UILabel gc_labelWithTitle:@"" withFontName:@"Helvetica-Bold" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:17 withTextAlignment:NSTextAlignmentCenter];
        iconType.frame = CGRectMake(0, 10, back.frame.size.width/2, 30);
        [v addSubview:iconType];
        
        //OC(总数/可用)
        UILabel *ocType = [UILabel gc_labelWithTitle:@"10000.00" withTextColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTextFont:17 withTextAlignment:(NSTextAlignmentCenter)];
        ocType.font = [UIFont boldSystemFontOfSize:15];
        ocType.frame = CGRectMake(0, 30+10, back.frame.size.width/2, 25);
        [v addSubview:ocType];
        
        // 0/0
        UILabel *ocNumber = [UILabel gc_labelWithTitle:@"10000.00" withTextColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTextFont:13 withTextAlignment:(NSTextAlignmentCenter)];
        ocNumber.frame = CGRectMake(0, 65, back.frame.size.width/2, 35);
        ocNumber.numberOfLines = 2;
        [v addSubview:ocNumber];
        
        //OC市值
        UILabel *shizhi = [UILabel gc_labelWithTitle:@"10000.00" withTextColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTextFont:15 withTextAlignment:(NSTextAlignmentCenter)];
        shizhi.frame = CGRectMake(0, 85+15, back.frame.size.width/2, 35);
        [v addSubview:shizhi];
        
        //OC市值
        UILabel *shizhiAccount = [UILabel gc_labelWithTitle:@"10000.00" withTextColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTextFont:13 withTextAlignment:(NSTextAlignmentCenter)];
        shizhiAccount.frame = CGRectMake(0, 135, back.frame.size.width/2, 20);
        [v addSubview:shizhiAccount];
        
        if (i == 0) {
            
            iconType.text = @"欧力币";
            ocType.text = @"OC(总数/可用):";
            ocNumber.text = [NSString stringWithFormat:@"%@\n%@",dic[@"vf_coin"],dic[@"vd_coin"]];
            shizhi.text = @"OC市值:";
            shizhiAccount.text = [NSString stringWithFormat:@"%@",dic[@"value"]];
            ocType.textColor = kTitleColor;
            ocNumber.textColor = kTitleColor;
            shizhi.textColor = kTitleColor;
            shizhiAccount.textColor = kTitleColor;
        }else{
            
            iconType.text = @"美元";
            ocType.text = @"美元(总数/可用):";
                 ocNumber.text = [NSString stringWithFormat:@"%@\n%@",dic[@"ud_amount"],dic[@"ud_mount"]];
           
            shizhi.text = @"总资产:";
            shizhiAccount.text = [NSString stringWithFormat:@"%@",dic[@"allAmount"]];
        }
        
        [back addSubview:v];
    }
    
    UILabel *line = [UILabel new];
    line.frame = CGRectMake(back.frame.size.width/2, 20, 1, back.frame.size.height-40);
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
    [back addSubview:line];
    
}

@end

