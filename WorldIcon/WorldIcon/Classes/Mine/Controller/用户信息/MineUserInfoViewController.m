//
//  MineUserInfoViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MineUserInfoViewController.h"
#import "UserInfoCell.h"
#import "AQKCBrithDayView.h"
#import "HJCActionSheet.h"
#import "EditNickNameViewController.h"
#import "GCAlertView.h"
#import "UserPhotoRequest.h"
#import "SaveUserInfoRequest.h"
#import "OSAddressPickerView.h"
#import "QuestionViewController.h"

@interface MineUserInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,AQKCDayChooseViewDelegate,HJCActionSheetDelegate,GCAlertViewDelegate>
{
    NSString *_province;
    NSString *_city;
    NSString *_district;
}
@property (nonatomic,strong)OSAddressPickerView *addressPickerView;
@property (nonatomic,strong)UITableView      *userInfoTableView;
@property (nonatomic,strong)NSArray          *leftArray;
@property (nonatomic,strong)NSArray          *rightArray;
@property (nonatomic,strong)AQKCBrithDayView *birthDayView;
@property (nonatomic,strong)HJCActionSheet   *sheet;
@property (nonatomic,strong)UIView           *alertView;
@property (nonatomic,strong)UIImage          *uploadPhoto;
@property (nonatomic,strong)UIImageView      *userPhoto;
@property (nonatomic,strong)NSDictionary     *dicFileId;

@end

@implementation MineUserInfoViewController
/** 提示框懒加载 */
- (UIView *)alertView{
    
    if (!_alertView) {
        // 这里还可以把alerView创建到一个蒙版上,直接进行操作蒙版的透明度隐藏来展示动画,也可以避免点击框外的其他控件,就不在这里细写了
        // 赋值
        _alertView = [[GCAlertView singleClass]
                      // 传入数组
                      quickAlertViewWithArray:@[@" 修改头像",@" 现在拍摄一张",@" 从相册中选择",@" 取消"]
                      ];
        // 设定中心,如果需要适配请layoutIfNeed
        _alertView.centerY = self.view.centerY-90;
        // 切圆角
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 3;
        // 初始状态为隐藏,透明度为0
        _alertView.hidden = YES;
        _alertView.alpha = 0.0;
        // 设置代理
        [GCAlertView singleClass].delegate = self;
    }
    return _alertView;
}

