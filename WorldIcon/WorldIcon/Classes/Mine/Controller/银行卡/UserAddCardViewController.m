//
//  UserAddCardViewController.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2017/12/28.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "UserAddCardViewController.h"
#import "UserInfoCell.h"
#import "ZHPickView.h"
#import "CardCell.h"
#import "AlipayCell.h"
#import "HXProvincialCitiesCountiesPickerview.h"
#import "BundRequest.h"
@interface UserAddCardViewController ()<UITableViewDelegate,UITableViewDataSource,ZHPickViewDelegate,AlipayContentDelegate,CardContentDelegate,UIPickerViewDelegate ,UIPickerViewDataSource>
@property (nonatomic,strong)UITableView        *userAddCardTableView;
@property (nonatomic,strong)NSMutableArray     *section;
@property (nonatomic,strong)NSMutableArray     *sectionPlaceHolder;
@property (nonatomic,strong) HXProvincialCitiesCountiesPickerview *regionPickerView;
@property(nonatomic,strong)ZHPickView *pickview;
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,assign)BOOL select1;
@property(nonatomic,assign)BOOL select2;
@property(nonatomic,assign)BOOL select3;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSArray *plistArray;
@property(nonatomic,assign)BOOL other;
@property(nonatomic,strong)NSString *otherstr;
@end

@implementation UserAddCardViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [super viewDidLoad];
    self.otherstr = @"";
    self.select1 = NO;
    self.select2 = NO;
    self.other = NO;
    self.navLabel.text = @"添加账户";
    
    [self setUpUI];
    
    NSArray *section1 = @[@"持卡人",@"卡号"];
    NSArray *section2 = @[@"开户行",@"备注"];
    
    NSArray *section1Placeholder = @[@"请输入持卡人",@"请输入卡号"];
    NSArray *section2Placeholder = @[@"请输入开户行",@"请输入备注"];
    
    _section = @[section1,section2].mutableCopy;
    
    _sectionPlaceHolder = @[section1Placeholder,section2Placeholder].mutableCopy;
    
    [self loadingData];
}

-(void)loadingData{
    NSDictionary * cardName = @{@"content":@""};
    [self.dataArray addObject:cardName];
    NSDictionary * cardNumber = @{@"content":@""};
    [self.dataArray addObject:cardNumber];
    NSDictionary * accountNumber = @{@"content":@""};
    [self.dataArray addObject:accountNumber];
    NSDictionary * provinceName = @{@"content":@""};
    [self.dataArray addObject:provinceName];
    
    
    NSDictionary * alipayNumber = @{@"content":@""};
    [self.dataArray addObject:alipayNumber];
    NSDictionary * alipayName = @{@"content":@""};
    [self.dataArray addObject:alipayName];
    
    NSDictionary * weixinNumber = @{@"content":@""};
    [self.dataArray addObject:weixinNumber];
    NSDictionary * weixinName = @{@"content":@""};
    [self.dataArray addObject:weixinName];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"BankList" ofType:@"plist"];
    NSArray * array = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
}

