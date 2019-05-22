//
//  RotationSettingVC.m
//  云售楼
//
//  Created by xiaoq on 2019/5/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RotationSettingVC.h"
#import "RotationSettingCell.h"
#import "CompanyHeader.h"

#import "DropBtn.h"
#import "BorderTextField.h"
#import "HMChooseView.h"
#import "AddCompanyView.h"
#import "AddCompanyVC.h"
#import "AddPeopleVC.h"
#import "RotationModel.h"


@interface RotationSettingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableDictionary *_dataDic;
    
    
    NSMutableArray *_teamArr;
    NSMutableArray *_peopleArr;
    NSMutableArray *companyArr;
}

@property (nonatomic , strong) UITableView *SettingTable;

@property (nonatomic , strong) UIButton *SureBtn;

@property (nonatomic , strong) UIView *TableHeader;

@property (nonatomic, strong) DropBtn *beginTime;

@property (nonatomic, strong) DropBtn *endTime;

@property (nonatomic , strong) BorderTextField *downTF;

@property (nonatomic , strong) BorderTextField *upTF;

@property (nonatomic , strong) AddCompanyView *addCompanyView;

@end

@implementation RotationSettingVC

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        _dataDic = [[NSMutableDictionary alloc] initWithDictionary:data];;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _teamArr = [@[] mutableCopy];
    _peopleArr = [@[] mutableCopy];
    companyArr = [@[] mutableCopy];
    if (_dataDic.count) {
        
        companyArr = [NSMutableArray arrayWithArray:_dataDic[@"person"]];
    }
    [self initUI];
    
}

- (void)initUI{
    
    self.titleLabel.text = @"轮岗设置";
    self.leftButton.hidden = NO;
    [self.view addSubview:self.SettingTable];
    [self.view addSubview:self.SureBtn];
}

