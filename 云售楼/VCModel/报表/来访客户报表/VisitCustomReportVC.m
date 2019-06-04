//
//  VisitCustomReportVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "VisitCustomReportVC.h"

#import "VisitCustomHeader.h"
#import "VisitCustomReportCell.h"

@interface VisitCustomReportVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
}

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UITableView *table;

@end

@implementation VisitCustomReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)valueChanged:(UISegmentedControl *)sender{


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 280 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    VisitCustomHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"VisitCustomHeader"];
    if (!header) {
        
        header = [[VisitCustomHeader alloc] initWithReuseIdentifier:@"VisitCustomHeader"];
    }
    
    header.dataDic = @{};
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VisitCustomReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VisitCustomReportCell"];
    if (!cell) {
        
        cell = [[VisitCustomReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VisitCustomReportCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = @{};
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"来访客户分析表";
    
    _segment = [[UISegmentedControl alloc] initWithItems:[NSMutableArray arrayWithObjects:@"今日统计",@"累计统计", nil]];
    _segment.frame = CGRectMake(80 *SIZE, NAVIGATION_BAR_HEIGHT, 200 *SIZE, 30 *SIZE);
    //添加到视图
    
//    [_segment setTintColor:CLWhiteColor];
//    [_segment setEnabled:NO forSegmentAtIndex:0];
    [_segment setWidth:100 *SIZE forSegmentAtIndex:0];
    [_segment addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:_segment];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 30 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - 30 *SIZE) style:UITableViewStyleGrouped];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}
@end
