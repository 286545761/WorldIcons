//
//  PaymentView.m
//  bage
//
//  Created by 陈潇 on 17/4/24.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "PaymentView.h"
#import "PaymentViewCell.h"
//#import "PayTypeView.h"

@interface PaymentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *contentView1;

@property (nonatomic,strong)UIButton *closeBtn;

@property (nonatomic,strong)NSIndexPath *lastIndexPath;

@property (nonatomic,strong)UIView *bottomView;

@property (nonatomic,strong)NSArray *iconArray;

@property (nonatomic,strong)NSArray *titleArray;

@property (nonatomic,strong)UILabel *line;

@property (nonatomic,strong)UILabel *line1;

@property (nonatomic,strong)UILabel *topLine;


@property (nonatomic,strong)UILabel *descripLabel;
@end

@implementation PaymentView
- (NSArray *)iconArray{
    if (!_iconArray) {
        _iconArray = [NSArray array];
    }
    return _iconArray;
}
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{

    _iconArray = @[@"yue",@"wechatPay",@"alipay",@"oc"];
    
    _titleArray = @[@"余额支付",@"微信支付",@"支付宝支付",@"欧力币"];
    
    //背景图片
    UIView *contentView1 = [[UIView alloc]init];
    contentView1.backgroundColor = [UIColor whiteColor];
    contentView1.layer.masksToBounds = YES;
    contentView1.layer.cornerRadius = 30;
    [self addSubview:contentView1];
    self.contentView1 = contentView1;
    
    UILabel *titleLabel = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor blackColor] withTextFont:18 withTextAlignment:(NSTextAlignmentCenter)];
    titleLabel.text = @"支付密码";
    [self.contentView1 addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *closeBtn = [UIButton new];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"whitecha"] forState:(UIControlStateNormal)];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:closeBtn];
    self.closeBtn = closeBtn;
    
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor whiteColor];
    [self addSubview:line];
    self.line = line;
    
    //八哥红包
    UILabel *redbag_InfoLabel = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentCenter)];
//    [UILabel gc_setUpLabelAWithSize:14 textColor:[UIColor gc_colorWithHexString:@"#333333"] TextAlignment:(NSTextAlignmentCenter) isNewLine:YES];
    redbag_InfoLabel.text = @"购买矿机";
//    redbag_InfoLabel.backgroundColor = [UIColor redColor];
    [self.contentView1 addSubview:redbag_InfoLabel];
    self.redbag_InfoLabel = redbag_InfoLabel;
    
    //金额展示
    UILabel *redbag_moneyLabel1 = [UILabel gc_labelWithTitle:@"" withFontName:@"Helvetica-Bold" withTextColor:[UIColor blackColor] withTextFont:20 withTextAlignment:(NSTextAlignmentCenter)];
    redbag_moneyLabel1.font = [UIFont boldSystemFontOfSize:20];
//    [UILabel gc_initLabelFontWithSize:28 font:@"Helvetica-Bold" color:[UIColor blackColor] alignment:(NSTextAlignmentCenter)];
    redbag_moneyLabel1.text = @"￥10";
//    redbag_moneyLabel1.backgroundColor = [UIColor blueColor];
    [self.contentView1 addSubview:redbag_moneyLabel1];
    self.redbag_moneyLabel1 = redbag_moneyLabel1;
    
    UILabel *topLine = [UILabel new];
    topLine.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb" alpha:1];
    [self.contentView1 addSubview:topLine];
    self.topLine = topLine;
    
    //关闭
//    UIView *bottomView = [UIView new];
//    [self addSubview:bottomView];
//    self.bottomView = bottomView;
    
//    UILabel *line1 = [UILabel new];
//    line1.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb" alpha:1.];
//    [self.contentView1 addSubview:line1];
//    self.line1 = line1;

    //添加tableView
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.rowHeight = 45;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
//    self.mainTableView.backgroundColor = [UIColor blueColor];
    [self.contentView1 addSubview:self.mainTableView];

    self.password = [[TTPasswordView alloc] init];
    self.password.elementCount = 6;
    self.password.elementColor=[UIColor gc_colorWithHexString:@"#d9d9d9"];
    [self addSubview:self.password];
    
    self.descripLabel=[[UILabel alloc]init];
    self.descripLabel.text=@"请在我的-账户余额-设置密码操作支付密码";
    self.descripLabel.textColor=[UIColor gc_colorWithHexString:@"#cc3333"];
    self.descripLabel.font=[UIFont systemFontOfSize:13];
    self.descripLabel.textAlignment=NSTextAlignmentCenter;
//    self.descripLabel.hidden=YES;
    [self addSubview:self.descripLabel];
 
}

