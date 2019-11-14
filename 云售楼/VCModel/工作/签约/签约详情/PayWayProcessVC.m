//
//  PayWayProcessVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/13.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "PayWayProcessVC.h"

#import "BaseHeader.h"
#import "ProcessCell.h"

@interface PayWayProcessVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation PayWayProcessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArr[section][@"list"] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.titleL.text = [NSString stringWithFormat:@"%@",self.dataArr[section][@"type"]];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProcessCell"];
    if (!cell) {
        cell = [[ProcessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProcessCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",self.dataArr[indexPath.section][@"list"][indexPath.row][@"name"],self.dataArr[indexPath.section][@"list"][indexPath.row][@"create_time"]];
    if (indexPath.row == 0) {
        
        cell.upLine.hidden = YES;
    }else{
        
        cell.upLine.hidden = NO;
    }
    if (indexPath.row == [self.dataArr[indexPath.section][@"list"] count] - 1) {
        
        cell.downLine.hidden = YES;
    }else{
        
        cell.downLine.hidden = NO;
    }
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"按揭过程";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = CLBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSelectionStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
