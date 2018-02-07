//
//  withdrawExplainView.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "withdrawExplainView.h"
@interface withdrawExplainView()

@end
@implementation withdrawExplainView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = RGBA(0, 0, 0, 0.3f);
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    deleteBtn.adaptiveIphone5Frame = CGRectMake(320/2-12.5f, 568-20-25, 25, 25);
    [deleteBtn setImage:[UIImage imageNamed:@"whitecha"] forState:UIControlStateNormal];
    deleteBtn.backgroundColor = [UIColor clearColor];
    [deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    if (CGRectGetHeight([UIScreen mainScreen].bounds) == 812.0) {
        if (@available(iOS 11.0, *)) {
            deleteBtn.adaptiveIphone5Frame = CGRectMake(320/2-12.5f, 568-20-25+44, 25, 25);
        }
    }else{
        deleteBtn.adaptiveIphone5Frame = CGRectMake(320/2-12.5f, 568-20-25, 25, 25);
    }
    
    UIView *lineV = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(320.0/2-0.5f, deleteBtn.adaptiveIphone5Frame.origin.y-25, 1, 25)];
    lineV.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineV];
    
    UIView *whiteView = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(20, 60, 320-40, lineV.adaptiveIphone5Frame.origin.y-50)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 20;
    whiteView.layer.masksToBounds = YES;
    [self addSubview:whiteView];
    if (CGRectGetHeight([UIScreen mainScreen].bounds) == 812.0) {
        if (@available(iOS 11.0, *)) {
            whiteView.adaptiveIphone5Frame = CGRectMake(20, 60+44, 320-40, lineV.adaptiveIphone5Frame.origin.y-50-44);
        }
    }else{
        whiteView.adaptiveIphone5Frame = CGRectMake(20, 60, 320-40, lineV.adaptiveIphone5Frame.origin.y-50);
    }
    
    UILabel *topL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 10, whiteView.adaptiveIphone5Frame.size.width,15)];
    topL.font = [UIFont boldSystemFontOfSize:15];
    topL.text = @"提现额度说明";
    topL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    topL.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:topL];
    
    UILabel *bigL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, topL.adaptiveIphone5Frame.origin.y+topL.adaptiveIphone5Frame.size.height+10, whiteView.adaptiveIphone5Frame.size.width-20,40)];
    bigL.font = [UIFont boldSystemFontOfSize:19];
    bigL.text = @"提现额度说明";
    bigL.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    bigL.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:bigL];
    
    UILabel *l1 = [[UILabel alloc]init];
    l1.font = [UIFont systemFontOfSize:15];
    l1.text = @"为了欧力币健康稳定发展，特别设置提现额度，执行提现额度时间截止到2018年08月01日，到时间后取消提现额度限制。";
    CGRect size = [tool characterAdaptionHeight:l1.text withSize:CGSizeMake(whiteView.adaptiveIphone5Frame.size.width-20, 1000) withFont:[UIFont systemFontOfSize:15]];
    l1.adaptiveIphone5Frame = CGRectMake(10, bigL.adaptiveIphone5Frame.origin.y+bigL.adaptiveIphone5Frame.size.height+5, whiteView.adaptiveIphone5Frame.size.width-20,[UIView countIphone5LengthWithBeforeLength:size.size.height]);
    l1.numberOfLines = 0;
    l1.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    l1.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:l1];
    
    UILabel *t1 = [[UILabel alloc]init];
    t1.font = [UIFont boldSystemFontOfSize:15];
    t1.text = @"一·增加提现额度情况";
    t1.adaptiveIphone5Frame = CGRectMake(10, l1.adaptiveIphone5Frame.origin.y+l1.adaptiveIphone5Frame.size.height, whiteView.adaptiveIphone5Frame.size.width-20,15);
    t1.numberOfLines = 0;
    t1.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    t1.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:t1];
    
    UILabel *l2 = [[UILabel alloc]init];
    l2.font = [UIFont systemFontOfSize:15];
    l2.text = @"1.充值提额，充值一次，提现额度增加充值金额两倍。\n2.买入提额，购买欧力币，提现额度会增加买入金额的两倍";
    CGRect rect = [tool characterAdaptionHeight:l2.text withSize:CGSizeMake(whiteView.adaptiveIphone5Frame.size.width-20, 1000) withFont:[UIFont systemFontOfSize:15]];
    l2.adaptiveIphone5Frame = CGRectMake(10, t1.adaptiveIphone5Frame.origin.y+t1.adaptiveIphone5Frame.size.height, whiteView.adaptiveIphone5Frame.size.width-20,[UIView countIphone5LengthWithBeforeLength:rect.size.height]);
    l2.numberOfLines = 0;
    l2.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    l2.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:l2];
    
    UILabel *t2 = [[UILabel alloc]init];
    t2.font = [UIFont boldSystemFontOfSize:15];
    t2.text = @"二·减少提现额度情况";
    t2.adaptiveIphone5Frame = CGRectMake(10, l2.adaptiveIphone5Frame.origin.y+l2.adaptiveIphone5Frame.size.height, whiteView.adaptiveIphone5Frame.size.width-20,15);
    t2.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    t2.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:t2];
    
    UILabel *l3 = [[UILabel alloc]init];
    l3.font = [UIFont systemFontOfSize:15];
    l3.text = @"1.卖出降额，卖出欧力币，提现额度会减少卖出金额的一倍。\n2.提现降额，当提现时候，提现额度会减少提现金额的一倍";
    CGRect r = [tool characterAdaptionHeight:l3.text withSize:CGSizeMake(whiteView.adaptiveIphone5Frame.size.width-20, 1000) withFont:[UIFont systemFontOfSize:15]];
    l3.adaptiveIphone5Frame = CGRectMake(10, t2.adaptiveIphone5Frame.origin.y+t2.adaptiveIphone5Frame.size.height, whiteView.adaptiveIphone5Frame.size.width-20,[UIView countIphone5LengthWithBeforeLength:r.size.height]);
    l3.numberOfLines = 0;
    l3.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    l3.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:l3];
}

-(void)deleteBtnAction{
    if ([self.delegate respondsToSelector:@selector(bottomPassBtnOnClick)]) {
        [self.delegate bottomPassBtnOnClick];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

