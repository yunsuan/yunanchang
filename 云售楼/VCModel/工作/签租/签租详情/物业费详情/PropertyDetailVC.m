//
//  PropertyDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/28.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "PropertyDetailVC.h"

#import "BaseHeader.h"
#import "PropertyDetailCell.h"

@interface PropertyDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;;

@end

@implementation PropertyDetailVC

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
    
    [self initUI];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    double money = 0;
    for (int i = 0; i < self->_dataArr.count; i++) {

        money = [self AddNumber:money num2:[self->_dataArr[i][@"total_rent"] doubleValue]];
    }
    header.titleL.text = [NSString stringWithFormat:@"合计物业费：%.2f元",money];
    
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PropertyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PropertyDetailCell"];
    if (!cell) {
        
        cell = [[PropertyDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PropertyDetailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"物业费详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = CLBackColor;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}
@end
