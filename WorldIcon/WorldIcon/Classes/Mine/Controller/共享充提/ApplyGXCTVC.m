//
//  ApplyGXCTVC.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/4.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "ApplyGXCTVC.h"
#import "ApplicatView.h"
#import "SendMsgView.h"
#import "WaitView.h"
#import "ApplicationViewController.h"
@interface ApplyGXCTVC ()

@end

@implementation ApplyGXCTVC

- (void)viewDidLoad {
    self.title = @"共享充提";
    [super viewDidLoad];
    switch ([self.getappDic[@"vm_status"] integerValue]) {
        case 0://申请
            [self test1];
            break;
        case 1://等待审核
            [self test2];
            break;
        case 2://成为共享充提者
            break;
        default:
            break;
    }
}

-(void)test1{
    
    ApplicatView *appliView = [[ApplicatView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    appliView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:appliView];
    appliView.block = ^(){
        ApplicationViewController *applicationVC = [[ApplicationViewController alloc]init];
        [self.navigationController pushViewController:applicationVC animated:YES];
//        SendMsgView *sendView = [[SendMsgView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) withDic:nil];
//        sendView.backgroundColor = [UIColor whiteColor];
//        [self.view  addSubview:sendView];
    };
}

-(void)test2{
    WaitView *waitView = [[WaitView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:waitView];
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
