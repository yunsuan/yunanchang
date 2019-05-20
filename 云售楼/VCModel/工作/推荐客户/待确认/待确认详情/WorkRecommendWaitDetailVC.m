//
//  WorkRecommendWaitDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkRecommendWaitDetailVC.h"

#import "WorkCompleteCustomVC1.h"
#import "SignNeedInfoVC.h"
#import "SignListVC.h"

#import "CountDownCell.h"
#import "InfoDetailCell.h"

#import "SignFailView.h"
#import "SignSelectWorkerView.h"
#import "InvalidView.h"

@interface WorkRecommendWaitDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _sign;
    NSArray *_checkArr;
    NSArray *_signArr;
    NSArray *_arrArr;
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_str;
    NSString *_endtime;
    NSString *_name;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic , strong) UITableView *Maintableview;

@property (nonatomic, strong) InvalidView *invalidView;

@property (nonatomic , strong) UIButton *confirmBtn;

@end

@implementation WorkRecommendWaitDetailVC

- (instancetype)initWithString:(NSString *)clientId
{
    self = [super init];
    if (self) {
        
        _str = clientId;
    }
    return self;
}

-(void)post{
    
    [BaseRequest GET:WaitConfirmDetail_URL parameters:@{
                                                        @"client_id":_str
                                                        }
             success:^(id resposeObject) {

                 if ([resposeObject[@"code"] integerValue]==200) {
                     self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];

                     [self->_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

                         if ([obj isKindOfClass:[NSNull class]]) {

                             [self->_dataDic setObject:@"" forKey:key];
                         }
                     }];

                     NSString *sex = @"客户性别：";
                     if ([self->_dataDic[@"sex"] integerValue] == 1) {
                         sex = @"客户性别：男";
                     }
                     if([self->_dataDic[@"sex"] integerValue] == 2)
                     {
                         sex =@"客户性别：女";
                     }
                     self->_name = self->_dataDic[@"name"];
                     NSString *tel = self->_dataDic[@"tel"];
                     NSArray *arr = [tel componentsSeparatedByString:@","];
                     if (arr.count>0) {
                         tel = [NSString stringWithFormat:@"联系方式：%@",arr[0]];
                     }
                     else{
                         tel = @"联系方式：";
                     }
                     NSString *adress = self->_dataDic[@"absolute_address"];
                     adress = [NSString stringWithFormat:@"项目地址：%@-%@-%@ %@",self->_dataDic[@"province_name"],self->_dataDic[@"city_name"],self->_dataDic[@"district_name"],adress];

                     if (self->_dataDic[@"sign"]) {

                         self->_sign = YES;
                         self->_signArr = self->_dataDic[@"sign"];
                         self->_arrArr = @[[NSString stringWithFormat:@"客户姓名：%@",self->_dataDic[@"name"]],[NSString stringWithFormat:@"%@",tel],[NSString stringWithFormat:@"到访人数：%@人",[self->_dataDic[@"visit_num"] integerValue] == 0?@"1":self->_dataDic[@"visit_num"]],self->_signArr.count?[self->_signArr[0][@"state"] integerValue] == 1?[NSString stringWithFormat:@"到访时间：%@",self->_signArr[0][@"create_time"]]:@"到访时间：":[NSString stringWithFormat:@"到访时间：%@",self->_dataDic[@"visit_time"]],self->_signArr.count?[NSString stringWithFormat:@"置业顾问：%@",self->_signArr[0][@"sign_agent_name"]]:@"置业顾问：",self->_signArr.count?[NSString stringWithFormat:@"确认状态：%@",self->_signArr[self->_signArr.count - 1][@"state_name"]]:@"确认状态："];

                     }else{


                     }



                     if ([self->_dataDic[@"tel_check_info"] isKindOfClass:[NSDictionary class]] && [self->_dataDic[@"tel_check_info"] count]) {

                         if ([self->_dataDic[@"disabled_reason"] isEqualToString:@"号码重复"]) {

                             self->_checkArr = @[[NSString stringWithFormat:@"确认人：%@",self->_dataDic[@"tel_check_info"][@"confirmed_agent_name"]],[NSString stringWithFormat:@"联系方式：%@",self->_dataDic[@"tel_check_info"][@"confirmed_agent_tel"]],[NSString stringWithFormat:@"确认时间：%@",self->_dataDic[@"tel_check_info"][@"confirmed_time"]],@"判重结果:不可带看"];
                         }else{

                             self->_checkArr = @[[NSString stringWithFormat:@"确认人：%@",self->_dataDic[@"tel_check_info"][@"confirmed_agent_name"]],[NSString stringWithFormat:@"联系方式：%@",self->_dataDic[@"tel_check_info"][@"confirmed_agent_tel"]],[NSString stringWithFormat:@"确认时间：%@",self->_dataDic[@"tel_check_info"][@"confirmed_time"]],@"判重结果:可带看"];
                         }

                     }
                     if (![self->_dataDic[@"comsulatent_advicer"] isEqualToString:@""]) {

                         self->_data = @[@[[NSString stringWithFormat:@"推荐编号：%@",self->_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",self->_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",self->_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",self->_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",self->_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",self->_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",self->_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"置业顾问：%@",self->_dataDic[@"comsulatent_advicer"]],[NSString stringWithFormat:@"备注：%@",self->_dataDic[@"client_comment"]]]];
                     }else{

                         self->_data = @[@[[NSString stringWithFormat:@"推荐编号：%@",self->_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",self->_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",self->_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",self->_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",self->_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",self->_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",self->_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"备注：%@",self->_dataDic[@"client_comment"]]]];
                     }
                     self->_endtime = self->_dataDic[@"timeLimit"];
                     [self->_Maintableview reloadData];

                     if (![self.needConfirm integerValue]) {
                         
                         self->_Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
                         //                             _confirmBtn.hidden = YES;
                     }else{
                         
                         [self.view addSubview:self->_confirmBtn];
                         
                     }
                 }
             }
             failure:^(NSError *error) {

                 [self showContent:@"网络错误"];
             }];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initDataSouce];
    [self initUI];
    [self post];
}


