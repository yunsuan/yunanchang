//
//  MultiVisitReportVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/10.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "MultiVisitReportVC.h"

#import "VisitCustomHeader.h"
#import "VisitCustomReportCell.h"

@interface MultiVisitReportVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _percent;
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation MultiVisitReportVC

- (instancetype)initWithDataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _dataArr = [[NSMutableArray alloc] initWithArray:dataArr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];

}

- (void)initDataSource{
    
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 280 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    VisitCustomHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"VisitCustomHeader"];
    if (!header) {
        
        header = [[VisitCustomHeader alloc] initWithReuseIdentifier:@"VisitCustomHeader"];
    }
    
    //    header.dataArr = _dataArr;
    header.header.titleL.text = [NSString stringWithFormat:@"%@-%@",@"客户来源",self.titleStr];
    header.approachArr = _dataArr;
    
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
    
    cell.approachDic = _dataArr[indexPath.row];
    
    _percent = 0;
    for (int i = 0; i < [_dataArr count]; i++) {
        
        _percent = _percent + [_dataArr[i][@"count"] integerValue];
    }
    if ([_dataArr[indexPath.row][@"count"] integerValue] == 0) {
        
        cell.percentL.text = @"占比：0%";
    }else{
        
        cell.percentL.text = [NSString stringWithFormat:@"占比：%.2f%@",[_dataArr[indexPath.row][@"count"] floatValue] / _percent * 100,@"%"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@",self.titleStr,@"分析表"];
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
