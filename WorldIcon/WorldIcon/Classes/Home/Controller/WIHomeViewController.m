//
//  WIHomeViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WIHomeViewController.h"
#import "SDCycleScrollView.h"
#import "CurrentIconNumberView.h"
#import "HomeSectionHeaderView.h"
#import "ShisjyView.h"
#import "MerchantCell.h"
#import "MessageViewController.h"
#import "MerchantDetailViewController.h"
#import "MineQrCodeViewController.h"
#import "HomeRequest.h"
#import "BTCShowCell.h"
#import "InformationDetailViewController.h"
#import "InfomationModel.h"
#import "BTCPriceModel.h"
#import "CoinDetailModel.h"
#import "KLineTableViewCell.h"
#import "KLineItem.h"
typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshHeadType = 1,  // 下拉
    RefreshFootType = 2,  // 上拉
    RefreshNoneType = 3   // 第一次加载
};
@interface WIHomeViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,strong)UITableView *homeTableView;

@property (nonatomic,strong)UIView *homeHeaderView;

@property (nonatomic,strong)UIView *navigationView;

@property (nonatomic,strong)NSArray *img1Array;
@property (nonatomic,strong)NSArray *img2Array;
@property (nonatomic,strong)NSArray *exchangeArray;
@property (nonatomic,strong)NSArray *informationArray;
@property (nonatomic,strong)CoinDetailModel *vm_funcModel;
@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)NSArray *kLineArr;

@end

@implementation WIHomeViewController

-(NSArray *)img1Array{
    if (!_img1Array) {
        _img1Array = [NSArray array];
    }
    return _img1Array;
}
-(NSArray *)img2rray{
    if (!_img2Array) {
        _img2Array = [NSArray array];
    }
    return _img2Array;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
}


- (void)viewDidLoad {
   
    [super viewDidLoad];

    self.navLabel.text = @"欧力币";
    
    [self setUpRightBarButton];

    [self setUpHomeTableView];

    [self setUpHeaderView];

//    [self setUpCustomHeaderView];

    [self loadHomeDataOnNet:RefreshNoneType];
    
    self.img1Array = @[@"平台资讯",@"",@"入驻商家"];
    _img2Array = @[@"实时交易图标",@"商家入驻图标"];
}

-(void)setUpCustomHeaderView{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    view.backgroundColor = [UIColor gc_colorWithHexString:@"#e6e8f3" alpha:0];
    [self.view addSubview:view];
    self.navigationView = view;
    
    UIButton *messageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [messageBtn setImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
    [messageBtn addTarget:self action:@selector(messageAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.navigationView addSubview:messageBtn];
    
    UIButton *myQRcodeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [myQRcodeBtn setImage:[UIImage imageNamed:@"bai_qrcode"] forState:(UIControlStateNormal)];
    [myQRcodeBtn addTarget:self action:@selector(myQRcodeBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.navigationView addSubview:myQRcodeBtn];
    
    [myQRcodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.mas_equalTo(view).offset(20);
        make.centerY.mas_equalTo(view.mas_centerY).offset(10);
    }];
    
    
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(view).offset(-20);
        make.centerY.mas_equalTo(view.mas_centerY).offset(10);
    }];
    
    UILabel *titleLabel = [UILabel gc_labelWithTitle:@"欧力币" withTextColor:[UIColor whiteColor] withTextFont:17 withTextAlignment:(NSTextAlignmentCenter)];
    [self.navigationView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY).offset(10);
    }];
}

-(void)myQRcodeBtnAction{
    MineQrCodeViewController *qrCodeVC = [[MineQrCodeViewController alloc]init];
//    qrCodeVC.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:qrCodeVC animated:YES];
//    qrCodeVC.hidesBottomBarWhenPushed = ye;
}