-(void)initDataSouce{
    _titleArr = @[@"推荐信息",@"判重信息"];
    _data =@[];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(post) name:@"reloadCustom" object:nil];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (_sign) {
        
                    if ([self.needConfirm integerValue] == 1) {
        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"签字确认" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
                        }];
        
                        UIAlertAction *valid = [UIAlertAction actionWithTitle:@"客户有效" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
                            [BaseRequest GET:AgentSignNextAgent_URL parameters:@{@"client_id":self->_str} success:^(id resposeObject) {
        
                                NSLog(@"%@",resposeObject);
                                if ([resposeObject[@"code"] integerValue] == 200) {
        
                                    if ([resposeObject[@"data"][@"agentGroup"] count]) {
        
                                        SignSelectWorkerView *view = [[SignSelectWorkerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
                                        view.dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"agentGroup"]];
                                        __strong __typeof(&*view)strongView = view;
                                        view.signSelectWorkerViewBlock = ^{
        
                                            [BaseRequest GET:AgentSignValue_URL parameters:@{@"client_id":self->_str,@"agent_id":strongView.agentId} success:^(id resposeObject) {
        
                                                NSLog(@"%@",resposeObject);
                                                if ([resposeObject[@"code"] integerValue] == 200) {
        
                                                    [self showContent:resposeObject[@"msg"]];
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                                                    [self.navigationController popViewControllerAnimated:YES];
                                                }else{
        
                                                    [self showContent:resposeObject[@"msg"]];
                                                }
                                            } failure:^(NSError *error) {
        
                                                [self showContent:@"网络错误"];
                                            }];
                                        };
                                        [[UIApplication sharedApplication].keyWindow addSubview:view];
                                    }else{
        
                                        [BaseRequest GET:AgentSignValue_URL parameters:@{@"client_id":self->_str} success:^(id resposeObject) {
        
                                            NSLog(@"%@",resposeObject);
                                            if ([resposeObject[@"code"] integerValue] == 200) {
        
                                                [self showContent:resposeObject[@"msg"]];
                                                [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                                                [self.navigationController popViewControllerAnimated:YES];
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
        
                                    dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_str,@"disabled_state":view.agentId,@"comment":view.markTV.text}];
                                }else{
        
                                    dic = [NSMutableDictionary dictionaryWithDictionary:@{@"client_id":self->_str,@"disabled_state":view.agentId}];
                                }
                                [BaseRequest GET:AgentSignDisabled_URL parameters:dic success:^(id resposeObject) {
        
                                    NSLog(@"%@",resposeObject);
                                    if ([resposeObject[@"code"] integerValue] == 200) {
        
                                        [self showContent:resposeObject[@"msg"]];
                                        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                                        [self.navigationController popViewControllerAnimated:YES];
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
                    }
                }else{
        
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认到访" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
                    }];
        
                    UIAlertAction *valid = [UIAlertAction actionWithTitle:@"已到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
                        WorkCompleteCustomVC1 *nextVC = [[WorkCompleteCustomVC1 alloc] initWithClientID:_str name:_name dataDic:_dataDic];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }];
        
                    UIAlertAction *invalid = [UIAlertAction actionWithTitle:@"未到访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
                        self.invalidView.client_id = self->_str;
                        [[UIApplication sharedApplication].keyWindow addSubview:self.invalidView];
                    }];
        
                    [alert addAction:valid];
                    [alert addAction:invalid];
                    [alert addAction:cancel];
                    [self.navigationController presentViewController:alert animated:YES completion:^{
        
                    }];
                }
}

#pragma mark    -----  delegate   ------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_checkArr.count) {
        
        if (_sign) {
            
            return _data.count + 2;
        }
        return _data.count + 1;
    }else{
        
        if (_sign) {
            
            return _data.count + 1;
        }
        return _data.count;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        NSArray *arr = _data[section];
        return arr.count? arr.count + 1:0;
    }else{
        
        if (section == 1) {
            
            if (_checkArr.count) {
                
                return _checkArr.count;
            }else{
                
                return _arrArr.count;
            }
        }else{
            
            return _arrArr.count;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 53*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(10*SIZE , 19*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = CLBlueBtnColor;
    [backview addSubview:header];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 19*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:15.3*SIZE];
    title.textColor = CLTitleLabColor;
    //    title.text = _titleArr[section];
    
    if (section == 0) {
        
        title.text = _titleArr[section];
    }else{
        
        if (section == 1) {
            
            if (_checkArr.count) {
                
                title.text = @"判重信息";
            }else{
                
                title.text = @"到访信息";
            }
        }else{
            
            title.text = @"到访信息";
        }
    }
    [backview addSubview:title];
    return backview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 53*SIZE;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"CountDownCell";
            CountDownCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[CountDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            cell.frame = CGRectMake(0, 0, 360*SIZE, 75*SIZE);
            cell.countDownCellBlock = ^{
                
                [self refresh];
            };
            [cell setcountdownbyendtime:_endtime];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *CellIdentifier = @"InfoDetailCell";
            InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell SetCellContentbystring:_data[indexPath.section][indexPath.row - 1]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        
        if (indexPath.section == 1) {
            
            if (_checkArr.count) {
                
                static NSString *CellIdentifier = @"InfoDetailCell";
                InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell SetCellContentbystring:_checkArr[indexPath.row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                
                static NSString *CellIdentifier = @"InfoDetailCell";
                InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell SetCellContentbystring:_arrArr[indexPath.row]];
                if (indexPath.row == 0) {
                    
                    if (_sign) {
                        
                        cell.moreBtn.hidden = NO;
                        [cell.moreBtn setTitle:@"查看需求信息" forState:UIControlStateNormal];
                        cell.infoDetailCellBlock = ^{
                            
                            SignNeedInfoVC *nextVC = [[SignNeedInfoVC alloc] initWithClientId:self->_str];
                            [self.navigationController pushViewController:nextVC animated:YES];
                        };
                    }
                }else{
                    
                    cell.infoDetailCellBlock = ^{
                        
                        SignListVC *nextVC = [[SignListVC alloc] initWithDataArr:self->_signArr];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    };
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }else{
            
            static NSString *CellIdentifier = @"InfoDetailCell";
            InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell SetCellContentbystring:_arrArr[indexPath.row]];
            if (indexPath.row == 0) {
                
                if (_sign) {
                    
                    cell.moreBtn.hidden = NO;
                    [cell.moreBtn setTitle:@"查看需求信息" forState:UIControlStateNormal];
                    cell.infoDetailCellBlock = ^{
                        
                        SignNeedInfoVC *nextVC = [[SignNeedInfoVC alloc] initWithClientId:self->_str];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    };
                }
            }else{
                
                cell.infoDetailCellBlock = ^{
                    
                    SignListVC *nextVC = [[SignListVC alloc] initWithDataArr:self->_signArr];
                    [self.navigationController pushViewController:nextVC animated:YES];
                };
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"确认中详情";
    
    _Maintableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT- 40 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _Maintableview.rowHeight = UITableViewAutomaticDimension;
    _Maintableview.estimatedRowHeight = 150 *SIZE;
    _Maintableview.backgroundColor = CLBackColor;
    _Maintableview.delegate = self;
    _Maintableview.dataSource = self;
    [_Maintableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
    //
    //        _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
    //    }
    
    [self.view addSubview:_Maintableview];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:CLBlueBtnColor];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    if ([[UserModel defaultModel].agent_identity integerValue] == 2) {
    //
    //        [self.view addSubview:_confirmBtn];
    //    }
    
}

- (InvalidView *)invalidView{

    if (!_invalidView) {

        _invalidView = [[InvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];

        WS(weakSelf);
        _invalidView.invalidViewBlock = ^(NSDictionary *dic) {

            [BaseRequest POST:ConfirmDisabled_URL parameters:dic success:^(id resposeObject) {

                if ([resposeObject[@"code"] integerValue] == 200) {

                    [weakSelf alertControllerWithNsstring:@"失效确认成功" And:@""];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{

                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {

            }];
        };

        _invalidView.invalidViewBlockFail = ^(NSString *str) {

            [weakSelf alertControllerWithNsstring:@"温馨提示" And:str];
        };
    }
    return _invalidView;
}

-(void)refresh{
    
//    [BaseRequest GET:FlushDate_URL parameters:nil success:^(id resposeObject) {
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
//        [self.navigationController popViewControllerAnimated:YES];
//    } failure:^(NSError *error) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
}

@end
