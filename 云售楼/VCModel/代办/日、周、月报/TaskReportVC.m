//
//  TaskReportVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/9/26.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "TaskReportVC.h"

#import "TaskSellReportCell.h"

@interface TaskReportVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSDictionary *_data;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation TaskReportVC

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        _data = data;
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskSellReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskSellReportCell"];
    if (!cell) {
        
        cell = [[TaskSellReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskSellReportCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentL.numberOfLines = 2;
    cell.dataDic = _data;
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = self.tit;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
