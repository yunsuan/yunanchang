//
//  OrderRentDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "OrderRentDetailVC.h"

#import "FileReadingVC.h"
#import "ShopBelongDetailVC.h"
#import "StageDetailVC.h"
#import "ShopAuditDetailVC.h"
#import "ModifyOrderRentVC.h"
#import "ShopAuditTaskDetailVC.h"
#import "AddSignRentVC.h"

#import "NumeralDetailInvalidView.h"

#import "BaseHeader.h"
#import "ShopDetailHeader.h"
#import "InfoDetailCell.h"
#import "EnclosureCell.h"
#import "CallTelegramCustomDetailInfoCell.h"

@interface OrderRentDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSInteger _num;
    
    NSString *_sub_id;
    
    NSString *_phone;
    
    NSArray *_certArr;
    
    NSMutableDictionary *_dataDic;
    
    NSMutableArray *_dataArr;
    NSMutableArray *_advicerArr;
    NSMutableArray *_stageArr;;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation OrderRentDetailVC

- (instancetype)initWithBusinessId:(NSString *)businessId
{
    self = [super init];
    if (self) {
        
        _sub_id = businessId;
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
    _stageArr = [@[] mutableCopy];
    _certArr = @[@{@"param":@"身份证",@"id":@"1"},@{@"param":@"户口簿",@"id":@"2"},@{@"param":@"驾驶证",@"id":@"3"},@{@"param":@"军官证",@"id":@"4"},@{@"param":@"工商营业执照",@"id":@"5"},@{@"param":@"其他",@"id":@"6"}];
}

- (void)RequestMethod{
    
    [BaseRequest GET:TradeSubGetTradeSubDetail_URL parameters:@{@"sub_id":_sub_id} success:^(id  _Nonnull resposeObject) {

            if ([resposeObject[@"code"] integerValue] == 200) {

                self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
                self->_phone = [NSString stringWithFormat:@"%@",self->_dataDic[@"business_info"][@"contact_tel"]];
                NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self->_dataDic[@"shop_detail_list"]];
                for (int i = 0; i < tempArr.count; i++) {

                    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:tempArr[i]];
                    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

                        if ([obj isKindOfClass:[NSNull class]]) {

                            [tempDic setObject:@"" forKey:key];
                        }else{

                            [tempDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
                        }
                    }];
                    [tempArr replaceObjectAtIndex:i withObject:tempDic];
                }
                [self->_dataDic setObject:tempArr forKey:@"shop_list"];
//                if ([self->_dataDic[@"disabled_state"] integerValue] == 2) {
//
//                    self.rightBtn.hidden = YES;
//                }else{
//
//                    self.rightBtn.hidden = NO;
//                }
                self->_advicerArr = resposeObject[@"data"][@"advicer_list"];
                self->_stageArr = resposeObject[@"data"][@"stage_list"];
                double money = 0;
                for (int i = 0; i < self->_stageArr.count; i++) {

                    money = [self DecimalNumber:[self AddNumber:money num2:[self->_stageArr[i][@"total_rent"] doubleValue]] num2:[self->_stageArr[i][@"free_rent"] doubleValue]];
//                    money = [self AddNumber:money num2:[self->_stageArr[i][@"total_rent"] doubleValue]];
                }
                
                NSString *cardStr = @" ";
                for (int i = 0; i < self->_certArr.count; i++) {
                    
                    if ([self->_dataDic[@"card_type"] integerValue] == [self->_certArr[i][@"id"] integerValue]) {
                        
                        cardStr = self->_certArr[i][@"param"];
                    }
                }
                self->_dataArr = [NSMutableArray arrayWithArray:@[@[],@[[NSString stringWithFormat:@"房间：%@%@%@",self->_dataDic[@"shop_detail_list"][0][@"build_name"],(self->_dataDic[@"shop_detail_list"][0][@"unit_name"] && ![self->_dataDic[@"shop_detail_list"][0][@"unit_name"] isKindOfClass:[NSNull class]])?self->_dataDic[@"shop_detail_list"][0][@"unit_name"]:@"" ,self->_dataDic[@"shop_detail_list"][0][@"name"]],[NSString stringWithFormat:@"面积：%@㎡",self->_dataDic[@"shop_detail_list"][0][@"build_size"]],[NSString stringWithFormat:@"租金：%@元/月/㎡",self->_dataDic[@"shop_detail_list"][0][@"total_rent"]]],@[[NSString stringWithFormat:@"商家名称：%@",self->_dataDic[@"business_info"][@"business_name"]],[NSString stringWithFormat:@"联系人：%@",self->_dataDic[@"business_info"][@"contact"]],[NSString stringWithFormat:@"所属区域：%@%@%@",self->_dataDic[@"business_info"][@"province_name"],self->_dataDic[@"business_info"][@"city_name"],self->_dataDic[@"business_info"][@"district_name"]],[NSString stringWithFormat:@"认知途径：%@",self->_dataDic[@"business_info"][@"source_name"]],[NSString stringWithFormat:@"承租面积：%@㎡",self->_dataDic[@"business_info"][@"lease_size"]],[NSString stringWithFormat:@"承受租价价格：%@元/月/㎡",self->_dataDic[@"business_info"][@"lease_money"]],[NSString stringWithFormat:@"经营关系：%@",self->_dataDic[@"business_info"][@"business_type_name"]],[NSString stringWithFormat:@"经营业态：%@",self->_dataDic[@"business_info"][@"format_name"]]],@[[NSString stringWithFormat:@"定租编号：%@",self->_dataDic[@"sub_code"]],[NSString stringWithFormat:@"签约人：%@",self->_dataDic[@"signatory"]],[NSString stringWithFormat:@"证件类型：%@",cardStr],[NSString stringWithFormat:@"签约人证件号码：%@",self->_dataDic[@"card_num"]],[NSString stringWithFormat:@"定金金额：%@元",self->_dataDic[@"down_pay"]],[NSString stringWithFormat:@"租期：%@个月",self->_dataDic[@"rent_month_num"]],[NSString stringWithFormat:@"开业时间：%@",self->_dataDic[@"open_time"]],[NSString stringWithFormat:@"付款方式：押%@付%@",[self->_dataDic[@"pay_way"] componentsSeparatedByString:@","][0],[self->_dataDic[@"pay_way"] componentsSeparatedByString:@","][1]],[NSString stringWithFormat:@"提醒签约时间：%@",self->_dataDic[@"remind_time"]],[NSString stringWithFormat:@"登记时间：%@",self->_dataDic[@"sign_time"]],[NSString stringWithFormat:@"登记人：%@",self->_dataDic[@"sign_agent_name"]]],@[[NSString stringWithFormat:@"合计总实付金额：%.2f元",money]]]];
                if ([self->_dataDic[@"check_state"] integerValue] != 2) {

                    if ([self->_dataDic[@"progressList"] isKindOfClass:[NSDictionary class]]) {

                        NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"申请流程：%@",self->_dataDic[@"progressList"][@"progress_name"]],[NSString stringWithFormat:@"申请人：%@",self->_dataDic[@"sign_agent_name"]],[NSString stringWithFormat:@"登记时间：%@",self->_dataDic[@"progressList"][@"list"][0][@"update_time"]]]];
                        if ([self->_dataDic[@"progressList"][@"check_type"] integerValue] == 1) {

                            [arr insertObject:@"流程类型：自由流程" atIndex:1];
                        }else if ([self->_dataDic[@"progressList"][@"check_type"] integerValue] == 2){

                            [arr insertObject:@"流程类型：固定流程" atIndex:1];
                        }else{

                            [arr insertObject:@"流程类型：混合流程" atIndex:1];
                        }
                        [self->_dataArr addObject:arr];
                    }
                }
                [self->_dataArr addObject:self->_dataDic[@"enclosure_list"]];
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
            
            ShopAuditTaskDetailVC *nextVC = [[ShopAuditTaskDetailVC alloc] init];
            nextVC.status = @"5";
            nextVC.requestId = self->_sub_id;
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_project_id];
            nextVC.shopAuditTaskDetailVCBlock = ^{
                
                [self RequestMethod];
    //            if (self.numeralDetailVCBlock) {
    //
    //                self.numeralDetailVCBlock();
    //            }
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }];
    
    UIAlertAction *sign = [UIAlertAction actionWithTitle:@"转签租" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        if ([self->_dataDic[@"receive_state"] integerValue] == 1) {
//
            AddSignRentVC *nextVC = [[AddSignRentVC alloc] initWithProjectId:self->_project_id info_id:self->_info_id];
            nextVC.from_type = @"3";
            nextVC.dataDic = self->_dataDic;
            nextVC.addSignRentVCBlock = ^{
            
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
//        }else{
//
//            [self showContent:@"未收款不能转签约"];
//        }
    }];
    
    UIAlertAction *quit = [UIAlertAction actionWithTitle:@"作废" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"" WithCancelBlack:^{
            
        } WithDefaultBlack:^{
           
            [BaseRequest POST:TradeSubTradeSubDel_URL parameters:@{@"sub_id":self->_sub_id} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [self showContent:@"作废成功"];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [self showContent:@"网络错误"];
            }];
        }];
    }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    if ([self.need_check integerValue] == 1 && [self->_dataDic[@"disabled_state"] integerValue] == 0 && ([self->_dataDic[@"check_state"] integerValue] != 0 || [self->_dataDic[@"check_state"] integerValue] != 1)) {
        
        [alert addAction:audit];
    }
    

    if ([self->_dataDic[@"disabled_state"] integerValue] == 0 && [self->_dataDic[@"check_state"] integerValue] == 1 && [self->_dataDic[@"receive_state"] integerValue] == 1) {

        [alert addAction:sign];
    }

    if ([self->_dataDic[@"disabled_state"] integerValue] == 0 && [self->_dataDic[@"check_state"] integerValue] == 2 && [self->_dataDic[@"receive_state"] integerValue] == 0) {

        [alert addAction:quit];
    }
    
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
        
        ShopDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShopDetailHeader"];
        if (!header) {
            
            header = [[ShopDetailHeader alloc] initWithReuseIdentifier:@"ShopDetailHeader"];
        }
        
        header.dataDic = self->_dataDic;
        header.num = _num;
        if (self.audit.length) {
            
            header.editBtn.hidden = YES;
        }
        
        header.addBtn.hidden = YES;
        

        header.shopDetailHeaderAddBlock = ^{
            
//            AddEncumbrancerVC *nextVC = [[AddEncumbrancerVC alloc] init];
//            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.shopDetailHeaderEditBlock = ^{
            
            ModifyOrderRentVC *nextVC = [[ModifyOrderRentVC alloc] initWithProjectId:self->_project_id info_id:self->_info_id];
            nextVC.dataDic = self->_dataDic;
            nextVC.modifyOrderRentVCBlock = ^{

                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.shopDetailHeaderCollBlock = ^(NSInteger index) {
            
            self->_num = index;
            NSArray *arr = @[[NSString stringWithFormat:@"房间：%@%@%@",self->_dataDic[@"shop_detail_list"][index][@"build_name"],(self->_dataDic[@"shop_detail_list"][index][@"unit_name"] && ![self->_dataDic[@"shop_detail_list"][index][@"unit_name"] isKindOfClass:[NSNull class]])?self->_dataDic[@"shop_detail_list"][index][@"unit_name"]:@"",self->_dataDic[@"shop_detail_list"][index][@"name"]],[NSString stringWithFormat:@"面积：%@㎡",self->_dataDic[@"shop_detail_list"][index][@"build_size"]],[NSString stringWithFormat:@"租金：%@元/月/㎡",self->_dataDic[@"shop_detail_list"][index][@"total_rent"]]];
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
            
            header.titleL.text = @"房源信息";
        }else if (section == 2) {
            
            header.titleL.text = @"商家信息";
        }else if (section == 3) {
            
            header.titleL.text = @"定租信息";
        }else if (section == _dataArr.count - 1){
            
            header.titleL.text = @"附件信息";
        }else if (section == 4){
         
            header.titleL.text = @"租金信息";
        }else{
            
            header.titleL.text = @"审核信息";
        }
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 5 && indexPath.row == 2) {

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

            ShopAuditDetailVC *nextVC = [[ShopAuditDetailVC alloc] init];
            nextVC.status = @"5";
            nextVC.requestId = self->_sub_id;
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_project_id];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
    }else if (indexPath.section == 3 && indexPath.row == 9) {

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

            ShopBelongDetailVC *nextVC = [[ShopBelongDetailVC alloc] initWithDataArr:self->_dataDic[@"advicer_list"]];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
    }else if (indexPath.section == 4 && indexPath.row == 0) {

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
        [cell.moreBtn setTitle:@"查看租金详情" forState:UIControlStateNormal];
        cell.infoDetailCellBlock = ^{

            StageDetailVC *nextVC = [[StageDetailVC alloc] initWithDataArr:self->_stageArr];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
    }else if(indexPath.section == _dataArr.count - 1){
        
        EnclosureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnclosureCell"];
        if (!cell) {
            
            cell = [[EnclosureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnclosureCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataArr = _dataDic[@"enclosure_list"];
        
        cell.enclosureCellBlock = ^(NSInteger idx) {
          
            FileReadingVC *nextVC = [[FileReadingVC alloc] initWithUrlString:self->_dataDic[@"enclosure_list"][idx][@"url"]];
            [self.navigationController pushViewController:nextVC animated:YES];
            NSLog(@"%@",self->_dataDic[@"enclosure_list"]);
        };
        
        return cell;
        
    }else{
    
        CallTelegramCustomDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCustomDetailInfoCell"];
        if (!cell) {
            
            cell = [[CallTelegramCustomDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCustomDetailInfoCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 2 && indexPath.row == 1) {
            
            // 下划线
            NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:_dataArr[indexPath.section][indexPath.row] attributes:attribtDic];
            cell.contentL.attributedText = attribtStr;
            
            cell.callTelegramCustomDetailInfoCellPhoneBlock = ^{
                
                NSString *phone = [self->_phone componentsSeparatedByString:@","][0];
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
    
    self.titleLabel.text = @"定租详情";
    self.navBackgroundView.backgroundColor = CLBlueBtnColor;
    self.line.hidden = YES;
    self.titleLabel.textColor = CLWhiteColor;
    
    [self.leftButton setImage:[UIImage imageNamed:@"leftarrow_white"] forState:UIControlStateNormal];
    if ([self.powerDic[@"contract"] boolValue] || [self.powerDic[@"row"] boolValue] || [self.powerDic[@"contract"] boolValue] || [self.powerDic[@"update"] boolValue]) {

        self.rightBtn.hidden = NO;
    }else{

        self.rightBtn.hidden = YES;
    }
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
