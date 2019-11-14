//
//  IntentStoreDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "IntentStoreDetailVC.h"

#import "ModifyIntentStoreVC.h"
#import "AuditDetailVC.h"
#import "FileReadingVC.h"
#import "BelongDetailVC.h"

#import "BaseHeader.h"
#import "IntentDetailHeader.h"
#import "InfoDetailCell.h"
#import "EnclosureCell.h"
#import "CallTelegramCustomDetailInfoCell.h"
#import "NumeralDetailInvalidView.h"

@interface IntentStoreDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSInteger _num;
    
    NSString *_businessId;
    
    NSMutableDictionary *_dataDic;
    
    NSMutableArray *_dataArr;
    NSMutableArray *_advicerArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation IntentStoreDetailVC

- (instancetype)initWithBusinessId:(NSString *)businessId
{
    self = [super init];
    if (self) {
        
        _businessId = businessId;
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
    
    [BaseRequest GET:ShopRowGetTradeRowDetail_URL parameters:@{@"row_id":_businessId} success:^(id  _Nonnull resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {

            self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self->_dataDic[@"shop_detail_list"][@"shop_list"]];
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
            if ([self->_dataDic[@"disabled_state"] integerValue] == 2) {

                self.rightBtn.hidden = YES;
            }else{

                self.rightBtn.hidden = NO;
            }
            self->_advicerArr = resposeObject[@"data"][@"advicer"];
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
            self->_dataArr = [NSMutableArray arrayWithArray:@[@[],@[[NSString stringWithFormat:@"房间：%@-%@-%@",self->_dataDic[@"shop_list"][0][@"build_name"],self->_dataDic[@"shop_list"][0][@"unit_name"],self->_dataDic[@"shop_list"][0][@"name"]],[NSString stringWithFormat:@"面积：%@㎡",self->_dataDic[@"shop_list"][0][@"build_size"]],[NSString stringWithFormat:@"租金：%@元/月/㎡",self->_dataDic[@"shop_list"][0][@"total_rent"]]],@[[NSString stringWithFormat:@"商家名称：%@",self->_dataDic[@"sign_agent_name"]],[NSString stringWithFormat:@"联系人：%@/%@",self->_dataDic[@"contact"],self->_dataDic[@"contact_tel"]],[NSString stringWithFormat:@"所属区域：%@%@%@",self->_dataDic[@"province_name"],self->_dataDic[@"city_name"],self->_dataDic[@"district_name"]],[NSString stringWithFormat:@"认知途径：%@",self->_dataDic[@"source_name"]],[NSString stringWithFormat:@"承租面积：%@㎡",self->_dataDic[@"lease_size"]],[NSString stringWithFormat:@"承受租价价格：%@元/月/㎡",self->_dataDic[@"lease_money"]],[NSString stringWithFormat:@"经营关系：%@",self->_dataDic[@"business_type_name"]],[NSString stringWithFormat:@"经营业态：%@",self->_dataDic[@"format_name"]]],@[[NSString stringWithFormat:@"意向编号：%@",self->_dataDic[@"row_code"]],[NSString stringWithFormat:@"诚意金：%@元",self->_dataDic[@"sincerity"]],[NSString stringWithFormat:@"意向租期：%@至%@",self->_dataDic[@"start_time"],self->_dataDic[@"end_time"]],[NSString stringWithFormat:@"登记时间：%@",self->_dataDic[@"sign_time"]],[NSString stringWithFormat:@"登记人：%@",self->_dataDic[@"sign_agent_name"]]]]];
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
//            [self->_dataArr addObject:@[]];
            [self->_dataArr addObject:self->_dataDic[@"enclosure"]];
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
    
    UIAlertAction *quit = [UIAlertAction actionWithTitle:@"作废" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NumeralDetailInvalidView *view = [[NumeralDetailInvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        view.numeralDetailInvalidViewBlock = ^{
          
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:@{@"type":@"1",@"id":self->_businessId}];
//            if ([self isEmpty:view.reasonTV.text]) {
//
//                [tempDic setObject:view.reasonTV.text forKey:@"disabled_reason"];
//            }
            [BaseRequest POST:ShopRowTradeRowDel_URL parameters:tempDic success:^(id  _Nonnull resposeObject) {
                
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
    if ([self->_dataDic[@"disabled_state"] integerValue] == 0 && [self->_dataDic[@"check_state"] integerValue] == 2 && [self->_dataDic[@"receive_state"] integerValue] == 2) {

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
        
        IntentDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"IntentDetailHeader"];
        if (!header) {
            
            header = [[IntentDetailHeader alloc] initWithReuseIdentifier:@"IntentDetailHeader"];
        }
        
        header.storeIntentDic = self->_dataDic;

        header.num = _num;
        
        header.addBtn.hidden = YES;
        
        

        header.intentDetailHeaderAddBlock = ^{
            
//            AddEncumbrancerVC *nextVC = [[AddEncumbrancerVC alloc] init];
//            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.intentDetailHeaderEditBlock = ^{
            
            ModifyIntentStoreVC *nextVC = [[ModifyIntentStoreVC alloc] initWithRowId:self->_businessId projectId:self->_project_id info_Id:self->_info_id dataDic:self->_dataDic];
            nextVC.advicer_id = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"advicer"]];
            nextVC.advicer_name = [NSString stringWithFormat:@"%@",self->_advicerArr[0][@"name"]];
            nextVC.projectName = self->_projectName;
            nextVC.modifyIntentStoreVCBlock = ^{

                if (self.intentStoreDetailVCBlock) {
                    
                    self.intentStoreDetailVCBlock();
                }
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.intentDetailHeaderCollBlock = ^(NSInteger index) {
            
            self->_num = index;
            
            NSArray *arr = @[[NSString stringWithFormat:@"房间：%@-%@-%@",self->_dataDic[@"shop_list"][index][@"build_name"],self->_dataDic[@"shop_list"][index][@"unit_name"],self->_dataDic[@"shop_list"][index][@"name"]],[NSString stringWithFormat:@"面积：%@㎡",self->_dataDic[@"shop_list"][index][@"build_size"]],[NSString stringWithFormat:@"租金：%@元/月/㎡",self->_dataDic[@"shop_list"][index][@"total_rent"]]];
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
            
            header.titleL.text = @"意向信息";
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

            AuditDetailVC *nextVC = [[AuditDetailVC alloc] init];
            nextVC.status = @"1";
            nextVC.requestId = self->_businessId;
            nextVC.project_id = [NSString stringWithFormat:@"%@",self->_project_id];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
    }else if (indexPath.section == 3 && indexPath.row == 0) {

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
    }else if(indexPath.section == _dataArr.count - 1){
        
        EnclosureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnclosureCell"];
        if (!cell) {
            
            cell = [[EnclosureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EnclosureCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataArr = _dataDic[@"enclosure"];
        
        cell.enclosureCellBlock = ^(NSInteger idx) {
          
            FileReadingVC *nextVC = [[FileReadingVC alloc] initWithUrlString:self->_dataDic[@"enclosure"][idx][@"url"]];
            [self.navigationController pushViewController:nextVC animated:YES];
            NSLog(@"%@",self->_dataDic[@"enclosure"]);
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
                
                NSString *phone = [self->_dataArr[indexPath.section][indexPath.row] componentsSeparatedByString:@"/"][1];
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
    
    self.titleLabel.text = @"意向商家详情";
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
