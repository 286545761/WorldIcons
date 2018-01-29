//
//  PriceCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/21.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "PriceCell.h"

@interface PriceCell ()

@property (nonatomic,strong)UILabel *jyStatus;
@property (nonatomic,strong)UIProgressView *rateProgressView;

@end

@implementation PriceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{

    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    v.backgroundColor = [UIColor whiteColor];
    
    //交易状态
    UILabel *jyStatus = [UILabel gc_labelWithTitle:@"卖1" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentCenter)];
    jyStatus.frame = CGRectMake(0, 0, kScreenWidth/4, 35);
    [v addSubview:jyStatus];
    self.jyStatus = jyStatus;
    //交易价格
    UILabel *jyPrice =  [UILabel gc_labelWithTitle:@"10.10" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentCenter)];
    jyPrice.frame = CGRectMake(kScreenWidth/4, 0, kScreenWidth/4, 35);
    [v addSubview:jyPrice];
    self.jyPrice = jyPrice;
    //交易量
    self.rateProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault]; // 进度条的底色
    self.rateProgressView.frame = CGRectMake(kScreenWidth/2, 16, kScreenWidth/2-10, 35);
    self.rateProgressView.progressTintColor = [UIColor gc_colorWithHexString:@"#cc9900"];
    self.rateProgressView.trackTintColor = [UIColor whiteColor];
    self.rateProgressView.layer.masksToBounds = YES;
    self.rateProgressView.layer.cornerRadius = 1;
    self.rateProgressView.transform = CGAffineTransformMakeScale(-1, 1);
    [self.rateProgressView setProgress:(arc4random()%10)/10.0 animated:YES];
    [v addSubview:self.rateProgressView];
    
    [self.contentView addSubview:v];

}

- (void)setSellModel:(SellModel *)sellModel{
    
    CGFloat pro = [sellModel.num floatValue];

    self.jyStatus.text  = [NSString stringWithFormat:@"卖%@",self.index];
    self.jyPrice.text = [NSString stringWithFormat:@"%@",sellModel.vs_s];
    
    [self.rateProgressView setProgress:(pro/10000.0) animated:YES];

}

-(void)setBuyModel:(BuyModel *)buyModel{

    CGFloat pro = [buyModel.num floatValue];
    
    self.jyStatus.text  = [NSString stringWithFormat:@"买%@",self.index];
    self.jyPrice.text = [NSString stringWithFormat:@"%@",buyModel.vb_b];
    
    [self.rateProgressView setProgress:(pro/10000.0) animated:YES];

}

@end
