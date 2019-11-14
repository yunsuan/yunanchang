//
//  SaleDetailVC.m
//  云售楼
//
//  Created by xiaoq on 2019/10/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SaleDetailVC.h"

#import "TitleRightBtnHeader.h"
#import "SaleDetailCell.h"

@interface SaleDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    
    NSString *_project_id;
    
    NSMutableArray *_dataArr;
    
    NSMutableDictionary *_dataDic;
}
@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UITableView *table;

@end

@implementation SaleDetailVC

- (instancetype)initWithProjectId:(NSString *)project_id
{
    self = [super init];
    if (self) {
        
        _project_id = project_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}


- (void)initDataSource{
    
    _dataDic = [@{} mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ReportSaleCount_URL parameters:@{@"project_id":_project_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [self->_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
                
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TitleRightBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleRightBtnHeader"];
    if (!header) {
        
        header = [[TitleRightBtnHeader alloc] initWithReuseIdentifier:@"TitleRightBtnHeader"];
    }
    
    if (section == 0) {
        
        header.titleL.text = @"客户信息";
    }else if (section == 1){
        
        header.titleL.text = @"排号信息";
    }else if (section == 2){
        
        header.titleL.text = @"订单信息";
    }else{
        
        header.titleL.text = @"合同信息";
    }
    header.addBtn.hidden = YES;
    header.moreBtn.hidden = YES;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 40 *SIZE;
    }
    
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SaleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaleDetailCell"];
    if (!cell) {
        
        cell = [[SaleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SaleDetailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {

        cell.contentView.backgroundColor = CLBackColor;
        cell.statisticsL.textColor = CLTitleLabColor;
        cell.numL1.textColor = CLTitleLabColor;
        cell.numL2.textColor = CLTitleLabColor;
        cell.numL3.textColor = CLTitleLabColor;
        cell.statisticsL.backgroundColor = CLBackColor;

//        cell.line1.hidden = YES;
//        cell.line2.hidden = YES;
//        cell.line3.hidden = YES;
//        cell.line4.hidden = YES;

        if (indexPath.section == 0) {
            
            cell.statisticsL.text = @"客户统计";
            cell.numL1.text = @"来电个数";
            cell.numL2.text = @"来访个数";
            cell.numL3.text = @"回访个数";
        }else if (indexPath.section == 1){
            
            cell.statisticsL.text = @"排号统计";
            cell.numL1.text = @"排号个数";
            cell.numL2.text = @"排号金额";
            cell.numL3.text = @"排号回款";
        }else if (indexPath.section == 2){
            
            cell.statisticsL.text = @"定单统计";
            cell.numL1.text = @"认购个数";
            cell.numL2.text = @"认购金额";
            cell.numL3.text = @"认购回款";
        }else{
            
            cell.statisticsL.text = @"合同统计";
            cell.numL1.text = @"合同个数";
            cell.numL2.text = @"合同金额";
            cell.numL3.text = @"合同回款";
        }
    }else{

        cell.contentView.backgroundColor = CLWhiteColor;
        cell.statisticsL.backgroundColor = CLBlueBtnColor;
        cell.statisticsL.textColor = CLWhiteColor;

        if (indexPath.row == 1) {
            
            cell.statisticsL.text = @"今日新增";
        }else if (indexPath.row == 2){
            
            cell.statisticsL.text = @"本月累计";
        }else if (indexPath.row == 3){
            
            cell.statisticsL.text = @"项目累计";
        }
        
        if (self->_dataDic.count) {
            
            if (indexPath.section == 0) {
                
                if (indexPath.row == 1) {
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"client"][@"month"][@"tel"]];
                    cell.numL2.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"client"][@"month"][@"visit"]];
                    cell.numL3.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"client"][@"month"][@"reVisit"]];
                }else if (indexPath.row == 2){
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"client"][@"today"][@"tel"]];
                    cell.numL2.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"client"][@"today"][@"visit"]];
                    cell.numL3.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"client"][@"today"][@"reVisit"]];
                }else{
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"client"][@"total"][@"tel"]];
                    cell.numL2.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"client"][@"total"][@"visit"]];
                    cell.numL3.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"client"][@"total"][@"reVisit"]];
                }
            }else if (indexPath.section == 1){
                
                if (indexPath.row == 1) {
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"row"][@"today"][@"count"]];
                    cell.numL2.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"row"][@"today"][@"down_pay"]];
                    cell.numL3.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"row"][@"today"][@"finance_sum"]];
                }else if (indexPath.row == 2){
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"row"][@"month"][@"count"]];
                    cell.numL2.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"row"][@"month"][@"down_pay"]];
                    cell.numL3.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"row"][@"month"][@"finance_sum"]];
                }else{
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"row"][@"total"][@"count"]];
                    cell.numL2.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"row"][@"total"][@"down_pay"]];
                    cell.numL3.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"row"][@"total"][@"finance_sum"]];
                }
            }else if (indexPath.section == 2){
                
                if (indexPath.row == 1) {
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"sub"][@"today"][@"count"]];
                    cell.numL2.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"sub"][@"today"][@"down_pay"]];
                    cell.numL3.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"sub"][@"today"][@"finance_sum"]];
                }else if (indexPath.row == 2){
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"sub"][@"month"][@"count"]];
                    cell.numL2.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"sub"][@"month"][@"down_pay"]];
                    cell.numL3.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"sub"][@"month"][@"finance_sum"]];
                }else{
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"sub"][@"total"][@"count"]];
                    cell.numL2.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"sub"][@"total"][@"down_pay"]];
                    cell.numL3.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"sub"][@"total"][@"finance_sum"]];
                }
            }else{
                
                if (indexPath.row == 1) {
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"contract"][@"today"][@"count"]];
                    cell.numL2.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"contract"][@"today"][@"down_pay"]];
                    cell.numL3.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"contract"][@"today"][@"finance_sum"]];
                }else if (indexPath.row == 2){
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"contract"][@"month"][@"count"]];
                    cell.numL2.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"contract"][@"month"][@"down_pay"]];
                    cell.numL3.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"contract"][@"month"][@"finance_sum"]];
                }else{
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"contract"][@"total"][@"count"]];
                    cell.numL2.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"contract"][@"total"][@"down_pay"]];
                    cell.numL3.text = [NSString stringWithFormat:@"%@",self->_dataDic[@"contract"][@"total"][@"finance_sum"]];
                }
            }
        }else{
            
            cell.numL1.text = @"0";
            cell.numL2.text = @"0";
            cell.numL3.text = @"0";
        }
    }

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
    
    self.titleLabel.text = @"销售明细表";
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scroll.delegate = self;
    _scroll.bounces = NO;
    [_scroll setContentSize:CGSizeMake(120 *SIZE * 3, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:_scroll];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE * 3, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 40 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 40 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = CLBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    [_scroll addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
       
        [self RequestMethod];
    }];
}

@end
