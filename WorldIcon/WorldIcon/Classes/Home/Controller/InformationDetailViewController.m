//
//  InformationDetailViewController.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/2.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "InformationDetailViewController.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"
@interface InformationDetailViewController ()<UINavigationBarDelegate, UIWebViewDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView * webView;
@end

@implementation InformationDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navLabel.text = @"资讯详情";
    UIImageView *backImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginback"]];
    backImg.frame = self.view.bounds;
    [self.view addSubview:backImg];
    CGRect bounds = self.view.frame;
    bounds.size.height -= 64;
    
    _webView = [[WKWebView alloc] initWithFrame:bounds];
    _webView.navigationDelegate = self;
    [_webView setOpaque:NO];
    [backImg addSubview:_webView];
    if (self.url.length > 0) {
        [self loadExamplePage:_webView];
    }
}

#pragma mark - WKNavigationDelegate 页面加载
#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
//    [MBProgressHUD gc_showErrorMessage:@"加载中..."];
}

#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
}

#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"加载完成");
}

#pragma mark 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [MBProgressHUD gc_showErrorMessage:@"加载失败"];
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
