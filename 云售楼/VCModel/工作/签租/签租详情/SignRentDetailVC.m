//
//  SignRentDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SignRentDetailVC.h"

#import "BaseHeader.h"
#import "IntentDetailHeader.h"
#import "InfoDetailCell.h"
#import "CallTelegramCustomDetailInfoCell.h"

@interface SignRentDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSInteger _num;
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation SignRentDetailVC

- (instancetype)initWithBusinessId:(NSString *)businessId
{
    self = [super init];
    if (self) {
        
//        _businessId = businessId;
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
//    _dataDic = [@{} mutableCopy];
//    _advicerArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
//    [BaseRequest GET:ProjectRowGetRowDetail_URL parameters:@{@"row_id":_row_id} success:^(id  _Nonnull resposeObject) {
//
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
//            self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
//            NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self->_dataDic[@"beneficiary"]];
//            for (int i = 0; i < tempArr.count; i++) {
//
//                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:tempArr[i]];
//                [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//
//                    if ([obj isKindOfClass:[NSNull class]]) {
//
//                        [tempDic setObject:@"" forKey:key];
//                    }else{
//
//                        [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
//                    }
//                }];
//                [tempArr replaceObjectAtIndex:i withObject:tempDic];
//            }
//            [self->_dataDic setObject:tempArr forKey:@"beneficiary"];
//            if ([self->_dataDic[@"disabled_state"] integerValue] == 2) {
//
//                self.rightBtn.hidden = YES;
//            }else{
//
//                self.rightBtn.hidden = NO;
//            }
//            self->_advicerArr = resposeObject[@"data"][@"advicer"];
//            NSString *str = @"";
//            for (int i = 0; i < self->_advicerArr.count; i++) {
//
//                if (str.length) {
//
//                    str = [NSString stringWithFormat:@"%@,%@",str,self->_advicerArr[i][@"name"]];
//                }else{
//
//                    str = [NSString stringWithFormat:@"%@",self->_advicerArr[i][@"name"]];
//                }
//            }
//            self->_dataArr = [NSMutableArray arrayWithArray:@[@[],@[[NSString stringWithFormat:@"姓名：%@",self->_dataDic[@"beneficiary"][0][@"name"]],[NSString stringWithFormat:@"手机：%@",self->_dataDic[@"beneficiary"][0][@"tel"]],[NSString stringWithFormat:@"证件类型：%@",self->_dataDic[@"beneficiary"][0][@"card_type"]],[NSString stringWithFormat:@"证件号码：%@",self->_dataDic[@"beneficiary"][0][@"card_num"]],[NSString stringWithFormat:@"出生日期：%@",self->_dataDic[@"beneficiary"][0][@"birth"]],[NSString stringWithFormat:@"通讯地址：%@",self->_dataDic[@"beneficiary"][0][@"address"]],[NSString stringWithFormat:@"邮政编码：%@",self->_dataDic[@"beneficiary"][0][@"mail_code"]],[NSString stringWithFormat:@"产权比例：%@%@",self->_dataDic[@"beneficiary"][0][@"property"],@"%"],[NSString stringWithFormat:@"类型：%@",[self->_dataDic[@"beneficiary"][0][@"beneficiary_type"] integerValue] == 1? @"主权益人":@"附权益人"]],@[[NSString stringWithFormat:@"排号号码：%@",self->_dataDic[@"row_code"]],[NSString stringWithFormat:@"排号时间：%@",self->_dataDic[@"row_time"]],[NSString stringWithFormat:@"有效期至：%@",self->_dataDic[@"end_time"]]/*,[NSString stringWithFormat:@"归属人：%@",str],[NSString stringWithFormat:@"登记人：%@",self->_dataDic[@"sign_agent_name"]],[NSString stringWithFormat:@"归属时间：%@",self->_dataDic[@"row_time"]]*/],@[[NSString stringWithFormat:@"登记人：%@",self->_dataDic[@"sign_agent_name"]],[NSString stringWithFormat:@"登记时间：%@",self->_dataDic[@"row_name"]],[NSString stringWithFormat:@"归属人：%@",self->_dataDic[@"advicer"][0][@"name"]],[NSString stringWithFormat:@"归属时间：%@",self->_dataDic[@"row_name"]]]]];
//            if ([self->_dataDic[@"check_state"] integerValue] != 2) {
//
//                if ([self->_dataDic[@"progressList"] isKindOfClass:[NSDictionary class]]) {
//
//                    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"申请流程：%@",self->_dataDic[@"progressList"][@"progress_name"]],[NSString stringWithFormat:@"申请人：%@",self->_dataDic[@"sign_agent_name"]],[NSString stringWithFormat:@"登记时间：%@",self->_dataDic[@"progressList"][@"list"][0][@"update_time"]]]];
//                    if ([self->_dataDic[@"progressList"][@"check_type"] integerValue] == 1) {
//
//                        [arr insertObject:@"流程类型：自由流程" atIndex:1];
//                    }else if ([self->_dataDic[@"progressList"][@"check_type"] integerValue] == 2){
//
//                        [arr insertObject:@"流程类型：固定流程" atIndex:1];
//                    }else{
//
//                        [arr insertObject:@"流程类型：混合流程" atIndex:1];
//                    }
//                    [self->_dataArr addObject:arr];
//                }
//            }
//            [self->_dataArr addObject:self->_dataDic[@"enclosure"]];
//            [self->_table reloadData];
//        }else{
//
//            [self showContent:resposeObject[@"msg"]];
//        }
//    } failure:^(NSError * _Nonnull error) {
//
//        [self showContent:@"网络错误"];
//    }];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *sign = [UIAlertAction actionWithTitle:@"转签租" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        if ([self->_dataDic[@"receive_state"] integerValue] == 1) {
//
//            AddSignVC *nextVC = [[AddSignVC alloc] initWithRow_id:self->_row_id personArr:self->_dataDic[@"beneficiary"] project_id:self->_project_id info_id:self->_info_id];
//            nextVC.from_type = @"3";
//            nextVC.advicer_id = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"advicer"]];
//            nextVC.advicer_name = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"name"]];
//            nextVC.trans = @"trans";
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else{
//
//            [self showContent:@"未收款不能转签约"];
//        }
    }];
    
    UIAlertAction *order = [UIAlertAction actionWithTitle:@"转定租" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        if ([self->_dataDic[@"receive_state"] integerValue] == 1) {
//
//            AddOrderVC *nextVC = [[AddOrderVC alloc] initWithRow_id:self->_row_id personArr:self->_dataDic[@"beneficiary"] project_id:self->_project_id info_id:self->_info_id];
//            nextVC.from_type = @"3";
//            nextVC.advicer_id = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"advicer"]];
//            nextVC.advicer_name = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"name"]];
//            nextVC.trans = @"trans";
//            nextVC.addOrderVCBlock = ^{
//
//                [self RequestMethod];
//            };
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else{
//
//            [self showContent:@"未收款不能转定单"];
//        }
    }];
    
    UIAlertAction *change = [UIAlertAction actionWithTitle:@"变更" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[@{@"id":@"1",@"param":@"排号增加诚意金"},@{@"id":@"2",@"param":@"排号退号"},@{@"id":@"3",@"param":@"排号更名"},@{@"id":@"4",@"param":@"排号增减权益人"}]];
//        view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//            if ([ID integerValue] == 1) {
//
//                SincerityChangeVC *nextVC = [[SincerityChangeVC alloc] initWithProject_id:self->_project_id sincerity:self->_dataDic[@"sincerity"] dataDic:self->_dataDic];
//                nextVC.sincerityChangeVCBlock = ^{
//
//                    [self RequestMethod];
//                    if (self.numeralDetailVCBlock) {
//
//                        self.numeralDetailVCBlock();
//                    }
//                };
//                [self.navigationController pushViewController:nextVC animated:YES];
//            }else if ([ID integerValue] == 2){
//
//                NumeralBackNumVC *nextVC = [[NumeralBackNumVC alloc] initWithProject_id:self->_project_id dataDic:self->_dataDic];
//                nextVC.numeralBackNumVCBlock = ^{
//
//                    [self RequestMethod];
//                };
//                [self.navigationController pushViewController:nextVC animated:YES];
//            }else if ([ID integerValue] == 3){
//
//                NumeralChangeNameVC *nextVC = [[NumeralChangeNameVC alloc] initWithProject_id:self->_project_id personArr:self->_dataDic[@"beneficiary"] dataDic:self->_dataDic info_id:self->_info_id];
//                nextVC.numeralChangeNameVCBlock = ^{
//
//                    [self RequestMethod];
//                };
//                [self.navigationController pushViewController:nextVC animated:YES];
//            }else{
//
//                NumeralAddMinusPersonVC *nextVC = [[NumeralAddMinusPersonVC alloc] initWithProject_id:self->_project_id personArr:self->_dataDic[@"beneficiary"] dataDic:self->_dataDic info_id:self->_info_id];
//                nextVC.numeralAddMinusPersonVCBlock = ^{
//
//                    [self RequestMethod];
//                };
//                [self.navigationController pushViewController:nextVC animated:YES];
//            }
//        };
//        [self.view addSubview:view];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
//    if ([self->_dataDic[@"disabled_state"] integerValue] == 0 && [self->_dataDic[@"check_state"] integerValue] == 1 && [self->_dataDic[@"receive_state"] integerValue] == 1) {
//
////        [alert addAction:change];
//    }
//    if ([self->_dataDic[@"disabled_state"] integerValue] == 0 && [self->_dataDic[@"check_state"] integerValue] == 1 && [self->_dataDic[@"receive_state"] integerValue] == 1) {
//
//        [alert addAction:order];
//    }
//    if ([self->_dataDic[@"disabled_state"] integerValue] == 0 && [self->_dataDic[@"check_state"] integerValue] == 1 && [self->_dataDic[@"receive_state"] integerValue] == 1) {
//
//        [alert addAction:sign];
//    }
//
//    if ([self->_dataDic[@"disabled_state"] integerValue] == 0 && [self->_dataDic[@"check_state"] integerValue] == 2 && [self->_dataDic[@"receive_state"] integerValue] == 0) {
//
//        [alert addAction:quit];
//    }
    
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == _dataArr.count - 1) {
        
        return 1;
    }
    return [_dataArr[section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        IntentDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"IntentDetailHeader"];
        if (!header) {
            
            header = [[IntentDetailHeader alloc] initWithReuseIdentifier:@"IntentDetailHeader"];
        }
        
//        header.dataDic = self->_dataDic;
//        header.moneyL.text = [NSString stringWithFormat:@"诚意金：%@元",self->_dataDic[@"sincerity"]];
        header.num = _num;
        
//        if ([self->_dataDic[@"beneficiary"] count]) {
//
//            if ([self->_dataDic[@"beneficiary"][_num][@"sex"] integerValue] == 1) {
//
//                header.headImg.image = IMAGE_WITH_NAME(@"nan");
//            }else{
//
//                header.headImg.image = IMAGE_WITH_NAME(@"nv");
//            }
//        }
        
        header.addBtn.hidden = YES;
        
        

        header.intentDetailHeaderAddBlock = ^{
            
//            AddEncumbrancerVC *nextVC = [[AddEncumbrancerVC alloc] init];
//            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.intentDetailHeaderEditBlock = ^{
            
//            ModifyNumeralVC *nextVC = [[ModifyNumeralVC alloc] initWithRowId:self->_row_id projectId:self->_project_id info_Id:self->_info_id dataDic:self->_dataDic];
//            nextVC.advicer_id = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"advicer"]];
//            nextVC.advicer_name = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"name"]];
//            nextVC.projectName = self->_projectName;
//            nextVC.modifyNumeralVCBlock = ^{
//
//                [self RequestMethod];
//            };
//            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.intentDetailHeaderCollBlock = ^(NSInteger index) {
            
            self->_num = index;
//            NSArray *arr = @[[NSString stringWithFormat:@"姓名：%@",self->_dataDic[@"beneficiary"][index][@"name"]],[NSString stringWithFormat:@"手机：%@",self->_dataDic[@"beneficiary"][index][@"tel"]],[NSString stringWithFormat:@"证件类型：%@",self->_dataDic[@"beneficiary"][index][@"card_type"]],[NSString stringWithFormat:@"证件号码：%@",self->_dataDic[@"beneficiary"][index][@"card_num"]],[NSString stringWithFormat:@"出生日期：%@",self->_dataDic[@"beneficiary"][index][@"birth"]],[NSString stringWithFormat:@"通讯地址：%@",self->_dataDic[@"beneficiary"][index][@"address"]],[NSString stringWithFormat:@"邮政编码：%@",self->_dataDic[@"beneficiary"][index][@"mail_code"]],[NSString stringWithFormat:@"产权比例：%@%@",self->_dataDic[@"beneficiary"][index][@"property"],@"%"],[NSString stringWithFormat:@"类型：%@",[self->_dataDic[@"beneficiary"][index][@"beneficiary_type"] integerValue] == 1? @"主权益人":@"附权益人"]];
//            [self->_dataArr replaceObjectAtIndex:1 withObject:arr];
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
            
            header.titleL.text = @"排号信息";
        }else if (section == 3) {
            
            header.titleL.text = @"交易信息";
        }else if (section == _dataArr.count - 1){
            
            header.titleL.text = @"附件信息";
        }else{
            
            header.titleL.text = @"审核信息";
        }
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 4 && indexPath.row == 2) {

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
        [cell.moreBtn setTitle:@"查看审核详情" forState:UIControlStateNormal];
        cell.infoDetailCellBlock = ^{

//            AuditDetailVC *nextVC = [[AuditDetailVC alloc] init];
//            nextVC.status = @"1";
//            nextVC.requestId = self->_row_id;
//            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_project_id];
//            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
    }else if (indexPath.section == 3 && indexPath.row == 2) {

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
        [cell.moreBtn setTitle:@"查看归属人详情" forState:UIControlStateNormal];
        cell.infoDetailCellBlock = ^{

//            BelongDetailVC *nextVC = [[BelongDetailVC alloc] initWithDataArr:self->_dataDic[@"advicer"]];
//            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
    }else{
    
        CallTelegramCustomDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCustomDetailInfoCell"];
        if (!cell) {
            
            cell = [[CallTelegramCustomDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCustomDetailInfoCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 1 && indexPath.row == 1) {
            
            // 下划线
            NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:_dataArr[indexPath.section][indexPath.row] attributes:attribtDic];
            cell.contentL.attributedText = attribtStr;
            
            cell.callTelegramCustomDetailInfoCellPhoneBlock = ^{
                
                NSString *phone = [self->_dataArr[indexPath.section][indexPath.row] substringFromIndex:3];
                if (phone.length) {
                    
                    //获取目标号码字符串,转换成URL
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
                    //调用系统方法拨号
                    [[UIApplication sharedApplication] openURL:url];
                }else{
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
                }
            };
        }else{
            
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:@""];
            cell.contentL.attributedText = attribtStr;
            cell.contentL.text = _dataArr[indexPath.section][indexPath.row];
            cell.callTelegramCustomDetailInfoCellPhoneBlock = ^{
                
            };
        }
        return cell;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"签租详情";
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
