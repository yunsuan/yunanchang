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
    
    NSString *_str;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation ChannelRankListVC

- (instancetype)initWithTitleStr:(NSString *)str
{
    self = [super init];
    if (self) {
        
        _str = str;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChannelRankListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelRankListCell"];
    if (!cell) {
        
        cell = [[ChannelRankListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChannelRankListCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.rankL.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    cell.titleL.text = @"大唐房屋";
    cell.contentL.text = @"推荐客户200 到访客户180 成交客户150";
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = _str;
    
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
