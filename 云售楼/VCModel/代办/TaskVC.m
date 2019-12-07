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

#import "AuditTaskDetailVC.h"
#import "NumeralDetailVC.h"
#import "TaskReportVC.h"

#import "ShopAuditTaskDetailVC.h"
#import "AddStoreFollowRecordVC.h"

#import "TaskCallBackCell.h"
#import "TaskCallFollowCell.h"
#import "TaskTakeLookConfirmCell.h"
#import "TaskSignAuditCell.h"
#import "TaskVisitConfirmCell.h"

#import "TransNumeralCell.h"
#import "TransOrderCell.h"
#import "TransSignCell.h"
#import "RoomPriceCell.h"

#import "TaskSellReportCell.h"

#import "StoreFollowCell.h"
#import "PayRemindCell.h"
#import "IntentStoreAuditCell.h"
#import "CancelIntentAuditCell.h"
#import "StoreOrderAuditCell.h"
#import "StoreSignAuditCell.h"
#import "StoreOrderMinPriceProcessCell.h"
#import "StoreSignMinPriceProcessCell.h"
#import "FreeOverTimeProcessCell.h"
#import "ShopChangeAuditCell.h"
#import "ShopFreePeriodChangeAuditCell.h"
#import "ShopRentPeriodChangeAuditCell.h"
#import "ShopRentPriceChangeAuditCell.h"

#import "InvalidView.h"
#import "SignSelectWorkerView.h"
#import "SignFailView.h"

//static NSInteger const SALE_MESSAGE_ROW_CHECK=10; //排号审核
//
//static NSInteger const SALE_MESSAGE_SUB_CHECK=11; //定单审核
//
//static NSInteger const SALE_MESSAGE_CONS_CHECK=12;//签约审核
//
//static NSInteger const SALE_MESSAGE_HOUSE_RESERVE=13; //房源预留
//
//static NSInteger const SALE_MESSAGE_HOUSE_PRICE_SET=14; //房源定价
//
//static NSInteger const SALE_MESSAGE_HOUSE_CTL=15; //房源销控
//
//static NSInteger const SALE_MESSAGE_HOUSE_PRICE_FIX=16; //房源调价
//
//static NSInteger const SALE_MESSAGE_HOUSE_PRICE_DISCOUNT=17; //房源标准折扣
//
//static NSInteger const SALE_MESSAGE_ROW_SINCERITY_ADD=21; //排号增加诚意金
//
//static NSInteger const SALE_MESSAGE_ROW_CANCEL=22; //排号退号
//
//static NSInteger const SALE_MESSAGE_ROW_RENAME=23; //排号更名
//
//static NSInteger const SALE_MESSAGE_ROW_ADD_BENEFIT=24; //排号增减权益人
//
//static NSInteger const SALE_MESSAGE_SUB_BREACH=25; //定单挞定
//
//static NSInteger const SALE_MESSAGE_SUB_ADD_DOWNPAY=26; //定单增加定金
//
//static NSInteger const SALE_MESSAGE_SUB_EXCHANGE_BENEFIT=27; //定单主从变更
//
//static NSInteger const SALE_MESSAGE_SUB_CHANGE_PAY_WYA=28; //定单付款方式变更
//
//static NSInteger const SALE_MESSAGE_SUB_CHANGE_TIME_LIMIT=29; //定单按揭年限变更
//
//static NSInteger const SALE_MESSAGE_SUB_CHANGE_DISCOUNT=30; //定单特殊优惠变更
//
//static NSInteger const SALE_MESSAGE_SUB_DELAY_CONS=31; //定单延期签约变更
//
//static NSInteger const SALE_MESSAGE_SUB_CHANGE_BENEFIT=32; //定单增减权益人
//
//static NSInteger const SALE_MESSAGE_SUB_CANCEL=33; //定单退房
//
//static NSInteger const SALE_MESSAGE_SUB_EXCHANGE_HOUSE=34; //定单换房
//
//static NSInteger const SALE_MESSAGE_SUB_RENAME=35; //定单更名
//
//static NSInteger const SALE_MESSAGE_CONS_CHANGE_PAY_WAY=36; //合同付款方式变更
//
//static NSInteger const SALE_MESSAGE_CONS_EXCHANGE_BENEFIT=37; //合同主从变更
//
//static NSInteger const SALE_MESSAGE_CONS_CHANGE_DISCOUNT=38; //合同特殊优惠变更
//
//static NSInteger const SALE_MESSAGE_CONS_DELAY_CONS=39; //合同延期签约变更
//
//static NSInteger const SALE_MESSAGE_CONS_CHANGE_BENEFIT=40; //合同增减权益人
//
//static NSInteger const SALE_MESSAGE_CONS_CANCEL=41; //合同退房
//
//static NSInteger const SALE_MESSAGE_CONS_EXCHANGE_HOUSE=42; //合同换房
//
//static NSInteger const SALE_MESSAGE_CONS_RENAME=43; //合同更名
//
//static NSInteger const SALE_MESSAGE_CONS_DELAY=44; //合同延期
//
//static NSInteger const SALE_MESSAGE_CHANGE_BANK_LIMIT=45; //合同按揭年限变更
//
//static NSInteger const SALE_MESSAGE_CONS_CHANGE_BANK=46; //合同按揭银行变更
//
//static NSInteger const SALE_MESSAGE_CONS_ADD_DOWMPAYMENT=47; //合同增加首付款
//
//static NSInteger const SALE_MESSAGE_CONS_PAY_DELAY=48; //合同付款延期
//
//static NSInteger const TEMPLATE_PUSH_DAY=50; //日报
//
//static NSInteger const TEMPLATE_PUSH_WEEK=51; //周报
//
//static NSInteger const TEMPLATE_PUSH_MONTH=52; //月报

