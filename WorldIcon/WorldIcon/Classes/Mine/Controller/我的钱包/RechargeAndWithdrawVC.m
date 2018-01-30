//
//  RechargeAndWithdrawVC.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/29.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "RechargeAndWithdrawVC.h"
#import "ShareCTView.h"
#import "ShowOneCell.h"
#import "ShowTwoCell.h"
#import "ShowThreeCell.h"
#import "ShowFourCell.h"
#import "ShareStateModel.h"
#import "FCPopMenu.h"
@interface RechargeAndWithdrawVC ()<UITableViewDelegate,UITableViewDataSource,ShareCTViewBtnChooseViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)ShareCTView *shareCTView;
@property (nonatomic,strong)NSString *dollersStr;
@property (nonatomic,strong)NSString *RMBStr;
@property (nonatomic,strong)NSMutableArray *moneyArr;
@property (nonatomic,strong)NSMutableArray *topArr;
@property (nonatomic,strong)FCPopMenu *list;
@property (nonatomic,strong)UIControl *back;
//选择的支付方式
@property (nonatomic,strong)NSString *sortMethodStr;

@property (nonatomic,strong)NSArray  *cardsArr;
@end

@implementation RechargeAndWithdrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.sortMethodStr = @"";
    if (self.type == OLBRechargeType) {
        self.navLabel.text = @"美元充值";
        self.topArr = [NSMutableArray arrayWithArray:@[@[@"充值方式",self.sortMethodStr],@[@"充值金额",@"输入金额"]]];
    }else{
        self.navLabel.text = @"美元提现";
        self.topArr = [NSMutableArray arrayWithArray:@[@[@"提现方式",self.sortMethodStr],@[@"银行卡号",@""],@[@"提现金额",@"输入金额"]]];
    }
    
    [self.view addSubview:self.tableView];
    [self initTableViewFooter];
    self.dollersStr = @"";
    self.RMBStr = @"";
    NSArray *oneArr = [NSArray arrayWithObjects:@"手续费",self.dollersStr,@"美元", nil];
    NSArray *twoArr = [NSArray arrayWithObjects:@"人民币",self.RMBStr,@"元", nil];
    self.moneyArr = [NSMutableArray arrayWithObjects:oneArr,twoArr, nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.list removeFromSuperview];
}

