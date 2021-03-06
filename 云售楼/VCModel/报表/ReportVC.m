//
//  ReportVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ReportVC.h"

#import "CallCustomReportVC.h"
#import "VisitCustomReportVC.h"
#import "ChannelAnalysisVC.h"
#import "CommissionReportVC.h"
#import "DealCustomerReportVC.h"
#import "ReceiptCountVC.h"
#import "SaleDetailVC.h"
#import "SaleRankVC.h"
#import "MonthCountVC.h"
#import "WeekCountVC.h"
#import "ResourcesAuditVC.h"
#import "RoomReportVC.h"

#import "PowerMannerger.h"
#import "SinglePickView.h"

#import "WorkCell.h"

#import "CompanyAuthVC.h"

@interface ReportVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_imgArr;
    NSArray *_projectArr;
    NSArray *_showArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation ReportVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    if ([UserModel defaultModel].projectinfo) {
//        
//        _table.hidden = NO;
//    }else{
//        
//        _table.hidden = YES;
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionNSNotificationMethod) name:@"reloadCompanyInfo" object:nil];
    
    _titleArr = @[@"来电客户分析表",@"来访客户分析表",@"渠道分析表",@"佣金统计表",@"成交客户分析表",@"销售明细表",@"资源盘点表",@"销售排名表",@"收款统计表",@"销售周汇总表",@"销售月汇总表",@"房源"];
    _imgArr = @[@"report_visit",@"report_visit",@"report_channel",@"report_commission",@"chengjiapfenxi",@"xiangmuhuizong",@"ziyuanpandian",@"xiaoshoupaiming",@"shoukuantongji",@"zhouhuixong",@"yuehuizong",@"xiangmuhuizong"];
    _projectArr = [UserModel defaultModel].project_list;
    _showArr = [PowerModel defaultModel].ReportListPower;
}

- (void)ActionNSNotificationMethod{
    
    [self.rightBtn setTitle:[UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];
    if ([[UserModel defaultModel].projectinfo count]) {
        
        _table.hidden = NO;
        self.rightBtn.hidden = NO;
        [PowerMannerger RequestPowerByprojectID:[UserModel defaultModel].projectinfo[@"project_id"] success:^(NSString * _Nonnull result) {
            if ([result isEqualToString:@"获取权限成功"]) {
                self->_showArr = [PowerModel defaultModel].ReportListPower;
                [self->_table reloadData];
//                [self RequestMethod];
            }
        } failure:^(NSString * _Nonnull error) {
            [self showContent:error];
        }];
    }else{
        
        _table.hidden = YES;
        self.rightBtn.hidden = YES;;
    }
}


- (void)ActionGoBtn:(UIButton *)btn{
    
    CompanyAuthVC *nextVC = [[CompanyAuthVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    NSMutableArray *temparr = [@[] mutableCopy];
    for (int i = 0; i < [_projectArr count]; i++) {
        
        NSDictionary *dic = @{@"id":[NSString stringWithFormat:@"%d",i],
                              @"param":_projectArr[i][@"project_name"]
                              };
        [temparr addObject:dic];
        
    }
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:temparr];
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        [self.rightBtn setTitle:MC forState:UIControlStateNormal];
        [UserModel defaultModel].projectinfo =  [UserModel defaultModel].project_list[[ID integerValue]];
        [UserModelArchiver archive];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCompanyInfo" object:nil];
        [PowerMannerger RequestPowerByprojectID:[UserModel defaultModel].projectinfo[@"project_id"] success:^(NSString * _Nonnull result) {
            if ([result isEqualToString:@"获取权限成功"]) {
                self->_showArr = [PowerModel defaultModel].ReportListPower;
                [self->_table reloadData];
            }
        } failure:^(NSString * _Nonnull error) {
            [self showContent:error];
        }];
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < _showArr.count) {
        
        if ([_showArr[indexPath.row] integerValue] == 1) {
            
            return UITableViewAutomaticDimension;
        }else{
            
            return 0;
        }
    }else{
        
        return UITableViewAutomaticDimension;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkCell"];
    if (!cell) {
        
        cell = [[WorkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WorkCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleL.text = _titleArr[indexPath.row];
    cell.headImg.image = IMAGE_WITH_NAME(_imgArr[indexPath.row]);
    if (indexPath.row < _showArr.count) {
        
        if ([_showArr[indexPath.row] integerValue] == 1) {
            
            cell.hidden = NO;
        }else{
            
            cell.hidden = YES;
        }
    }else{
        
         cell.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        CallCustomReportVC *nextVC = [[CallCustomReportVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 1) {
        
        VisitCustomReportVC *nextVC = [[VisitCustomReportVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(indexPath.row == 2){
        
        ChannelAnalysisVC *nextVC = [[ChannelAnalysisVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        nextVC.status = @"1";
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(indexPath.row == 3){
        
        CommissionReportVC *nextVC = [[CommissionReportVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(indexPath.row == 4){
        
        DealCustomerReportVC *nextVC = [[DealCustomerReportVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
//        nextVC.status = @"1";
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(indexPath.row == 5){
        
        SaleDetailVC *nextVC = [[SaleDetailVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        //        nextVC.status = @"1";
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(indexPath.row == 6){
        
        ResourcesAuditVC *nextVC = [[ResourcesAuditVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        //        nextVC.status = @"1";
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(indexPath.row == 7){
        
        SaleRankVC *nextVC = [[SaleRankVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(indexPath.row == 8){
        
       ReceiptCountVC *nextVC = [[ReceiptCountVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        //        nextVC.status = @"1";
                [self.navigationController pushViewController:nextVC animated:YES];
    }else if(indexPath.row == 9){
        
        WeekCountVC *nextVC = [[WeekCountVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        //        nextVC.status = @"1";
                [self.navigationController pushViewController:nextVC animated:YES];
    }else if(indexPath.row == 10){
        
        MonthCountVC *nextVC = [[MonthCountVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        //        nextVC.status = @"1";
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        RoomReportVC *nextVC = [[RoomReportVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.leftButton.hidden = YES;
    
    self.titleLabel.text = @"报表";
    self.rightBtn.hidden = NO;
    self.rightBtn.center = CGPointMake(SCREEN_Width - 45 * SIZE, STATUS_BAR_HEIGHT + 20);
    self.rightBtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    [self.rightBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:[UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
//    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
//    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
//        
////        [self RequestMethod];
//    }];
    
    if ([UserModel defaultModel].projectinfo) {
        
        _table.hidden = NO;
    }else{
        
        _table.hidden = YES;
    }
}

@end