#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.informationArray.count;
    }
    if (section == 3) {
        return 0;
    }
    return self.exchangeArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"homeCell"];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        ShisjyView *ssjyView = [[ShisjyView alloc]initWithFrame:CGRectZero withDic:self.vm_funcModel];
//        ssjyView.backgroundColor = [UIColor whiteColor];
//        ssjyView.layer.masksToBounds = YES;
//        ssjyView.layer.cornerRadius = 4;
//        [cell.contentView addSubview:ssjyView];
//        [ssjyView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(cell.contentView).with.insets(UIEdgeInsetsMake(11, 10, 11, 10));
//        }];
//        return cell;
//    }
    if (indexPath.section == 0) {
        KLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KLineTableViewCell"];
        if (!cell) {
            cell = [[KLineTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"KLineTableViewCell"];
        }
        [cell reloadCell:self.kLineArr];
        return cell;
    }
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"homeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = [UIImage imageNamed:@"方"];
        cell.imageView.image = [tool image:cell.imageView.image withColor:kTitleColor];
        InfomationModel *model = self.informationArray[indexPath.row];
        if (model.vi_title.length == 0) {
            cell.textLabel.text = @"";
        }else
            cell.textLabel.text = model.vi_title;
        cell.textLabel.font = [UIFont fontWithAdaptiveIphone5Size:14];
        cell.textLabel.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        return cell;
    }
    
    BTCShowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BTCShowCell"];
    if (!cell) {
        cell = [[BTCShowCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"BTCShowCell"];
    }
    [cell reloadCell:self.exchangeArray[indexPath.row]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [KLineTableViewCell getHeight];
    }
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
       return [UIView countBeforeWithIphone5Length:45];
    }
    if (section == 3) {
        return [UIView countBeforeWithIphone5Length:130];
    }
    return [UIView countBeforeWithIphone5Length:30];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        InformationDetailViewController *information = [InformationDetailViewController new];
        InfomationModel *model = self.informationArray[indexPath.row];
        information.url = [NSString stringWithFormat:@"%@/index.php/index/index/information?vi_id=%@",kHosturl,model.vi_id];
        [self.navigationController pushViewController:information animated:YES];
    }
    if (indexPath.section == 3) {
        MerchantDetailViewController *detailVC = [[MerchantDetailViewController alloc]init];
        detailVC.hidesBottomBarWhenPushed = YES;
//        detailVC.model = self.agentArray[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 2) {
        UIImageView *backImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backb"]];
        backImg.frame = CGRectMake(0, 0, kScreenWidth, [UIView countBeforeWithIphone5Length:30]);
        if (section == 0) {
            UILabel *l1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, [UIView countBeforeWithIphone5Length:30])];
            l1.text = @"OC";
            l1.textColor = [UIColor whiteColor];
            l1.textAlignment = NSTextAlignmentCenter;
            l1.font = [UIFont fontWithAdaptiveIphone5Size:15];
            [backImg addSubview:l1];
            
            UILabel *l2 = [[UILabel alloc]initWithFrame:CGRectMake(l1.frame.origin.x+l1.frame.size.width, 0, (kScreenWidth-l1.frame.size.width)/2, [UIView countBeforeWithIphone5Length:30])];
            if (self.vm_funcModel.buy.length == 0) {
                l2.text = [NSString stringWithFormat:@"买1 0$"];
            }else{
                l2.text = [NSString stringWithFormat:@"买1 %@$",self.vm_funcModel.sell];
            }
            l2.textColor = [UIColor whiteColor];
            l2.textAlignment = NSTextAlignmentLeft;
            l2.font = [UIFont fontWithAdaptiveIphone5Size:15];
            [backImg addSubview:l2];
            
            UILabel *l3 = [[UILabel alloc]initWithFrame:CGRectMake(l2.frame.origin.x+l2.frame.size.width, 0, (kScreenWidth-l1.frame.size.width)/2, [UIView countBeforeWithIphone5Length:30])];
            if (self.vm_funcModel.sell.length == 0) {
                l3.text = [NSString stringWithFormat:@"卖1 0$"];
            }else{
                l3.text = [NSString stringWithFormat:@"卖1 %@$",self.vm_funcModel.sell];
            }
            l3.textColor = [UIColor whiteColor];
            l3.textAlignment = NSTextAlignmentLeft;
            l3.font = [UIFont fontWithAdaptiveIphone5Size:15];
            [backImg addSubview:l3];
        }
        if (section == 2) {
            UILabel *l1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, [UIView countBeforeWithIphone5Length:30])];
            l1.text = @"名称";
            l1.textColor = [UIColor whiteColor];
            l1.textAlignment = NSTextAlignmentCenter;
            l1.font = [UIFont fontWithAdaptiveIphone5Size:15];
            [backImg addSubview:l1];
            
            UILabel *l2 = [[UILabel alloc]initWithFrame:CGRectMake(l1.frame.origin.x+l1.frame.size.width, 0, (kScreenWidth-l1.frame.size.width)/4, [UIView countBeforeWithIphone5Length:30])];
            l2.text = @"价格(USD)";
            l2.textColor = [UIColor whiteColor];
            l2.textAlignment = NSTextAlignmentCenter;
            l2.font = [UIFont fontWithAdaptiveIphone5Size:15];
            [backImg addSubview:l2];
            
            UILabel *l3 = [[UILabel alloc]initWithFrame:CGRectMake(l2.frame.origin.x+l2.frame.size.width, 0, (kScreenWidth-l1.frame.size.width)/4, [UIView countBeforeWithIphone5Length:30])];
            l3.text = @"价格(BTC)";
            l3.textColor = [UIColor whiteColor];
            l3.textAlignment = NSTextAlignmentCenter;
            l3.font = [UIFont fontWithAdaptiveIphone5Size:15];
            [backImg addSubview:l3];
            
            UILabel *l4 = [[UILabel alloc]initWithFrame:CGRectMake(l3.frame.origin.x+l3.frame.size.width, 0, (kScreenWidth-l1.frame.size.width)/4, [UIView countBeforeWithIphone5Length:30])];
            l4.text = @"市值";
            l4.textColor = [UIColor whiteColor];
            l4.textAlignment = NSTextAlignmentCenter;
            l4.font = [UIFont fontWithAdaptiveIphone5Size:15];
            [backImg addSubview:l4];
            
            UILabel *l5 = [[UILabel alloc]initWithFrame:CGRectMake(l4.frame.origin.x+l4.frame.size.width, 0, (kScreenWidth-l1.frame.size.width)/4, [UIView countBeforeWithIphone5Length:30])];
            l5.text = @"涨跌幅(1天)";
            l5.textColor = [UIColor whiteColor];
            l5.textAlignment = NSTextAlignmentCenter;
            l5.font = [UIFont fontWithAdaptiveIphone5Size:15];
            [backImg addSubview:l5];
        }
        return backImg;
    }
    if (section == 1 || section == 3) {
        HomeSectionHeaderView *headerView = [[HomeSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, [UIView countBeforeWithIphone5Length:30])];
        headerView.backgroundColor = [UIColor clearColor];
        headerView.img2.text = _img1Array[section-1];
        if (section == 3) {
            headerView.frame = CGRectMake(0, 0, kScreenWidth, [UIView countBeforeWithIphone5Length:100+30]);
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:headerView.frame];
            scrollView.backgroundColor = [UIColor clearColor];
            [headerView addSubview:scrollView];
            
            UIImageView *imag1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"merchant_1"]];
            imag1.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imag1Action)];
            [imag1 addGestureRecognizer:tap1];
            imag1.backgroundColor = [UIColor gc_colorWithHexString:@"#cc3333"];
            imag1.frame = CGRectMake(0, 35, [tool setImageImage:imag1]*110, 110);
            [scrollView addSubview:imag1];
            
            UIImageView *imag2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"merchant_2"]];
            imag2.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imag2Action)];
            [imag2 addGestureRecognizer:tap2];
            imag2.backgroundColor = [UIColor blueColor];
            imag2.frame = CGRectMake(imag1.frame.size.width, 35, [tool setImageImage:imag2]*110, 110);
            [scrollView addSubview:imag2];
            scrollView.contentSize = CGSizeMake([tool setImageImage:imag1]*110+[tool setImageImage:imag2]*110,110);
            scrollView.showsHorizontalScrollIndicator = YES;
            scrollView.showsVerticalScrollIndicator = NO;
            [headerView sendSubviewToBack:scrollView];
            
            headerView.topview.hidden = YES;
        }
        return headerView;
    }
    return [UIView new];
}


