//
//  NumeralDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/1.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NumeralDetailVC.h"

#import "ModifyNumeralVC.h"

#import "AddEncumbrancerVC.h"
#import "AddOrderVC.h"
#import "AddSignVC.h"

#import "AuditTaskDetailVC.h"
#import "AuditDetailVC.h"
#import "BelongDetailVC.h"
#import "SincerityChangeVC.h"

#import "NumeralDetailInvalidView.h"
#import "SinglePickView.h"

#import "NumeralDetailHeader.h"
#import "BaseHeader.h"

#import "CallTelegramCustomDetailInfoCell.h"
#import "InfoDetailCell.h"

@interface NumeralDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSInteger _num;
    
    NSString *_row_id;
    NSString *_project_id;
    NSString *_info_id;
    
    NSMutableDictionary *_dataDic;
    
    NSMutableArray *_advicerArr;
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation NumeralDetailVC

- (instancetype)initWithRowId:(NSString *)row_id project_id:(nonnull NSString *)project_id info_id:(nonnull NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _row_id = row_id;
        _project_id = project_id;
        _info_id = info_id;
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
    _dataDic = [@{} mutableCopy];
    _advicerArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectRowGetRowDetail_URL parameters:@{@"row_id":_row_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            if ([self->_dataDic[@"disabled_state"] integerValue] == 2) {
                
                self.rightBtn.hidden = YES;
            }else{
                
                self.rightBtn.hidden = NO;
            }
            self->_advicerArr = resposeObject[@"data"][@"advicer"];
            NSString *str = @"";
            for (int i = 0; i < self->_advicerArr.count; i++) {
                
                if (str.length) {
                    
                    str = [NSString stringWithFormat:@"%@,%@",str,self->_advicerArr[i][@"name"]];
                }else{
                    
                    str = [NSString stringWithFormat:@"%@",self->_advicerArr[i][@"name"]];
                }
            }
            self->_dataArr = [NSMutableArray arrayWithArray:@[@[],@[[NSString stringWithFormat:@"姓名：%@",self->_dataDic[@"beneficiary"][0][@"name"]],[NSString stringWithFormat:@"手机：%@",self->_dataDic[@"beneficiary"][0][@"tel"]],[NSString stringWithFormat:@"证件类型：%@",self->_dataDic[@"beneficiary"][0][@"card_type"]],[NSString stringWithFormat:@"证件号码：%@",self->_dataDic[@"beneficiary"][0][@"card_num"]],[NSString stringWithFormat:@"出生日期：%@",self->_dataDic[@"beneficiary"][0][@"birth"]],[NSString stringWithFormat:@"通讯地址：%@",self->_dataDic[@"beneficiary"][0][@"address"]],[NSString stringWithFormat:@"邮政编码：%@",self->_dataDic[@"beneficiary"][0][@"mail_code"]],[NSString stringWithFormat:@"产权比例：%@%@",self->_dataDic[@"beneficiary"][0][@"property"],@"%"],[NSString stringWithFormat:@"类型：%@",[self->_dataDic[@"beneficiary"][0][@"beneficiary_type"] integerValue] == 1? @"主权益人":@"附权益人"]],@[[NSString stringWithFormat:@"申请流程：：%@",self->_dataDic[@"progressList"][@"progress_name"]],[NSString stringWithFormat:@"流程类型：%@",[self->_dataDic[@"progressList"][@"check_type"] integerValue] == 1 ? @"自由流程":@"固定流程"],[NSString stringWithFormat:@"申请人：%@",self->_dataDic[@"sign_agent_name"]],[NSString stringWithFormat:@"登记时间：%@",self->_dataDic[@"row_time"]]],@[[NSString stringWithFormat:@"排号号码：%@",self->_dataDic[@"row_code"]],[NSString stringWithFormat:@"排号时间：%@",self->_dataDic[@"row_time"]],[NSString stringWithFormat:@"有效期至：%@",self->_dataDic[@"end_time"]],[NSString stringWithFormat:@"归属人：%@",str],[NSString stringWithFormat:@"登记人：%@",self->_dataDic[@"sign_agent_name"]],[NSString stringWithFormat:@"归属时间：%@",self->_dataDic[@"row_time"]]]]];
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
    
    UIAlertAction *audit = [UIAlertAction actionWithTitle:@"审核" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        AuditTaskDetailVC *nextVC = [[AuditTaskDetailVC alloc] init];
        nextVC.status = @"1";
        nextVC.requestId = self->_row_id;
        nextVC.project_id = [NSString stringWithFormat:@"%@",self->_project_id];
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *sign = [UIAlertAction actionWithTitle:@"转签约" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self->_dataDic[@"receive_state"] integerValue] == 1) {
            
            AddSignVC *nextVC = [[AddSignVC alloc] initWithRow_id:self->_row_id personArr:self->_dataDic[@"beneficiary"] project_id:self->_project_id info_id:self->_info_id];
            nextVC.from_type = @"3";
            nextVC.advicer_id = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"advicer_id"]];
            nextVC.advicer_name = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"advicer_name"]];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            [self showContent:@"未收款不能转签约"];
        }
    }];
    
    UIAlertAction *order = [UIAlertAction actionWithTitle:@"转定单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self->_dataDic[@"receive_state"] integerValue] == 1) {
            
            AddOrderVC *nextVC = [[AddOrderVC alloc] initWithRow_id:self->_row_id personArr:self->_dataDic[@"beneficiary"] project_id:self->_project_id info_id:self->_info_id];
            nextVC.from_type = @"3";
            nextVC.advicer_id = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"advicer_id"]];
            nextVC.advicer_name = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"advicer_name"]];
            nextVC.addOrderVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            [self showContent:@"未收款不能转定单"];
        }
    }];
    
    UIAlertAction *change = [UIAlertAction actionWithTitle:@"变更" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[@{@"id":@"1",@"param":@"排号增加诚意金"},@{@"id":@"2",@"param":@"排号退号"},@{@"id":@"3",@"param":@"排号更名"},@{@"id":@"4",@"param":@"排号增减权益人"}]];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            if ([ID integerValue] == 1) {
                
                SincerityChangeVC *nextVC = [[SincerityChangeVC alloc] initWithProject_id:self->_project_id sincerity:self->_dataDic[@"sincerity"]];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else if ([ID integerValue] == 2){
                
            }else if ([ID integerValue] == 3){
                
            }else{
                
                
            }
        };
        [self.view addSubview:view];
    }];
    
    UIAlertAction *quit = [UIAlertAction actionWithTitle:@"作废" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NumeralDetailInvalidView *view = [[NumeralDetailInvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        view.numeralDetailInvalidViewBlock = ^{
          
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:@{@"type":@"1",@"id":self->_row_id}];
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
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    if ([self.need_check integerValue] == 1 && [self->_dataDic[@"disabled_state"] integerValue] == 0 && [self->_dataDic[@"check_state"] integerValue] == 2) {
        
        [alert addAction:audit];
    }

//    if ([self.powerDic[@"order"] boolValue]) {
    
        [alert addAction:order];
//    }
//    if ([self.powerDic[@"contract"] boolValue]) {
    
        [alert addAction:sign];
//    }
//    if ([self.powerDic[@"giveUp"] boolValue]) {
    
        [alert addAction:quit];
//    }
    if ([self->_dataDic[@"disabled_state"] integerValue] == 0 && [self->_dataDic[@"check_state"] integerValue] == 1) {
        
        [alert addAction:change];
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
        
        header.dataDic = self->_dataDic;
        header.moneyL.text = [NSString stringWithFormat:@"诚意金：%@元",self->_dataDic[@"sincerity"]];
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
            
            AddEncumbrancerVC *nextVC = [[AddEncumbrancerVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.numeralDetailHeaderEditBlock = ^{
            
            ModifyNumeralVC *nextVC = [[ModifyNumeralVC alloc] initWithRowId:self->_row_id projectId:self->_project_id info_Id:self->_info_id dataDic:self->_dataDic];
            nextVC.advicer_id = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"advicer_id"]];
            nextVC.advicer_name = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"advicer_name"]];
            nextVC.projectName = self->_projectName;
            nextVC.modifyNumeralVCBlock = ^{
                
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
            
            header.titleL.text = @"审核信息";
        }else{
            
            header.titleL.text = @"排号信息";
        }
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2 && indexPath.row == 3) {
        
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
            
            AuditDetailVC *nextVC = [[AuditDetailVC alloc] init];
            nextVC.status = @"1";
            nextVC.requestId = self->_row_id;
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_project_id];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
    }else if (indexPath.section == 3 && indexPath.row == 3) {
        
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
            
            BelongDetailVC *nextVC = [[BelongDetailVC alloc] initWithDataArr:self->_dataDic[@"advicer"]];
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

- (void)initUI{
    
    self.titleLabel.text = @"排号详情";
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
