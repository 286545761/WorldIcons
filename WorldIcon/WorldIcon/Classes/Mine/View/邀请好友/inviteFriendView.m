//
//  inviteFriendView.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2017/12/28.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "inviteFriendView.h"
#import "inviteFriendModel.h"
@implementation inviteFriendView

- (instancetype)initWithModel:(inviteFriendModel *)model
{
    self = [super init];
    if (self) {
        [self initView:model];
    }
    return self;
}

-(void)initView:(inviteFriendModel *)model
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backView.backgroundColor = RGBA(0, 0, 0, 0.3f);
    [self addSubview:backView];
    
    UIView *showView = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(20, 100, 320-40, 100)];
    showView.backgroundColor = [UIColor whiteColor];
    [showView.layer setMasksToBounds:YES];
    [showView.layer setCornerRadius:15];
    [self addSubview:showView];
    
    
    UILabel *showL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 10, showView.adaptiveIphone5Frame.size.width, 15)];
    showL.text = @"邀请好友";
    showL.textAlignment = NSTextAlignmentCenter;
    showL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    showL.font = [UIFont fontWithAdaptiveIphone5Size:15];
    showL.textAlignment = NSTextAlignmentCenter;
    [showView addSubview:showL];
    
    UIImageView *QRcodeImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qr_code"]];
    QRcodeImg.adaptiveIphone5Frame = CGRectMake((showView.adaptiveIphone5Frame.size.width-150)/2.0f, showL.adaptiveIphone5Frame.origin.y+showL.adaptiveIphone5Frame.size.height+20, 150, 150);
    [showView addSubview:QRcodeImg];
    
    UILabel *showL1 = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, QRcodeImg.adaptiveIphone5Frame.origin.y+QRcodeImg.adaptiveIphone5Frame.size.height+15, showView.adaptiveIphone5Frame.size.width-20, 15)];
    showL1.text = @"您的分享地址";
    showL1.textAlignment = NSTextAlignmentLeft;
    showL1.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    showL1.font = [UIFont fontWithAdaptiveIphone5Size:13];
    showL1.textAlignment = NSTextAlignmentLeft;
    [showView addSubview:showL1];
    
    UILabel *addressL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, showL1.adaptiveIphone5Frame.origin.y+showL1.adaptiveIphone5Frame.size.height+10, showView.adaptiveIphone5Frame.size.width-20, 15)];
    addressL.text = @"您的分享地址";
    addressL.textAlignment = NSTextAlignmentLeft;
    addressL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    addressL.font = [UIFont fontWithAdaptiveIphone5Size:13];
    addressL.textAlignment = NSTextAlignmentLeft;
    [showView addSubview:addressL];
    
    
    UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyBtn setTitle:@"复制地址" forState:UIControlStateNormal];
    copyBtn.adaptiveIphone5Frame = CGRectMake(10, addressL.adaptiveIphone5Frame.origin.y+addressL.adaptiveIphone5Frame.size.height+10, 40, 20);
    [copyBtn setTitleColor:[UIColor gc_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    copyBtn.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:13];
    [copyBtn addTarget:self action:@selector(copyBtnAction) forControlEvents:UIControlEventTouchDown];
    [showView addSubview:copyBtn];
    
    UILabel *showL3 = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, copyBtn.adaptiveIphone5Frame.origin.y+copyBtn.adaptiveIphone5Frame.size.height+10, showView.adaptiveIphone5Frame.size.width-20, 15)];
    showL3.text = @"复制地址，您就可以粘贴到微信或QQ分享给好友";
    showL3.textAlignment = NSTextAlignmentLeft;
    showL3.textColor = [UIColor redColor];
    showL3.font = [UIFont fontWithAdaptiveIphone5Size:13];
    showL3.textAlignment = NSTextAlignmentLeft;
    [showView addSubview:showL3];
    
    showView.adaptiveIphone5Frame = CGRectMake(20, 100, 320-40, showL3.adaptiveIphone5Frame.origin.y+showL3.adaptiveIphone5Frame.size.height+20);
    
    UIView *line = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(320/2-0.5f, showView.adaptiveIphone5Frame.origin.y+showView.adaptiveIphone5Frame.size.height, 1, 20)];
    line.backgroundColor = [UIColor whiteColor];
    [self addSubview:line];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"whitecha"] forState:UIControlStateNormal];
    deleteBtn.adaptiveIphone5Frame = CGRectMake(320/2.0f-17.5f, line.adaptiveIphone5Frame.origin.y+line.adaptiveIphone5Frame.size.height, 35, 35);
    [deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchDown];
    [self addSubview:deleteBtn];
}

-(void)copyBtnAction{
    
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
