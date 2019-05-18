//
//  SignListVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SignListVC.h"

//#import "BrokerageDetailTableCell3.h"
#import "SignListCell.h"

@interface SignListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation SignListVC

- (instancetype)initWithDataArr:(NSArray *)data
{
    self = [super init];
    if (self) {
        
        _dataArr = [@[] mutableCopy];
        _dataArr = [NSMutableArray arrayWithArray:data];
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
    
    SignListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SignListCell"];
    if (!cell) {
        
        cell = [[SignListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SignListCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        cell.upLine.hidden = YES;
    }else{
        
        cell.upLine.hidden = NO;
    }
    
    if (indexPath.row == _dataArr.count - 1) {
        
        cell.downLine.hidden = YES;
    }else{
        
        cell.downLine.hidden = NO;
    }
    
    cell.titleL.text = _dataArr[indexPath.row][@"group_name"];
    cell.nameL.text = [NSString stringWithFormat:@"%@/%@",_dataArr[indexPath.row][@"sign_agent_name"],_dataArr[indexPath.row][@"sign_agent_tel"]];
    if ([_dataArr[indexPath.row][@"state"] integerValue] == 2) {
        
        cell.timeL.text = @"签字时间：";
    }else{
        
        cell.timeL.text = [NSString stringWithFormat:@"签字时间：%@",_dataArr[indexPath.row][@"create_time"]];
    }
    cell.statusL.text = _dataArr[indexPath.row][@"state_name"];
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"确认流程";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    
    [self.view addSubview:_table];
}

@end
