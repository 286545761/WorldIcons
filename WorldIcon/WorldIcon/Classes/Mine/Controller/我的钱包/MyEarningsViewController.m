//
//  MyEarningsViewController.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/2/6.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "MyEarningsViewController.h"
typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshHeadType = 1,  // 下拉
    RefreshFootType = 2,  // 上拉
    RefreshNoneType = 3   // 第一次加载
};
@interface MyEarningsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
//页码
@property (nonatomic,strong)NSString *page;
@end

@implementation MyEarningsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navLabel.text = @"我的收益";
    self.page = @"1";
    [self.view addSubview:self.tableView];
}

#pragma mark -- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [UIView countBeforeWithIphone5Length:35];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 35)];
    back.backgroundColor = KBackgroundColor;
    
    UILabel *oneL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 10, 320.0f/3, 15)];
    oneL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    oneL.font = [UIFont boldSystemFontOfSize:15];
    oneL.text = @"下线";
    oneL.textAlignment = NSTextAlignmentCenter;
    [back addSubview:oneL];
    
    UILabel *twoL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(oneL.adaptiveIphone5Frame.size.width, 10, 320.0f/3, 15)];
    twoL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    twoL.font = [UIFont boldSystemFontOfSize:15];
    twoL.text = @"数量";
    twoL.textAlignment = NSTextAlignmentCenter;
    [back addSubview:twoL];
    
    UILabel *threeL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(twoL.adaptiveIphone5Frame.size.width+twoL.adaptiveIphone5Frame.origin.x, 10, 320.0f/3, 15)];
    threeL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    threeL.font = [UIFont boldSystemFontOfSize:15];
    threeL.text = @"单位";
    threeL.textAlignment = NSTextAlignmentCenter;
    [back addSubview:threeL];
    return back;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect rect = self.view.bounds;
        rect.size.height -= 64;
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
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
