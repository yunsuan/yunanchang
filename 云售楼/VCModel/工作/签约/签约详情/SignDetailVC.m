//
//  SignDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SignDetailVC.h"

#import "ModifySignVC.h"
#import "AuditTaskDetailVC.h"
#import "SpePerferDetailVC.h"
#import "InstallMentDetailVC.h"

#import "NumeralDetailInvalidView.h"

#import "NumeralDetailHeader.h"
#import "BaseHeader.h"
#import "CallTelegramCustomDetailInfoCell.h"
#import "InfoDetailCell.h"

@interface SignDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSInteger _num;
    
    NSString *_sub_id;
    
    NSArray *_bankArr;
    
    NSMutableDictionary *_dataDic;
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation SignDetailVC

- (instancetype)initWithSubId:(NSString *)sub_id
{
    self = [super init];
    if (self) {
        
        _sub_id = sub_id;
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
    
//    _bankArr = [self getDetailConfigArrByConfigState:BANK_TYPE];
    [BaseRequest GET:WorkClientAutoBasicConfig_URL parameters:@{@"project_id":_project_id,@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_bankArr = resposeObject[@"data"][5];
            if (self->_dataArr.count) {
                
                [self RequestMethod];
            }
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    _dataArr = [@[] mutableCopy];
    _dataDic = [@{} mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectHouseGetProjectContractDetail_URL parameters:@{@"contract_id":_sub_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            if ([self->_dataDic[@"disabled_state"] integerValue] == 2) {
                
                self.rightBtn.hidden = YES;
            }else{
                
                self.rightBtn.hidden = NO;
            }
            self->_dataArr = [NSMutableArray arrayWithArray:
                              @[
                                @[],
                                @[[NSString stringWithFormat:@"姓名：%@",self->_dataDic[@"beneficiary"][0][@"name"]],[NSString stringWithFormat:@"手机：%@",self->_dataDic[@"beneficiary"][0][@"tel"]],[NSString stringWithFormat:@"证件类型：%@",self->_dataDic[@"beneficiary"][0][@"card_type"]],[NSString stringWithFormat:@"证件号码：%@",self->_dataDic[@"beneficiary"][0][@"card_num"]],[NSString stringWithFormat:@"出生日期：%@",self->_dataDic[@"beneficiary"][0][@"birth"]],[NSString stringWithFormat:@"通讯地址：%@",self->_dataDic[@"beneficiary"][0][@"address"]],[NSString stringWithFormat:@"邮政编码：%@",self->_dataDic[@"beneficiary"][0][@"mail_code"]],[NSString stringWithFormat:@"产权比例：%@%@",self->_dataDic[@"beneficiary"][0][@"property"],@"%"],[NSString stringWithFormat:@"类型：%@",[self->_dataDic[@"beneficiary"][0][@"beneficiary_type"] integerValue] == 1? @"主权益人":@"附权益人"]],
                                @[[NSString stringWithFormat:@"房间号码：%@",self->_dataDic[@"house_name"]],[NSString stringWithFormat:@"公示总价：%@元",self->_dataDic[@"total_price"]],[NSString stringWithFormat:@"物业类型：%@",self->_dataDic[@"property_type"]],[NSString stringWithFormat:@"建筑面积：%@㎡",self->_dataDic[@"estimated_build_size"]],[NSString stringWithFormat:@"套内面积：%@㎡",self->_dataDic[@"indoor_size"]],[NSString stringWithFormat:@"公摊面积：%@㎡",self->_dataDic[@"public_size"]]],
                                @[[NSString stringWithFormat:@"登记时间：%@",self->_dataDic[@"contract_time"]],[NSString stringWithFormat:@"登记人：%@",self->_dataDic[@"contract_agent_name"]],[NSString stringWithFormat:@"归属时间：%@",self->_dataDic[@"contract_limit_time"]]]]];
            if ([self->_dataDic[@"pay_way_name"] isEqualToString:@"一次性付款"]) {
                
                NSMutableArray *discountArr = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"合同编号：%@",self->_dataDic[@"contract_code"]],[NSString stringWithFormat:@"房屋总价：%@元",self->_dataDic[@"total_price"]],[NSString stringWithFormat:@"签约总价：%@元",self->_dataDic[@"contract_total_price"]],[NSString stringWithFormat:@"套内单价：%@元/㎡",self->_dataDic[@"inner_unit_price"]],[NSString stringWithFormat:@"建筑单价：%@元/㎡",self->_dataDic[@"build_unit_price"]],[NSString stringWithFormat:@"付款金额：%@元",self->_dataDic[@"down_pay"]],[NSString stringWithFormat:@"付款方式：%@",self->_dataDic[@"pay_way_name"]],[NSString stringWithFormat:@"分期期数：%ld",[self->_dataDic[@"back"] count]]]];
                [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%.2f元",([self->_dataDic[@"total_price"] floatValue] - [self->_dataDic[@"contract_total_price"] floatValue])] atIndex:2];
                [self->_dataArr insertObject:discountArr atIndex:3];
            }else if ([self->_dataDic[@"pay_way_name"] isEqualToString:@"分期付款"]){
                
                NSMutableArray *discountArr = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"合同编号：%@",self->_dataDic[@"contract_code"]],[NSString stringWithFormat:@"房屋总价：%@元",self->_dataDic[@"total_price"]],[NSString stringWithFormat:@"签约总价：%@元",self->_dataDic[@"contract_total_price"]],[NSString stringWithFormat:@"套内单价：%@元/㎡",self->_dataDic[@"inner_unit_price"]],[NSString stringWithFormat:@"建筑单价：%@元/㎡",self->_dataDic[@"build_unit_price"]],[NSString stringWithFormat:@"付款金额：%@元",self->_dataDic[@"down_pay"]],[NSString stringWithFormat:@"付款方式：%@",self->_dataDic[@"pay_way_name"]]]];
                [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%.2f元",([self->_dataDic[@"total_price"] floatValue] - [self->_dataDic[@"contract_total_price"] floatValue])] atIndex:2];
                [self->_dataArr insertObject:discountArr atIndex:3];
            }else if ([self->_dataDic[@"pay_way_name"] isEqualToString:@"公积金贷款"]){
                NSString *bank = @"";
                for (int i = 0; i < self->_bankArr.count; i++) {
                
                    if ([self->_dataDic[@"back"][0][@"bank_id"] integerValue] == [self->_bankArr[i][@"config_id"] integerValue]) {
                        
                        bank = self->_bankArr[i][@"config_name"];
                    }
                }
                NSMutableArray *discountArr = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"合同编号：%@",self->_dataDic[@"contract_code"]],[NSString stringWithFormat:@"房屋总价：%@元",self->_dataDic[@"total_price"]],[NSString stringWithFormat:@"签约总价：%@元",self->_dataDic[@"contract_total_price"]],[NSString stringWithFormat:@"套内单价：%@元/㎡",self->_dataDic[@"inner_unit_price"]],[NSString stringWithFormat:@"建筑单价：%@元/㎡",self->_dataDic[@"build_unit_price"]],[NSString stringWithFormat:@"付款金额：%@元",self->_dataDic[@"down_pay"]],[NSString stringWithFormat:@"付款方式：%@",self->_dataDic[@"pay_way_name"]],[NSString stringWithFormat:@"首付金额：%@元",self->_dataDic[@"back"][0][@"downpayment"]],[NSString stringWithFormat:@"贷款金额：%@元",self->_dataDic[@"back"][0][@"loan_money"]],[NSString stringWithFormat:@"按揭银行：%@",bank],[NSString stringWithFormat:@"按揭年限：%@年",self->_dataDic[@"back"][0][@"loan_limit"]]]];
                [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%.2f元",([self->_dataDic[@"total_price"] floatValue] - [self->_dataDic[@"contract_total_price"] floatValue])] atIndex:2];
                [self->_dataArr insertObject:discountArr atIndex:3];
            }else if ([self->_dataDic[@"pay_way_name"] isEqualToString:@"综合贷款"]){
                
                NSString *bankbank = @"";
                NSString *fundbank = @"";
                for (int i = 0; i < self->_bankArr.count; i++) {
                    
                    if ([self->_dataDic[@"back"][0][@"bank_bank_id"] integerValue] == [self->_bankArr[i][@"config_id"] integerValue]) {
                        
                        bankbank = self->_bankArr[i][@"config_name"];
                    }
                    if ([self->_dataDic[@"back"][0][@"fund_bank_id"] integerValue] == [self->_bankArr[i][@"config_id"] integerValue]) {
                        
                        fundbank = self->_bankArr[i][@"config_name"];
                    }
                }
                NSMutableArray *discountArr = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"合同编号：%@",self->_dataDic[@"contract_code"]],[NSString stringWithFormat:@"房屋总价：%@元",self->_dataDic[@"total_price"]],[NSString stringWithFormat:@"签约总价：%@元",self->_dataDic[@"contract_total_price"]],[NSString stringWithFormat:@"套内单价：%@元/㎡",self->_dataDic[@"inner_unit_price"]],[NSString stringWithFormat:@"建筑单价：%@元/㎡",self->_dataDic[@"build_unit_price"]],[NSString stringWithFormat:@"付款金额：%@元",self->_dataDic[@"back"][0][@"downpayment"]],[NSString stringWithFormat:@"付款方式：%@",self->_dataDic[@"pay_way_name"]],[NSString stringWithFormat:@"首付金额：%@元",self->_dataDic[@"back"][0][@"downpayment"]],[NSString stringWithFormat:@"商业贷款金额：%@元",self->_dataDic[@"back"][0][@"bank_loan_money"]],[NSString stringWithFormat:@"商业按揭银行：%@",bankbank],[NSString stringWithFormat:@"商业按揭年限：%@年",self->_dataDic[@"back"][0][@"bank_loan_limit"]],[NSString stringWithFormat:@"公积金贷款金额：%@元",self->_dataDic[@"back"][0][@"fund_loan_money"]],[NSString stringWithFormat:@"公积金按揭银行：%@",fundbank],[NSString stringWithFormat:@"公积金按揭年限：%@年",self->_dataDic[@"back"][0][@"fund_loan_limit"]]]];
                [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%.2f元",([self->_dataDic[@"total_price"] floatValue] - [self->_dataDic[@"contract_total_price"] floatValue])] atIndex:2];

                [self->_dataArr insertObject:discountArr atIndex:3];
            }else if ([self->_dataDic[@"pay_way_name"] isEqualToString:@"银行按揭贷款"]){
                
                NSString *bank = @"";
                for (int i = 0; i < self->_bankArr.count; i++) {
                    
                    if ([self->_dataDic[@"back"][0][@"bank_id"] integerValue] == [self->_bankArr[i][@"config_id"] integerValue]) {
                        
                        bank = self->_bankArr[i][@"config_name"];
                    }
                }
                NSMutableArray *discountArr = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"合同编号：%@",self->_dataDic[@"contract_code"]],[NSString stringWithFormat:@"房屋总价：%@元",self->_dataDic[@"total_price"]],[NSString stringWithFormat:@"签约总价：%@元",self->_dataDic[@"contract_total_price"]],[NSString stringWithFormat:@"套内单价：%@元/㎡",self->_dataDic[@"inner_unit_price"]],[NSString stringWithFormat:@"建筑单价：%@元/㎡",self->_dataDic[@"build_unit_price"]],[NSString stringWithFormat:@"付款金额：%@元",self->_dataDic[@"down_pay"]],[NSString stringWithFormat:@"付款方式：%@",self->_dataDic[@"pay_way_name"]],[NSString stringWithFormat:@"首付金额：%@元",self->_dataDic[@"back"][0][@"downpayment"]],[NSString stringWithFormat:@"贷款金额：%@元",self->_dataDic[@"back"][0][@"loan_money"]],[NSString stringWithFormat:@"按揭银行：%@",bank],[NSString stringWithFormat:@"按揭年限：%@",self->_dataDic[@"back"][0][@"loan_limit"]]]];
                [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%.2f元",([self->_dataDic[@"total_price"] floatValue] - [self->_dataDic[@"contract_total_price"] floatValue])] atIndex:2];
                [self->_dataArr insertObject:discountArr atIndex:3];
            }else{
                
                
            }
            [self->_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
        UIAlertAction *numeral = [UIAlertAction actionWithTitle:@"作废" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
            NumeralDetailInvalidView *view = [[NumeralDetailInvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
            view.numeralDetailInvalidViewBlock = ^{
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:@{@"type":@"1",@"id":self->_sub_id}];
                if ([self isEmpty:view.reasonTV.text]) {
                    
                    [tempDic setObject:view.reasonTV.text forKey:@"disabled_reason"];
                }
                [BaseRequest POST:ProjectRowDisabled_URL parameters:tempDic success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [view removeFromSuperview];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                    [self showContent:@"网络错误"];
                }];
            };
            [self.view addSubview:view];
        }];
    
    UIAlertAction *audit = [UIAlertAction actionWithTitle:@"审核" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
        nextVC.status = @"3";
        nextVC.requestId = self->_sub_id;
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_project_id];
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
    }];
    
    
    [alert addAction:numeral];
    if ([self.need_check integerValue] == 1 && [self->_dataDic[@"disabled_state"] integerValue] == 0 && [self->_dataDic[@"check_state"] integerValue] == 2) {
        
        [alert addAction:audit];
    }
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
    
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArr[section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        NumeralDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"NumeralDetailHeader"];
        if (!header) {
            
            header = [[NumeralDetailHeader alloc] initWithReuseIdentifier:@"NumeralDetailHeader"];
        }
        
        //
        header.signDic = self->_dataDic;
        header.num = _num;
        
        if ([self->_dataDic[@"beneficiary"] count]) {
            
            if ([self->_dataDic[@"beneficiary"][_num][@"sex"] integerValue] == 1) {
                
                header.headImg.image = IMAGE_WITH_NAME(@"nan");
            }else{
                
                header.headImg.image = IMAGE_WITH_NAME(@"nv");
            }
        }
        
        header.addBtn.hidden = YES;
        
        header.numeralDetailHeaderAddBlock = ^{
            
            //            AddEncumbrancerVC *nextVC = [[AddEncumbrancerVC alloc] init];
            //            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.numeralDetailHeaderEditBlock = ^{
          
            ModifySignVC *nextVC = [[ModifySignVC alloc] initWithSubId:self->_sub_id projectId:self->_project_id info_Id:self->_info_id dataDic:self->_dataDic];
            nextVC.projectName = self->_projectName;
            nextVC.modifySignVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.numeralDetailHeaderCollBlock = ^(NSInteger index) {
            
            self->_num = index;
            NSArray *arr = @[[NSString stringWithFormat:@"姓名：%@",self->_dataDic[@"beneficiary"][index][@"name"]],[NSString stringWithFormat:@"手机：%@",self->_dataDic[@"beneficiary"][index][@"tel"]],[NSString stringWithFormat:@"证件类型：%@",self->_dataDic[@"beneficiary"][index][@"card_type"]],[NSString stringWithFormat:@"证件号码：%@",self->_dataDic[@"beneficiary"][index][@"card_num"]],[NSString stringWithFormat:@"出生日期：%@",self->_dataDic[@"beneficiary"][index][@"birth"]],[NSString stringWithFormat:@"通讯地址：%@",self->_dataDic[@"beneficiary"][index][@"address"]],[NSString stringWithFormat:@"邮政编码：%@",self->_dataDic[@"beneficiary"][index][@"name"]],[NSString stringWithFormat:@"产权比例：%@",self->_dataDic[@"beneficiary"][index][@"property"]],[NSString stringWithFormat:@"类型：%@",[self->_dataDic[@"beneficiary"][index][@"beneficiary_type"] integerValue] == 1? @"主权益人":@"附权益人"]];
            [self->_dataArr replaceObjectAtIndex:1 withObject:arr];
            [tableView reloadData];
        };
        
        return header;
    }else{
        
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        if (section == 1) {
            
            header.titleL.text = @"权益人信息";
        }else if (section == 2) {
            
            header.titleL.text = @"房屋概况";
        }else if (section == 3) {
            
            header.titleL.text = @"合同信息";
        }else{
            
            header.titleL.text = @"审核信息";
        }
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3 && indexPath.row == 2) {
        
        InfoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoDetailCell"];
        if (!cell) {
            
            cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoDetailCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentlab.text = _dataArr[indexPath.section][indexPath.row];
        
        cell.contentlab.font = FONT(14 *SIZE);
        cell.contentlab.textColor = CL95Color;
        [cell.contentlab mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentView).offset(28 *SIZE);
            make.top.equalTo(cell.contentView).offset(10 *SIZE);
            make.width.mas_lessThanOrEqualTo(200 *SIZE);
            make.bottom.equalTo(cell.contentView).offset(-10 *SIZE);
        }];
        [cell.moreBtn setTitle:@"查看优惠详情" forState:UIControlStateNormal];
        
        cell.infoDetailCellBlock = ^{
            
            SpePerferDetailVC *nextVC = [[SpePerferDetailVC alloc] initWithDataArr:self->_dataDic[@"discount"]];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
    }else{
        
        if ([self->_dataDic[@"pay_way_name"] isEqualToString:@"分期付款"] && indexPath.section == 3 && indexPath.row == 8) {
            
            InfoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoDetailCell"];
            if (!cell) {
                
                cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoDetailCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentlab.text = _dataArr[indexPath.section][indexPath.row];
            
            cell.contentlab.font = FONT(14 *SIZE);
            cell.contentlab.textColor = CL95Color;
            [cell.contentlab mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(28 *SIZE);
                make.top.equalTo(cell.contentView).offset(10 *SIZE);
                make.width.mas_lessThanOrEqualTo(200 *SIZE);
                make.bottom.equalTo(cell.contentView).offset(-10 *SIZE);
            }];
            [cell.moreBtn setTitle:@"查看分期详情" forState:UIControlStateNormal];
            
            cell.infoDetailCellBlock = ^{
                
                InstallMentDetailVC *nextVC = [[InstallMentDetailVC alloc] initWithDataArr:self->_dataDic[@"back"]];
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            return cell;
        }else{
        
            CallTelegramCustomDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCustomDetailInfoCell"];
            if (!cell) {
                
                cell = [[CallTelegramCustomDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCustomDetailInfoCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentL.text = _dataArr[indexPath.section][indexPath.row];
            
            return cell;
        }
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"签约详情";
    self.navBackgroundView.backgroundColor = CLBlueBtnColor;
    self.line.hidden = YES;
    self.titleLabel.textColor = CLWhiteColor;
    
    [self.leftButton setImage:[UIImage imageNamed:@"leftarrow_white"] forState:UIControlStateNormal];
    self.rightBtn.hidden = YES;
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:IMAGE_WITH_NAME(@"add_2") forState:UIControlStateNormal];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSelectionStyleNone;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}


@end
