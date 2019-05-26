//
//  WorkRecommendValidVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkRecommendValidVC.h"

#import "WorkRecommendValidDetailVC.h"
#import "SignNeedInfoVC.h"
#import "SignListVC.h"

#import "WorkRecommendValidCell.h"

@interface WorkRecommendValidVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}

@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation WorkRecommendValidVC

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
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:ButterValue_URL parameters:dic success:^(id resposeObject) {
        
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
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(_page)}];
    if (![self isEmpty:self.search]) {
        
        [dic setObject:self.search forKey:@"search"];
    }
    [BaseRequest GET:ButterValue_URL parameters:dic success:^(id resposeObject) {
        
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"WorkRecommendValidCell";
    
    WorkRecommendValidCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[WorkRecommendValidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.confirmBtn.hidden = YES;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.workRecommendValidCellBlock = ^(NSInteger index) {
        
        if ([_dataArr[index][@"tel_complete_state"] integerValue] <= 2) {
            
            NSString *phone = [_dataArr[index][@"tel"] componentsSeparatedByString:@","][0];
            if (phone.length) {
                
                //获取目标号码字符串,转换成URL
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                //调用系统方法拨号
                [[UIApplication sharedApplication] openURL:url];
            }else{
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
            }
        }else{
            
            
        }
    };
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WorkRecommendValidDetailVC *nextVC = [[WorkRecommendValidDetailVC alloc] initWithClientId:_dataArr[indexPath.row][@"client_id"]];
//    if (_dataArr[indexPath.row][@"need_confirm"]) {
//
//        nextVC.needConfirm = _dataArr[indexPath.row][@"need_confirm"];
//    }else{
//
//        nextVC.needConfirm = @"1";
//    }
    
    [self.navigationController pushViewController:nextVC animated:YES];
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
        _MainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 81 *SIZE) style:UITableViewStylePlain];
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
