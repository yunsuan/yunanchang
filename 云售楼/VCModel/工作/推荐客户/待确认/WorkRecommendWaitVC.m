
//
//  WorkRecommendWaitVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkRecommendWaitVC.h"

#import "WorkRecommendWaitDetailVC.h"
#import "WorkCompleteCustomVC1.h"

#import "WorkRecommendWaitCell.h"

#import "InvalidView.h"
#import "SignSelectWorkerView.h"
#import "SignFailView.h"

@interface WorkRecommendWaitVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSInteger _page;
}

@property (nonatomic , strong) UITableView *MainTableView;

@end

@implementation WorkRecommendWaitVC

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
    [BaseRequest GET:ButterWaitConfirm_URL parameters:dic success:^(id resposeObject) {

        [self->_MainTableView.mj_header endRefreshing];
        
        if ([resposeObject[@"code"] integerValue] == 200) {
        
            [self->_dataArr removeAllObjects];
            [self->_MainTableView reloadData];
            if ([resposeObject[@"data"] count]) {
        
                [self SetUnComfirmArr:resposeObject[@"data"]];
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
    [BaseRequest GET:ButterWaitConfirm_URL parameters:dic success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] count]) {
                
                [self SetUnComfirmArr:resposeObject[@"data"]];
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
    
    static NSString *CellIdentifier = @"WorkRecommendWaitCell";
    
    WorkRecommendWaitCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[WorkRecommendWaitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.tag = indexPath.row;
    
    cell.workRecommendWaitCellBlock = ^(NSInteger index) {
        
//        WorkCompleteCustomVC1 *nextVC = [[WorkCompleteCustomVC1 alloc] init];
//        [self.navigationController pushViewController:nextVC animated:YES];
        if ([self->_dataArr[index][@"need_confirm"] integerValue] == 1) {

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"签字确认" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            }];

            UIAlertAction *valid = [UIAlertAction actionWithTitle:@"客户有效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
                [BaseRequest GET:AgentSignNextAgent_URL parameters:@{@"client_id":self->_dataArr[index][@"client_id"]} success:^(id resposeObject) {

                    NSLog(@"%@",resposeObject);
                    if ([resposeObject[@"code"] integerValue] == 200) {

                        if ([resposeObject[@"data"][@"agentGroup"] count]) {

                            SignSelectWorkerView *view = [[SignSelectWorkerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                            __strong __typeof(&*view)strongView = view;
                            view.dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"agentGroup"]];
                            view.signSelectWorkerViewBlock = ^{

                                NSMutableDictionary *dic;
                                if (![self isEmpty:strongView.markTV.text]) {

                                    dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[index][@"client_id"],@"agent_id":view.agentId,@"comment":view.markTV.text}];
                                }else{

                                    dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[index][@"client_id"],@"agent_id":view.agentId}];
                                }
                                [BaseRequest GET:AgentSignValue_URL parameters:dic success:^(id resposeObject) {

                                    NSLog(@"%@",resposeObject);
                                    if ([resposeObject[@"code"] integerValue] == 200) {

                                        [self showContent:resposeObject[@"msg"]];
                                        [self RequestMethod];
                                    }else{

                                        [self showContent:resposeObject[@"msg"]];
                                    }
                                } failure:^(NSError *error) {

                                    [self showContent:@"网络错误"];
                                }];
                            };
                            [[UIApplication sharedApplication].keyWindow addSubview:view];
                        }else{

                            [BaseRequest GET:AgentSignValue_URL parameters:@{@"client_id":self->_dataArr[index][@"client_id"]} success:^(id resposeObject) {

                                NSLog(@"%@",resposeObject);
                                if ([resposeObject[@"code"] integerValue] == 200) {

                                    [self showContent:resposeObject[@"msg"]];
                                    [self RequestMethod];
                                }else{

                                    [self showContent:resposeObject[@"msg"]];
                                }
                            } failure:^(NSError *error) {

                                [self showContent:@"网络错误"];
                            }];
                        }
                    }else{

                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {

                    [self showContent:@"网络错误"];
                }];
            }];

            UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"客户无效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
                SignFailView *view = [[SignFailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];

                __strong __typeof(&*view)strongView = view;
                view.signFailViewBlock = ^{

                    NSMutableDictionary *dic;
                    if (![self isEmpty:strongView.markTV.text]) {

                        dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[index][@"client_id"],@"disabled_state":view.agentId,@"comment":view.markTV.text}];
                    }else{

                        dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[index][@"client_id"],@"disabled_state":view.agentId}];
                    }
                    [BaseRequest GET:AgentSignDisabled_URL parameters:dic success:^(id resposeObject) {

                        NSLog(@"%@",resposeObject);
                        if ([resposeObject[@"code"] integerValue] == 200) {

                            [self showContent:resposeObject[@"msg"]];
                            [self RequestMethod];
                        }else{

                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError *error) {

                        [self showContent:@"网络错误"];
                    }];
                };
                [[UIApplication sharedApplication].keyWindow addSubview:view];
            }];

            [alert addAction:valid];
            [alert addAction:invalid];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{

            }];
        }else{

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认到访" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            }];

            UIAlertAction *valid = [UIAlertAction actionWithTitle:@"已到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                NSDictionary *dic = self->_dataArr[index];
                WorkCompleteCustomVC1 *nextVC = [[WorkCompleteCustomVC1 alloc] initWithClientID:dic[@"client_id"] name:dic[@"name"] dataDic:dic];
                [self.navigationController pushViewController:nextVC animated:YES];
            }];

            UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"未到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                InvalidView * invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                invalidView.client_id = self->_dataArr[indexPath.row][@"client_id"];
                invalidView.invalidViewBlock = ^(NSDictionary *dic) {

                    [BaseRequest POST:ConfirmDisabled_URL parameters:dic success:^(id resposeObject) {

                        if ([resposeObject[@"code"] integerValue] == 200) {

                            [self alertControllerWithNsstring:@"失效确认成功" And:@""];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];

                        }else{

                            [self alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError *error) {

                        [self alertControllerWithNsstring:@"温馨提示" And:@"操作失败" WithDefaultBlack:^{

                        }];
                    }];
                };

                invalidView.invalidViewBlockFail = ^(NSString *str) {

                    [self alertControllerWithNsstring:@"温馨提示" And:str];
                };
                [[UIApplication sharedApplication].keyWindow addSubview:invalidView];
            }];

            [alert addAction:valid];
            [alert addAction:invalid];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{

            }];
        }
        
    };
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WorkRecommendWaitDetailVC *nextVC = [[WorkRecommendWaitDetailVC alloc] initWithString:_dataArr[indexPath.row][@"client_id"]];
//    if (_dataArr[indexPath.row][@"need_confirm"]) {
//
//        nextVC.needConfirm = _dataArr[indexPath.row][@"need_confirm"];
//    }else{
//
//        nextVC.needConfirm = @"1";
//    }
//
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
