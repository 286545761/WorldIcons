//
//  QuestionViewController.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2017/12/26.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "QuestionViewController.h"
#import "HZPOrderTableViewCell.h"
#import "ZHPickView.h"
#import "SetSecurityRequest.h"
#define HIDE_KEYBOARD [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
@interface QuestionViewController ()<UITableViewDelegate,UITableViewDataSource,ZHPickViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *leftArr;
@property (nonatomic,strong)NSMutableArray *rightArr;
@property (nonatomic,strong)NSMutableArray *inputArr;
@property (nonatomic,strong)ZHPickView *pickview;
@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navLabel.text = @"密保设置";
    self.leftArr = @[@"问题1：",@"问题2：",@"问题3："];
    self.rightArr = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    self.inputArr = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    [self.view addSubview:self.tableView];
    [self initSubmit];
}

-(void)initSubmit{
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 100)];
    back.backgroundColor = [UIColor clearColor];
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.adaptiveIphone5Frame = CGRectMake(15, 30, 320-30-20, 40);
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:17];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = [UIView countBeforeWithIphone5Length:35.0/2];
    [submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchDown];
    [back addSubview:submitBtn];
    self.tableView.tableFooterView = back;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [UIView countBeforeWithIphone5Length:40];
    }
    return 0.00001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 40)];
        back.backgroundColor = [UIColor clearColor];
        UILabel *show = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 10, 320-20, 30)];
        show.text = @"  请选择下列问题中的3个进行填写";
        show.backgroundColor = [UIColor whiteColor];
        show.textColor = [UIColor gc_colorWithHexString:@"#333333"];
        show.font = [UIFont fontWithAdaptiveIphone5Size:16];
        show.textAlignment = NSTextAlignmentLeft;
        [back addSubview:show];
        return back;
    }
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 40)];
    back.backgroundColor = [UIColor whiteColor];
    UITextField *inputTF = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 10, 320-40, 30)];
    inputTF.placeholder = @"请输入";
    inputTF.leftView = [[UIView alloc] initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 10, 30)];
    inputTF.leftViewMode = UITextFieldViewModeAlways;
    inputTF.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    inputTF.font = [UIFont fontWithAdaptiveIphone5Size:16];
    inputTF.backgroundColor = RGBA(245, 245, 245,1);
    inputTF.layer.masksToBounds = YES;
    inputTF.delegate = self;
    inputTF.tag = 100+section;
    inputTF.layer.cornerRadius = [UIView countBeforeWithIphone5Length:30.0/2];
    [back addSubview:inputTF];
    if (section == 0) {
        if (![self.rightArr[0] isEqualToString:@""]) {
            return back;
        }else
            return [UIView new];
    }
    if (section == 1) {
        if (![self.rightArr[1] isEqualToString:@""]) {
            return back;
        }else
            return [UIView new];
    }
    if (section == 2) {
        if (![self.rightArr[2] isEqualToString:@""]) {
            return back;
        }else{
            UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 10)];
            back.backgroundColor = [UIColor whiteColor];
            return back;
        }
    }
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if (![self.rightArr[0] isEqualToString:@""]) {
            return [UIView countBeforeWithIphone5Length:40];
        }else
            return 0.00001;
    }
    if (section == 1) {
        if (![self.rightArr[1] isEqualToString:@""]) {
            return [UIView countBeforeWithIphone5Length:40];
        }else
            return 0.00001;
    }
    if (section == 2) {
        if (![self.rightArr[2] isEqualToString:@""]) {
            return [UIView countBeforeWithIphone5Length:50];
        }else
            return [UIView countBeforeWithIphone5Length:10];
    }
    return 0.0001;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIView countBeforeWithIphone5Length:40];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HZPOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HZPOrderTableViewCell"];
    if (!cell) {
        cell = [[HZPOrderTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"HZPOrderTableViewCell"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.myOrderLable.adaptiveIphone5Frame = CGRectMake(10, 12, 250 ,20);
        cell.myOrderLable.font = [UIFont fontWithAdaptiveIphone5Size:16];
        UIView *line = [[UIView alloc] initWithAdaptiveIphone5Frame:CGRectMake(10, 39, 300-20, 1)];
        line.backgroundColor = RGBA(245, 245, 245,1);
        [cell.contentView addSubview:line];
    }
    NSString *s = self.rightArr[indexPath.section];
    if ([s containsString:@"+"]) {
        s = [s substringFromIndex:2];
        [cell reloadViewTitleLable:[NSString stringWithFormat:@"%@%@",self.leftArr[indexPath.section],s] WithShowLable:nil];
    }else
        [cell reloadViewTitleLable:[NSString stringWithFormat:@"%@%@",self.leftArr[indexPath.section],self.rightArr[indexPath.section]] WithShowLable:nil];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self selectKhh:indexPath];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect rect = self.view.bounds;
        rect.size.height -= 44;
        rect.origin.x += [UIView countBeforeWithIphone5Length:10];
        rect.size.width -= [UIView countBeforeWithIphone5Length:20];
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        _tableView.separatorInset = UIEdgeInsetsMake(0,[UIView countBeforeWithIphone5Length:10], 0, [UIView countBeforeWithIphone5Length:10]);
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorColor = RGBA(217, 217, 217,1);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(void)selectKhh:(NSIndexPath *)index{
    [self closeKeyboard];
    NSArray *dataArray = @[@"你第一所小学校名",@"你在设置预留信息",@"你第一个男／女朋友名字",@"你的出生地方",@"你最要好的朋友名字",@"你母亲名字",@"你父亲名字"];
    _pickview = [[ZHPickView alloc]initWithArray:dataArray];
    _pickview.frame = CGRectMake(0, 0, GCWidth, GCHeight);
    _pickview.tag = 100+index.section;
    _pickview.backgroundColor = [UIColor gc_colorWithHexString:@"#000000" alpha:0.6];
    [self.view addSubview:_pickview];
    _pickview.delegate=self;
    [_pickview showView];
}

-(void)closeKeyboard{
    [self.tableView endEditing:YES];
}

#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    NSArray *dataArray = @[@"你第一所小学校名",@"你在设置预留信息",@"你第一个男／女朋友名字",@"你的出生地方",@"你最要好的朋友名字",@"你母亲名字",@"你父亲名字"];
    if ([self.rightArr containsObject:[NSString stringWithFormat:@"+%ld%@",[dataArray indexOfObject:resultString]+1,resultString]]) {
        [MBProgressHUD gc_showErrorMessage:@"请不要重复选择一个问题"];
        return;
    }
    [self.rightArr replaceObjectAtIndex:pickView.tag-100 withObject:[NSString stringWithFormat:@"+%ld%@",[dataArray indexOfObject:resultString]+1,resultString]];
    [self.tableView reloadData];
}

