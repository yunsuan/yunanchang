//
//  TaskVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "TaskVC.h"

#import "FollowRecordVC.h"
#import "CallTelegramCustomDetailVC.h"
#import "VisitCustomDetailVC.h"
#import "WorkPhoneConfrimWaitDetailVC.h"
#import "WorkRecommendWaitDetailVC.h"
#import "WorkCompleteCustomVC1.h"
#import "CompanyAuthVC.h"


#import "TaskCallBackCell.h"
#import "TaskCallFollowCell.h"
#import "TaskTakeLookConfirmCell.h"
#import "TaskSignAuditCell.h"
#import "TaskVisitConfirmCell.h"

#import "InvalidView.h"
#import "SignSelectWorkerView.h"
#import "SignFailView.h"

@interface TaskVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation TaskVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if ([UserModel defaultModel].projectinfo) {
        
        _table.hidden = NO;
    }else{
        
        _table.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
//    _dataArr = [[NSMutableArray alloc] initWithArray:@[@"来电客户",@"来访客户",@"推荐客户",@"审核待办",@"财务待办"]];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HandleGetMessageList_URL parameters:nil success:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        [self->_table.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            if ([resposeObject[@"data"][@"list"] count]) {
                
                [self SetData:resposeObject[@"data"][@"list"]];
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
       
        [self->_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                if ([key isEqualToString:@"signAgent"]) {
                    
                    [dic setObject:@[] forKey:key];
                }else{
                 
                    [dic setObject:@"" forKey:key];
                }
            }else{
                
                if ([key isEqualToString:@"signAgent"]) {
                    
//                    key setObject:<#(nonnull id)#> forKey:<#(nonnull id<NSCopying>)#>
                }else{
                    
                    [dic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                }
            }
        }];
        [_dataArr addObject:dic];
    }
    [_table reloadData];
}