#pragma mark -- 主视图
-(void)setUpHomeTableView{
    
    self.homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, kScreenWidth, kScreenHeight-20) style:(UITableViewStyleGrouped)];
    if (CGRectGetHeight([UIScreen mainScreen].bounds) == 812.0) {
        if (@available(iOS 11.0, *)) {
            self.homeTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        }
    }else{
        self.homeTableView.frame = CGRectMake(0, -20, kScreenWidth, kScreenHeight-20);
    }
    self.homeTableView.showsVerticalScrollIndicator = NO;
    self.homeTableView.backgroundColor = [UIColor clearColor];
    self.homeTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.homeTableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    [self.view addSubview:self.homeTableView];
    
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    
    __weak typeof (self) weakSelf = self;
    //下拉上拉刷新
    _homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHomeDataOnNet:RefreshHeadType];
    }];
    
}
#pragma mark -- 右侧消息
-(void)setUpRightBarButton{
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"message"] style:(UIBarButtonItemStylePlain) target:self action:@selector(messageAction)];
    btn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = btn;
    
    
    UIBarButtonItem *myQRcodeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bai_qrcode"] style:(UIBarButtonItemStylePlain) target:self action:@selector(myQRcodeBtnAction)];
    myQRcodeBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = myQRcodeBtn;
}

