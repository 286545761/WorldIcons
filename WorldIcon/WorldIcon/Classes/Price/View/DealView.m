//
//  DealView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/24.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "DealView.h"

@interface DealView ()

@property (nonatomic,strong)UILabel *sjbLabel;
@property (nonatomic,strong)UIButton *closeBtn;

@property (nonatomic,strong)UIButton *dealBtn;
@property (nonatomic,strong)UIButton *quxiaoBtn;
@property (nonatomic,strong)UILabel *dealNumberLabel;
@property (nonatomic,strong)UIButton *jianBtn;
@property (nonatomic,strong)UIButton *addBtn;
@property (nonatomic,strong)UIButton *jianBtn1;
@property (nonatomic,strong)UIButton *addBtn1;

@end

@implementation DealView

-(instancetype)initWithFrame:(CGRect)frame withDealType:(NSString *)dealType withNumber:(NSString *)number withField1:(NSString *)text1 withField2:(NSString *)text2{
    if ([super initWithFrame:frame]) {
       
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4;
        
        [self setUpView:text1 with:text2];
        
        self.dealNumberLabel.text = number;
        [self.dealBtn setTitle:dealType forState:(UIControlStateNormal)];
        
        if ([dealType isEqualToString:@"买入"]) {
            [self.dealBtn setBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"]];
            [self.addBtn setBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"]];
            [self.jianBtn setBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"]];
            [self.addBtn1 setBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"]];
            [self.jianBtn1 setBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"]];
            
        }else{
            [self.dealBtn setBackgroundColor:[UIColor gc_colorWithHexString:@"#cc9900"]];
            [self.addBtn setBackgroundColor:[UIColor gc_colorWithHexString:@"#cc9900"]];
            [self.jianBtn setBackgroundColor:[UIColor gc_colorWithHexString:@"#cc9900"]];
            [self.addBtn1 setBackgroundColor:[UIColor gc_colorWithHexString:@"#cc9900"]];
            [self.jianBtn1 setBackgroundColor:[UIColor gc_colorWithHexString:@"#cc9900"]];
        }
    }
    return self;
}
-(void)setUpView:(NSString *)text with:(NSString *)text2{
 
    self.backgroundColor = [UIColor whiteColor];
    
    //欧力币
    UILabel *sjbLabel = [UILabel gc_labelWithTitle:@"欧力币" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
//    sjbLabel.backgroundColor = arc4randomColor;
    [self addSubview:sjbLabel];
    self.sjbLabel = sjbLabel;
    //close
    UIButton *closeBtn = [UIButton new];
    [closeBtn setImage:[UIImage imageNamed:@"叉号"] forState:(UIControlStateNormal)];
    [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    closeBtn.backgroundColor = arc4randomColor;
    [self addSubview:closeBtn];
    self.closeBtn = closeBtn;
    //价格
    UITextField *priceField = [UITextField new];
    priceField.textAlignment = NSTextAlignmentCenter;
    priceField.text = text;
    priceField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    priceField.layer.borderWidth = 0.5;
    priceField.layer.borderColor = [UIColor gc_colorWithHexString:@"#dbdbdb"].CGColor;
    priceField.placeholder = @"价格";
    UIButton *jianBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 35)];
    [jianBtn setBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"]];
    jianBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [jianBtn setImage:[UIImage imageNamed:@"减号"] forState:(UIControlStateNormal)];
    [jianBtn setTitle:@"0.01" forState:(UIControlStateNormal)];
    jianBtn.tag = 8001;
    [jianBtn addTarget:self action:@selector(toolAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    priceField.leftView=jianBtn;
    priceField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    [jianBtn gc_layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleTop) imageTitleSpace:5];
    self.jianBtn = jianBtn;
    
    UIButton *addBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 35)];
    [addBtn setBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"]];
    [addBtn setImage:[UIImage imageNamed:@"加号"] forState:(UIControlStateNormal)];
    [addBtn setTitle:@"0.01" forState:(UIControlStateNormal)];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    addBtn.tag = 8002;
    [addBtn addTarget:self action:@selector(toolAction:) forControlEvents:(UIControlEventTouchUpInside)];
    priceField.rightView=addBtn;
    priceField.rightViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    [addBtn gc_layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleTop) imageTitleSpace:2];
    self.addBtn = addBtn;
//  priceField.backgroundColor = arc4randomColor;
    [self addSubview:priceField];
    self.priceField = priceField;
    
    //数量
    UITextField *countField = [UITextField new];
    countField.layer.borderWidth = 0.5;
    countField.layer.borderColor = [UIColor gc_colorWithHexString:@"#dbdbdb"].CGColor;
    countField.textAlignment = NSTextAlignmentCenter;
    countField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    countField.placeholder = @"数量";
    countField.text = text2;
//    countField.backgroundColor = arc4randomColor;
    [self addSubview:countField];
    self.countField = countField;
    
    UIButton *jianBtn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 35)];
    [jianBtn1 setBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"]];
    jianBtn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [jianBtn1 setImage:[UIImage imageNamed:@"减号"] forState:(UIControlStateNormal)];
    [jianBtn1 setTitle:@"10" forState:(UIControlStateNormal)];
    jianBtn1.tag = 8003;
    [jianBtn1 addTarget:self action:@selector(toolAction:) forControlEvents:(UIControlEventTouchUpInside)];

    self.countField.leftView=jianBtn1;
    self.countField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    [jianBtn1 gc_layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleTop) imageTitleSpace:5];
    self.jianBtn1 = jianBtn1;
    
    UIButton *addBtn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 35)];
    [addBtn1 setBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"]];
    [addBtn1 setImage:[UIImage imageNamed:@"加号"] forState:(UIControlStateNormal)];
    [addBtn1 setTitle:@"10" forState:(UIControlStateNormal)];
    addBtn1.titleLabel.font = [UIFont systemFontOfSize:13];
    addBtn1.tag = 8004;
    [addBtn1 addTarget:self action:@selector(toolAction:) forControlEvents:(UIControlEventTouchUpInside)];

    self.countField.rightView=addBtn1;
    self.countField.rightViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    [addBtn1 gc_layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleTop) imageTitleSpace:2];
    self.addBtn1 = addBtn1;
    //可买/可卖
    UILabel *dealNumberLabel = [UILabel gc_labelWithTitle:@"可买2000个" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:13 withTextAlignment:(NSTextAlignmentLeft)];
//    dealNumberLabel.backgroundColor = arc4randomColor;
    [self addSubview:dealNumberLabel];
    self.dealNumberLabel = dealNumberLabel;
    
    //deal按钮
    UIButton *dealBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"买入" withRadius:2];
    dealBtn.tag = 8005;
    [dealBtn addTarget:self action:@selector(toolAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    dealBtn.backgroundColor = arc4randomColor;
    [self addSubview:dealBtn];
    self.dealBtn = dealBtn;
    //取消
    UIButton *quxiaoBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#cccccc"] withTitle:@"取消" withRadius:2];
    [quxiaoBtn addTarget:self action:@selector(quxiaoAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    quxiaoBtn.backgroundColor = arc4randomColor;
    [self addSubview:quxiaoBtn];
    self.quxiaoBtn = quxiaoBtn;
    
}
-(void)toolAction:(UIButton *)sender{

    switch (sender.tag) {
        case 8001:
            if (self.pricejianblock) {
                self.pricejianblock();
            }
            break;
        case 8002:
            if (self.pricejiablock) {
                self.pricejiablock();
            }
            break;
        case 8003:
            if (self.accountjianblock) {
                self.accountjianblock();
            }
            break;
        case 8004:
            if (self.accountjiablock) {
                self.accountjiablock();
            }
            break;
        case 8005:
            if (self.didClickButtonBlock) {
                self.didClickButtonBlock();
            }
            break;
           
        default:
            break;
    }
}
-(void)closeAction:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(closeDealView:)]) {
        [self.delegate closeDealView:(DealView *)sender.superview];
    }
    
}
-(void)quxiaoAction:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(cancleDealView:)]) {
        [self.delegate cancleDealView:(DealView *)sender.superview];
    }
}

//-(void)dealAction{
//    if ([self.delegate respondsToSelector:@selector(didClickButtonWithTag:)]) {
//        [self.delegate didClickButtonWithTag:0];
//    }
//}

/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.sjbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.centerY.mas_equalTo(self.sjbLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.priceField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sjbLabel.mas_left);
        make.top.mas_equalTo(self.sjbLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth*0.43, 35));
    }];
    
    [self.countField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.closeBtn.mas_right);
        make.centerY.mas_equalTo(self.priceField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth*0.43, 35));
    }];
    
    [self.dealNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sjbLabel.mas_left);
        make.top.mas_equalTo(self.priceField.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth*0.43, 20));
    }];
    
    [self.dealBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sjbLabel.mas_left);
        make.top.mas_equalTo(self.dealNumberLabel.mas_bottom).offset(35);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth*0.43, 35));
    }];
    
    [self.quxiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.closeBtn.mas_right);
        make.top.mas_equalTo(self.dealNumberLabel.mas_bottom).offset(35);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth*0.43, 35));
    }];
  
    [super updateConstraints];
    
}
/**
 自动布局
 */
+(BOOL)requiresConstraintBasedLayout{
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
