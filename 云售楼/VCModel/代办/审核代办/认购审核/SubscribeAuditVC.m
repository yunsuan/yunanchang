//
//  SubscribeAuditVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SubscribeAuditVC.h"

#import "SubScribeAuditDetailVC.h"

#import "AuditTaskCell.h"

@interface SubscribeAuditVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArr;
    NSString *_page;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation SubscribeAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSouce];
    [self initUI];
}

-(void)initDataSouce
{
    _dataArr = @[];
    _page = @"1";
    [self postWithpage:_page];
}

- (void)SearchMethod:(NSNotification *)noti{
    
    //    _content = noti.userInfo[@"content"];
    [self postWithpage:_page];
}

-(void)postWithpage:(NSString *)page{
    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":page,@"type":@"1"}];
    //    [BaseRequest GET:TakeDealAllList_URL parameters:dic success:^(id resposeObject) {
    //        [_table.mj_footer endRefreshing];
    //        [_table.mj_header endRefreshing];
    //        if ([resposeObject[@"code"] integerValue] ==200) {
    //            if ([page integerValue]==1) {
    //                _dataArr = resposeObject[@"data"][@"data"];
    //                if ([resposeObject[@"data"][@"total"] integerValue]==0||[resposeObject[@"data"][@"total"] integerValue]) {
    //                    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //                        _table.mj_footer.state = MJRefreshStateNoMoreData;
    //                    });
    //
    //                }
    //            }else
    //            {
    //                _dataArr = [_dataArr arrayByAddingObjectsFromArray:resposeObject[@"data"][@"data"]];
    //                if ([_page integerValue]>=[resposeObject[@"data"][@"total"] integerValue]) {
    //                    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //                        _table.mj_footer.state = MJRefreshStateNoMoreData;
    //                    });
    //                }
    //            }
    //            [_table reloadData];
    //        }
    //    } failure:^(NSError *error) {
    //
    //    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;//_dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AuditTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AuditTaskCell"];
    if (!cell) {
        
        cell = [[AuditTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AuditTaskCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = @{};
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SubScribeAuditDetailVC *next_vc = [[SubScribeAuditDetailVC alloc]init];
    [self.navigationController pushViewController:next_vc animated:YES];
}

- (void)initUI{
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 120 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _table.mj_header= [GZQGifHeader headerWithRefreshingBlock:^{
    //        _page =@"1";
    //        [self postWithpage:_page];
    //    }];
    //    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
    //        NSInteger i = [_page integerValue];
    //        i++;
    //        [self postWithpage:[NSString stringWithFormat:@"%ld",(long)i]];
    //    }];
    
    [self.view addSubview:_table];
}

@end