-(void)action_sure
{
    
    if (!_beginTime.content.text.length) {
        
        [self alertControllerWithNsstring:@"轮岗设置错误" And:@"请选择开始时间"];
        return;
    }
    if (!_endTime.content.text.length) {
        
        [self alertControllerWithNsstring:@"轮岗设置错误" And:@"请选择开始时间"];
        return;
    }
    if ([self isEmpty:_downTF.textField.text]) {
        
        [self alertControllerWithNsstring:@"轮岗设置错误" And:@"请输入下位时间"];
        return;
    }
    if ([self isEmpty:_upTF.textField.text]) {
        
        [self alertControllerWithNsstring:@"轮岗设置错误" And:@"请输入上位提醒时间"];
        return;
    }
    
    if (!companyArr.count) {
        
        [self alertControllerWithNsstring:@"轮岗设置错误" And:@"请选择轮岗团队"];
        return;
    }
    
//    if (!companyArr.count) {
//
//        [self alertControllerWithNsstring:@"轮岗设置错误" And:@"请选择轮岗团队"];
//        return;
//    }
    
    [_teamArr removeAllObjects];
    [_peopleArr removeAllObjects];
    for (int i = 0; i < companyArr.count; i++) {
        
        NSDictionary *dic = @{@"company_id":companyArr[i][@"company_id"],@"sort":@(i)};
        [_teamArr addObject:dic];
        for (int j = 0; j < [companyArr[i][@"list"] count]; j++) {
            
            NSDictionary *dic1 = @{@"company_id":companyArr[i][@"company_id"],@"agent_id":companyArr[i][@"list"][j][@"agent_id"],@"sort":@(j)};
            [_peopleArr addObject:dic1];
        }
    }
    
    if (!_teamArr.count) {
        
        [self alertControllerWithNsstring:@"轮岗设置错误" And:@"请选择轮岗团队"];
        return;
    }
    
    if (!_peopleArr.count) {
        
        [self alertControllerWithNsstring:@"轮岗设置错误" And:@"请选择轮岗人员"];
        return;
    }
    
    
    if (_dataDic.count) {
        
        NSDictionary *dic = @{@"project_id":[UserModel defaultModel].projectinfo[@"project_id"],
                              @"exchange_time_min":_downTF.textField.text,
                              @"tip_time_min":_upTF.textField.text,
                              @"start_time":_beginTime.content.text,
                              @"end_time":_endTime.content.text,
                              @"duty_id":_dataDic[@"duty"][@"duty_id"]
                              };
        
        [BaseRequest POST:DutyUpdate_URL parameters:dic success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if (self.rotationSettingVCBlock) {
                    
                    self.rotationSettingVCBlock();
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }else{
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_teamArr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *companyjson = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSData *jsonData1 = [NSJSONSerialization dataWithJSONObject:_peopleArr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *personjson = [[NSString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        
        NSDictionary *dic = @{@"project_id":[UserModel defaultModel].projectinfo[@"project_id"],
                              @"exchange_time_min":_downTF.textField.text,
                              @"tip_time_min":_upTF.textField.text,
                              @"start_time":_beginTime.content.text,
                              @"end_time":_endTime.content.text,
                              @"person_list":personjson,
                              @"company_list":companyjson
                              };
        
        [BaseRequest POST:Dutyadd_URL parameters:dic success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [BaseRequest GET:DutyStartURL parameters:@{@"project_id":self->_project_id} success:^(id  _Nonnull resposeObject) {
                        
                        NSLog(@"%@",resposeObject);
                        if (self.rotationSettingVCBlock) {
                            
                            self.rotationSettingVCBlock();
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        if (self.rotationSettingVCBlock) {
                            
                            self.rotationSettingVCBlock();
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                        NSLog(@"%@",error);
                    }];
                });
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }
}

-(void)action_begin
{
    HMChooseView *picker = [[HMChooseView alloc] initDatePackerWithStartHour:@"00" endHour:@"24" period:15 selectedHour:@"08" selectedMin:@"13"];
    picker.dateblock = ^(NSString * _Nonnull date) {
        
        self->_beginTime.content.text = date;
    };
    [picker show];
}

-(void)action_end
{
    HMChooseView *picker = [[HMChooseView alloc] initDatePackerWithStartHour:@"00" endHour:@"24" period:1 selectedHour:@"08" selectedMin:@"13"];
    picker.dateblock = ^(NSString * _Nonnull date) {
        
        self->_endTime.content.text = date;
    };
    [picker show];
}

-(void)action_people:(UIButton *)sender
{
    AddPeopleVC *next_vc = [[AddPeopleVC alloc]init];
    next_vc.company_id = companyArr[sender.tag][@"company_id"];
    next_vc.selectPeople = [companyArr[sender.tag][@"list"] mutableCopy];
    if (self->_dataDic.count) {
        
        next_vc.status = @"direct";
        next_vc.duty_id = [NSString stringWithFormat:@"%@",self->_dataDic[@"duty"][@"duty_id"]];
        next_vc.sort = [NSString stringWithFormat:@"%ld",[companyArr[sender.tag][@"list"] count]];
    }
    next_vc.addBtnBlock = ^(NSDictionary * _Nonnull dic) {
        
        if (self->_dataDic.count) {
            
            if (self->_dataDic.count) {
                
                [BaseRequest GET:DutyDetail_URL parameters:@{@"project_id":self.project_id} success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
                        self->companyArr = [NSMutableArray arrayWithArray:self->_dataDic[@"person"]];
                        self->_addCompanyView.dataArr = self->companyArr;
                        [self->_addCompanyView.tagColl reloadData];
                        [self->_SettingTable reloadData];
                        if (self.rotationSettingVCBlock) {
                            
                            self.rotationSettingVCBlock();
                        }
                    }else{
                        
                        [self->_SettingTable reloadData];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                    [self showContent:@"网络错误"];
                }];
            }
        }else{
            
            NSMutableArray *list = [[NSMutableArray alloc] initWithArray:self->companyArr[sender.tag][@"list"]];
            [list addObject:dic];
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self->companyArr[sender.tag]];
            [tempDic setObject:list forKey:@"list"];
            [self->companyArr replaceObjectAtIndex:sender.tag withObject:tempDic];
            [self->_SettingTable reloadData];
        }
    };
    [self.navigationController pushViewController:next_vc animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewCellEditingStyleNone;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return companyArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.indexPathsForSelectedRows.count>1) {
        [tableView deselectRowAtIndexPath:tableView.indexPathsForSelectedRows[0] animated:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray *list = companyArr[section][@"list"];
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 37*SIZE;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73*SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    CompanyHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CompanyHeader"];
    if (!header) {
        header = [[CompanyHeader alloc]initWithReuseIdentifier: @"CompanyHeader"];
    }
    header.companyL.text = companyArr[section][@"company_name"];
    header.addBtn.tag = section;
    [header.addBtn addTarget:self action:@selector(action_people:) forControlEvents:UIControlEventTouchUpInside];
    
    return header;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RotationSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RotationSettingCell"];
    if (!cell) {
        
        cell = [[RotationSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RotationSettingCell"];
    }
    
    cell.nameL.text = companyArr[indexPath.section][@"list"][indexPath.row][@"name"];
    cell.phoneL.text = companyArr[indexPath.section][@"list"][indexPath.row][@"tel"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if ([companyArr[indexPath.section][@"list"][indexPath.row][@"state"] integerValue] == 1) {
        
        [cell.sleepBtn setTitle:@"休息" forState:UIControlStateNormal];
    }else{
        
        [cell.sleepBtn setTitle:@"上岗" forState:UIControlStateNormal];
    }
    
    cell.rotationSettingCellDeleleBtnBlock = ^{
      
        if (self->_dataDic) {
            
            if (self->companyArr.count == 1 && [self->companyArr[indexPath.section][@"list"] count] == 1) {
                
                [MBProgressHUD showError:@"至少需要保留一个团队人员"];
            }else{
                
                [BaseRequest POST:DutyAgentUpdate_URL parameters:@{@"duty_agent_id":self->companyArr[indexPath.section][@"list"][indexPath.row][@"duty_agent_id"],@"disabled_state":@"1"} success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self->companyArr[indexPath.section][@"list"]];
                        [tempArr removeObjectAtIndex:indexPath.row];
                        if (tempArr.count) {
                            
                            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self->companyArr[indexPath.section]];
                            [tempDic setObject:tempArr forKey:@"list"];
                            [self->companyArr replaceObjectAtIndex:indexPath.section withObject:tempDic];
                        }else{
                            
                            [BaseRequest POST:DutyCompanyUpdate_URL parameters:@{@"duty_company_id":self->companyArr[indexPath.section][@"duty_company_id"],@"disabled_state":@"1"} success:^(id  _Nonnull resposeObject) {
                                
                                if ([resposeObject[@"code"] integerValue] == 200) {
                                    
                                    [self->companyArr removeObjectAtIndex:indexPath.section];
                                    [tableView reloadData];
                                }else{
                                    
                                    [MBProgressHUD showError:resposeObject[@"msg"]];
                                }
                            } failure:^(NSError * _Nonnull error) {
                                
                                [MBProgressHUD showError:@"网络错误"];
                            }];
                        }
                        
                        [tableView reloadData];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                    [self showContent:@"网络错误"];
                }];
            }
        }else{
            
            NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self->companyArr[indexPath.section][@"list"]];
            [tempArr removeObjectAtIndex:indexPath.row];
            if (tempArr.count) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self->companyArr[indexPath.section]];
                [tempDic setObject:tempArr forKey:@"list"];
                [self->companyArr replaceObjectAtIndex:indexPath.section withObject:tempDic];
            }else{
                
                [self->companyArr removeObjectAtIndex:indexPath.section];
            }
            
            [tableView reloadData];
        }
    };
    
    cell.rotationSettingCellSleepBtnBlock = ^{
        
        if (self->_dataDic) {
            
            NSDictionary *dic;
            if ([self->companyArr[indexPath.section][@"list"][indexPath.row][@"state"] integerValue] == 1) {
                
                dic = @{@"duty_agent_id":self->companyArr[indexPath.section][@"list"][indexPath.row][@"duty_agent_id"],@"state":@"0"};
            }else{
                
                dic = @{@"duty_agent_id":self->companyArr[indexPath.section][@"list"][indexPath.row][@"duty_agent_id"],@"state":@"1"};
            }
            [BaseRequest POST:DutyAgentUpdate_URL parameters:dic success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self->companyArr[indexPath.section]];
                    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self->companyArr[indexPath.section][@"list"]];
                    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:tempArr[indexPath.row]];
                    if ([tempDic[@"state"] integerValue] == 0) {
                        
                        [tempDic setObject:@"1" forKey:@"state"];
                    }else{
                        
                        [tempDic setObject:@"0" forKey:@"state"];
                    }
                    [tempArr replaceObjectAtIndex:indexPath.row withObject:tempDic];
                    [dic setObject:tempArr forKey:@"list"];
                    [self->companyArr replaceObjectAtIndex:indexPath.section withObject:dic];
                    [tableView reloadData];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [self showContent:@"网络错误"];
            }];
        }else{
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self->companyArr[indexPath.section]];
            NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self->companyArr[indexPath.section][@"list"]];
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:tempArr[indexPath.row]];
            if ([tempDic[@"state"] integerValue] == 0) {
                
                [tempDic setObject:@"1" forKey:@"state"];
            }else{
                
                [tempDic setObject:@"0" forKey:@"state"];
            }
            [tempArr replaceObjectAtIndex:indexPath.row withObject:tempDic];
            [dic setObject:tempArr forKey:@"list"];
            [self->companyArr replaceObjectAtIndex:indexPath.section withObject:dic];
            
            [tableView reloadData];
        }
    };
    
    return cell;
}




