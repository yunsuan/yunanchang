//
//  AddOrderRentVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddOrderRentVC.h"

#import "AddIntentSelectStoreVC.h"
#import "AddStoreVC.h"
#import "AddOrderRentalDetailVC.h"
#import "ShopRoomVC.h"
#import "ModifyNoChangeStoreVC.h"

#import "TitleRightBtnHeader.h"

#import "AddIntentStoreAddCell.h"
#import "AddIntentStoreRoomCell.h"

#import "AddIntentStoreDoubleBtnCell.h"
#import "StoreCell.h"

#import "AddOrderRentInfoCell.h"

#import "AddOrderRentPriceCell.h"

#import "AddIntentStoreProccessCell.h"

#import "AddIntentStoreFileCell.h"

#import "ModifyAndAddRentalView.h"
#import "SinglePickView.h"
#import "DateChooseView.h"

@interface AddOrderRentVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_info_id;
    NSString *_project_id;
    NSString *_role_id;
    NSString *_chargeId;
    
    NSString *_form_id;
    
    NSInteger _canCommit;
    NSInteger _isDown;
    
    NSArray *_titleArr;
    
    NSArray *_certArr;
    
    
    NSMutableDictionary *_orderDic;
    
    NSMutableDictionary *_rentPirceDic;
    
    NSMutableDictionary *_progressDic;
    
    NSMutableArray *_roomArr;
    NSMutableArray *_storeArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_payArr1;
    NSMutableArray *_payArr2;
    NSMutableArray *_progressArr;
    NSMutableArray *_progressAllArr;
    NSMutableArray *_roleArr;
    NSMutableArray *_rolePersonArr;
    NSMutableArray *_rolePersonSelectArr;
    NSMutableArray *_imgArr;
    NSMutableArray *_stageArr;;;
    
    NSDateFormatter *_secondFormatter;
}
@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddOrderRentVC

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _project_id = projectId;
        _info_id = info_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _stageArr = [@[] mutableCopy];
    _payArr1 = [@[] mutableCopy];
    _payArr2 = [@[] mutableCopy];
    
    self->_canCommit = 1;
    _certArr = @[@{@"param":@"身份证",@"id":@"1"},@{@"param":@"户口簿",@"id":@"2"},@{@"param":@"驾驶证",@"id":@"3"},@{@"param":@"军官证",@"id":@"4"},@{@"param":@"工商营业执照",@"id":@"5"},@{@"param":@"其他",@"id":@"6"}];
    for (int i = 0; i < 12; i++) {
        
        if (i == 0 || i == 1 || i == 2 || i == 5 || i == 11) {
            
            [_payArr1 addObject:@{@"param":[NSString stringWithFormat:@"押%d",i + 1],@"id":[NSString stringWithFormat:@"%d",i + 1]}];
            [_payArr2 addObject:@{@"param":[NSString stringWithFormat:@"付%d",i + 1],@"id":[NSString stringWithFormat:@"%d",i + 1]}];
        }
    }
    _titleArr = @[@"房源信息",@"商家信息",@"定租信息",@"租金信息",@"流程信息",@"附件文件"];
    _selectArr = [[NSMutableArray alloc] initWithArray:@[@1,@0,@0,@0,@0,@0]];
    
    _orderDic = [@{} mutableCopy];
    
    _rentPirceDic = [@{} mutableCopy];
    
    _progressDic = [@{} mutableCopy];
    
    _roomArr = [@[] mutableCopy];
    
    _storeArr = [@[] mutableCopy];
    
    _progressArr = [@[] mutableCopy];
    _progressAllArr = [@[] mutableCopy];
    
    _roleArr = [@[] mutableCopy];
    _rolePersonArr = [@[] mutableCopy];
    _rolePersonSelectArr = [@[] mutableCopy];
    _imgArr = [@[] mutableCopy];
    
    _secondFormatter = [[NSDateFormatter alloc] init];
    [_secondFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    if (self.dataDic) {
        
        _roomArr = [[NSMutableArray alloc] initWithArray:self->_dataDic[@"shop_detail_list"]];
        if (self->_dataDic[@"business_info"]) {
        
//            _storeArr = [NSMutableArray arrayWithArray:@[self.dataDic[@"business_info"]]];
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self.dataDic[@"business_info"]];
            [tempDic setValue:[NSString stringWithFormat:@"%@",self.dataDic[@"business_id"]] forKey:@"business_id"];
            _form_id = [NSString stringWithFormat:@"%@",self.dataDic[@"row_id"]];
            _storeArr = [NSMutableArray arrayWithArray:@[tempDic]];
        }else{
            
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self->_dataDic];
            _storeArr = [[NSMutableArray alloc] initWithArray:@[tempDic]];
            _form_id = [NSString stringWithFormat:@"%@",self->_dataDic[@"business_id"]];
//            _storeArr = [[NSMutableArray alloc] initWithArray:@[@{@"business_name":self->_dataDic[@"business_name"],@"contact":self->_dataDic[@"contact"],@"lease_money":self->_dataDic[@"lease_money"],@"lease_size":self->_dataDic[@"lease_size"],@"create_time":self->_dataDic[@"create_time"],@"format_name":self->_dataDic[@"format_name"],@"business_id":[NSString stringWithFormat:@"%@",self->_dataDic[@"business_id"]]}]];
        }
        if (![self->_orderDic[@"down_pay"] length]) {
        
            if (_roomArr.count) {
                
                NSDictionary *dic = self->_roomArr[0][@"cost_set_list"];
                for (int i = 0; i < [dic[@"fixed"] count]; i++) {
                    
                    if ([dic[@"fixed"][i][@"name"] isEqualToString:@"定金"]) {
                        
                        if ([dic[@"fixed"][i][@"is_execute"] integerValue] == 1) {
                            
                            [self->_orderDic setValue:dic[@"fixed"][i][@"param"] forKey:@"down_pay"];
                        }
                    }
                }
            }
        }
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if (!_roomArr.count) {
        
        [self showContent:@"请选择房源"];
        return;
    }
    
    if (!_storeArr.count) {
        
        [self showContent:@"请选择商家"];
        return;
    }
    

    if (!_orderDic[@"sub_code"]) {

        [self showContent:@"请输入意向编号"];
        return;
    }

    if (!_orderDic[@"signatory"]) {

        [self showContent:@"请输入签约人"];
        return;
    }
    if (!_orderDic[@"card_type"]) {

        [self showContent:@"请选择证件类型"];
        return;
    }

    if (!_orderDic[@"card_num"]) {

        [self showContent:@"请输入证件号码"];
        return;
    }

    if (!_orderDic[@"down_pay"]) {

        [self showContent:@"请输入定金金额"];
        return;
    }
    if (!_orderDic[@"open_time"]) {

        [self showContent:@"请选择开业时间"];
        return;
    }

    if (!_orderDic[@"sub_time"]) {

        [self showContent:@"请选择定租时间"];
        return;
    }
    if (!_orderDic[@"remind_time"]) {

        [self showContent:@"请选择提醒签约时间"];
        return;
    }
    if (!_orderDic[@"start_time"]) {

        [self showContent:@"请选择租期开始时间"];
        return;
    }
    if (!_orderDic[@"rent_month_num"]) {

        [self showContent:@"请输入租期时长"];
        return;
    }
    if (!_orderDic[@"pay_way1"] || !_orderDic[@"pay_way2"]) {

        [self showContent:@"请选择付款方式"];
        return;
    }
    if (!_orderDic[@"deposit"]) {

        [self showContent:@"请输入押金金额"];
        return;
    }
    if (!_stageArr.count) {
        
        [self showContent:@"请生成租金信息"];
        return;
    }
    _canCommit = 1;
    [self ProgreesMethod];
}