- (AQKCBrithDayView *)birthDayView{
    if (!_birthDayView) {
        _birthDayView = [[AQKCBrithDayView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _birthDayView.delegate = self;
        _birthDayView.backgroundColor = [UIColor gc_colorWithHexString:@"#000000" alpha:0.6];
    }
    return _birthDayView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navLabel.text = @"个人信息";
    
    [self setUpRightBarButton];
    
    [self setUpuserInfoTableView];
    
    [self.view addSubview:self.alertView];

    self.leftArray = @[@[@"头像"],@[@"昵称",@"真实姓名",@"身份证",@"生日",@"性别",@"所在地",@"OC地址"]];
    NSString *nickname = @"";
    if (self.model.user_detail.ud_nickname.length != 0) {
        nickname = self.model.user_detail.ud_nickname;
    }
    NSString *sex = @"";
    if ([self.model.user_detail.ud_sex isEqualToString:@"1"]) {
        sex = @"男";
    }else{
        sex = @"女";
    }
    
    NSString *borth = @"";
    if (self.model.user_detail.ud_borth.length != 0) {
        borth = self.model.user_detail.ud_borth;
    }

    NSString *address = @"";
    if (self.model.user_detail.ud_address.length != 0) {
        address = self.model.user_detail.ud_address;
    }
    
    NSString *md5Str = @"";
    if (self.model.user_detail.ud_md5addr.length != 0) {
        md5Str = self.model.user_detail.ud_md5addr;
    }
    
    NSString *ud_name = @"";
    if (self.model.user_detail.ud_name.length != 0) {
        ud_name = self.model.user_detail.ud_name;
    }
    NSString *ud_idcard = @"";
    if (self.model.user_detail.ud_idcard.length != 0) {
        ud_idcard = self.model.user_detail.ud_idcard;
    }
    self.rightArray = @[@[@""],@[nickname,ud_name,ud_idcard,borth,sex,address,md5Str]];
}
#pragma mark -- 右侧申请入驻
-(void)setUpRightBarButton{
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStyleDone) target:self action:@selector(saveUserInfoAction)];
    btn.tintColor = [UIColor whiteColor];
    [btn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn;
}


-(void)setUpuserInfoTableView{
    
    self.userInfoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStyleGrouped)];
    self.userInfoTableView.showsVerticalScrollIndicator = NO;
    self.userInfoTableView.backgroundColor = [UIColor clearColor];
    self.userInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.userInfoTableView];
    
    self.userInfoTableView.delegate = self;
    self.userInfoTableView.dataSource = self;
    
    UIView *footerView = [[UIView alloc] initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 100)];
    UIButton *securityBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor clearColor] withTitle:@"密保设置" withRadius:5];
    securityBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    securityBtn.adaptiveIphone5Frame = CGRectMake(40, 25, 320-80, 40);
    [securityBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
    [securityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [securityBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:securityBtn];
    self.userInfoTableView.tableFooterView = footerView;
}

-(void)confirmClick{
    QuestionViewController *question = [QuestionViewController new];
    [self.navigationController pushViewController:question animated:YES];
}

#pragma mark -- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.leftArray[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoCell"];
    if (!cell) {
        cell = [[UserInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"userInfoCell"];
    }

    cell.leftLabel.text = self.leftArray[indexPath.section][indexPath.row];
    
    if ([self.rightArray[indexPath.section][indexPath.row] length] == 0) {
        cell.rightLabel.text = @"请设置";
    }else
        cell.rightLabel.text = self.rightArray[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {
        if (cell.rightLabel) {
            cell.rightLabel.hidden = YES;
            cell.headerImage.hidden = NO;
        }
        //图片
        self.userPhoto = cell.headerImage;
        if (_uploadPhoto) {
            self.userPhoto.image = _uploadPhoto;
        }else{
            NSString *imageUrl =self.model.user_detail.ud_photo_fileid;
            [self.userPhoto sd_setImageWithURL:[NSURL URLWithString:[AppManager getPhotoUrlFileID:imageUrl]] placeholderImage:[UIImage imageNamed:kDefaultImg]];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 6) {
        cell.arrow.hidden = YES;
    }else
        cell.arrow.hidden = NO;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    return 0.00001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.userInfoTableView endEditing:YES];
    if (indexPath.section == 0) {
        //编辑头像
        [UIView animateWithDuration:0.1 animations:^{
            self.alertView.alpha = 1;
            self.alertView.hidden = NO;
        }];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UserInfoCell *cell1 = [self.userInfoTableView cellForRowAtIndexPath:indexPath];
            
            //编辑昵称
            EditNickNameViewController *editNicknameVC = [[EditNickNameViewController alloc]init];
            editNicknameVC.hidesBottomBarWhenPushed = YES;
            if (![cell1.rightLabel.text isEqualToString:@"请设置"]) {
                editNicknameVC.nicknameStr = cell1.rightLabel.text;
            }
            editNicknameVC.title = @"昵称";
            
            editNicknameVC.block = ^(NSString *nickname){
                cell1.rightLabel.text = nickname;
            };
            [self.navigationController pushViewController:editNicknameVC animated:YES];
        }
        if (indexPath.row == 1) {
            UserInfoCell *cell1 = [self.userInfoTableView cellForRowAtIndexPath:indexPath];
            //真实姓名
            EditNickNameViewController *editNicknameVC = [[EditNickNameViewController alloc]init];
            editNicknameVC.hidesBottomBarWhenPushed = YES;
            if (![cell1.rightLabel.text isEqualToString:@"请设置"]) {
                editNicknameVC.nicknameStr = cell1.rightLabel.text;
            }
            editNicknameVC.nicknameStr = cell1.rightLabel.text;
            editNicknameVC.title = @"真实姓名";
            editNicknameVC.block = ^(NSString *nickname){
                cell1.rightLabel.text = nickname;
            };
            [self.navigationController pushViewController:editNicknameVC animated:YES];
        }
        if (indexPath.row == 2) {
            UserInfoCell *cell1 = [self.userInfoTableView cellForRowAtIndexPath:indexPath];
            //身份证
            EditNickNameViewController *editNicknameVC = [[EditNickNameViewController alloc]init];
            editNicknameVC.hidesBottomBarWhenPushed = YES;
            if (![cell1.rightLabel.text isEqualToString:@"请设置"]) {
                editNicknameVC.nicknameStr = cell1.rightLabel.text;
            }
            editNicknameVC.title = @"身份证";

            editNicknameVC.block = ^(NSString *nickname){
                cell1.rightLabel.text = nickname;
            };
            [self.navigationController pushViewController:editNicknameVC animated:YES];

        }
        if (indexPath.row == 3) {
            //编辑生日
            
            [self.view addSubview:self.birthDayView];
            
            self.birthDayView.backView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 250);
            [UIView animateWithDuration:.3f animations:^{
                if (CGRectGetHeight([UIScreen mainScreen].bounds) == 812.0) {
                    if (@available(iOS 11.0, *)) {
                        self.birthDayView.backView.frame = CGRectMake(0, kScreenHeight-250-44, kScreenWidth, 250);
                    }
                }else{
                    self.birthDayView.backView.frame = CGRectMake(0, kScreenHeight-250, kScreenWidth, 250);
                }
            }];
            
        }
        if (indexPath.row == 4) {
            //编辑性别
            HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"男",@"女", nil];
            sheet.tag = 2022;
            // 2.显示出来
            [sheet show];
        }
        if (indexPath.row == 5) {
            
            //编辑所在地
            _addressPickerView = [OSAddressPickerView shareInstance];
            [_addressPickerView showBottomView];
            [self.view addSubview:_addressPickerView];
            
            @weakify(self);
            
            _addressPickerView.block = ^(NSString *province,NSString *city,NSString *district)
            {
                @strongify(self);
                
                UserInfoCell *cell1 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]];
                cell1.rightLabel.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,district];
                //                _province = province;
                //                _city = city;
                //                _district = district;
            };
        }
    }
}