-(void)closeAction{
    [self removeFromSuperview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    PaymentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"paymentCell"];
    if (!cell) {
        cell = [[PaymentViewCell alloc]initWithStyle:(UITableViewCellStyleValue2) reuseIdentifier:@"paymentCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSInteger payStyle = self.payType == 0 ? 0 :self.payType;
    
    cell.payStyleImage.image = [UIImage imageNamed:_iconArray[payStyle]];
    cell.titleLabel.text = _titleArray[payStyle];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    self.didClickCell(indexPath);
    
//    [self removeFromSuperview];
//    
//    PayTypeView *view = [[PayTypeView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
//    
//    [GCKeyWindow addSubview:view];

    /*
    //当前cell row
    NSInteger newRow = [indexPath row];
    //记录上一次cell row
    NSInteger oldRow = (self.lastIndexPath != nil) ? [self.lastIndexPath row] : -1;
    if (newRow != oldRow)
    {
        //选中cell
        PaymentViewCell *newcell =  [tableView cellForRowAtIndexPath:indexPath];
        newcell.selectImage.image = [UIImage imageNamed:@"payStyle_selected"];
        //取消上一次选中cell
        PaymentViewCell *oldCell = [tableView cellForRowAtIndexPath:self.lastIndexPath];
        oldCell.selectImage.image = [UIImage imageNamed:@"payStyle_default"];
    }

    self.lastIndexPath = indexPath;

    if (self.lastIndexPath.row == 0) {
        
        _psView = [PasswordView new];
        [self.contentView1 addSubview:_psView];
        
        [_psView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.mas_centerY).offset(-50);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(300, 200));

        }];
        
    }
    if (self.lastIndexPath.row == 1) {

        [TipsView show:@"微信支付"];
    }
    if (self.lastIndexPath.row == 2) {
        
        [TipsView show:@"支付宝支付"];
    }
 */
    
}

-(void)updateConstraints{
  
//    NSString* phoneModel = [AppManager iphoneType];//方法在下面
//    
//    if ([phoneModel isEqualToString:@"iPhone 5"] || [phoneModel isEqualToString:@"iPhone 5c"] || [phoneModel isEqualToString:@"iPhone 5s"]) {
//       
//        [self.contentView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.mas_centerY).offset(-100);
//            make.centerX.equalTo(self.mas_centerX);
//            make.width.mas_equalTo(200);
//            make.height.mas_equalTo(300);
//        }];
//        
//    }else{
    
        [self.contentView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(-50);
            make.centerX.equalTo(self.mas_centerX);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(270);
        }];
//    }
    
//    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView1.mas_bottom).offset(0);
//        make.centerX.equalTo(self.mas_centerX);
//        make.width.mas_equalTo(300);
//        make.height.mas_equalTo(50);
//    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView1).offset(0);
        make.top.equalTo(self.contentView1).offset(10);
        make.right.equalTo(self.contentView1).offset(0);
        make.height.equalTo(@20);
    }];
    
    [self.redbag_InfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView1).offset(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView1).offset(-15);
        make.height.equalTo(@20);
    }];
    
    [self.redbag_moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView1).offset(15);
        make.top.equalTo(self.redbag_InfoLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView1).offset(-15);
        make.height.equalTo(@30);
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView1).offset(15);
        make.right.equalTo(self.contentView1).offset(-15);
        make.top.equalTo(self.redbag_moneyLabel1.mas_bottom).offset(15);
        make.height.mas_equalTo(.5);
    }];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView1).offset(15);
        make.top.equalTo(self.topLine.mas_bottom).offset(0);
        make.right.equalTo(self.contentView1).offset(-15);
        make.height.equalTo(@45);
    }];
    
//    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView1).offset(15);
//        make.right.equalTo(self.contentView1).offset(-15);
//        make.bottom.equalTo(self.mainTableView.mas_top).offset(10);
//        make.height.mas_equalTo(.5);
//    }];
//    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.contentView1.mas_centerX);
//        make.bottom.equalTo(self.contentView1.mas_bottom).offset(-40);
//        make.left.equalTo(self.contentView1).offset(10);
//        make.right.equalTo(self.contentView1).offset(-10);
//        make.height.mas_equalTo(@40);
        make.left.equalTo(self.contentView1).offset(15);
        make.top.equalTo(self.mainTableView.mas_bottom).offset(10);
        make.right.equalTo(self.contentView1).offset(-15);
        make.height.equalTo(@48);
    }];

    [self.descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView1.mas_centerX);
        make.bottom.equalTo(self.contentView1.mas_bottom).offset(-15);
        make.left.equalTo(self.contentView1).offset(10);
        make.right.equalTo(self.contentView1).offset(-10);
        make.height.mas_equalTo(@20);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView1.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(1);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake([UIView countBeforeWithIphone5Length:25], [UIView countBeforeWithIphone5Length:25]));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [super updateConstraints];
}
+(BOOL)requiresConstraintBasedLayout{
    return YES;
}

@end
