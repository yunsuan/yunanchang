//
//  ChannelRankListVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelRankListVC.h"

#import "ChannelRankListCell.h"

@interface ChannelRankListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation ChannelRankListVC

- (instancetype)initWithDataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _dataArr = dataArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChannelRankListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelRankListCell"];
    if (!cell) {
        
        cell = [[ChannelRankListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChannelRankListCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.rankL.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    cell.titleL.text = _dataArr[indexPath.row][@"name"];
    cell.contentL.text = [NSString stringWithFormat:@"推荐客户%@ 到访客户%@ 成交客户%@",_dataArr[indexPath.row][@"recommendNum"],_dataArr[indexPath.row][@"visitNum"],_dataArr[indexPath.row][@"dealNum"]];
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = self.titleStr;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