//商业message_type类型：
//70=>'房源定价',
//71=>'房源调价',
//72=>'定租底价流程',
//73=>'商家转意向',
//74=>'商家转定租',
//75=>'商家转签租',
//76=>'定租转签租',
//77=>'房源预留',
//78=>'房源销控',
//79=>'房源解控',
//80=>'票据审核流程',
//81=>'签租底价流程',
//82=>'定租免租期流程',
//83=>'意向转定租',
//84=>'意向转签租',
//85=>'签租免租期流程',
//    const SALE_MESSAGE_BUSINESS_FOLLOW=86; //商业商家跟进消息类型

@interface TaskVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation TaskVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if ([[UserModel defaultModel].projectinfo count]) {
        
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"TaskReload" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"recommendReload" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"reloadCall" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionNSNotificationMethod) name:@"reloadCompanyInfo" object:nil];
    _dataArr = [@[] mutableCopy];
//    _dataArr = [[NSMutableArray alloc] initWithArray:@[@"来电客户",@"来访客户",@"推荐客户",@"审核待办",@"财务待办"]];
}

- (void)ActionNSNotificationMethod{
    
    if ([[UserModel defaultModel].projectinfo count]) {
        
        _table.hidden = NO;
    }else{
        
        _table.hidden = YES;
    }
}

