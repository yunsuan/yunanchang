//
//  DealCustomerReportPropertyVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/24.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "DealCustomerReportPropertyVC.h"

#import "BaseHeader.h"
#import "DealCustomerReportPropertyDetailCell.h"

@interface DealCustomerReportPropertyVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSDictionary *_dataDic;
    
}
@property (nonatomic, strong) UITableView *table;
@end

@implementation DealCustomerReportPropertyVC

- (instancetype)initWithDataDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _dataDic = dataDic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_dataDic[@"list"] count];;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 240 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
                
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
            
    header.titleL.text = _dataDic[@"list"][section][@"select_name"];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DealCustomerReportPropertyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealCustomerReportPropertyDetailCell"];
    if (!cell) {
                        
        cell = [[DealCustomerReportPropertyDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DealCustomerReportPropertyDetailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
    cell.dataDic =  _dataDic[@"list"][indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row == 0) {
//
//    }else{
//
//        CompanyCommissionReportVC *nextVC = [[CompanyCommissionReportVC alloc] initWithRuleId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"rule_id"]] project_id:_project_id];
//        nextVC.money = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"broker_num"]];;
//        nextVC.num = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"count"]];
//        [self.navigationController pushViewController:nextVC animated:YES];
//    }
}

- (void)initUI{
    
    self.titleLabel.text = _dataDic[@"property_name"];
    
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
