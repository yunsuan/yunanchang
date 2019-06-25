//
//  CompanyCommissionReportVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CompanyCommissionReportVC.h"

#import "CompanyCommissionReportCell.h"

@interface CompanyCommissionReportVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    
    NSInteger _page;
    
    NSString *_rule_id;
    NSString *_project_id;
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UITableView *table;

@end

@implementation CompanyCommissionReportVC

- (instancetype)initWithRuleId:(NSString *)rule_id project_id:(NSString *)project_id
{
    self = [super init];
    if (self) {
        
        _rule_id = rule_id;
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
    
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    _table.mj_footer.state = MJRefreshStateIdle;
    
    [BaseRequest GET:BrokerCompanyList_URL parameters:@{@"project_id":_project_id,@"rule_id":_rule_id,@"page":@(_page)} success:^(id  _Nonnull resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            [self->_table reloadData];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                self->_dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
                self->_table.mj_footer.state = MJRefreshStateIdle;
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
            [self->_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self->_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    _table.mj_footer.state = MJRefreshStateIdle;
    
    [BaseRequest GET:BrokerCompanyList_URL parameters:@{@"project_id":_project_id,@"rule_id":_rule_id,@"page":@(_page)} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                self->_table.mj_footer.state = MJRefreshStateIdle;
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }
        else{
            
            self->_page -= 1;
            [self->_table.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        self->_page -= 1;
        [self->_table.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetUnComfirmArr:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    
    [_table reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompanyCommissionReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyCommissionReportCell"];
    if (!cell) {
        
        cell = [[CompanyCommissionReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CompanyCommissionReportCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        cell.codeL.text = @"推荐编号";
        cell.roomL.text = @"房间号";
        cell.nameL.text = @"经纪人姓名";
        cell.phoneL.text = @"联系电话";
        cell.moneyL.text = @"累计金额（￥）";
//        cell.numL.text = @"累计笔数";
        cell.typeL.text = @"佣金类型";
        cell.ruleL.text = @"计算规则";
        cell.timeL.text = @"时间";
    }else{
        
        cell.codeL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"client_id"]];
        cell.roomL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"house_info"]];
        cell.nameL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"name"]];
        cell.phoneL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"tel"]];
        cell.moneyL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"broker_num"]];
        cell.typeL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"broker_type"]];
        cell.ruleL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"commission_way"]];
        cell.timeL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"create_time"]];
    }
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"公司佣金统计表";
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scroll.delegate = self;
    [_scroll setContentSize:CGSizeMake(120 *SIZE * 8, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:_scroll];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE * 8, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 40 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [_scroll addSubview:_table];
    
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        [self RequestMethod];
    }];

    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{

        [self RequestAddMethod];
    }];
}

@end