#pragma mark -- GCAlertViewDelegate
- (void)didSelectAlertButton:(NSString *)title{
    
    [UIView animateWithDuration:0.1 animations:^{
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        // 如果直接在动画里隐藏不会出现动画效果,所以要在动画结束之后进行隐藏
        self.alertView.hidden = YES;
        //跳转相应的地方
        if ([title isEqualToString:@" 现在拍摄一张"]) {
            UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            //获取方式:通过相机
            PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            PickerImage.allowsEditing = YES;
            PickerImage.delegate = self;
            [self presentViewController:PickerImage animated:YES completion:nil];
            
        }
        if ([title isEqualToString:@" 从相册中选择"]) {
            UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            //从相机获取
            PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //允许编辑，即放大裁剪
            PickerImage.allowsEditing = YES;
            //自代理
            PickerImage.delegate = self;
            //页面跳转
            [self presentViewController:PickerImage animated:YES completion:nil];
        }
        
    }];
}
#pragma mark -- 修改用户图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSMutableArray *imgsArray = [NSMutableArray arrayWithCapacity:9];
        
        //定义一个newPhoto，用来存放我们选择的图片。
        _uploadPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        [imgsArray addObject:_uploadPhoto];
        
        UserPhotoRequest *req = [[UserPhotoRequest alloc] init];
        
        [req startCompletionBlockWithSuccess:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            _dicFileId = responseDict;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.userPhoto.image = _uploadPhoto;
                
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
                [self.userInfoTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                
            });
        } failure:^(NSError *error) {
            GCLog(@"error:%@", error.localizedFailureReason);
        }];
        req.images = imgsArray;
        [req startRequest];

    }];
}

- (void)ensureBtnOnClick:(NSString *)value{
    
    [UIView animateWithDuration:.3f animations:^{
        self.birthDayView.backView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 250);
    }completion:^(BOOL finished) {
        [self.birthDayView removeFromSuperview];
    }];
    
    UserInfoCell *cell1 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    cell1.rightLabel.text = value;
}
- (void)cancelBtnOnClick{
    
    [UIView animateWithDuration:.3f animations:^{
        self.birthDayView.backView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 250);
    }completion:^(BOOL finished) {
        [self.birthDayView removeFromSuperview];
    }];
}

#pragma mark -- HJCActionSheetDelegate
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UserInfoCell *cell1 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];
    switch (buttonIndex) {
        case 1:
            cell1.rightLabel.text = @"男";
            break;
        case 2:
            cell1.rightLabel.text = @"女";
            break;
    }
}

#pragma mark -- 保存用户信息
-(void)saveUserInfoAction3{

    UserInfoCell *cell1 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];//昵称
    UserInfoCell *cell2 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];//真实姓名
    
    UserInfoCell *cell3 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];//身份证
    UserInfoCell *cell4 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];//生日
    UserInfoCell *cell5 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];//性别
    UserInfoCell *cell6 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]];//所在地