-(void)submitBtnAction{
    [self closeKeyboard];
    [MBProgressHUD gc_showActivityMessageInWindow:@"设置中..."];
    SetSecurityRequest *buyCoinReq = [SetSecurityRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [MBProgressHUD gc_hiddenHUD];
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
            [MBProgressHUD gc_showErrorMessage:@"设置成功"];
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5/*延迟执行时间*/ * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
        [MBProgressHUD gc_showErrorMessage:@"网络错误"];
    }];
    if ([self.inputArr containsObject:@""]) {
        [MBProgressHUD gc_showErrorMessage:@"请填写所有的问题！"];
        return;
    }
    buyCoinReq.ub_id = [UserManager getUID];
    if ([[NSString stringWithFormat:@"%@",self.rightArr[0]] containsString:@"+"]) {
        buyCoinReq.ud_p1 = [self.rightArr[0] substringWithRange:NSMakeRange(1, 1)];
    }
    if ([[NSString stringWithFormat:@"%@",self.rightArr[1]] containsString:@"+"]) {
        buyCoinReq.ud_p2 = [self.rightArr[1] substringWithRange:NSMakeRange(1, 1)];
    }
    if ([[NSString stringWithFormat:@"%@",self.rightArr[2]] containsString:@"+"]) {
        buyCoinReq.ud_p3 = [self.rightArr[2] substringWithRange:NSMakeRange(1, 1)];
    }
    buyCoinReq.ud_a1 = self.inputArr[0];
    buyCoinReq.ud_a2 = self.inputArr[1];
    buyCoinReq.ud_a3 = self.inputArr[2];
    [buyCoinReq startRequest];
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [self.inputArr replaceObjectAtIndex:textField.tag-100 withObject:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    HIDE_KEYBOARD;
    return YES;
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
