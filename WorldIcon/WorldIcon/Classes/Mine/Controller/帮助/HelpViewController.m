//
//  HelpViewController.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2017/12/22.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "HelpViewController.h"
#import <WebKit/WebKit.h>
@interface HelpViewController ()<UINavigationBarDelegate, UIWebViewDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) NSString *url;
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navLabel.text = @"帮助";
    self.url = @"http://vm.lchtime.com/index.php/system/help";
    CGRect bounds = self.view.frame;
    bounds.size.height -= 64;
    _webView = [[WKWebView alloc] initWithFrame:bounds];
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    if (self.url.length > 0) {
        [self loadExamplePage:_webView];
    }
}

#pragma mark - WKNavigationDelegate 页面加载
#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中"];
}

#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
}

#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"加载完成");
    [MBProgressHUD gc_hiddenHUD];
//    [MBProgressHUD hideHUDForView:GCKeyWindow animated:YES];
}

#pragma mark 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
//    [MBProgressHUD hideHUDForView:GCKeyWindow animated:YES];
    [MBProgressHUD gc_showErrorMessage:@"加载失败"];
    [MBProgressHUD gc_hiddenHUD];
}


- (void)loadExamplePage:(WKWebView*)webView {
    //_webView.navigationDelegate = self;
    if([self.url hasPrefix:@"http"])//判断是否为一个url
    {
        NSString *requestUrlStr = [NSString stringWithFormat:@"%@",self.url];
        requestUrlStr = [requestUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString: requestUrlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
    }else//不是url
    {
        [webView  loadHTMLString:self.url baseURL:nil];
    }
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
