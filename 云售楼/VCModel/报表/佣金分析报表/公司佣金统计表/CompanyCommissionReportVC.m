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

@property (nonatomic, strong) UILabel *moneyL;

@property (nonatomic, strong) UILabel *numL;

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
                
                self->_dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"data"]];
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
        
        cell.contentView.backgroundColor = CLBlueBtnColor;
        cell.codeL.textColor = CLWhiteColor;
        cell.roomL.textColor = CLWhiteColor;
        cell.nameL.textColor = CLWhiteColor;
        cell.phoneL.textColor = CLWhiteColor;
        cell.moneyL.textColor = CLWhiteColor;
        cell.typeL.textColor = CLWhiteColor;
        cell.ruleL.textColor = CLWhiteColor;
        cell.timeL.textColor = CLWhiteColor;
        
        cell.line1.hidden = YES;
        cell.line2.hidden = YES;
        cell.line3.hidden = YES;
        cell.line4.hidden = YES;
        cell.line5.hidden = YES;
        cell.line6.hidden = YES;
        cell.line7.hidden = YES;
        
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
        
        cell.contentView.backgroundColor = CLWhiteColor;
        cell.codeL.textColor = CL86Color;
        cell.roomL.textColor = CL86Color;
        cell.nameL.textColor = CL86Color;
        cell.phoneL.textColor = CL86Color;
        cell.moneyL.textColor = CL86Color;
        cell.typeL.textColor = CL86Color;
        cell.ruleL.textColor = CL86Color;
        cell.timeL.textColor = CL86Color;
        
        cell.line1.hidden = NO;
        cell.line2.hidden = NO;
        cell.line3.hidden = NO;
        cell.line4.hidden = NO;
        cell.line5.hidden = NO;
        cell.line6.hidden = NO;
        cell.line7.hidden = NO;
        
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
    
//    self.view.backgroundColor = COLOR(119, 185, 213, 1);
    self.view.backgroundColor = CLWhiteColor;
    
    _moneyL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 10 *SIZE + NAVIGATION_BAR_HEIGHT, 160 *SIZE, 20 *SIZE)];
    _moneyL.textColor = CL86Color;
    _moneyL.font = [UIFont systemFontOfSize:14 *SIZE];
    _moneyL.text = [NSString stringWithFormat:@"累计金额：%@",self.money];
    [self.view addSubview:_moneyL];
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(190 *SIZE, 10 *SIZE + NAVIGATION_BAR_HEIGHT, 160 *SIZE, 20 *SIZE)];
    _numL.textColor = CL86Color;
    _numL.font = [UIFont systemFontOfSize:14 *SIZE];
    _numL.text = [NSString stringWithFormat:@"累计笔数：%@",self.num];
    [self.view addSubview:_numL];
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE)];
    _scroll.delegate = self;
    _scroll.bounces = NO;
    [_scroll setContentSize:CGSizeMake(120 *SIZE * 8 - 40 *SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE)];
    [self.view addSubview:_scroll];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE * 8 - 40 *SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE) style:UITableViewStylePlain];
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

    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{

        [self RequestAddMethod];
    }];
}

@end
