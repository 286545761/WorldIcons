//
//  ShisjyView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "ShisjyView.h"
#import "CoinDetailModel.h"
@implementation ShisjyView

-(instancetype)initWithFrame:(CGRect)frame withDic:(CoinDetailModel *)model{
    if ([super initWithFrame:frame]) {
        [self setUpViewWithDic:model];
    }
    return self;
}
-(void)setUpViewWithDic:(CoinDetailModel *)model{
    
    //每个Item宽高
    CGFloat W = kRatioX6((kScreenWidth-22));
    CGFloat H = kRatioY6(30);
    //每行列数
    NSInteger rank = 3;
    //每列间距
    CGFloat rankMargin = 1;
    //每行间距
    CGFloat rowMargin = 1;
    //Item索引 ->根据需求改变索引
    NSUInteger index = 3;
    
    for (int i = 0 ; i< index; i++) {

        UILabel *speedView = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor whiteColor] withTextFont:14 withTextAlignment:(NSTextAlignmentCenter)];
        speedView.backgroundColor = RandomColor;
        
        if ((i % rank) == 0) {
            
            speedView.text = @"欧力币";
            //Item X轴
            CGFloat X = (i % rank) * (W + rankMargin);
            //Item Y轴
            NSUInteger Y = (i / rank) * (H +rowMargin);
            
            speedView.frame = CGRectMake(X, Y, W*0.2, H);
        
        }else if((i % rank) == 1){
            speedView.text = [NSString stringWithFormat:@"买1   %@",model.buy];

            CGFloat X = ((W*0.2) + rankMargin);
            //Item Y轴
            NSUInteger Y = (i / rank) * (H +rowMargin);
            
            speedView.frame = CGRectMake(X , Y, (kScreenWidth-20)*0.4, H);
        }else{
            
            speedView.text = [NSString stringWithFormat:@"卖1   %@",model.sell];

            CGFloat X = ((W*0.6) + rankMargin*3);
            //Item Y轴
            NSUInteger Y = (i / rank) * (H +rowMargin);
            
            speedView.frame = CGRectMake(X , Y, (kScreenWidth-20)*0.4, H);
        }
       
        if ((i / rank) == 0 || (i / rank) == 2) {
            speedView.backgroundColor = [UIColor gc_colorWithHexString:@"#e3b34a"];
        }else{
            speedView.backgroundColor = [UIColor gc_colorWithHexString:@"#e9c26e"];
        }
        
        [self addSubview:speedView];
        
    }
}

@end