-(void)setUpUI{
    
    self.userAddCardTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    self.userAddCardTableView.backgroundColor = [UIColor clearColor];
    self.userAddCardTableView.separatorStyle = NO;
    self.userAddCardTableView.delegate = self;
    self.userAddCardTableView.dataSource = self;
    [self.view addSubview:self.userAddCardTableView];
    
    //手势关闭键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.userAddCardTableView addGestureRecognizer:tap];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GCWidth, 60)];
    back.backgroundColor = [UIColor clearColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake([UIView countBeforeWithIphone5Length:10], 15, GCWidth-[UIView countBeforeWithIphone5Length:20], 45);
    button.backgroundColor = [UIColor whiteColor];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitleColor:[UIColor gc_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3;
    button.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:15];
    button.tag = 100+section;
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiajiantou"]];
    image.frame = CGRectMake(GCWidth-20-10-15, 15+3.5f, 15, 8);
    [button addSubview:image];
    if (section == 0) {
        [button setTitle:@"   银行卡账户" forState:UIControlStateNormal];
    }
    if (section == 1) {
        [button setTitle:@"   支付宝账户" forState:UIControlStateNormal];
    }
    if (section == 2) {
        [button setTitle:@"   微信账户" forState:UIControlStateNormal];
    }
    button.selected = NO;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [back addSubview:button];
    return back;
}

-(void)buttonAction:(UIButton *)sender{
    if (sender.tag == 100) {
        self.select1 = !self.select1;
        if (self.select1 == YES) {
            self.tag = 2;
        }else
            self.tag = 1;
    }
    if (sender.tag == 101) {
        self.select2 = !self.select2;
        if (self.select2 == YES) {
            self.tag = 4;
        }else
            self.tag = 3;
    }
    if (sender.tag == 102) {
        self.select3 = !self.select3;
        if (self.select3 == YES) {
            self.tag = 6;
        }else
            self.tag = 5;
    }
    [self.userAddCardTableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.other == YES) {
            return [UIView countBeforeWithIphone5Length:170+40];
        }else
            return [UIView countBeforeWithIphone5Length:170];
    }
    if (indexPath.section == 1) {
        return [UIView countBeforeWithIphone5Length:170-80];
    }
    if (indexPath.section == 2) {
        return [UIView countBeforeWithIphone5Length:170-80];
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.tag == 2) {
            return 1;
        }else
            return 0;
    }
    if (section == 1) {
        if (self.tag == 4) {
            return 1;
        }else
            return 0;
    }
    if (section == 2) {
        if (self.tag == 6) {
            return 1;
        }else
            return 0;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CardCell"];
        if (!cell) {
            cell = [[CardCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"CardCell"];
        }
        cell.provinceBtnBlock = ^(NSString *text){
            NSString *address = text;
            NSArray *array = [address componentsSeparatedByString:@" "];
            NSString *province = @"";//省
            NSString *city = @"";//市
            NSString *county = @"";//县
            if (array.count > 2) {
                province = array[0];
                city = array[1];
                county = array[2];
            } else if (array.count > 1) {
                province = array[0];
                city = array[1];
            } else if (array.count > 0) {
                province = array[0];
            }
            [self.regionPickerView showPickerWithProvinceName:province cityName:city countyName:county];
        };
        cell.accountBtnBlock = ^(NSString *text){
            [self selectKhh];
        };
        cell.delegate = self;
        [cell reloadCell:[NSArray arrayWithArray:self.dataArray] isshow:self.other];
        return cell;
    }
    AlipayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlipayCell"];
    if (!cell) {
        cell = [[AlipayCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"AlipayCell"];
    }
    if (indexPath.section == 2) {
        [cell reloadView:@[@"微信号",@"请输入微信号",@"微信名字",@"请输入微信名字"]];
    }
    cell.delegate = self;
    return cell;
}

-(void)closeKeyboard{
    [self.userAddCardTableView endEditing:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if (self.tag == 2) {
            return 90;
        }else
            return 0.00001;
    }
    if (section == 1) {
        if (self.tag == 4) {
            return 90;
        }else
            return 0.00001;
    }
    if (section == 2) {
        if (self.tag == 6) {
            return 90;
        }else
            return 0.00001;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self gc_tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath isOpen:YES];
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if (self.tag == 2) {
            UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GCWidth, 90)];
            UIButton *submitBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor whiteColor] withTitle:@"完成" withRadius:50.0/2];
            submitBtn.tag = 111;
            [submitBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
            submitBtn.frame = CGRectMake(40, 30, GCWidth-80, 50);
            [submitBtn addTarget:self action:@selector(addCardAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [back addSubview:submitBtn];
            return back;
        }else
            return [UIView new];
    }
    if (section == 1) {
        if (self.tag == 4) {
            UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GCWidth, 90)];
            UIButton *submitBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor whiteColor] withTitle:@"完成" withRadius:50.0/2];
            submitBtn.tag = 222;
            [submitBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
            submitBtn.frame = CGRectMake(40, 30, GCWidth-80, 50);
            [submitBtn addTarget:self action:@selector(addCardAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [back addSubview:submitBtn];
            return back;
        }else
            return [UIView new];
    }
    if (section == 2) {
        if (self.tag == 6) {
            UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GCWidth, 90)];
            UIButton *submitBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor whiteColor] withTitle:@"完成" withRadius:50.0/2];
            submitBtn.tag = 333;
            [submitBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
            submitBtn.frame = CGRectMake(40, 30, GCWidth-80, 50);
            [submitBtn addTarget:self action:@selector(addCardAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [back addSubview:submitBtn];
            return back;
        }else
            return [UIView new];
    }
    return [UIView new];
}

-(void)selectKhh{
    [self closeKeyboard];
    _pickview = [[ZHPickView alloc]initWithArray:nil];
    _pickview.frame = CGRectMake(0, 0, GCWidth, GCHeight);
    _pickview.backgroundColor = [UIColor gc_colorWithHexString:@"#000000" alpha:0.6];
    [self.view addSubview:_pickview];
    _pickview.delegate=self;
    [_pickview showView];
}