- (void)CommitRequest{
    
    NSString *param = @"";
    if (!_isDown) {
        
        if (![_progressDic[@"progress_name"] length]) {
            [self showContent:@"请选择审批流程"];
            return;
        }
        if ([_progressDic[@"check_type"] integerValue] == 1) {

            if (!_progressDic[@"auditMC"]) {
                [self showContent:@"请选择流程类型"];
                return;
            }
        }
        if ([_progressDic[@"auditMC"] isEqualToString:@"自由流程"]) {

            for (int i = 0; i < _rolePersonSelectArr.count; i++) {

                if ([_rolePersonSelectArr[i] integerValue] == 1) {

                    if (param.length) {

                        param = [NSString stringWithFormat:@"%@,%@",param,_rolePersonArr[i][@"agent_id"]];
                    }else{

                        param = [NSString stringWithFormat:@"%@",_rolePersonArr[i][@"agent_id"]];
                    }
                }
            }
            if (!param.length) {

                [self showContent:@"请选择审核人员"];
                return;
            }
        }
    }
    
        
    NSMutableDictionary *dic = [@{} mutableCopy];
    NSString *room;
    for (int i = 0; i < _roomArr.count; i++) {
        
        if (i == 0) {
            
            room = [NSString stringWithFormat:@"%@",_roomArr[i][@"shop_id"]];
        }else{
            
            room = [NSString stringWithFormat:@"%@,%@",room,_roomArr[i][@"shop_id"]];
        }
    }
    [dic setValue:room forKey:@"shop_list"];
    
    NSString *store;
    for (int i = 0; i < _storeArr.count; i++) {
        
        if (i == 0) {
            
            store = [NSString stringWithFormat:@"%@",_storeArr[i][@"business_id"]];
        }else{
            
            store = [NSString stringWithFormat:@"%@,%@",store,_storeArr[i][@"business_id"]];
        }
    }
    if (self->_form_id.length) {
        
        [dic setValue:self->_form_id forKey:@"from_id"];
    }else{
        
        [dic setValue:store forKey:@"from_id"];
    }
    
    [dic setValue:store forKey:@"business_id"];
    NSMutableDictionary *tempDic = [@{} mutableCopy];
    [tempDic setValue:_storeArr[0][@"business_type"] forKey:@"business_type"];
    [tempDic setValue:_storeArr[0][@"resource_list"] forKey:@"resource_list"];
    [tempDic setValue:_storeArr[0][@"format_list"] forKey:@"format_list"];
    [tempDic setValue:_storeArr[0][@"source_list"] forKey:@"source_list"];
    [tempDic setValue:_storeArr[0][@"business_name"] forKey:@"business_name"];
    [tempDic setValue:_storeArr[0][@"business_name_short"] forKey:@"business_name_short"];
    [tempDic setValue:_storeArr[0][@"lease_size"] forKey:@"lease_size"];
    [tempDic setValue:_storeArr[0][@"lease_money"] forKey:@"lease_money"];
    [tempDic setValue:_storeArr[0][@"contact"] forKey:@"contact"];
    [tempDic setValue:_storeArr[0][@"contact_tel"] forKey:@"contact_tel"];
    [tempDic setValue:_storeArr[0][@"province"] forKey:@"province"];
    [tempDic setValue:_storeArr[0][@"city"] forKey:@"city"];
    [tempDic setValue:_storeArr[0][@"district"] forKey:@"district"];
    [tempDic setValue:_storeArr[0][@"address"] forKey:@"address"];
    [tempDic setValue:_storeArr[0][@"comment"] forKey:@"comment"];
    NSError *error;
    NSData *jsonData3 = [NSJSONSerialization dataWithJSONObject:tempDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString3 = [[NSString alloc]initWithData:jsonData3 encoding:NSUTF8StringEncoding];
    [dic setObject:jsonString3 forKey:@"business_info"];
    if ([self.from_type isEqualToString:@"2"]) {
        
        [dic setValue:@"2" forKey:@"from_type"];
    }else{
        
        [dic setValue:@"1" forKey:@"from_type"];
    }
    [dic setValue:_project_id forKey:@"project_id"];
    [dic setValue:_orderDic[@"sub_code"] forKey:@"sub_code"];
    [dic setValue:_orderDic[@"signatory"] forKey:@"signatory"];
    [dic setValue:_orderDic[@"card_type"] forKey:@"card_type"];
    [dic setValue:_orderDic[@"card_num"] forKey:@"card_num"];
    [dic setValue:_orderDic[@"end_time"] forKey:@"end_time"];
    [dic setValue:_orderDic[@"down_pay"] forKey:@"down_pay"];
    [dic setValue:_orderDic[@"open_time"] forKey:@"open_time"];
    [dic setValue:_orderDic[@"sub_time"] forKey:@"sub_time"];
    [dic setValue:_orderDic[@"start_time"] forKey:@"start_time"];
    [dic setValue:_orderDic[@"rent_month_num"] forKey:@"rent_month_num"];
    [dic setValue:_orderDic[@"remind_time"] forKey:@"remind_time"];
    [dic setValue:_orderDic[@"deposit"] forKey:@"deposit"];
    [dic setValue:_orderDic[@"pay_way"] forKey:@"pay_way"];
    
//    [dic setValue:_chargeId forKey:@"charge_company_id"];
    
    if (_stageArr.count) {
        
        NSError *error;
        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:_stageArr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString2 = [[NSString alloc]initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        [dic setObject:jsonString2 forKey:@"stage_list"];
    }
    
    if (_imgArr.count) {
        
        NSError *error;
        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:_imgArr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString2 = [[NSString alloc]initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        [dic setObject:jsonString2 forKey:@"enclosure_list"];
    }
    [dic setObject:_progressDic[@"progress_id"] forKey:@"current_progress"];
    if (param.length) {

        [dic setObject:param forKey:@"param"];
    }
    [BaseRequest POST:TradeSubAdd_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.addOrderRentVCBlock) {

                self.addOrderRentVCBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ProgreesMethod{
    
    _isDown = 0;
    [self->_progressArr removeAllObjects];
    [self->_progressAllArr removeAllObjects];
//    [self->_rolePersonArr removeAllObjects];
//    [self->_rolePersonSelectArr removeAllObjects];
    
    NSMutableDictionary *dic = [@{} mutableCopy];
    NSString *room = @"";
    for (int i = 0; i < _roomArr.count; i++) {
        
        if (i == 0) {
            
            room = [NSString stringWithFormat:@"%@",_roomArr[i][@"shop_id"]];
        }else{
            
            room = [NSString stringWithFormat:@"%@,%@",room,_roomArr[i][@"shop_id"]];
        }
    }
    
    if (_stageArr.count) {
        
        NSError *error;
        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:_stageArr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString2 = [[NSString alloc]initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        [dic setObject:jsonString2 forKey:@"stage_list"];
    }
    
    if (room.length) {
        
        [dic setValue:room forKey:@"shop_list"];
        [BaseRequest POST:TradeSubCheckRent_URL parameters:dic success:^(id  _Nonnull resposeObject) {

            if ([resposeObject[@"code"] integerValue] == 250) {

                [self->_progressArr removeAllObjects];
                [self->_progressAllArr removeAllObjects];
                if ([resposeObject[@"data"] integerValue] == 1) {
                    
                    [self alertControllerWithNsstring:@"是否执行免租期流程" And:@"当前租金符合免租期流程，如不执行免租期流程，本次定租将不能提交，需要返回重新修改租金信息" WithCancelBlack:^{
                        
                        self->_canCommit = 0;
                    } WithDefaultBlack:^{
                       
                        self->_canCommit = 1;
                        NSDictionary *dic;
                        dic = @{@"project_id":self->_project_id,@"config_type":@"1",@"progress_defined_id":@"13"};
                        [BaseRequest GET:ShopGetProgress_URL parameters:dic success:^(id  _Nonnull resposeObject) {

                            if ([resposeObject[@"code"] integerValue] == 200) {

                                if ([resposeObject[@"data"] count]) {
                                    
                                    [self->_progressDic setValue:[NSString stringWithFormat:@"%@",resposeObject[@"data"][0][@"progress_id"]] forKey:@"progress_id"];
                                    self->_isDown = 1;
                                    [self CommitRequest];
                                }else{
                                    
                                    [self showContent:@"当前未设置免租期流程,请修改租金信息后重新提交"];
                                }
                            }else{

                                [self showContent:@"当前未设置免租期流程,请修改租金信息后重新提交"];
                            }
                        } failure:^(NSError * _Nonnull error) {

                            [self showContent:@"网络错误"];
                        }];
                    }];
                }else{
                    
                    [self alertControllerWithNsstring:@"是否执底价流程" And:@"当前租金符合底价流程，如不执行底价流程，本次定租将不能提交，需要返回重新修改租金信息" WithCancelBlack:^{
                        
                        self->_canCommit = 0;
                    } WithDefaultBlack:^{
                       
                        self->_canCommit = 1;
                        NSDictionary *dic;
                        dic = @{@"project_id":self->_project_id,@"config_type":@"1",@"progress_defined_id":@"3"};
                        [BaseRequest GET:ShopGetProgress_URL parameters:dic success:^(id  _Nonnull resposeObject) {

                            if ([resposeObject[@"code"] integerValue] == 200) {

                                if ([resposeObject[@"data"] count]) {
                                    
                                    [self->_progressDic setValue:[NSString stringWithFormat:@"%@",resposeObject[@"data"][0][@"progress_id"]] forKey:@"progress_id"];
                                    self->_isDown = 1;
                                    [self CommitRequest];
                                }else{
                                    
                                    [self showContent:@"当前未设置免租期流程,请修改租金信息后重新提交"];
                                }
                            }else{

                                [self showContent:@"当前未设置底价流程,请修改租金信息后重新提交"];
                            }
                        } failure:^(NSError * _Nonnull error) {

                            [self showContent:@"网络错误"];
                        }];
                    }];
                }
            }else{

                [self->_table reloadData];
                [self CommitRequest];
            }
        } failure:^(NSError * _Nonnull error) {

            NSLog(@"%@",error);
        }];
    }
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id}];
    
    if (_role_id.length) {
        
        [dic setObject:_role_id forKey:@"role_id"];
    }
    
    [BaseRequest GET:ProjectRolePersonList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_rolePersonArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            for (int i = 0 ; i < [resposeObject[@"data"] count]; i++) {
                
                [self->_rolePersonSelectArr addObject:@0];
            }
//            self->_addNumeralProcessView.personArr = self->_rolePersonArr;
//            self->_addNumeralProcessView.personSelectArr = self->_rolePersonSelectArr;
            [self->_table reloadData];
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}

-(void)updateheadimgbyimg:(UIImage *)img{
    
    NSData *data = [self resetSizeOfImageData:img maxSize:150];

    NSString *name = [self->_secondFormatter stringFromDate:[NSDate date]];
    [BaseRequest UpdateFile:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];
        
    } url:UploadFile_URL parameters:@{@"file_name":@"img"} success:^(id  _Nonnull resposeObject) {
        
       if ([resposeObject[@"code"] integerValue] == 200) {

           [self->_imgArr addObject:@{@"url":[NSString stringWithFormat:@"%@",resposeObject[@"data"]],@"name":name,@"create_time":name}];
           [self->_table reloadData];
//           self->_addNumeralFileView.dataArr = self->_imgArr;
       }else{

           [self showContent:resposeObject[@"msg"]];
       }

    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_selectArr[section] integerValue]) {
        
        if (section == 0) {
            
            return _roomArr.count + 1;
        }else if (section == 1){
            
            return _storeArr.count + 1;
        }else if (section == 2){
            
            return 1;
        }else if (section == 3){
            
            return 1;
        }else if (section == 4){
            
            return 1;
        }else{
            
            return _imgArr.count ? 2: 1;
        }
    }else{
        
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TitleRightBtnHeader *header = [[TitleRightBtnHeader alloc] initWithReuseIdentifier:@"TitleRightBtnHeader"];
    if (!header) {
        
        header = [[TitleRightBtnHeader alloc] initWithReuseIdentifier:@"TitleRightBtnHeader"];
    }
    header.titleL.text = _titleArr[section];
    header.addBtn.hidden = YES;
    if ([_selectArr[section] integerValue] == 0) {
        
        [header.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    }else{
        
        [header.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
    }
    header.titleRightBtnHeaderMoreBlock = ^{
        
        if ([self->_selectArr[section] integerValue] == 0) {
            
            [self->_selectArr replaceObjectAtIndex:section withObject:@1];
        }else{
            
            [self->_selectArr replaceObjectAtIndex:section withObject:@0];
        }
        [tableView reloadData];
    };
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row < _roomArr.count) {
            
            return YES;
        }else{
            
            return NO;
        }
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 1) {
            
            return YES;
        }else{
            
            return NO;
        }
    }else{
        
        return NO;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        [_roomArr removeObjectAtIndex:indexPath.row];
        
        [_stageArr removeAllObjects];
    }else{
        
        [_storeArr removeAllObjects];
    }
    [tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
#pragma mark -- 房源 --
    if (indexPath.section == 0) {
        
        if (indexPath.row == _roomArr.count) {
            
            AddIntentStoreAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddIntentStoreAddCell"];
            
            if (!cell) {
                
                cell = [[AddIntentStoreAddCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddIntentStoreAddCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.addBtn setTitle:@"添加房源" forState:UIControlStateNormal];
            
            cell.addIntentStoreAddCellBlock = ^{
                
                ShopRoomVC *nextVC = [[ShopRoomVC alloc] init];
                nextVC.project_id = self->_project_id;
                nextVC.roomArr = self->_roomArr;
                nextVC.shopRoomVCBlock = ^(NSDictionary * _Nonnull dic, NSString * _Nonnull chargeId) {

                    if (!self->_chargeId) {

                        self->_chargeId = chargeId;
                    }
                    [self->_roomArr addObject:dic];
                    if (![self->_orderDic[@"down_pay"] length]) {
                        
                        for (int i = 0; i < [self->_roomArr[0][@"cost_set_list"][@"fixed"] count]; i++) {
                            
                            if ([self->_roomArr[0][@"cost_set_list"][@"fixed"][i][@"name"] isEqualToString:@"定金"]) {
                                
                                if ([self->_roomArr[0][@"cost_set_list"][@"fixed"][i][@"is_execute"] integerValue] == 1) {
                                    
                                    [self->_orderDic setValue:self->_roomArr[0][@"cost_set_list"][@"fixed"][i][@"param"] forKey:@"down_pay"];
                                }
                            }
                        }
                    }
                    [self->_stageArr removeAllObjects];
                    [tableView reloadData];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            return cell;
        }else{
            
            AddIntentStoreRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddIntentStoreRoomCell"];
            
            if (!cell) {
                
                cell = [[AddIntentStoreRoomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddIntentStoreRoomCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (![_roomArr[indexPath.row][@"unit_name"] isKindOfClass:[NSNull class]] && _roomArr[indexPath.row][@"unit_name"]) {
                
                cell.roomL.text = [NSString stringWithFormat:@"房间：%@%@%@",_roomArr[indexPath.row ][@"build_name"],_roomArr[indexPath.row][@"unit_name"],_roomArr[indexPath.row][@"name"]];
            }else{
                
                cell.roomL.text = [NSString stringWithFormat:@"房间：%@%@",_roomArr[indexPath.row ][@"build_name"],_roomArr[indexPath.row][@"name"]];
            }
            cell.areaL.text = [NSString stringWithFormat:@"面积：%@㎡",_roomArr[indexPath.row][@"build_size"]];
            cell.priceL.text = [NSString stringWithFormat:@"租金：%@元/月/㎡",_roomArr[indexPath.row][@"total_rent"]];
            
            return cell;
        }
        
#pragma mark -- 商家 --
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            AddIntentStoreDoubleBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddIntentStoreDoubleBtnCell"];
            
            if (!cell) {
                
                cell = [[AddIntentStoreDoubleBtnCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddIntentStoreDoubleBtnCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.addIntentStoreDoubleBtnCellAddBlock = ^{
                
                AddStoreVC *nextVC = [[AddStoreVC alloc] initWithProjectId:self->_project_id info_id:self->_info_id];
                nextVC.status = @"direct";
                nextVC.addStoreVCDicBlock = ^(NSDictionary * _Nonnull dic) {

                    [self->_storeArr removeAllObjects];
                    [self->_storeArr addObject:dic];
                    [tableView reloadData];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            
            cell.addIntentStoreDoubleBtnCellSelectBlock = ^{
                
                AddIntentSelectStoreVC *nextVC = [[AddIntentSelectStoreVC alloc] initWithProjectId:self->_project_id info_id:self->_info_id];
                nextVC.addIntentSelectStoreVCBlock = ^(NSDictionary * _Nonnull dic) {
                    
                    [self->_storeArr removeAllObjects];
                    [self->_storeArr addObject:dic];
                    [tableView reloadData];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            return cell;
        }else{
            
            StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCell"];
            if (!cell) {
                   
                cell = [[StoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
               
            cell.tag = indexPath.row;
               
            cell.dataDic = _storeArr[indexPath.row - 1];
               
            return cell;
        }
        
#pragma mark -- 定租 --
    }else if (indexPath.section == 2){
        
        AddOrderRentInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddOrderRentInfoCell"];
        
        if (!cell) {
            
            cell = [[AddOrderRentInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddIntentStoreIntentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _orderDic;
        
        cell.addOrderRentInfoCellStrBlock = ^(NSString * _Nonnull str, NSInteger idx) {
          
            if (idx == 0) {

                [self->_orderDic setValue:str forKey:@"sub_code"];
            }else if (idx == 1) {

                [self->_orderDic setValue:str forKey:@"signatory"];
            }else if (idx == 3) {

                [self->_orderDic setValue:str forKey:@"card_num"];
            }else if (idx == 4){

                [self->_orderDic setValue:str forKey:@"down_pay"];
            }else if (idx == 9){

                [self->_orderDic setValue:str forKey:@"rent_month_num"];
            }else{

                [self->_orderDic setValue:str forKey:@"deposit"];
            }
            [tableView reloadData];
        };
        
        cell.addOrderRentInfoCellBtnBlock = ^(NSInteger idx) {
          
            if (idx == 2) {
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:self->_certArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    self->_orderDic[@"typeName"] = [NSString stringWithFormat:@"%@",MC];
                    self->_orderDic[@"card_type"] = [NSString stringWithFormat:@"%@",ID];
                    if ([self->_orderDic[@"typeName"] containsString:@"身份证"]) {
                        
                        if ([self->_orderDic[@"card_num"] length]) {
                            
                            if ([self validateIDCardNumber:self->_orderDic[@"card_num"]]) {
                                
                                
                            }else{
                                
                                [self showContent:@"请输入正确的身份证号"];
                            }
                        }else{
                            
//                            [self showContent:@"请输入正确的身份证号"];
                        }
                    }
                    [tableView reloadData];
                };
                [self.view addSubview:view];
            }else if (idx == 5){
                
                DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
                view.dateblock = ^(NSDate *date) {

                    [self->_orderDic setObject:[[self->_secondFormatter stringFromDate:date] componentsSeparatedByString:@" "][0] forKey:@"open_time"];
                    [tableView reloadData];
                };
                [self.view addSubview:view];
            }else if (idx == 6){
                
               DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
               view.dateblock = ^(NSDate *date) {

                   [self->_orderDic setObject:[[self->_secondFormatter stringFromDate:date] componentsSeparatedByString:@" "][0] forKey:@"sub_time"];
                   [tableView reloadData];
               };
               [self.view addSubview:view];
            }else if (idx == 7){
                
                DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
                view.dateblock = ^(NSDate *date) {

                    [self->_orderDic setObject:[[self->_secondFormatter stringFromDate:date] componentsSeparatedByString:@" "][0] forKey:@"remind_time"];
                    [tableView reloadData];
                };
                [self.view addSubview:view];
            }else if (idx == 8){
                
                DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
                view.dateblock = ^(NSDate *date) {

                    [self->_orderDic setObject:[[self->_secondFormatter stringFromDate:date] componentsSeparatedByString:@" "][0] forKey:@"start_time"];
                    [tableView reloadData];
                };
                [self.view addSubview:view];
            }else if (idx == 10){
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_payArr1];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {

                    [self->_orderDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"pay_way1"];
                    [self->_orderDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"pay_name1"];
                    if (self->_orderDic[@"pay_way2"]) {
                        
                        [self->_orderDic setObject:[NSString stringWithFormat:@"%@,%@",ID,self->_orderDic[@"pay_way2"]] forKey:@"pay_way"];
                        [self->_orderDic setObject:[NSString stringWithFormat:@"%@,%@",MC,self->_orderDic[@"pay_name2"]] forKey:@"pay_name"];
                    }
                    [tableView reloadData];
                };
                [self.view addSubview:view];
            }else{
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_payArr2];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {

                    [self->_orderDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"pay_way2"];
                    [self->_orderDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"pay_name2"];
                    if (self->_orderDic[@"pay_way1"]) {
                        
                        [self->_orderDic setObject:[NSString stringWithFormat:@"%@,%@",self->_orderDic[@"pay_way1"],ID] forKey:@"pay_way"];
                        [self->_orderDic setObject:[NSString stringWithFormat:@"%@,%@",self->_orderDic[@"pay_name1"],MC] forKey:@"pay_name"];
                    }
                    [tableView reloadData];
                };
                [self.view addSubview:view];
            }
        };

        
        return cell;
        
#pragma mark -- 租金 --
    }else if (indexPath.section == 3){
        
     
        AddOrderRentPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddOrderRentPriceCell"];
        
        if (!cell) {
            
            cell = [[AddOrderRentPriceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddOrderRentPriceCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataArr = _stageArr;
        
        cell.addOrderRentPriceCellBlock = ^{
          
            double area = 0;
            for (int i = 0; i < self->_roomArr.count; i++) {
                
                area = area + [self->_roomArr[i][@"build_size"] doubleValue];
            }
            AddOrderRentalDetailVC *nextVC = [[AddOrderRentalDetailVC alloc] initWithStageArr:self->_stageArr];
            nextVC.area = area;
            nextVC.addOrderRentalDetailVCBlock = ^(NSArray * _Nonnull arr) {
              
                self->_stageArr = [NSMutableArray arrayWithArray:arr];
                [tableView reloadData];
//                self->_canCommit = 1;
//                [self ProgreesMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        cell.addOrderRentPriceCellAddBlock = ^{
            
            if (!self->_roomArr.count) {
                
                [self showContent:@"请先选择房源"];
            }else{
                
                 if (![[NSString stringWithFormat:@"%@",self->_orderDic[@"rent_month_num"]] length] || !self->_orderDic[@"start_time"]) {
                    
                    if (!self->_orderDic[@"start_time"]) {
                        
                        [self showContent:@"请先选择租期开始时间"];
                    }else{
                     
                        [self showContent:@"请先输入租期时长"];
                    }
                }else{
                    
                    if (self->_orderDic[@"pay_way1"] && self->_orderDic[@"pay_way2"]) {
                        
                        ModifyAndAddRentalView *view = [[ModifyAndAddRentalView alloc] initWithFrame:self.view.bounds];
                        view.periodTF.textField.text = self->_orderDic[@"deposit"];
                        if (([self->_orderDic[@"rent_month_num"] integerValue] % [self->_orderDic[@"pay_way2"] integerValue]) == 0) {
                            
                             view.numL.text = [NSString stringWithFormat:@"期数：%.0f期",[self->_orderDic[@"rent_month_num"] floatValue] / [self->_orderDic[@"pay_way2"] floatValue]];
                        }else{
                            
                             view.numL.text = [NSString stringWithFormat:@"期数：%ld期",([self->_orderDic[@"rent_month_num"] integerValue] / [self->_orderDic[@"pay_way2"] integerValue]) + 1];
                        }
                       
                        view.modifyAndAddRentalViewComfirmBtnBlock = ^(NSString * _Nonnull str) {
                          
                            [self->_stageArr removeAllObjects];
                            
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:@"YYYY-MM-dd"];
                            
                            NSString *unit = @"0";
                            
//                            double total = [self MultiplyingNumber:[str doubleValue] num2:([self->_orderDic[@"rent_month_num"] doubleValue] / [self->_orderDic[@"pay_way2"] doubleValue])];
                            double area = 0;
                            for (int i = 0; i < self->_roomArr.count; i++) {
                                
                                area = area + [self->_roomArr[i][@"build_size"] doubleValue];
                            }
                            if (area > 0) {
                                
                                unit = [NSString stringWithFormat:@"%.2f",[str doubleValue] / [self->_orderDic[@"pay_way2"] doubleValue] / area];
                            }else{
                                
                                unit = [NSString stringWithFormat:@"%.2f",[str doubleValue] / [self->_orderDic[@"pay_way2"] doubleValue]];
                            }
                            NSString *date;
                            NSString *endDate;
                            NSString *resultDate = [formatter stringFromDate:[self getPriousorLaterDateFromDate:[formatter dateFromString:self->_orderDic[@"start_time"]] withMonth:[self->_orderDic[@"rent_month_num"] integerValue]]];
                            [self->_orderDic setValue:resultDate forKey:@"end_time"];
                            for (int i = 0; i < ([self->_orderDic[@"rent_month_num"] floatValue] / [self->_orderDic[@"pay_way2"] floatValue]); i++) {

                                if (i == 0) {
                                    
                                    date = self->_orderDic[@"start_time"];
                                }else{
                                    
                                    date = [formatter stringFromDate:[self getPriousorLaterDateFromDate:[formatter dateFromString:date] withMonth:[self->_orderDic[@"pay_way2"] integerValue]]];
                                }
                                endDate = [formatter stringFromDate:[self getPriousorLaterDateFromDate:[formatter dateFromString:date] withMonth:[self->_orderDic[@"pay_way2"] integerValue]]];
                                NSComparisonResult result = [endDate compare:resultDate];
                                if (result == NSOrderedDescending) {
                                    
                                    endDate = resultDate;
                                }
                                NSString *stateNum = [NSString stringWithFormat:@"%ld",[self getMonthFromDate:[formatter dateFromString:date] withDate2:[formatter dateFromString:endDate]] + 1];
                                
                                [self->_stageArr addObject:@{@"unit_rent":unit,@"total_rent":str,@"free_rent":@"0",@"comment":@" ",@"stage_num":stateNum,@"stage_start_time":date,@"stage_end_time":endDate,@"pay_time":date,@"remind_time":date,@"free_start_time":date,@"free_end_time":date,@"free_month_num":@"0"}];
                            }
                            [tableView reloadData];
//                            self->_canCommit = 1;
//                            [self ProgreesMethod];
                            AddOrderRentalDetailVC *nextVC = [[AddOrderRentalDetailVC alloc] initWithStageArr:self->_stageArr];
                            nextVC.area = area;
                            nextVC.addOrderRentalDetailVCBlock = ^(NSArray * _Nonnull arr) {
                              
                                self->_stageArr = [NSMutableArray arrayWithArray:arr];
                                [tableView reloadData];
                            };
                            [self.navigationController pushViewController:nextVC animated:YES];
                        };
                        view.modifyAndAddRentalViewBlock = ^{
                          
                            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[]];
                            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                                
                            };
                            [self.view addSubview:view];
                        };
                        [self.view addSubview:view];
                    }else{
                        
                        [self showContent:@"请先选择付款方式"];
                    }
                }
            }
        };
        
        return cell;
        
#pragma mark -- 流程 --
    }else if (indexPath.section == 4){
        
        AddIntentStoreProccessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddIntentStoreProccessCell"];
        
        if (!cell) {
            
            cell = [[AddIntentStoreProccessCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddIntentStoreProccessCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _progressDic;
        cell.personArr = self->_rolePersonArr;
        cell.personSelectArr = self->_rolePersonSelectArr;
        
        cell.addIntentStoreProccessCellAuditBlock = ^{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[@{@"param":@"自由流程",@"id":@"1"},@{@"param":@"固定流程",@"id":@"2"}]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {

                [self->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"auditMC"];
                [self->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"auditID"];
                [tableView reloadData];
            };
            [self.view addSubview:view];
        };
        
        __strong __typeof(&*cell)strongCell = cell;
        cell.addIntentStoreProccessCellTypeBlock = ^{
          
            if (self->_progressArr.count) {

                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_progressArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {

                    if ([MC containsString:@"自由"]) {

                        [self->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                        [self->_progressDic setObject:@"1" forKey:@"auditID"];
                    }else if ([MC containsString:@"固定"]){

                        [self->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                        [self->_progressDic setObject:@"2" forKey:@"auditID"];
                    }else{

                        [self->_progressDic removeObjectForKey:@"auditMC"];
                        [self->_progressDic removeObjectForKey:@"auditID"];
                    }
                    if (![MC isEqualToString:self->_progressDic[@"progress_name"]]) {

                        [self->_rolePersonArr removeAllObjects];
                        [self->_rolePersonSelectArr removeAllObjects];
                        strongCell.personArr = self->_rolePersonArr;
                        strongCell.personSelectArr = self->_rolePersonSelectArr;
                        [self->_progressDic removeObjectForKey:@"role_name"];
                        [self->_progressDic removeObjectForKey:@"role_id"];
                    }
                    [self->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"progress_name"];
                    [self->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"progress_id"];
                    for (int i = 0; i < self->_progressAllArr.count; i++) {

                        if ([ID integerValue] == [self->_progressAllArr[i][@"progress_id"] integerValue]) {

                            [self->_progressDic setObject:[NSString stringWithFormat:@"%@",self->_progressAllArr[i][@"check_type"]] forKey:@"check_type"];
                        }
                    }
                    if ([self->_progressDic[@"check_type"] integerValue] == 1) {

                        [self->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                        [self->_progressDic setObject:@"1" forKey:@"auditID"];
                    }else if ([self->_progressDic[@"check_type"] integerValue] == 2) {

                        [self->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                        [self->_progressDic setObject:@"2" forKey:@"auditID"];
                    }
                    [tableView reloadData];
                };
                [self.view addSubview:view];
            }else{

                NSDictionary *dic;
                if ([self.from_type isEqualToString:@"2"]) {
                    
                    dic = @{@"project_id":self->_project_id,@"config_type":@"1",@"progress_defined_id":@"14"};
                }else{
                    
                    dic = @{@"project_id":self->_project_id,@"config_type":@"1",@"progress_defined_id":@"5"};
                }
                [BaseRequest GET:ShopGetProgress_URL parameters:dic success:^(id  _Nonnull resposeObject) {

                    if ([resposeObject[@"code"] integerValue] == 200) {

                        [self->_progressArr removeAllObjects];
                        [self->_progressAllArr removeAllObjects];
                        self->_progressAllArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
                        for (int i = 0; i < [resposeObject[@"data"] count]; i++) {

                            [self->_progressArr addObject:@{@"param":[NSString stringWithFormat:@"%@",resposeObject[@"data"][i][@"progress_name"]],@"id":resposeObject[@"data"][i][@"progress_id"]}];
                        }

                        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_progressArr];
                        view.selectedBlock = ^(NSString *MC, NSString *ID) {

                            if ([MC containsString:@"自由"]) {

                                [self->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                                [self->_progressDic setObject:@"1" forKey:@"auditID"];
                            }else if ([MC containsString:@"固定"]){

                                [self->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                                [self->_progressDic setObject:@"2" forKey:@"auditID"];
                            }else{

                                [self->_progressDic removeObjectForKey:@"auditMC"];
                                [self->_progressDic removeObjectForKey:@"auditID"];
                            }
                            if (![MC isEqualToString:self->_progressDic[@"progress_name"]]) {

                                [self->_rolePersonArr removeAllObjects];
                                [self->_rolePersonSelectArr removeAllObjects];
                                strongCell.personArr = self->_rolePersonArr;
                                strongCell.personSelectArr = self->_rolePersonSelectArr;
                                [self->_progressDic removeObjectForKey:@"role_name"];
                                [self->_progressDic removeObjectForKey:@"role_id"];
                            }
                            [self->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"progress_name"];
                            [self->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"progress_id"];
                            for (int i = 0; i < self->_progressAllArr.count; i++) {

                                if ([ID integerValue] == [self->_progressAllArr[i][@"progress_id"] integerValue]) {

                                    [self->_progressDic setObject:[NSString stringWithFormat:@"%@",self->_progressAllArr[i][@"check_type"]] forKey:@"check_type"];
                                }
                            }
                            if ([self->_progressDic[@"check_type"] integerValue] == 1) {

                                [self->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                                [self->_progressDic setObject:@"1" forKey:@"auditID"];
                            }else if ([self->_progressDic[@"check_type"] integerValue] == 2) {

                                [self->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                                [self->_progressDic setObject:@"2" forKey:@"auditID"];
                            }
                            [tableView reloadData];
                        };
                        [self.view addSubview:view];
                    }else{


                    }
                } failure:^(NSError * _Nonnull error) {


                }];
            }
        };
        
        cell.addIntentStoreProccessCellRoleBlock = ^{
            
            if (self->_roleArr.count) {

                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_roleArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {

                    if (![MC isEqualToString:self->_progressDic[@"role_name"]]) {

                        [self->_rolePersonArr removeAllObjects];
                        [self->_rolePersonSelectArr removeAllObjects];
                        strongCell.personArr = self->_rolePersonArr;
                        strongCell.personSelectArr = self->_rolePersonSelectArr;
                    }
                    [self->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"role_name"];
                    [self->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"role_id"];
                    [tableView reloadData];
                    [self RequestMethod];
                };
                [self.view addSubview:view];
            }else{

                [BaseRequest GET:ProjectRoleListAll_URL parameters:@{@"project_id":self->_project_id} success:^(id  _Nonnull resposeObject) {

                    if ([resposeObject[@"code"] integerValue] == 200) {

                        for (NSDictionary *dic in resposeObject[@"data"]) {

                            [self->_roleArr addObject:@{@"param":[NSString stringWithFormat:@"%@/%@",dic[@"project_name"],dic[@"role_name"]],@"id":dic[@"role_id"]}];
                        }
                        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_roleArr];
                        view.selectedBlock = ^(NSString *MC, NSString *ID) {

                            [self->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"role_name"];
                            [self->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"role_id"];
                            [tableView reloadData];
                            [self RequestMethod];
                        };
                        [self.view addSubview:view];
                    }else{


                    }
                } failure:^(NSError * _Nonnull error) {

                    NSLog(@"%@",error);
                }];
            }
        };
        
        cell.addIntentStoreProccessCellSelectBlock = ^(NSArray * _Nonnull arr) {
          
             self->_rolePersonSelectArr = [NSMutableArray arrayWithArray:arr];
        };
        return cell;
        
#pragma mark -- 附件 --
    }else{
        
        if (indexPath.row == 0) {
            
            AddIntentStoreAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddIntentStoreAddCell"];
            
            if (!cell) {
                
                cell = [[AddIntentStoreAddCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddIntentStoreAddCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.addBtn setTitle:@"选择文件上传" forState:UIControlStateNormal];
            
            cell.addIntentStoreAddCellBlock = ^{
                
                [ZZQAvatarPicker startSelected:^(UIImage * _Nonnull image) {

                    if (image) {

                        [self updateheadimgbyimg:image];
                    }
                }];
            };
            return cell;
        }else{
            
            AddIntentStoreFileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddIntentStoreFileCell"];
                       
            if (!cell) {
                           
                cell = [[AddIntentStoreFileCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddIntentStoreFileCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
            cell.dataArr = _imgArr;
            
            cell.addIntentStoreFileCellSelectBlock = ^(NSInteger idx) {
                
                ChangeFileNameView *view = [[ChangeFileNameView alloc] initWithFrame:self.view.bounds name:self->_imgArr[idx][@"name"]];
                view.changeFileNameViewBlock = ^(NSString * _Nonnull name) {

                    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:self->_imgArr[idx]];
                    [tempDic setValue:name forKey:@"name"];
                    [self->_imgArr replaceObjectAtIndex:idx withObject:tempDic];
                    [tableView reloadData];
                };
                [self.view addSubview:view];
            };
            cell.addIntentStoreFileCellDeleteBlock = ^(NSInteger idx) {
              
                [self->_imgArr removeObjectAtIndex:idx];
                [tableView reloadData];
            };
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row != 0) {
        
        ModifyNoChangeStoreVC *vc = [[ModifyNoChangeStoreVC alloc] initWithProjectId:self->_project_id info_id:self->_info_id];
        vc.storeDic = self->_storeArr[indexPath.row - 1];
        vc.business_id = [NSString stringWithFormat:@"%@",self->_storeArr[indexPath.row - 1][@"business_id"]];
        vc.modifyNoChangeStoreVCBlock = ^(NSDictionary * _Nonnull dic) {
            
            [self->_storeArr replaceObjectAtIndex:indexPath.row - 1 withObject:dic];
            [tableView reloadData];
            if (self.addOrderRentVCBlock) {
                
                self.addOrderRentVCBlock();
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"新增定租";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _table.backgroundColor = CLBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];

    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    [self.view addSubview:_nextBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{

}

@end
