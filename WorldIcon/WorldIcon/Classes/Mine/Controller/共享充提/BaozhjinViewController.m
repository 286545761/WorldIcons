//
//  BaozhjinViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/24.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BaozhjinViewController.h"
#import "BaozhjinView.h"
#import "SubbzjRequest.h"
#import "SRActionSheet.h"
#import "WSDatePickerView.h"

@interface BaozhjinViewController ()

@property (nonatomic,strong) BaozhjinView *bzjView;

@property (nonatomic,strong)NSMutableArray *mbCardsArray;
@property (nonatomic,strong)NSMutableArray *myCardsArray;

@end

@implementation BaozhjinViewController

-(NSMutableArray *)mbCardsArray{
    if (!_mbCardsArray) {
        _mbCardsArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _mbCardsArray;
}
-(NSMutableArray *)myCardsArray{
    if (!_myCardsArray) {
        _myCardsArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _myCardsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"提交保证金";

    self.bzjView = [[BaozhjinView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    self.bzjView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bzjView];
    
    self.mbCardsArray = @[@"78978967956",@"0976678956975"].mutableCopy;
    self.myCardsArray = @[@"78978967956",@"0976678956975"].mutableCopy;
    
    //汇款目标账号
    @weakify(self);
    self.bzjView.mbzhBlock = ^(){
        @strongify(self);
        NSLog(@"账号选择");
        
        [SRActionSheet sr_showActionSheetViewWithTitle:@"选择目标账号"
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:@""
                                     otherButtonTitles:self.mbCardsArray
                                      selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger actionIndex) {
                                          if (actionIndex == -1) {
                                              
                                          }else{
                                              self.bzjView.hkmbLabel.field.text = self.mbCardsArray[actionIndex];
                                          }
                                      }];

        
    };
    //时间选择
    
    self.bzjView.timeBlock = ^(){
        @strongify(self);

        NSLog(@"时间选择");
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowMonthDayHourMinute CompleteBlock:^(NSDate *startDate) {
            NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            
            self.bzjView.hktimeLabel.field.text =date;
            
        }];
        datepicker.doneButtonColor = [UIColor gc_colorWithHexString:@"#e1ad34"];//确定按钮的颜色
        [datepicker show];
    };
    
    self.bzjView.zhBlock = ^(){
    
        @strongify(self);
        NSLog(@"账号选择");
        
        [SRActionSheet sr_showActionSheetViewWithTitle:@"选择账号"
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:@""
                                     otherButtonTitles:self.myCardsArray
                                      selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger actionIndex) {
                                          if (actionIndex == -1) {
                                              
                                          }else{
                                              self.bzjView.hkLabel.field.text = self.myCardsArray[actionIndex];
                                          }
                                      }];

    
    };
    
    
    //汇款截图
    self.bzjView.tapBlock = ^(){
    
        NSLog(@"汇款截图");
    };
    
    //提交
    self.bzjView.sumlimtBlock = ^(){
        @strongify(self);

        NSLog(@"提交");
        [self sendBaozhjin];
    };
}
-(void)sendBaozhjin{

    [MBProgressHUD gc_showActivityMessageInWindow:@"提交中..."];

    SubbzjRequest *subbzjReq = [SubbzjRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
            
            [MBProgressHUD gc_showSuccessMessage:@"保证金提交成功"];
            
            @weakify(self);
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                @strongify(self);
                [self.navigationController popViewControllerAnimated:YES];
            });

            
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    subbzjReq.ub_id = [UserManager getUID];
    subbzjReq.vb_bzj = self.bzjView.hkjeLabel.field.text;
    subbzjReq.vb_pic = @"";
    subbzjReq.vb_info = [NSString stringWithFormat:@"%@%@%@%@",self.bzjView.hkLabel.field.text,self.bzjView.hkmbLabel.field.text,self.bzjView.hkjeLabel.field.text,self.bzjView.hktimeLabel.field.text];//本人汇款账号+汇款目标账号+汇款金额+汇款时间
    
    [subbzjReq startRequest];

}
@end