#pragma mark ZhpickVIewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    if ([resultString isEqualToString:@"其他"]) {
        self.other = YES;
    }
    [self.dataArray replaceObjectAtIndex:2 withObject:[NSDictionary dictionaryWithObject:resultString forKey:@"content"]];
    [self.userAddCardTableView reloadData];
}
#pragma mark -- 添加银行卡
-(void)addCardAction:(UIButton *)sender{
    [self closeKeyboard];
    [self.view endEditing:YES];
    
    if (sender.tag == 111) {//银行卡
        if ([self.dataArray[0][@"content"] length] == 0) {
            [MBProgressHUD gc_showErrorMessage:@"持卡人姓名不能为空"];
            return;
        }
        if ([self.dataArray[1][@"content"]length] == 0) {
            [MBProgressHUD gc_showErrorMessage:@"卡号不能为空"];
            return;
        }else
            if (![tool checkCardNo:self.dataArray[1][@"content"]]) {
                [MBProgressHUD gc_showErrorMessage:@"卡号有误"];
                return ;
            }
        if (self.dataArray[2][@"content"] == 0) {
            [MBProgressHUD gc_showErrorMessage:@"开户行不能为空"];
            return;
        }
    }
    if (sender.tag == 222) {//支付宝
        if ([self.dataArray[4][@"content"]length] == 0) {
            [MBProgressHUD gc_showErrorMessage:@"支付宝账号不能为空"];
            return;
        }
        if ([self.dataArray[5][@"content"] length] == 0) {
            [MBProgressHUD gc_showErrorMessage:@"姓名不能为空"];
            return;
        }
    }
    
    [MBProgressHUD gc_showActivityMessageInWindow:@"添加中..."];
    BundRequest *bundReq = [BundRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            [MBProgressHUD gc_showSuccessMessage:@"银行卡添加成功"];
            @weakify(self);
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                @strongify(self);
                [self.navigationController popViewControllerAnimated:YES];
                if (self.selectBlock) {
                    self.selectBlock();
                }
            });
            
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    if (sender.tag == 111) {//银行卡
        bundReq.uc_type = @"0";
        bundReq.uc_name = self.dataArray[0][@"content"];
        bundReq.uc_card = self.dataArray[1][@"content"];
        if ([self.dataArray[2][@"content"] isEqualToString:@"其他"]) {
            bundReq.uc_khh = self.otherstr;
        }else
            bundReq.uc_khh = self.dataArray[2][@"content"];
        bundReq.uc_addr = self.dataArray[3][@"content"];
    }
    if (sender.tag == 222) {//支付宝
        bundReq.uc_type = @"2";
        bundReq.uc_card = self.dataArray[4][@"content"];
        bundReq.uc_name = self.dataArray[5][@"content"];
        bundReq.uc_khh = @"";
        bundReq.uc_addr = @"";
    }
    bundReq.ub_id = [UserManager getUID];
    bundReq.action = @"1";
    
    [bundReq startRequest];
    
