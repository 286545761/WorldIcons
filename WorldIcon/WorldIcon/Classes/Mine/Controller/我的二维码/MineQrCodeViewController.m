//
//  MineQrCodeViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MineQrCodeViewController.h"

@interface MineQrCodeViewController ()

@end

@implementation MineQrCodeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navLabel.text = @"我的二维码";
   
    NSString *s1 = [self customSecureStr:[UserManager getPhone]];
    
    NSString *s2 = [self customSecureStr:[UserManager getUID]];
    
    NSString *s = [NSString stringWithFormat:@"%@_%@",s1,s2];
    
    NSString *url = [NSString stringWithFormat:@"%@?data=%@",@"http://vm.lchtime.com/qrcode.php",s];
    //二维码
    UIImageView *qrCodeView = [UIImageView new];
    [qrCodeView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"展示二维码"]];
    [self.view addSubview:qrCodeView];
    //我的二维码
    UILabel *qrLabel = [UILabel gc_labelWithTitle:@"我的二维码" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:18 withTextAlignment:(NSTextAlignmentCenter)];
    [self.view addSubview:qrLabel];
    //oc 地址
    UILabel *ocLabel = [UILabel gc_labelWithTitle:[NSString stringWithFormat:@"OC地址：%@",[UserManager getmdaddr]] withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:18 withTextAlignment:(NSTextAlignmentCenter)];
    ocLabel.layer.masksToBounds = YES;
    ocLabel.layer.cornerRadius = 5;
    ocLabel.backgroundColor = [UIColor gc_colorWithHexString:@"#f5f5f5"];
    [self.view addSubview:ocLabel];
    
    [qrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(260, 260));
        make.top.mas_equalTo(self.view).offset(60);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [qrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(qrCodeView.mas_bottom).offset(32.5);
        make.height.mas_equalTo(20);
    }];
    [ocLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(qrLabel.mas_bottom).offset(32.5);
        make.height.mas_equalTo(40);
    }];
}
-(NSString *)customSecureStr:(NSString *)str{

    NSString *temp = nil;
    NSString *distinationStr = @"";
    for (int i=0; i < str.length ; i++) {
        
        temp = [str substringWithRange:NSMakeRange(i, 1)];
        int number = [temp intValue];
        switch (number) {
            case 0:
                temp = @"Y";
                break;
            case 1:
                temp = @"J";
                break;
            case 2:
                temp = @"M";
                break;
            case 3:
                temp = @"O";
                break;
            case 4:
                temp = @"A";
                break;
            case 5:
                temp = @"K";
                break;
            case 6:
                temp = @"R";
                break;
            case 7:
                temp = @"S";
                break;
            case 8:
                temp = @"Z";
                break;
            case 9:
                temp = @"P";
                break;
                
            default:
                break;
        }
        distinationStr = [distinationStr stringByAppendingString:temp];
    }
    return distinationStr;
}
@end