//    UserInfoCell *cell7 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:2]];//所在地
    
    NSString *fileID = [_dicFileId[@"file_ids"] lastObject];
    fileID = fileID.length == 0 ? @"" : fileID;
    
    NSMutableDictionary *dicPara = [NSMutableDictionary dictionaryWithCapacity:10];
    [dicPara setValue:fileID forKey:@"ud_photo_fileid"];
    [dicPara setValue:cell2.rightLabel.text forKey:@"ud_name"];
    [dicPara setValue:cell3.rightLabel.text forKey:@"ud_idcard"];
    if (![cell1.rightLabel.text isEqualToString:@"请设置"]) {
        [dicPara setValue:cell1.rightLabel.text forKey:@"ud_nickname"];
    }else
        [dicPara setValue:@"" forKey:@"ud_nickname"];
    
    if (![cell4.rightLabel.text isEqualToString:@"请设置"]) {
        [dicPara setValue:cell4.rightLabel.text forKey:@"ud_borth"];
    }else
        [dicPara setValue:@"" forKey:@"ud_borth"];
    
    if (![cell5.rightLabel.text isEqualToString:@"请设置"]) {
        [dicPara setValue:cell5.rightLabel.text forKey:@"ud_sex"];
    }else
        [dicPara setValue:@"" forKey:@"ud_sex"];
    
    if (![cell6.rightLabel.text isEqualToString:@"请设置"]) {
        [dicPara setValue:cell6.rightLabel.text forKey:@"ud_address"];
    }else
        [dicPara setValue:@"" forKey:@"ud_address"];
    
    [MBProgressHUD gc_showActivityMessageInWindow:@"保存中..."];
    SaveUserInfoRequest *saveUserInfoReq = [SaveUserInfoRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [MBProgressHUD gc_hiddenHUD];
        GCLog(@"---%@",responseDict);
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
            [MBProgressHUD gc_showInfoMessage:model.info];
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
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
    }];
    saveUserInfoReq.ub_id = [UserManager getUID];
    saveUserInfoReq.user_detail = dicPara;
    [saveUserInfoReq startRequest];
}

-(void)saveUserInfoAction{

    UserInfoCell *cell1 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];//昵称
    UserInfoCell *cell2 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];//真实姓名
    
    UserInfoCell *cell3 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];//身份证
    UserInfoCell *cell4 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];//生日
    UserInfoCell *cell5 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];//性别
    UserInfoCell *cell6 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]];//所在地
    //UserInfoCell *cell7 = [self.userInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:2]];//所在地
    
    NSString *fileID = [_dicFileId[@"file_ids"] lastObject];
    fileID = fileID.length == 0 ? @"" : fileID;
    
    NSMutableDictionary *dicPara = [NSMutableDictionary dictionaryWithCapacity:10];
    if (fileID.length != 0) {
        [dicPara setValue:fileID forKey:@"ud_photo_fileid"];
    }
    
    if ([cell6.rightLabel.text isEqualToString:@"请设置"]) {
    }else
        [dicPara setValue:cell6.rightLabel.text forKey:@"ud_address"];
    
    if ([cell5.rightLabel.text isEqualToString:@"请设置"]) {
    }else
        [dicPara setValue:cell5.rightLabel.text forKey:@"ud_sex"];
    
    if ([cell4.rightLabel.text isEqualToString:@"请设置"]) {
    }else
        [dicPara setValue:cell4.rightLabel.text forKey:@"ud_borth"];
    
    if ([cell3.rightLabel.text isEqualToString:@"请设置"]) {
    }else
        [dicPara setValue:cell3.rightLabel.text forKey:@"ud_idcard"];
    
    if ([cell2.rightLabel.text isEqualToString:@"请设置"]) {
    }else
        [dicPara setValue:cell2.rightLabel.text forKey:@"ud_name"];
    
    if ([cell1.rightLabel.text isEqualToString:@"请设置"]) {
    }else
        [dicPara setValue:cell1.rightLabel.text forKey:@"ud_nickname"];

    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithCapacity:5];
    [d setValue:[UserManager getSID] forKey:@"sid"];
    [d setValue:@"" forKey:@"index"];
    [d setValue:@"" forKey:@"uo_long"];
    [d setValue:@"" forKey:@"uo_lat"];
    [d setValue:@"" forKey:@"uo_high"];
    [d setValue:[UserManager getUID] forKey:@"ub_id"];
    [d setValue:dicPara forKey:@"user_detail"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //1.创建URL
    NSString *hosturl = Hosturl;
    NSString *host =  [NSString stringWithFormat:@"%@%@",hosturl,@"/index.php/user/edit"];
    NSURL *url = [NSURL URLWithString:host];
    
    //2.创建请求
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //2.5 核心设置boby
    NSString *bobyString = [self ObjectTojsonString:d];
    
    NSData *postData = [bobyString dataUsingEncoding:NSUTF8StringEncoding];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    [MBProgressHUD gc_showActivityMessageInWindow:@"保存中..."];
    NSURLSessionTask *task = [session dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD gc_hiddenHUD];
        });
        if (error == nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            GCLog(@"=========================%@",dict);
            if ([dict[@"result"][@"code"] isEqualToString:@"10"]) {
                
                @weakify(self);
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5/*延迟执行时间*/ * NSEC_PER_SEC));
                
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    @strongify(self);
                    if (self.seleteBlock) self.seleteBlock();
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    }];
    //6.启动任务
    [task resume];
}

-(NSString*)ObjectTojsonString:(id)object
{
    NSString *jsonString = [[NSString alloc]init];
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted                                                         error:&error];
    
    if (!jsonData) {
        
        NSLog(@"error: %@", error);
        
    } else {
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

@end