//    NSMutableDictionary *dicPara = [[NSMutableDictionary alloc]init];
//    [dicPara setValue:@"" forKey:@"sid"];
//    [dicPara setValue:@"1" forKey:@"index"];
//    [dicPara setValue:[UserManager getUID] forKey:@"ub_id"];
//    [dicPara setValue:@"" forKey:@"uo_high"];
//    [dicPara setValue:[UserManager getUserLatitude] forKey:@"uo_lat"];
//    [dicPara setValue:[UserManager getUserLongitude] forKey:@"uo_long"];
//    [dicPara setValue:@"1" forKey:@"action"];
//
//    if (sender.tag == 111) {//银行卡
//        [dicPara setValue:@"0" forKey:@"uc_type"];
//        if ([self.dataArray[0][@"content"] length] == 0) {
//            [TipsView show:@"持卡人姓名不能为空"];
//            return;
//        }
//        if ([self.dataArray[1][@"content"]length] == 0) {
//            [TipsView show:@"卡号不能为空"];
//            return;
//        }else
//            if (![Tools checkCardNo:self.dataArray[1][@"content"]]) {
//                [TipsView showError:@"卡号有误"];
//                return ;
//            }
//        if (self.dataArray[2][@"content"] == 0) {
//            [TipsView show:@"开户行不能为空"];
//            return;
//        }
//        [dicPara setValue:self.dataArray[0][@"content"] forKey:@"uc_name"];
//        [dicPara setValue:self.dataArray[1][@"content"] forKey:@"uc_card"];
//        if ([self.dataArray[2][@"content"] isEqualToString:@"其他"]) {
//            [dicPara setValue:self.otherstr forKey:@"uc_khh"];
//        }else
//            [dicPara setValue:self.dataArray[2][@"content"] forKey:@"uc_khh"];
//        [dicPara setValue:self.dataArray[3][@"content"] forKey:@"uc_addr"];
//    }
//    if (sender.tag == 222) {//支付宝
//        [dicPara setValue:@"2" forKey:@"uc_type"];
//        if ([self.dataArray[4][@"content"]length] == 0) {
//            [TipsView show:@"支付宝账号不能为空"];
//            return;
//        }
//        if ([self.dataArray[5][@"content"] length] == 0) {
//            [TipsView show:@"姓名不能为空"];
//            return;
//        }
//        [dicPara setValue:self.dataArray[4][@"content"] forKey:@"uc_card"];
//        [dicPara setValue:self.dataArray[5][@"content"] forKey:@"uc_name"];
//    }
//
//    [MBProgressHUD showMessage:@"添加中..." toView:self.view];
//
//    [GCRequestApi CardEditApiWithParegams:dicPara completion:^(BundModel *model, NSError *error) {
//
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//        if ([model.result.code isEqualToString:@"01"]) {
//            [TipsView show:@"重新连接中"];
//        }else if ([model.result.code isEqualToString:@"10"]) {
//
//            [self.navigationController popViewControllerAnimated:YES];
//            if (self.selectBlock) {
//                self.selectBlock();
//            }
//        }else if([model.result.code isEqualToString:@"20"]) {
//            [TipsView showError:model.result.info];
//        }else if([model.result.code isEqualToString:@"02"]) {
//            [TipsView showError:model.result.info];
//        }else{
//            [TipsView showError:@"网络开小差"];
//        }
//
//    }];
}

#pragma 支付宝输入
- (void)textChanged:(NSString *)content1 andText:(NSString *)content tag:(NSString *)str{
    if ([str isEqualToString:@"1"]) {
        [self.dataArray replaceObjectAtIndex:6 withObject:[NSDictionary dictionaryWithObject:content1 forKey:@"content"]];
        [self.dataArray replaceObjectAtIndex:7 withObject:[NSDictionary dictionaryWithObject:content forKey:@"content"]];
    }else{
        [self.dataArray replaceObjectAtIndex:4 withObject:[NSDictionary dictionaryWithObject:content1 forKey:@"content"]];
        [self.dataArray replaceObjectAtIndex:5 withObject:[NSDictionary dictionaryWithObject:content forKey:@"content"]];
    }
}

#pragma 银行卡输入
-(void)textChanged:(NSString *)content1 Text:(NSString *)content
             other:(NSString *)content2{
    [self.dataArray replaceObjectAtIndex:0 withObject:[NSDictionary dictionaryWithObject:content1 forKey:@"content"]];
    [self.dataArray replaceObjectAtIndex:1 withObject:[NSDictionary dictionaryWithObject:content forKey:@"content"]];
    self.otherstr = content2;
}

- (HXProvincialCitiesCountiesPickerview *)regionPickerView {
    [self.userAddCardTableView endEditing:YES];
    if (!_regionPickerView) {
        _regionPickerView = [[HXProvincialCitiesCountiesPickerview alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        __weak typeof(self) wself = self;
        _regionPickerView.completion = ^(NSString *provinceName,NSString *cityName,NSString *countyName) {
            [wself.dataArray replaceObjectAtIndex:3 withObject:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName] forKey:@"content"]];
            [wself.userAddCardTableView reloadData];
            //            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName];
        };
        [self.navigationController.view addSubview:_regionPickerView];
    }
    return _regionPickerView;
}

#pragma -----resignFirstRespond----
- (void)resignFirstRespond{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView * view in self.view.subviews){
        if ([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]] ) {
            [view resignFirstResponder];
        }else if ([view isKindOfClass:[UIPickerView class]]) {
            UIPickerView * packer = (UIPickerView *)view;
            [self resignFirstPicker:packer];
        }
    }
}
-(void)resignFirstPicker:(UIPickerView *)picker
{
    [UIView animateWithDuration:0.6 delay:0. options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [picker setAdaptiveIphone5Frame:CGRectMake(0, kScreenHeight , kScreenWidth, 160)];
    } completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