#pragma mark --- 头部视图
-(void)setUpHeaderView{

    _homeHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 230+60+15)];
    _homeTableView.backgroundColor = [UIColor clearColor];
//    if (CGRectGetHeight([UIScreen mainScreen].bounds) == 812.0) {
//        if (@available(iOS 11.0, *)) {
//            _homeHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 220+60+44);
//        }
//    }else{
//        _homeHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 220+60);
//    }
    self.homeTableView.tableHeaderView = _homeHeaderView;
    //轮播图
    [self setUpBanner];
    
    UIButton *messageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [messageBtn setImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
    [messageBtn addTarget:self action:@selector(messageAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.homeTableView addSubview:messageBtn];
    
    UIButton *myQRcodeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [myQRcodeBtn setImage:[UIImage imageNamed:@"bai_qrcode"] forState:(UIControlStateNormal)];
    [myQRcodeBtn addTarget:self action:@selector(myQRcodeBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.homeTableView addSubview:myQRcodeBtn];
    
    [myQRcodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.mas_equalTo(_homeHeaderView).offset(20);
        make.top.mas_equalTo(_homeHeaderView.mas_top).offset(30);
    }];
    
    
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(_homeHeaderView).offset(-20);
        make.top.mas_equalTo(_homeHeaderView.mas_top).offset(30);
    }];
    
}
#pragma mark -- 设置轮播图
-(void)setUpBanner{
    
    NSArray *imageArray = @[@"banner"];
    
    // 网络加载图片的轮播器
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, self.homeHeaderView.frame.size.height-60-15) shouldInfiniteLoop:YES imageNamesGroup:imageArray];
    _cycleScrollView.backgroundColor = [UIColor whiteColor];
    self.cycleScrollView.delegate = self;
    [_homeHeaderView addSubview:self.cycleScrollView];
    [self setUpCurrentIconNumberWithDic:nil];
}