- (void)ActionGoBtn:(UIButton *)btn{
    
    CompanyAuthVC *nextVC = [[CompanyAuthVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 2) {

        TaskCallBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCallBackCell"];
        if (!cell) {
            
            cell = [[TaskCallBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCallBackCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.taskCallBackCellBlock = ^{
            
            FollowRecordVC *nextVC = [[FollowRecordVC alloc] initWithGroupId:self->_dataArr[indexPath.row][@"group_id"]];
            nextVC.info_id = self->_dataArr[indexPath.row][@"info_id"];
            nextVC.status = @"direct";
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;

    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 1){

        TaskCallBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCallBackCell"];
        if (!cell) {
            
            cell = [[TaskCallBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCallBackCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.taskCallBackCellBlock = ^{
            
            FollowRecordVC *nextVC = [[FollowRecordVC alloc] initWithGroupId:self->_dataArr[indexPath.row][@"group_id"]];
            nextVC.info_id = self->_dataArr[indexPath.row][@"info_id"];
            nextVC.status = @"direct";
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;

    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 3){

        TaskTakeLookConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskTakeLookConfirmCell"];
        if (!cell) {
            
            cell = [[TaskTakeLookConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskTakeLookConfirmCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.taskTakeLookConfirmCellConfirmBlock = ^{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认号码" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *unuse = [UIAlertAction actionWithTitle:@"可带看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [BaseRequest GET:ClientTelCheckValue_URL parameters:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"]} success:^(id resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [self->_dataArr removeObjectAtIndex:indexPath.row];
                        [tableView reloadData];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneConfirm" object:nil];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                    [self showContent:@"网络错误"];
                }];
            }];
            
            UIAlertAction *used = [UIAlertAction actionWithTitle:@"不可带看" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [self alertControllerWithNsstring:@"温馨提示" And:@"请仔细核对，一旦确认该号码重复，将无法再次推荐" WithCancelBlack:^{
                    
                } WithDefaultBlack:^{
                    
                    [BaseRequest GET:ClientTelCheckDisabled_URL parameters:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"]} success:^(id resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            [self->_dataArr removeObjectAtIndex:indexPath.row];
                            [tableView reloadData];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"PhoneConfirm" object:nil];
                        }else{
                            
                            [self showContent:resposeObject[@"msg"]];
                        }
                    } failure:^(NSError *error) {
                        
                        [self showContent:@"网络错误"];
                    }];
                }];
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:unuse];
            [alert addAction:used];
            [alert addAction:cancel];
            
            [self.navigationController presentViewController:alert animated:YES completion:^{
                
    
            }];
        };
        
        cell.taskTakeLookConfirmCellCopyBlock = ^{
            
            [self showContent:@"复制成功!"];
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = self->_dataArr[indexPath.row][@"tel"];
        };
        return cell;
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 4){

        TaskSignAuditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskSignAuditCell"];
        if (!cell) {

            cell = [[TaskSignAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskSignAuditCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.taskSignAuditCellCollBlock = ^(NSString * _Nonnull mark) {
            
            [self alertControllerWithNsstring:@"审核备注" And:mark];
        };
        
        cell.taskSignAuditCellBtnBlock = ^{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"签字确认" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *valid = [UIAlertAction actionWithTitle:@"客户有效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [BaseRequest GET:AgentSignNextAgent_URL parameters:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"]} success:^(id resposeObject) {
                    
                    NSLog(@"%@",resposeObject);
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        if ([resposeObject[@"data"][@"agentGroup"] count]) {
                            
                            SignSelectWorkerView *view = [[SignSelectWorkerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                            __strong __typeof(&*view)strongView = view;
                            view.dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"agentGroup"]];
                            view.signSelectWorkerViewBlock = ^{
                                
                                NSMutableDictionary *dic;
                                if (![self isEmpty:strongView.markTV.text]) {
                                    
                                    dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"],@"agent_id":view.agentId,@"comment":view.markTV.text}];
                                }else{
                                    
                                    dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"],@"agent_id":view.agentId}];
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
                            
                            [BaseRequest GET:AgentSignValue_URL parameters:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"]} success:^(id resposeObject) {
                                
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
                        
                        dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"],@"disabled_state":view.agentId,@"comment":view.markTV.text}];
                    }else{
                        
                        dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"],@"disabled_state":view.agentId}];
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
        };
        return cell;
    }else{

        TaskVisitConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskVisitConfirmCell"];
        if (!cell) {
            
            cell = [[TaskVisitConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskVisitConfirmCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.taskVisitConfirmCellBlock = ^{
            
            if ([self->_dataArr[indexPath.row][@"need_confirm"] integerValue] == 1) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"签字确认" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction *valid = [UIAlertAction actionWithTitle:@"客户有效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [BaseRequest GET:AgentSignNextAgent_URL parameters:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"]} success:^(id resposeObject) {
                        
                        NSLog(@"%@",resposeObject);
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            if ([resposeObject[@"data"][@"agentGroup"] count]) {
                                
                                SignSelectWorkerView *view = [[SignSelectWorkerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                                __strong __typeof(&*view)strongView = view;
                                view.dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"agentGroup"]];
                                view.signSelectWorkerViewBlock = ^{
                                    
                                    NSMutableDictionary *dic;
                                    if (![self isEmpty:strongView.markTV.text]) {
                                        
                                        dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"],@"agent_id":view.agentId,@"comment":view.markTV.text}];
                                    }else{
                                        
                                        dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"],@"agent_id":view.agentId}];
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
                                
                                [BaseRequest GET:AgentSignValue_URL parameters:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"]} success:^(id resposeObject) {
                                    
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
                            
                            dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"],@"disabled_state":view.agentId,@"comment":view.markTV.text}];
                        }else{
                            
                            dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_dataArr[indexPath.row][@"client_id"],@"disabled_state":view.agentId}];
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
                    
                    NSDictionary *dic = self->_dataArr[indexPath.row];
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
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:_dataArr[indexPath.row]];
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([key isEqualToString:@"is_read"]) {
            
            [tempDic setObject:@"1" forKey:key];
        }
    }];
    [_dataArr replaceObjectAtIndex:indexPath.row withObject:tempDic];
    [tableView reloadData];
    if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 1) {
        
        CallTelegramCustomDetailVC *nextVC = [[CallTelegramCustomDetailVC alloc] initWithGroupId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"group_id"]]];
        nextVC.project_id = _dataArr[indexPath.row][@"project_id"];
        nextVC.info_id = _dataArr[indexPath.row][@"info_id"];
        nextVC.powerDic = @{@"detail":[NSNumber numberWithBool:true],@"add":[NSNumber numberWithBool:true],@"update":[NSNumber numberWithBool:true],@"giveUp":[NSNumber numberWithBool:true],@"delete":[NSNumber numberWithBool:true],@"follow":[NSNumber numberWithBool:true]};
        [self.navigationController pushViewController:nextVC animated:YES];
//        VisitCustomDetailVC *nextVC = [[VisitCustomDetailVC alloc] initWithGroupId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"group_id"]]];
//        nextVC.project_id = _dataArr[indexPath.row][@"project_id"];
//        nextVC.info_id = _dataArr[indexPath.row][@"info_id"];
//        [self.navigationController pushViewController:nextVC animated:YES];
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 2) {
        
        VisitCustomDetailVC *nextVC = [[VisitCustomDetailVC alloc] initWithGroupId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"group_id"]]];
        nextVC.project_id = _dataArr[indexPath.row][@"project_id"];
        nextVC.info_id = _dataArr[indexPath.row][@"info_id"];
        nextVC.powerDic = @{@"detail":[NSNumber numberWithBool:true],@"add":[NSNumber numberWithBool:true],@"update":[NSNumber numberWithBool:true],@"giveUp":[NSNumber numberWithBool:true],@"delete":[NSNumber numberWithBool:true],@"follow":[NSNumber numberWithBool:true]};
        [self.navigationController pushViewController:nextVC animated:YES];
//        CallTelegramCustomDetailVC *nextVC = [[CallTelegramCustomDetailVC alloc] initWithGroupId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"group_id"]]];
//        nextVC.project_id = _dataArr[indexPath.row][@"project_id"];
//        nextVC.info_id = _dataArr[indexPath.row][@"info_id"];
//        [self.navigationController pushViewController:nextVC animated:YES];
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 3) {
        
        WorkPhoneConfrimWaitDetailVC *nextVC = [[WorkPhoneConfrimWaitDetailVC alloc] initWithClientId:_dataArr[indexPath.row][@"client_id"]];
        nextVC.workPhoneConfrimWaitDetailVCBlock = ^{
            
            [self->_dataArr removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 4) {
        
        WorkRecommendWaitDetailVC *nextVC = [[WorkRecommendWaitDetailVC alloc] initWithString:_dataArr[indexPath.row][@"client_id"]];

        nextVC.needConfirm = _dataArr[indexPath.row][@"need_confirm"];

        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        WorkRecommendWaitDetailVC *nextVC = [[WorkRecommendWaitDetailVC alloc] initWithString:_dataArr[indexPath.row][@"client_id"]];
        nextVC.needConfirm = @"1";
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"待办";
    self.leftButton.hidden = YES;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"清空数据" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    [self.rightBtn setTitleColor:CL86Color forState:UIControlStateNormal];
    self.rightBtn.center = CGPointMake(SCREEN_Width - 40 * SIZE, STATUS_BAR_HEIGHT + 20);
    
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(3 *SIZE, 7 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width - 6 *SIZE, 167 *SIZE)];
    whiteView.backgroundColor = CLWhiteColor;
    whiteView.layer.cornerRadius = 7 *SIZE;
    whiteView.clipsToBounds = YES;
    [self.view addSubview:whiteView];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(151 *SIZE, 36 *SIZE, 57 *SIZE, 57 *SIZE)];
    img.image = IMAGE_WITH_NAME(@"company");
    [whiteView addSubview:img];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 110 *SIZE, SCREEN_Width - 6 *SIZE, 13 *SIZE)];
    label.textColor = CL86Color;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"您目前没有进行公司认证，请先认证公司！";
    [whiteView addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(97 *SIZE, 31 *SIZE + CGRectGetMaxY(whiteView.frame), 167 *SIZE, 40 *SIZE);
    btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [btn addTarget:self action:@selector(ActionGoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"去认证" forState:UIControlStateNormal];
    [btn setBackgroundColor:CLBlueBtnColor];
    btn.layer.cornerRadius = 3 *SIZE;
    btn.clipsToBounds = YES;
    [self.view addSubview:btn];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = CLLineColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
       
        [self RequestMethod];
    }];
    [self.view addSubview:_table];
    if ([UserModel defaultModel].projectinfo) {
        
        _table.hidden = NO;
    }else{
        
        _table.hidden = YES;
    }
}

@end
