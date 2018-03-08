//
//  EditBaseInfoViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/24.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "EditBaseInfoViewController.h"
#import "SendMsgView.h"

#import "SubappRequest.h"

@interface EditBaseInfoViewController ()
@property (nonatomic,strong)SendMsgView *sendView;
@end

@implementation EditBaseInfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navLabel.text = @"修改基本信息";
    
    self.sendView = [[SendMsgView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) withDic:self.dic];

    self.sendView.backgroundColor = [UIColor whiteColor];
    
    @weakify(self);
    self.sendView.block = ^(){//提交按钮
        @strongify(self);
        
        [self editBaseInfo];
    };
    
    [self.view addSubview:self.sendView];

    UILabel *tips = [UILabel gc_labelWithTitle:@"提交修改后，需再次审核，请耐心等待" withTextColor:[UIColor gc_colorWithHexString:@"#278090"] withTextFont:15 withTextAlignment:(NSTextAlignmentCenter)];
    [self.view addSubview:tips];
    
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.view).offset(kRatioY6(340));
    }];    
}

-(void)editBaseInfo{

    [MBProgressHUD gc_showActivityMessageInWindow:@"提交中..."];
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    //银行卡
    [paraDic setValue:@"" forKey:@"va_card"];//0 不支持 1支持
    [paraDic setValue:self.sendView.username.field.text forKey:@"va_name"];
    [paraDic setValue:self.sendView.khhAddress.field.text forKey:@"va_khh"];
    [paraDic setValue:self.sendView.cardNumber.field.text forKey:@"va_yhzh"];
    [paraDic setValue:@"" forKey:@"va_swift"];
    [paraDic setValue:@"" forKey:@"va_yhhh"];
    
    //微信
    [paraDic setValue:self.sendView.city forKey:@"va_weixin"];//0 不支持 1支持
    [paraDic setValue:self.sendView.city forKey:@"va_wx_zh"];
    [paraDic setValue:self.sendView.city forKey:@"va_wx_param"];
    
    
    //支付宝
    [paraDic setValue:self.sendView.city forKey:@"va_zhifubao"];//0 不支持 1支持
    [paraDic setValue:self.sendView.city forKey:@"va_zf_zh"];
    [paraDic setValue:self.sendView.city forKey:@"va_zf_name"];
    [paraDic setValue:self.sendView.city forKey:@"va_zf_param"];
    
    
    
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithCapacity:5];
    [d setValue:[UserManager getSID] forKey:@"sid"];
    [d setValue:@"" forKey:@"index"];
    [d setValue:@"" forKey:@"uo_long"];
    [d setValue:@"" forKey:@"uo_lat"];
    [d setValue:@"" forKey:@"uo_high"];
    [d setValue:@"1" forKey:@"type"];//0 提交信息  1 修改信息
    [d setValue:[UserManager getUID] forKey:@"ub_id"];
    
    [d setValue:paraDic forKey:@"vm_application"];
    //1.创建URL
    NSString *hosturl = Hosturl;
    NSString *host =  [NSString stringWithFormat:@"%@%@",hosturl,@"/index.php/gongx/subapp"];
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
    
    NSURLSessionTask *task = [session dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD gc_hiddenHUD];
        });
    
        
        if (error == nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            GCLog(@"=========================%@",dict);
            if ([dict[@"result"][@"code"] isEqualToString:@"10"]) {
                
                @weakify(self);
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
                
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    @strongify(self);
                    [self.navigationController popToRootViewControllerAnimated:YES];
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
