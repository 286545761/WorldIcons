//
//  ShareCTView.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "ShareCTView.h"

@implementation ShareCTView

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
    deleteBtn.adaptiveIphone5Frame = CGRectMake(320/2-12.5f, 568-20-25, 25, 25);
    [deleteBtn setImage:[UIImage imageNamed:@"whitecha"] forState:UIControlStateNormal];
    deleteBtn.backgroundColor = [UIColor clearColor];
    [deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    
    UIView *lineV = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(320.0/2-0.5f, deleteBtn.adaptiveIphone5Frame.origin.y-25, 1, 25)];
    lineV.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineV];
    
    UIView *whiteView = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(20, 60, 320-40, lineV.adaptiveIphone5Frame.origin.y-50)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 20;
    whiteView.layer.masksToBounds = YES;
    [self addSubview:whiteView];
    
    UILabel *topL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 10, whiteView.adaptiveIphone5Frame.size.width,15)];
    topL.font = [UIFont boldSystemFontOfSize:15];
    topL.text = @"共享充提协议";
    topL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    topL.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:topL];
    
    UILabel *bigL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, topL.adaptiveIphone5Frame.origin.y+topL.adaptiveIphone5Frame.size.height+10, whiteView.adaptiveIphone5Frame.size.width-20,40)];
    bigL.font = [UIFont boldSystemFontOfSize:19];
    bigL.text = @"共享充提公约";
    bigL.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    bigL.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:bigL];
    
    UILabel *l1 = [[UILabel alloc]init];
    l1.font = [UIFont boldSystemFontOfSize:15];
    l1.text = @"为了更好维护欧力币运转，特定以下公约制度:";
    l1.numberOfLines = 2;
    CGRect size = [tool characterAdaptionHeight:l1.text withSize:CGSizeMake(whiteView.adaptiveIphone5Frame.size.width-20, 1000) withFont:[UIFont boldSystemFontOfSize:15]];
    l1.frame = CGRectMake([UIView countBeforeWithIphone5Length:10], bigL.frame.origin.y+bigL.frame.size.height+5, whiteView.frame.size.width-[UIView countBeforeWithIphone5Length:20], size.size.height);
    l1.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    l1.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:l1];
    
    
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, l1.adaptiveIphone5Frame.origin.y+l1.adaptiveIphone5Frame.size.height+10, whiteView.adaptiveIphone5Frame.size.width-20,whiteView.adaptiveIphone5Frame.size.height-l1.adaptiveIphone5Frame.origin.y-l1.adaptiveIphone5Frame.size.height-10)];
    back.backgroundColor = [UIColor clearColor];
    [whiteView addSubview:back];
    
    UITextView *t1 = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, back.frame.size.width, back.frame.size.height)];
    t1.font = [UIFont systemFontOfSize:15];
    t1.text = @"1.欧力币共享充提采用智能合约技术，全程自动化运行，每步操作都是合规有效。\n2.欧力币信用体系采用积分制，每人每年有3分满分信用，从注册时间开始计算，一个周期年后自动恢复满分3分。\n3.会员在一年周期内，信用分扣完，账户自动冻结。\n4.扣分规则如下:\n  A.会员在充值过程，没有汇款就确认汇款，扣1分。\n  B.会员在提现过程，拒绝承认收到汇款，扣1分。\n  C.共享者在充值过程，拒绝承认收到汇款，扣1分。\n  D.共享者在提现过程，没有汇款就确认汇款，扣1分。\n  E.本人被投诉，证明本人违规，扣2分。\n  F.本人投诉别人，证明本人违规，扣2分。\n5.充值和提现操作后，只有全部流程走完，才能第二次充值和提现。\n6.充值和提现操作，必须在6个小时做完，否则自动无效。\n7.所有会员必须同意以上条款，才能操作共享充提。";
    t1.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    t1.textAlignment = NSTextAlignmentLeft;
    [t1 setContentOffset:CGPointZero];
    [back addSubview:t1];
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