-(UITableView *)SettingTable
{
    if (!_SettingTable) {
        _SettingTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _SettingTable.delegate = self;
        _SettingTable.dataSource = self;
        _SettingTable.backgroundColor = CLWhiteColor;
        _SettingTable.tableHeaderView = self.TableHeader;
//        _SettingTable.editing = YES;
        [_SettingTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _SettingTable;
}

-(UIButton *)SureBtn
{
    if (!_SureBtn) {
        _SureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _SureBtn.frame = CGRectMake(0, SCREEN_Height-TAB_BAR_HEIGHT, 360*SIZE, TAB_BAR_HEIGHT);
        _SureBtn.backgroundColor = CLBlueBtnColor;
        _SureBtn.titleLabel.font = FONT(15);
        [_SureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_SureBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
        [_SureBtn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SureBtn;
}

-(UIView *)TableHeader{
    
    if (!_TableHeader) {
        _TableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 350*SIZE)];
        NSArray *arr = @[@"每日轮岗开始时间：",@"每日轮岗结束时间：",@"自然下位时间(分):",@"上位提醒时间(分):"];
        for (int i = 0; i<4; i++) {
            UILabel *lab =  [[UILabel alloc]initWithFrame:CGRectMake(8*SIZE, 25*SIZE+55*SIZE*i, 110*SIZE, 13*SIZE)];
            lab.text =arr[i];
            lab.textColor = CLTitleLabColor;
            lab.font = FONT(12);
            [_TableHeader addSubview:lab];
        }
        [_TableHeader addSubview:self.beginTime];
        [_TableHeader addSubview:self.endTime];
        [_TableHeader addSubview:self.downTF];
        [_TableHeader addSubview:self.upTF];
        
        UIView *view= [[UIView alloc]initWithFrame:CGRectMake(0, 230*SIZE, 360*SIZE, 7*SIZE)];
        view.backgroundColor = COLOR(240, 240, 240, 1);
        [_TableHeader addSubview:view];
        [_TableHeader addSubview:self.addCompanyView];
    } 
    return _TableHeader;
}


-(DropBtn *)beginTime
{
    if (!_beginTime) {
        _beginTime = [[DropBtn alloc]initWithFrame:CGRectMake(121*SIZE, 13*SIZE, 216*SIZE, 33*SIZE)];
        [_beginTime addTarget:self action:@selector(action_begin) forControlEvents:UIControlEventTouchUpInside];
        if (_dataDic.count) {
            
            _beginTime.content.text = [NSString stringWithFormat:@"%@",_dataDic[@"duty"][@"start_time"]];
        }
    }
    return _beginTime;
}

-(DropBtn *)endTime
{
    if (!_endTime) {
        _endTime = [[DropBtn alloc]initWithFrame:CGRectMake(121*SIZE, 68*SIZE, 216*SIZE, 33*SIZE)];
        [_endTime addTarget:self action:@selector(action_end) forControlEvents:UIControlEventTouchUpInside];
        if (_dataDic.count) {
            
            _endTime.content.text = [NSString stringWithFormat:@"%@",_dataDic[@"duty"][@"end_time"]];
        }
    }
    return _endTime;
}

-(BorderTextField *)downTF
{
    if (!_downTF) {
        _downTF = [[BorderTextField alloc]initWithFrame:CGRectMake(121*SIZE, 123*SIZE, 216*SIZE, 33*SIZE)];
        _downTF.textField.placeholder = @"设置为0则无自然下岗";
        if (_dataDic.count) {
            
            _downTF.textField.text = _dataDic[@"duty"][@"exchange_time_min"];
        }
    }
    return _downTF;
}


-(BorderTextField *)upTF
{
    if (!_upTF) {
        _upTF = [[BorderTextField alloc]initWithFrame:CGRectMake(121*SIZE, 178*SIZE, 216*SIZE, 33*SIZE)];
        if (_dataDic.count) {
            
            _upTF.textField.text = [NSString stringWithFormat:@"%@",_dataDic[@"duty"][@"tip_time_min"]];
        }
    }
    return _upTF;
}


-(AddCompanyView *)addCompanyView
{
    if(!_addCompanyView)
    {
        _addCompanyView = [[AddCompanyView alloc]initWithFrame:CGRectMake(0, 240*SIZE, 360*SIZE, 103*SIZE)];
        _addCompanyView.dataArr = companyArr;
        
        SS(strongSelf);
        _addCompanyView.deletBtnBlock = ^{
            
            if (strongSelf->_dataDic.count) {
                
                if (strongSelf.rotationSettingVCBlock) {
                    
                    strongSelf.rotationSettingVCBlock();
                }
            }
            strongSelf->companyArr = strongSelf->_addCompanyView.dataArr;
            [strongSelf->_SettingTable reloadData];
        };
        
        _addCompanyView.addBtnBlock = ^{
            
            AddCompanyVC *next_vc = [[AddCompanyVC alloc]init];
            next_vc.selectCompany = strongSelf->companyArr;
            if (strongSelf->_dataDic.count) {
                
                next_vc.status = @"add";
                next_vc.duty_id = [NSString stringWithFormat:@"%@",strongSelf->_dataDic[@"duty"][@"duty_id"]];
                next_vc.sort = [NSString stringWithFormat:@"%ld",[strongSelf->_dataDic[@"person"] count]];
            }
            next_vc.addBtnBlock = ^(NSMutableDictionary * _Nonnull dic) {
 
                if (strongSelf->_dataDic.count) {
                    
                    [BaseRequest GET:DutyDetail_URL parameters:@{@"project_id":strongSelf.project_id} success:^(id  _Nonnull resposeObject) {
                        
                        if ([resposeObject[@"code"] integerValue] == 200) {
                            
                            strongSelf->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
                            strongSelf->companyArr = [NSMutableArray arrayWithArray:strongSelf->_dataDic[@"person"]];
                            strongSelf->_addCompanyView.dataArr = strongSelf->companyArr;
                            [strongSelf->_addCompanyView.tagColl reloadData];
                            [strongSelf->_SettingTable reloadData];
                            if (strongSelf.rotationSettingVCBlock) {
                                
                                strongSelf.rotationSettingVCBlock();
                            }
                        }else{
                            
                            [strongSelf->_SettingTable reloadData];
                        }
                    } failure:^(NSError * _Nonnull error) {
                        
                        [strongSelf showContent:@"网络错误"];
                    }];
                }else{
                    
                    [strongSelf->companyArr addObject:dic];
                    strongSelf->_addCompanyView.dataArr = strongSelf->companyArr;
                    [strongSelf->_addCompanyView.tagColl reloadData];
                    [strongSelf->_SettingTable reloadData];
                }
            };
            [strongSelf.navigationController pushViewController:next_vc animated:YES];
            
        };
    }
    return _addCompanyView;
}

@end