#pragma mark --币的即时数量
-(void)setUpCurrentIconNumberWithDic:(NSDictionary *)dic{
    UIView *view = [_homeHeaderView viewWithTag:101];
    [view removeFromSuperview];
    
    UIView *shadowView = [[UIView alloc]init];
    shadowView.frame = CGRectMake(20, 160+30, kScreenWidth-40, 95);
    shadowView.layer.shadowOffset = CGSizeMake(0,0);
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOpacity = 0.5f;
    shadowView.tag = 101;
    [_homeHeaderView addSubview:shadowView];
    
    CurrentIconNumberView *currentIconNumberView = [[CurrentIconNumberView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 100) withDic:self.vm_funcModel];
    currentIconNumberView.tag = 101;
    currentIconNumberView.layer.masksToBounds = YES;
    currentIconNumberView.layer.cornerRadius = 15;
    [shadowView addSubview:currentIconNumberView];
}

#pragma mark -- 消息
-(void)messageAction{
    MessageViewController *messageVC = [[MessageViewController alloc]init];
    messageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageVC animated:YES];
}

-(void)imag1Action{
    [MBProgressHUD gc_showInfoMessage:@"敬请期待"];
}

-(void)imag2Action{
    [MBProgressHUD gc_showInfoMessage:@"敬请期待"];
}

#pragma mark -- 加载首页数据
-(void)loadHomeDataOnNet:(RefreshType )type{
    if (type == RefreshNoneType) {
        [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    }
    __weak typeof(self) weakSelf = self;
    
    HomeRequest *homeReq = [HomeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [weakSelf endRefresh];
        [MBProgressHUD gc_hiddenHUD];
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
            NSError * err;
            self.vm_funcModel = [[CoinDetailModel alloc] initWithDictionary:responseDict[@"vm_func"] error:&err];
            self.vm_funcModel.buy = responseDict[@"buy"];
            self.vm_funcModel.sell = responseDict[@"sell"];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in responseDict[@"banner"]) {
                [arr addObject:[AppManager getPhotoUrlFileID:dic[@"vb_pic"]]];
            }
            self.cycleScrollView.imageURLStringsGroup = arr;
            [self setUpCurrentIconNumberWithDic:nil];
            
            NSMutableArray *kline = [NSMutableArray array];
            for (NSDictionary *dic in responseDict[@"k_line"]) {
                NSError * e;
                KLineItem *model = [[KLineItem alloc] initWithDictionary:dic error:&e];
                [kline insertObject:model atIndex:0];
            }
            self.kLineArr = [NSArray arrayWithArray:kline];
            NSMutableArray *Infomation = [NSMutableArray array];
            for (NSDictionary *dic in responseDict[@"information"]) {
                NSError * e;
                InfomationModel *model = [[InfomationModel alloc] initWithDictionary:dic error:&e];
                [Infomation addObject:model];
            }
            self.informationArray = [NSArray arrayWithArray:Infomation];
            NSMutableArray *btcPrice = [NSMutableArray array];
            for (NSDictionary *dic in responseDict[@"exchange"]) {
                NSError * error;
                BTCPriceModel *model = [[BTCPriceModel alloc] initWithDictionary:dic error:&error];
                [btcPrice addObject:model];
            }
            self.exchangeArray = [NSArray arrayWithArray:btcPrice];
            [self.homeTableView reloadData];
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }

    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
        [weakSelf endRefresh];
        [MBProgressHUD gc_showErrorMessage:@"网络错误"];
    }];

    homeReq.ub_id = [UserManager getUID];
    
    [homeReq startRequest];
}

#pragma mark    ----    MJRefresh   -----
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.homeTableView.mj_header endRefreshing];
    [self.homeTableView.mj_footer endRefreshing];
}

@end
