//
//  ChannelDealVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelDealVC.h"

#import "ChannelDealCell.h"

@interface ChannelDealVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}

@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation ChannelDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDateSouce];
    [self initUI];
    [self RequestMethod];
}

-(void)initDateSouce
{
    _page = 1;
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    _page = 1;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page),@"project_id":self.project_id}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    if (self.date.length) {
        
        [dic setObject:self.date forKey:@"startTime"];
        if (self.endTime.length) {
            
            [dic setObject:self.endTime forKey:@"endTime"];
        }
    }
    [BaseRequest GET:ProjectClientDeal_URL parameters:dic success:^(id resposeObject) {
        
        [self->_MainTableView.mj_header endRefreshing];
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            [self->_MainTableView reloadData];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                self->_MainTableView.mj_footer.state = MJRefreshStateIdle;
            }else{
                
                self->_MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self->_MainTableView.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    _page += 1;
    _MainTableView.mj_footer.state = MJRefreshStateIdle;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page),@"project_id":self.project_id}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    if (self.date.length) {
        
        [dic setObject:self.date forKey:@"startTime"];
        if (self.endTime.length) {
            
            [dic setObject:self.endTime forKey:@"endTime"];
        }
    }
    [BaseRequest GET:ProjectClientDeal_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetUnComfirmArr:resposeObject[@"data"][@"data"]];
                self->_MainTableView.mj_footer.state = MJRefreshStateIdle;
            }else{
                
                self->_MainTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }
        else{
            
            self->_page -= 1;
            [self->_MainTableView.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        self->_page -= 1;
        [self->_MainTableView.mj_footer endRefreshing];
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
    
    [_MainTableView reloadData];
}

#pragma mark  ---  delegate   ---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 6 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ChannelDealCell";
    
    ChannelDealCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ChannelDealCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.section];
    
    cell.tag = indexPath.section;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    WorkRecommendWaitDetailVC *nextVC = [[WorkRecommendWaitDetailVC alloc] initWithString:_dataArr[indexPath.row][@"client_id"]];
    //    if (_dataArr[indexPath.row][@"need_confirm"]) {
    //
    //        nextVC.needConfirm = _dataArr[indexPath.row][@"need_confirm"];
    //    }else{
    //
    //        nextVC.needConfirm = @"1";
    //    }
    //
    //    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)initUI
{
    
    //    if ([[UserModel defaultModel].agent_identity integerValue] ==1) {
    //        self.rightBtn.hidden = NO;
    //    }else{
    //        self.rightBtn.hidden = YES;
    //    }
    
    [self.view addSubview:self.MainTableView];
}


-(UITableView *)MainTableView
{
    if(!_MainTableView)
    {
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 81 *SIZE) style:UITableViewStyleGrouped];
        _MainTableView.backgroundColor = CLBackColor;
        _MainTableView.rowHeight = UITableViewAutomaticDimension;
        _MainTableView.estimatedRowHeight = 130 *SIZE;
        _MainTableView.delegate = self;
        _MainTableView.dataSource = self;
        [_MainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _MainTableView.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
            
            [self RequestMethod];
        }];
        
        _MainTableView.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
            
            [self RequestAddMethod];
        }];
    }
    return _MainTableView;
}

@end