- (void)RequestMethod{
    
    [BaseRequest GET:HandleGetMessageList_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        [self->_table.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            if ([resposeObject[@"data"][@"list"] count]) {
                
                [self SetData:resposeObject[@"data"][@"list"]];
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
            [self->_table reloadData];
            if ([resposeObject[@"data"][@"unread_number"] integerValue] < 1) {
                
                [self.navigationController.tabBarItem setBadgeValue:nil];
            }else{
                
                [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%@",resposeObject[@"data"][@"unread_number"]]];
            }
            [UIApplication sharedApplication].applicationIconBadgeNumber = [resposeObject[@"data"][@"unread_number"] integerValue];
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


- (void)ActionRightBtn:(UIButton *)btn{
    
    [BaseRequest POST:HandleEmptyMessage_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            [self->_table reloadData];
            [self RequestMethod];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
#pragma mark -- 2 电话来访--
    if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 2) {

        TaskCallBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCallBackCell"];
        if (!cell) {
            
            cell = [[TaskCallBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCallBackCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.titleL.text = @"来访跟进";
        cell.headImg.image = IMAGE_WITH_NAME(@"laifang");
        
        cell.taskCallBackCellBlock = ^{
            
            FollowRecordVC *nextVC = [[FollowRecordVC alloc] initWithGroupId:self->_dataArr[indexPath.row][@"group_id"]];
            nextVC.info_id = self->_dataArr[indexPath.row][@"info_id"];
            nextVC.status = @"direct";
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;

        #pragma mark -- 1 自然来访--
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 1){

        TaskCallBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCallBackCell"];
        if (!cell) {
            
            cell = [[TaskCallBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCallBackCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.titleL.text = @"来电回访";
        cell.headImg.image = IMAGE_WITH_NAME(@"laidian");
        cell.taskCallBackCellBlock = ^{
            
            FollowRecordVC *nextVC = [[FollowRecordVC alloc] initWithGroupId:self->_dataArr[indexPath.row][@"group_id"]];
            nextVC.info_id = self->_dataArr[indexPath.row][@"info_id"];
            nextVC.status = @"direct";
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;

#pragma mark -- 3 带看确认 --
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
        
        #pragma mark -- 4 签字确认--
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
        #pragma mark -- 5 到访确认 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 5){
        
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
#pragma mark -- 10 排号审核 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 10){
        
        TransNumeralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransNumeralCell"];
        if (!cell) {
            
            cell = [[TransNumeralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TransNumeralCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.transNumeralCellAuditBlock = ^(NSInteger index) {
            
            AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
            nextVC.status = @"1";
            nextVC.requestId = self->_dataArr[indexPath.row][@"row_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.auditTaskDetailVCBlock = ^{
              
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
        
        #pragma mark -- 11 定单审核 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 11){

        TransOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransOrderCell"];
        if (!cell) {
            
            cell = [[TransOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TransOrderCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.transOrderCellAuditBlock = ^(NSInteger index) {
            
            AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
            nextVC.status = @"2";
            nextVC.requestId = self->_dataArr[indexPath.row][@"sub_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.auditTaskDetailVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
        
        #pragma mark -- 12 签约审核 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 12){

        TransSignCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransSignCell"];
        if (!cell) {
            
            cell = [[TransSignCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TransSignCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.transSignCellAuditBlock = ^(NSInteger index) {
            
            AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
            nextVC.status = @"3";
            nextVC.requestId = self->_dataArr[indexPath.row][@"contract_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.auditTaskDetailVCBlock = ^{
              
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
        
        #pragma mark -- 13 房源预留 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 13){

        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.hidden = YES;
        return cell;
        
        #pragma mark -- 14 房源定价 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 14){

        RoomPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomPriceCell"];
        if (!cell) {
            
            cell = [[RoomPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomPriceCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.hidden = YES;
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.roomPriceCellAuditBlock = ^(NSInteger index) {
            
            AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
            nextVC.status = @"3";
            nextVC.requestId = self->_dataArr[indexPath.row][@"log_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.auditTaskDetailVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
        
        #pragma mark -- 15 房源销控 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 15){

        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.hidden = YES;
        return cell;
        
        #pragma mark -- 16 房源调价 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 16){

        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.hidden = YES;
        return cell;
        
        #pragma mark -- 17 房源标准折扣 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 17){
    
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.hidden = YES;
        return cell;
        
#pragma mark -- 21 排号增加诚意金 --
#pragma mark -- 22 排号退号 --
#pragma mark -- 23 排号更名 --
#pragma mark -- 24 排号增减权益人 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 21 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 22 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 23 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 24) {
        
        TransNumeralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransNumeralCell"];
        if (!cell) {
            
            cell = [[TransNumeralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TransNumeralCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 21) {
            
            cell.title = @"排号增加诚意金";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 22) {
            
            cell.title = @"排号退号";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 23) {
            
            cell.title = @"排号更名";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 24) {
            
            cell.title = @"排号增减权益人";
        }else{
            
            cell.title = @"排号审核";
        }
        
        cell.transNumeralCellAuditBlock = ^(NSInteger index) {
            
            AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
            nextVC.status = @"1";
            nextVC.requestId = self->_dataArr[indexPath.row][@"row_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.auditTaskDetailVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
#pragma mark -- 25 定单挞定 --
#pragma mark -- 26 定单增加定金 --
#pragma mark -- 27 定单主从变更 --
#pragma mark -- 28 定单付款方式变更 --
#pragma mark -- 29 定单按揭年限变更 --
#pragma mark -- 30 定单特殊优惠变更 --
#pragma mark -- 31 定单延期签约变更 --
#pragma mark -- 32 定单增减权益人 --
#pragma mark -- 33 定单退房 --
#pragma mark -- 34 定单换房 --
#pragma mark -- 35 定单更名 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 25 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 26 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 27 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 28 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 29 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 30 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 31 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 32 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 33 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 34 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 35) {
        
        TransOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransOrderCell"];
        if (!cell) {
            
            cell = [[TransOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TransOrderCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 25) {
            
            cell.title = @"定单挞定";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 26) {
            
            cell.title = @"定单增加定金";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 27) {
            
            cell.title = @"定单主从变更";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 28) {
            
            cell.title = @"定单付款方式变更";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 29) {
            
            cell.title = @"定单按揭年限变更";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 30) {
            
            cell.title = @"定单特殊优惠变更";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 31) {
            
            cell.title = @"定单延期签约变更";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 32) {
            
            cell.title = @"定单增减权益人";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 33) {
            
            cell.title = @"定单退房";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 34) {
            
            cell.title = @"定单换房";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 35) {
            
            cell.title = @"定单更名";
        }else{
            
            cell.title = @"定单审核";
        }
        
        cell.transOrderCellAuditBlock = ^(NSInteger index) {
            
            AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
            nextVC.status = @"2";
            nextVC.requestId = self->_dataArr[indexPath.row][@"sub_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.auditTaskDetailVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;

#pragma mark -- 36 合同付款方式变更 --
#pragma mark -- 37 合同主从变更 --
#pragma mark -- 38 合同特殊优惠变更 --
#pragma mark -- 39 合同延期签约变更 --
#pragma mark -- 40 合同增减权益人 --
#pragma mark -- 41 合同退房 --
#pragma mark -- 42 合同换房 --
#pragma mark -- 43 合同更名 --
#pragma mark -- 44 合同延期 --
#pragma mark -- 45 合同按揭年限变更 --
#pragma mark -- 46 合同按揭银行变更 --
#pragma mark -- 47 合同增加首付款 --
#pragma mark -- 48 合同付款延期 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 36 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 37 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 38 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 39 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 40 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 41 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 42 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 43 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 44 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 45 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 46 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 47 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 48) {
        
        TransSignCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransSignCell"];
        if (!cell) {
            
            cell = [[TransSignCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TransSignCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 36) {
            
            cell.title = @"合同付款方式变更";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 37) {
            
            cell.title = @"合同主从变更";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 38) {
            
            cell.title = @"合同特殊优惠变更";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 39) {
            
            cell.title = @"合同延期签约变更";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 40) {
            
            cell.title = @"合同增减权益人";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 41) {
            
            cell.title = @"合同退房";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 42) {
            
            cell.title = @"合同换房";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 43) {
            
            cell.title = @"合同更名";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 44) {
            
            cell.title = @"合同延期";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 45) {
            
            cell.title = @"合同按揭年限变更";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 46) {
            
            cell.title = @"合同按揭银行变更";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 47) {
            
            cell.title = @"合同增加首付款";
        }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 48) {
            
            cell.title = @"合同付款延期";
        }else{
            
            cell.title = @"签约审核";
        }
        
        cell.transSignCellAuditBlock = ^(NSInteger index) {
            
            AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
            nextVC.status = @"3";
            nextVC.requestId = self->_dataArr[indexPath.row][@"contract_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.auditTaskDetailVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
        
#pragma mark -- 50 日报 --
#pragma mark -- 51 周报 --
#pragma mark -- 52 月报 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 50 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 51 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 52){
        
        TaskSellReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskSellReportCell"];
        if (!cell) {
            
            cell = [[TaskSellReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskSellReportCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentL.numberOfLines = 2;
        cell.dataDic = _dataArr[indexPath.row];
        return cell;
#pragma mark -- 72 定租底价流程 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 72){
              
        StoreOrderMinPriceProcessCell *cell = [[StoreOrderMinPriceProcessCell alloc] init];
        if (!cell) {
            
            cell = [[StoreOrderMinPriceProcessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreOrderMinPriceProcessCell"];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.storeOrderMinPriceProcessCellAuditBlock = ^(NSInteger index) {
            
            ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
            nextVC.status = @"5";
            nextVC.requestId = self->_dataArr[indexPath.row][@"sub_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.shopAuditTaskDetailVCBlock = ^{
                        
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
#pragma mark -- 73 商家转意向 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 73){
              
        IntentStoreAuditCell *cell = [[IntentStoreAuditCell alloc] init];
        if (!cell) {
            
            cell = [[IntentStoreAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntentStoreAuditCell"];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.intentStoreAuditCellAuditBlock = ^(NSInteger index) {
          
            ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
            nextVC.status = @"4";
            nextVC.requestId = self->_dataArr[indexPath.row][@"row_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.shopAuditTaskDetailVCBlock = ^{
                        
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
#pragma mark -- 74 商家转定租 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 74){
              
        StoreOrderAuditCell *cell = [[StoreOrderAuditCell alloc] init];
        if (!cell) {
            
            cell = [[StoreOrderAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreOrderAuditCell"];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.storeOrderAuditCellAuditBlock = ^(NSInteger index) {
          
            ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
            nextVC.status = @"5";
            nextVC.requestId = self->_dataArr[indexPath.row][@"sub_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.shopAuditTaskDetailVCBlock = ^{
                        
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
#pragma mark -- 75 商家转签租 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 75){
              
        StoreSignAuditCell *cell = [[StoreSignAuditCell alloc] init];
        if (!cell) {
            
            cell = [[StoreSignAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreSignAuditCell"];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.storeSignAuditCellAuditBlock = ^(NSInteger index) {
          
            ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
            nextVC.status = @"6";
            nextVC.requestId = self->_dataArr[indexPath.row][@"contact_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.shopAuditTaskDetailVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
#pragma mark -- 76 定租转签租 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 76){
              
        StoreSignAuditCell *cell = [[StoreSignAuditCell alloc] init];
        if (!cell) {
            
            cell = [[StoreSignAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreSignAuditCell"];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.storeSignAuditCellAuditBlock = ^(NSInteger index) {
          
            ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
            nextVC.status = @"6";
            nextVC.requestId = self->_dataArr[indexPath.row][@"contact_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.shopAuditTaskDetailVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
#pragma mark -- 80 票据审核流程 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 80){
              
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.hidden = YES;
        return cell;
#pragma mark -- 81 签租底价流程 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 81){
              
        StoreSignMinPriceProcessCell *cell = [[StoreSignMinPriceProcessCell alloc] init];
        if (!cell) {
            
            cell = [[StoreSignMinPriceProcessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreSignMinPriceProcessCell"];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.storeSignMinPriceProcessCellAuditBlock = ^(NSInteger index) {
          
            ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
            nextVC.status = @"6";
            nextVC.requestId = self->_dataArr[indexPath.row][@"contact_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.shopAuditTaskDetailVCBlock = ^{
                        
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
#pragma mark -- 82 定租免租期流程 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 82){
              
        ShopFreePeriodChangeAuditCell *cell = [[ShopFreePeriodChangeAuditCell alloc] init];
        if (!cell) {
            
            cell = [[ShopFreePeriodChangeAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopFreePeriodChangeAuditCell"];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.shopFreePeriodChangeAuditCellAuditBlock = ^(NSInteger index) {
          
            ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
            nextVC.status = @"5";
            nextVC.requestId = self->_dataArr[indexPath.row][@"sub_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.shopAuditTaskDetailVCBlock = ^{
                        
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
#pragma mark -- 83 意向转定租 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 83){
              
        StoreOrderAuditCell *cell = [[StoreOrderAuditCell alloc] init];
        if (!cell) {
            
            cell = [[StoreOrderAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreOrderAuditCell"];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.storeOrderAuditCellAuditBlock = ^(NSInteger index) {
          
            ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
            nextVC.status = @"5";
            nextVC.requestId = self->_dataArr[indexPath.row][@"sub_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.shopAuditTaskDetailVCBlock = ^{
                        
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
#pragma mark -- 84 意向转签租 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 84){
              
        StoreSignAuditCell *cell = [[StoreSignAuditCell alloc] init];
        if (!cell) {
            
            cell = [[StoreSignAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreSignAuditCell"];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.storeSignAuditCellAuditBlock = ^(NSInteger index) {
          
            ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
            nextVC.status = @"6";
            nextVC.requestId = self->_dataArr[indexPath.row][@"contact_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.shopAuditTaskDetailVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
#pragma mark -- 85 签租免租期流程 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 85){
              
        ShopFreePeriodChangeAuditCell *cell = [[ShopFreePeriodChangeAuditCell alloc] init];
        if (!cell) {
            
            cell = [[ShopFreePeriodChangeAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopFreePeriodChangeAuditCell"];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.shopFreePeriodChangeAuditCellAuditBlock = ^(NSInteger index) {
          
            ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
            nextVC.status = @"6";
            nextVC.requestId = self->_dataArr[indexPath.row][@"contact_id"];
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            nextVC.shopAuditTaskDetailVCBlock = ^{
                        
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
#pragma mark -- 86 商家跟进 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 86){
              
        StoreFollowCell *cell = [[StoreFollowCell alloc] init];
        if (!cell) {
            
            cell = [[StoreFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreFollowCell"];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        cell.dataDic = _dataArr[indexPath.row];
        
        cell.storeFollowCellBlock = ^{
            
            AddStoreFollowRecordVC *vc = [[AddStoreFollowRecordVC alloc] init];
            vc.followDic = [@{} mutableCopy];
            vc.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
            vc.business_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"business_id"]];
            vc.status = @"direct";
            vc.addStoreFollowRecordVCBlock = ^{

                [self RequestMethod];
            };
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else{

        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.hidden = YES;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:_dataArr[indexPath.row]];
    
    if ([tempDic[@"is_read"] integerValue] == 0) {
        
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([key isEqualToString:@"is_read"]) {
                
                [tempDic setObject:@"1" forKey:key];
            }
        }];
        [BaseRequest GET:@"saleApp/handle/message/read" parameters:@{@"message_id":[NSString stringWithFormat:@"%@",tempDic[@"message_id"]]} success:^(id  _Nonnull resposeObject) {
            
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
        [_dataArr replaceObjectAtIndex:indexPath.row withObject:tempDic];
        
        [UIApplication sharedApplication].applicationIconBadgeNumber -= 1;
        if ([UIApplication sharedApplication].applicationIconBadgeNumber < 1) {
            
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            [self.navigationController.tabBarItem setBadgeValue:nil];
        }else{
            
            [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld",[UIApplication sharedApplication].applicationIconBadgeNumber]];
        }
        [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
    }
    [tableView reloadData];
    
        #pragma mark -- 1 自然来访--
    if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 1) {
        
        CallTelegramCustomDetailVC *nextVC = [[CallTelegramCustomDetailVC alloc] initWithGroupId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"group_id"]]];
        nextVC.project_id = _dataArr[indexPath.row][@"project_id"];
        nextVC.info_id = _dataArr[indexPath.row][@"info_id"];
        nextVC.name = @"";
        nextVC.powerDic = @{@"detail":[NSNumber numberWithBool:true],@"add":[NSNumber numberWithBool:true],@"update":[NSNumber numberWithBool:true],@"giveUp":[NSNumber numberWithBool:true],@"delete":[NSNumber numberWithBool:true],@"follow":[NSNumber numberWithBool:true]};
        [self.navigationController pushViewController:nextVC animated:YES];

        #pragma mark -- 2 电话来访--
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 2) {
        
        VisitCustomDetailVC *nextVC = [[VisitCustomDetailVC alloc] initWithGroupId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"group_id"]]];
        nextVC.project_id = _dataArr[indexPath.row][@"project_id"];
        nextVC.info_id = _dataArr[indexPath.row][@"info_id"];
        nextVC.powerDic = @{@"detail":[NSNumber numberWithBool:true],@"add":[NSNumber numberWithBool:true],@"update":[NSNumber numberWithBool:true],@"giveUp":[NSNumber numberWithBool:true],@"delete":[NSNumber numberWithBool:true],@"follow":[NSNumber numberWithBool:true]};
        nextVC.name = @"";
        [self.navigationController pushViewController:nextVC animated:YES];

        #pragma mark -- 3 带看确认 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 3) {
        
        WorkPhoneConfrimWaitDetailVC *nextVC = [[WorkPhoneConfrimWaitDetailVC alloc] initWithClientId:_dataArr[indexPath.row][@"client_id"]];
        nextVC.workPhoneConfrimWaitDetailVCBlock = ^{
            
            [self->_dataArr removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
        
                #pragma mark -- 4 签字确认--
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 4) {
        
        WorkRecommendWaitDetailVC *nextVC = [[WorkRecommendWaitDetailVC alloc] initWithString:_dataArr[indexPath.row][@"client_id"]];

        nextVC.needConfirm = _dataArr[indexPath.row][@"need_confirm"];

        [self.navigationController pushViewController:nextVC animated:YES];
        
        #pragma mark -- 5 到访确认 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 5){
        
        WorkRecommendWaitDetailVC *nextVC = [[WorkRecommendWaitDetailVC alloc] initWithString:_dataArr[indexPath.row][@"client_id"]];
        nextVC.needConfirm = @"1";
        [self.navigationController pushViewController:nextVC animated:YES];
        
        #pragma mark -- 10 排号审核 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 10) {
        
//        NumeralDetailVC *nextVC = [[NumeralDetailVC alloc] initWithRowId:self->_dataArr[indexPath.row][@"row_id"] project_id:@"" info_id:@""];
//        [self.navigationController pushViewController:nextVC animated:YES];
        AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
        nextVC.status = @"1";
        nextVC.requestId = self->_dataArr[indexPath.row][@"row_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.auditTaskDetailVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
        
               #pragma mark -- 11 定单审核 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 11) {
        
        AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
        nextVC.status = @"2";
        nextVC.requestId = self->_dataArr[indexPath.row][@"sub_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.auditTaskDetailVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
        
                #pragma mark -- 12 签约审核 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 12) {
        
        AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
        nextVC.status = @"3";
        nextVC.requestId = self->_dataArr[indexPath.row][@"contract_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.auditTaskDetailVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
        
             #pragma mark -- 13 房源预留 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 13) {
        
        
                #pragma mark -- 14 房源定价 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 14) {
        
          #pragma mark -- 15 房源销控 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 15) {
        
        
           #pragma mark -- 16 房源调价 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 16) {
        
        
        #pragma mark -- 17 房源标准折扣 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 17) {
        
        
#pragma mark -- 21 排号增加诚意金 --
#pragma mark -- 22 排号退号 --
#pragma mark -- 23 排号更名 --
#pragma mark -- 24 排号增减权益人 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 21 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 22 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 23 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 24) {

        AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
        nextVC.status = @"1";
        nextVC.requestId = self->_dataArr[indexPath.row][@"row_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.auditTaskDetailVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
#pragma mark -- 25 定单挞定 --
#pragma mark -- 26 定单增加定金 --
#pragma mark -- 27 定单主从变更 --
#pragma mark -- 28 定单付款方式变更 --
#pragma mark -- 29 定单按揭年限变更 --
#pragma mark -- 30 定单特殊优惠变更 --
#pragma mark -- 31 定单延期签约变更 --
#pragma mark -- 32 定单增减权益人 --
#pragma mark -- 33 定单退房 --
#pragma mark -- 34 定单换房 --
#pragma mark -- 35 定单更名 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 25 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 26 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 27 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 28 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 29 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 30 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 31 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 32 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 33 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 34 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 35) {
        
        AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
        nextVC.status = @"2";
        nextVC.requestId = self->_dataArr[indexPath.row][@"sub_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.auditTaskDetailVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
        
#pragma mark -- 36 合同付款方式变更 --
#pragma mark -- 37 合同主从变更 --
#pragma mark -- 38 合同特殊优惠变更 --
#pragma mark -- 39 合同延期签约变更 --
#pragma mark -- 40 合同增减权益人 --
#pragma mark -- 41 合同退房 --
#pragma mark -- 42 合同换房 --
#pragma mark -- 43 合同更名 --
#pragma mark -- 44 合同延期 --
#pragma mark -- 45 合同按揭年限变更 --
#pragma mark -- 46 合同按揭银行变更 --
#pragma mark -- 47 合同增加首付款 --
#pragma mark -- 48 合同付款延期 --
    }else if ([_dataArr[indexPath.row][@"message_type"] integerValue] == 36 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 37 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 38 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 39 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 40 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 41 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 42 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 43 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 44 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 45 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 46 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 47 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 48) {
        

        AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
        nextVC.status = @"3";
        nextVC.requestId = self->_dataArr[indexPath.row][@"contract_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.auditTaskDetailVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
#pragma mark -- 50 日报 --
#pragma mark -- 51 周报 --
#pragma mark -- 52 月报 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 50 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 51 || [_dataArr[indexPath.row][@"message_type"] integerValue] == 52){
        
        TaskReportVC *nextVC = [[TaskReportVC alloc] initWithData:_dataArr[indexPath.row]];
        
        if([_dataArr[indexPath.row][@"message_type"] integerValue] == 50){

            nextVC.tit = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"title"]];
        }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 51){

            nextVC.tit = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"title"]];
        }else{

            nextVC.tit = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"title"]];
        }
        [self.navigationController pushViewController:nextVC animated:YES];
        
#pragma mark -- 72 定租底价流程 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 72){
                  
        ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
        nextVC.status = @"5";
        nextVC.requestId = self->_dataArr[indexPath.row][@"sub_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.shopAuditTaskDetailVCBlock = ^{
                    
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
#pragma mark -- 73 商家转意向 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 73){
                  
        ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
        nextVC.status = @"4";
        nextVC.requestId = self->_dataArr[indexPath.row][@"row_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.shopAuditTaskDetailVCBlock = ^{
                    
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
#pragma mark -- 74 商家转定租 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 74){
          
        ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
        nextVC.status = @"5";
        nextVC.requestId = self->_dataArr[indexPath.row][@"sub_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.shopAuditTaskDetailVCBlock = ^{
                    
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
#pragma mark -- 75 商家转签租 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 75){
                  
        ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
        nextVC.status = @"6";
        nextVC.requestId = self->_dataArr[indexPath.row][@"contact_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.shopAuditTaskDetailVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
#pragma mark -- 76 定租转签租 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 76){
                  
        ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
        nextVC.status = @"6";
        nextVC.requestId = self->_dataArr[indexPath.row][@"contact_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.shopAuditTaskDetailVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
#pragma mark -- 80 票据审核流程 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 80){
                  
            
#pragma mark -- 81 签租底价流程 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 81){
                
        ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
        nextVC.status = @"6";
        nextVC.requestId = self->_dataArr[indexPath.row][@"contact_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.shopAuditTaskDetailVCBlock = ^{
                    
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
#pragma mark -- 82 定租免租期流程 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 82){
                  
        ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
        nextVC.status = @"5";
        nextVC.requestId = self->_dataArr[indexPath.row][@"sub_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.shopAuditTaskDetailVCBlock = ^{
                    
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
#pragma mark -- 83 意向转定租 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 83){
                  
        ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
        nextVC.status = @"5";
        nextVC.requestId = self->_dataArr[indexPath.row][@"sub_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.shopAuditTaskDetailVCBlock = ^{
                    
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
#pragma mark -- 84 意向转签租 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 84){
                  
        ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
        nextVC.status = @"6";
        nextVC.requestId = self->_dataArr[indexPath.row][@"contact_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.shopAuditTaskDetailVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
#pragma mark -- 85 签租免租期流程 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 85){
                  
        ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
        nextVC.status = @"6";
        nextVC.requestId = self->_dataArr[indexPath.row][@"contact_id"];
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        nextVC.shopAuditTaskDetailVCBlock = ^{
                    
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
#pragma mark -- 86 商家跟进 --
    }else if([_dataArr[indexPath.row][@"message_type"] integerValue] == 86){
        
        AddStoreFollowRecordVC *vc = [[AddStoreFollowRecordVC alloc] init];
        vc.followDic = [@{} mutableCopy];
        vc.project_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"project_id"]];
        vc.business_id = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.row][@"business_id"]];
        vc.status = @"direct";
        vc.addStoreFollowRecordVCBlock = ^{

            [self RequestMethod];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"待办";
    self.leftButton.hidden = YES;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"清空数据" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
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
