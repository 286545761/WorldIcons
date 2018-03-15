//
//  WIMerchantViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WIMerchantViewController.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"
#import "WKWebViewJavascriptBridge.h"
@interface WIMerchantViewController ()<UINavigationBarDelegate,WKNavigationDelegate,UIWebViewDelegate>
@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) WKWebViewJavascriptBridge* bridge;
@end

@implementation WIMerchantViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.url = @"http://vm.lchtime.com/index1.html";
    self.navLabel.text = @"应用";
    if (_bridge) { return; }
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled=YES;
    [self.view addSubview:_webView];
    _bridge=[WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [WKWebViewJavascriptBridge enableLogging];
    [_bridge setWebViewDelegate:self];
    if (self.url.length > 0) {
        [self loadExamplePage:_webView];
    }
    [_bridge callHandler:@"getSID" data:[UserManager getSID] responseCallback:^(id responseData) {
        NSLog(@"fromJS%@",responseData);
    }];
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

- (void)callHandler:(id)sender {
    [_bridge callHandler:@"getSID" data:[UserManager getSID] responseCallback:^(id responseData) {
        NSLog(@"fromJS%@",responseData);
    }];
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


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}


//- (void)loadExamplePage:(UIWebView*)webView {
//    //_webView.navigationDelegate = self;
//    if([self.url hasPrefix:@"http"])//判断是否为一个url
//    {
//        NSString *requestUrlStr = [NSString stringWithFormat:@"%@",self.url];
//        requestUrlStr = [requestUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSURL *url = [NSURL URLWithString: requestUrlStr];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [webView loadRequest:request];
//    }else//不是url
//    {
//        [webView  loadHTMLString:self.url baseURL:nil];
//    }
//}



@end
