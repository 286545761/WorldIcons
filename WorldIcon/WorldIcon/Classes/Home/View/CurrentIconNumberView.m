//
//  CurrentIconNumberView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "CurrentIconNumberView.h"
#import "CoinDetailModel.h"
@implementation CurrentIconNumberView
-(instancetype)initWithFrame:(CGRect)frame withDic:(CoinDetailModel *)model{
    if ([super initWithFrame:frame]) {
       
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUpView:model frame:frame];
    }
    return self;
}
-(void)setUpView:(CoinDetailModel *)model
           frame:(CGRect)frame{
    
    NSArray *keyArray = @[@"vf_coin",@"vf_jk",@"vf_yk",@"vf_tk"];
    
    NSMutableArray *dataArra = [NSMutableArray arrayWithCapacity:4];
    
    for (int i= 0; i < keyArray.count; i++) {
    
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];

        if ([keyArray[i] isEqualToString:@"vf_coin"]) {
            
            [dic1 setValue:@"oc" forKey:@"type"];
            [dic1 setValue:model.vf_coin forKey:@"number"];
        }
    
        if ([keyArray[i] isEqualToString:@"vf_jk"]) {
            
            [dic1 setValue:@"金矿" forKey:@"type"];
            [dic1 setValue:model.vf_jk forKey:@"number"];
        }
        if ([keyArray[i] isEqualToString:@"vf_yk"]) {
            
            [dic1 setValue:@"银矿" forKey:@"type"];
            [dic1 setValue:model.vf_yk forKey:@"number"];
        }
        if ([keyArray[i] isEqualToString:@"vf_tk"]) {
            
            [dic1 setValue:@"铜矿" forKey:@"type"];
            [dic1 setValue:model.vf_tk forKey:@"number"];
        }
        [dataArra addObject:dic1];
    }
    NSArray *imageArr = @[@"oc",@"gold_ore",@"silver_ore",@"copper_ore"];
    CGFloat w = (kScreenWidth-40-20)/dataArra.count;
    for (int i = 0; i < dataArra.count; i++) {
       
        NSDictionary *dict = dataArra[i];
        
        UIView *view = [UIView new];
        view.frame = CGRectMake(10+i*w, 0, w, frame.size.height);
        
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageArr[i]]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:image];
        
        //icontype
        UILabel *iconType = [UILabel gc_labelWithTitle:[NSString stringWithFormat:@"%@",dict[@"type"]] withTextColor:[UIColor gc_colorWithHexString:@"#858a90"] withTextFont:14 withTextAlignment:(NSTextAlignmentCenter)];
        [view addSubview:iconType];
        //iconnumber
        UILabel *iconNumber = [UILabel gc_labelWithTitle:[NSString stringWithFormat:@"%@",dict[@"number"]] withTextColor:[UIColor gc_colorWithHexString:@"#e1ad34"] withTextFont:14 withTextAlignment:(NSTextAlignmentCenter)];
        [view addSubview:iconNumber];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(0);
            make.top.mas_equalTo(view.mas_top).offset(8);
            make.width.mas_equalTo(@(w));
            make.height.mas_equalTo(@40);
        }];
        [iconType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(image.mas_bottom).offset(5);
            make.left.mas_equalTo(view).offset(0);
            make.height.mas_equalTo(20);
            make.width.equalTo(view.mas_width).offset(0);
        }];

        [iconNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(iconType.mas_bottom).offset(5);
            make.bottom.mas_equalTo(view.mas_bottom).offset(-8);
            make.left.mas_equalTo(view).offset(0);
            make.width.equalTo(view.mas_width).offset(0);
        }];
        [self addSubview:view];
    }
}
@end
