//
//  WeekCountVC.m
//  云售楼
//
//  Created by xiaoq on 2019/10/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WeekCountVC.h"

@interface WeekCountVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UITableView *table;

@end

@implementation WeekCountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
    
}


- (void)initDataSource{
    
   
}

- (void)RequestMethod{
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 40 *SIZE;
    }
    
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    if (indexPath.row == 0) {
//
//        cell.contentView.backgroundColor = CLBlueBtnColor;
//        cell.companyL.textColor = CLWhiteColor;
//        cell.contactL.textColor = CLWhiteColor;
//        cell.phoneL.textColor = CLWhiteColor;
//        cell.moneyL.textColor = CLWhiteColor;
//        cell.numL.textColor = CLWhiteColor;
//
//        cell.line1.hidden = YES;
//        cell.line2.hidden = YES;
//        cell.line3.hidden = YES;
//        cell.line4.hidden = YES;
//
//
//        cell.companyL.text = @"乙方公司";
//        cell.contactL.text = @"乙方负责人";
//        cell.phoneL.text = @"乙方联系电话";
//        cell.moneyL.text = @"累计金额（￥）";
//        cell.numL.text = @"累计笔数";
//    }else{
//
//        cell.contentView.backgroundColor = CLWhiteColor;
//        cell.companyL.textColor = CL86Color;
//        cell.contactL.textColor = CL86Color;
//        cell.phoneL.textColor = CL86Color;
//        cell.moneyL.textColor = CLBlueBtnColor;
//        cell.numL.textColor = CL86Color;
//
//        cell.line1.hidden = NO;
//        cell.line2.hidden = NO;
//        cell.line3.hidden = NO;
//        cell.line4.hidden = NO;
//
//        cell.companyL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"sell_company_name"]];
//        cell.contactL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"sell_docker"]];
//        cell.phoneL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"sell_docker_tel"]];
//        cell.moneyL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"broker_num"]];
//        cell.numL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"count"]];
//    }
//
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
    
    self.titleLabel.text = @"销售周汇总表";
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scroll.delegate = self;
    _scroll.bounces = NO;
    [_scroll setContentSize:CGSizeMake(120 *SIZE * 3, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:_scroll];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE * 3, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 40 *SIZE;
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