-(void)initTableViewFooter{
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 150)];
    back.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = back;
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.adaptiveIphone5Frame = CGRectMake(30, 35, 320-60, 40);
    [submitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [back addSubview:submitBtn];
    
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.adaptiveIphone5Frame = CGRectMake(30, submitBtn.adaptiveIphone5Frame.origin.y+submitBtn.adaptiveIphone5Frame.size.height+10, 320-60, 20);
    [agreeBtn setTitle:@"我已同意《欧力币共享充提协议》" forState:UIControlStateNormal];
    [agreeBtn setTitleColor:[UIColor gc_colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"unargry"] forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(agreeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [agreeBtn gc_layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    agreeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [agreeBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0.0,0.0)];
    agreeBtn.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:14];
    [back addSubview:agreeBtn];
}

-(void)submitBtnAction{
    
}

-(void)agreeBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        UIWindow *Windown = [UIApplication sharedApplication].keyWindow;
        self.shareCTView = [[ShareCTView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.shareCTView.delegate = self;
        [Windown addSubview:self.shareCTView];
        [sender setImage:[UIImage imageNamed:@"argry"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"unargry"] forState:UIControlStateNormal];
    }
}

- (void)bottomPassBtnOnClick{
    [self.shareCTView removeFromSuperview];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type == OLBRechargeType) {
        if (section == 0) {
            return 2;
        }
        return 3;
    }
    if (section == 0) {
        return 3;
    }
    return 3;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [UIView countIphone5LengthWithBeforeLength:10];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [ShowOneCell getCellHeight];
    }
    if (indexPath.row == 2) {
        return [ShowFourCell getCellHeight];
    }
    return [ShowThreeCell getCellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString * strCell = @"ShowOneCell";
            ShowOneCell * cell = [tableView dequeueReusableCellWithIdentifier:strCell];
            if (cell == nil) {
                cell = [[ShowOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
                cell.topV.hidden = YES;
            }
            [cell reloadView:self.topArr[indexPath.row]];
            return cell;
        }
        if (self.type == OLBWithdrawType) {
            if (indexPath.row == 1) {
                static NSString * strCell = @"ShowOneCell";
                ShowOneCell * cell = [tableView dequeueReusableCellWithIdentifier:strCell];
                if (cell == nil) {
                    cell = [[ShowOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
                    cell.topV.hidden = NO;
                    cell.bottomV.hidden = NO;
                }
                [cell reloadView:self.topArr[indexPath.row]];
                return cell;
            }
        }
        static NSString * strCell = @"ShowTwoCell";
        ShowTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (cell == nil) {
            cell = [[ShowTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.bottomV.hidden = YES;
        }
        [cell reloadView:self.topArr[indexPath.row]];
        return cell;
    }
    if (indexPath.row == 2) {
        static NSString * strCell = @"ShowFourCell";
        ShowFourCell * cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (cell == nil) {
            cell = [[ShowFourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.bottomV.hidden = YES;
        }
        if (self.type == OLBRechargeType) {
            [cell reloadView:@[@"",@"",[NSString stringWithFormat:@"充值金额*%@(手续费率)",self.model.vra_sxf],[NSString stringWithFormat:@"(1+%@(手续费率))*充值金额*美元汇率",self.model.vra_sxf]]];
        }else
            [cell reloadView:@[@"",@"",[NSString stringWithFormat:@"充值金额*%@(手续费率)",self.model.vra_sxf],[NSString stringWithFormat:@"(1-%@(手续费率))*充值金额*美元汇率",self.model.vra_sxf]]];
        return cell;
    }
    static NSString * strCell = @"ShowThreeCell";
    ShowThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[ShowThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        if (indexPath.row == 0) {
            cell.topV.hidden = YES;
        }else{
            cell.topV.hidden = NO;
            cell.bottomV.hidden = NO;
        }
    }
    [cell reloadView:self.moneyArr[indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self initList:indexPath];
        [self.view addSubview:self.list];
    }
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect rect = self.view.bounds;
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(void)initList:(NSIndexPath *)index
{
    self.tableView.scrollEnabled = NO;
    NSArray *names;
    if (index.row == 0) {
        names = @[@"银行卡",@"支付宝",@"微信"];
    }else{
        names = [NSArray arrayWithArray:self.cardsArr];
    }
    
//    NSArray *imgs=@[@"sence_new",@"recruit_new",@"sence_search"];
    NSMutableArray *items=[NSMutableArray array];
    __weak typeof(self) wkself=self;
    for(int i=0;i<names.count;i++){
        FCPopMenuItem *item=[FCPopMenuItem itemWithImage:nil title:names[i] titleColor:[UIColor gc_colorWithHexString:@"#666666"] handler:^(FCPopMenuItem *sender) {
            [wkself listClickAction:sender];
        }];
        if ([wkself.sortMethodStr isEqualToString:names[i]]){
            item.titleColor = [UIColor redColor];
        }
        [items addObject:item];
    }
    _list=[FCPopMenu menuWithFrame:CGRectMake([UIView countBeforeWithIphone5Length:95], [UIView countBeforeWithIphone5Length:41+8]+index.row*[ShowOneCell getCellHeight], 215, 43.5*names.count) trangleHeight:0 tranglePosition:CGPointMake(0, 0) items:items];
    _list.rowHeight=43.5;
    _list.sperateColor=[UIColor clearColor];
    _list.seperateInsets=UIEdgeInsetsMake(0, 14, 0, 14);
}

-(void)listClickAction:(FCPopMenuItem *)sender{
    self.tableView.scrollEnabled = YES;
    [self hideList:self.back];
    NSString *title=[sender.title copy];
    self.sortMethodStr = title;
    if (self.type == OLBRechargeType) {
        self.topArr = [NSMutableArray arrayWithArray:@[@[@"充值方式",self.sortMethodStr],@[@"充值金额",@"输入金额"]]];
    }else{
        self.topArr = [NSMutableArray arrayWithArray:@[@[@"提现方式",self.sortMethodStr],@[@"银行卡号",@""],@[@"提现金额",@"输入金额"]]];
    }
    [self.tableView reloadData];
}

-(void)hideList:(UIControl *)sender{
    [sender removeFromSuperview];
    [self.list removeFromSuperview];
}

-(UIControl *)back{
    self.tableView.scrollEnabled = YES;
    if(!_back){
        _back=[[UIControl alloc] initWithFrame:CGRectMake(0, 64*2, kScreenWidth, self.tableView.frame.size.height-64-64)];
        _back.backgroundColor= RGBA(0, 0, 0, 0.3f);
        [_back addTarget:self action:@selector(hideList:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _back;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
