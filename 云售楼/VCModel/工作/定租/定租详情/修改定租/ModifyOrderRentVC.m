//
//  ModifyOrderRentVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ModifyOrderRentVC.h"

#import "AddIntentSelectStoreVC.h"
#import "AddStoreVC.h"
#import "AddOrderRentalDetailVC.h"
#import "ShopRoomVC.h"

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

@interface ModifyOrderRentVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_info_id;
    NSString *_project_id;
    NSString *_role_id;
    NSString *_chargeId;
    
    NSArray *_titleArr;
    
    NSArray *_certArr;
    
    
    NSMutableDictionary *_orderDic;
    
    NSMutableDictionary *_rentPirceDic;

    
    NSMutableArray *_roomArr;
    NSMutableArray *_storeArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_payArr1;
    NSMutableArray *_payArr2;

    NSMutableArray *_imgArr;
    NSMutableArray *_stageArr;
    
    NSDateFormatter *_secondFormatter;
}
@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation ModifyOrderRentVC

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
    _stageArr = [NSMutableArray arrayWithArray:self.dataDic[@"stage_list"]];
    _payArr1 = [@[] mutableCopy];
    _payArr2 = [@[] mutableCopy];
    
    _certArr = @[@{@"param":@"身份证",@"id":@"1"},@{@"param":@"户口簿",@"id":@"2"},@{@"param":@"驾驶证",@"id":@"3"},@{@"param":@"军官证",@"id":@"4"},@{@"param":@"工商营业执照",@"id":@"5"},@{@"param":@"其他",@"id":@"6"}];
    for (int i = 0; i < 12; i++) {
        
        if (i == 0 || i == 1 || i == 2 || i == 5 || i == 11) {
            
            [_payArr1 addObject:@{@"param":[NSString stringWithFormat:@"押%d",i + 1],@"id":[NSString stringWithFormat:@"%d",i + 1]}];
            [_payArr2 addObject:@{@"param":[NSString stringWithFormat:@"付%d",i + 1],@"id":[NSString stringWithFormat:@"%d",i + 1]}];
        }
    }
    _titleArr = @[@"房源信息",@"商家信息",@"定租信息",@"租金信息",@"附件文件"];
    _selectArr = [[NSMutableArray alloc] initWithArray:@[@1,@0,@0,@0,@0,@0]];
    
    _orderDic = [@{} mutableCopy];
    [_orderDic setValue:self.dataDic[@"sub_code"] forKey:@"sub_code"];
    [_orderDic setValue:self.dataDic[@"signatory"] forKey:@"signatory"];
    if ([self.dataDic[@"card_type"] integerValue] == 1) {
        
        [_orderDic setValue:@"身份证" forKey:@"typeName"];
    }else if ([self.dataDic[@"card_type"] integerValue] == 2){
        
        [_orderDic setValue:@"户口簿" forKey:@"typeName"];
    }else if ([self.dataDic[@"card_type"] integerValue] == 3){
        
        [_orderDic setValue:@"驾驶证" forKey:@"typeName"];
    }else if ([self.dataDic[@"card_type"] integerValue] == 4){
        
        [_orderDic setValue:@"军官证" forKey:@"typeName"];
    }else if ([self.dataDic[@"card_type"] integerValue] == 5){
        
        [_orderDic setValue:@"工商营业执照" forKey:@"typeName"];
    }else if ([self.dataDic[@"card_type"] integerValue] == 6){
        
        [_orderDic setValue:@"其他" forKey:@"typeName"];
    }
    [_orderDic setValue:self.dataDic[@"card_type"] forKey:@"card_type"];
    [_orderDic setValue:self.dataDic[@"card_num"] forKey:@"card_num"];
    [_orderDic setValue:self.dataDic[@"down_pay"] forKey:@"down_pay"];
    [_orderDic setValue:self.dataDic[@"deposit"] forKey:@"deposit"];
    [_orderDic setValue:self.dataDic[@"open_time"] forKey:@"open_time"];
    [_orderDic setValue:self.dataDic[@"sub_time"] forKey:@"sub_time"];
    [_orderDic setValue:self.dataDic[@"remind_time"] forKey:@"remind_time"];
    [_orderDic setValue:self.dataDic[@"start_time"] forKey:@"start_time"];
    [_orderDic setValue:self.dataDic[@"end_time"] forKey:@"end_time"];
    [_orderDic setValue:self.dataDic[@"pay_way"] forKey:@"pay_way"];
    [_orderDic setValue:[self.dataDic[@"pay_way"] componentsSeparatedByString:@","][0] forKey:@"pay_way1"];
    [_orderDic setValue:[self.dataDic[@"pay_way"] componentsSeparatedByString:@","][1] forKey:@"pay_way2"];
    [_orderDic setValue:[NSString stringWithFormat:@"押%@",[self.dataDic[@"pay_way"] componentsSeparatedByString:@","][0]] forKey:@"pay_name1"];
    [_orderDic setValue:[NSString stringWithFormat:@"付%@",[self.dataDic[@"pay_way"] componentsSeparatedByString:@","][1]] forKey:@"pay_name2"];
    [_orderDic setValue:self.dataDic[@"deposit"] forKey:@"deposit"];
    [_orderDic setValue:self.dataDic[@"rent_month_num"] forKey:@"rent_month_num"];
    
    _rentPirceDic = [@{} mutableCopy];
    
    
    _roomArr = [@[] mutableCopy];
    _roomArr = [NSMutableArray arrayWithArray:self.dataDic[@"shop_detail_list"]];
    
    _storeArr = [@[] mutableCopy];
    _storeArr = [NSMutableArray arrayWithArray:@[self.dataDic[@"business_info"]]];

    _imgArr = [@[] mutableCopy];
    _imgArr = [NSMutableArray arrayWithArray:self.dataDic[@"enclosure_list"]];
    
    _secondFormatter = [[NSDateFormatter alloc] init];
    [_secondFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
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
    

    
    NSMutableDictionary *dic = [@{} mutableCopy];
    NSString *room;
    for (int i = 0; i < _roomArr.count; i++) {
        
        if (i == 0) {
            
            room = _roomArr[i][@"shop_id"];
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
    [dic setValue:store forKey:@"from_id"];
    [dic setValue:store forKey:@"business_id"];
//    [dic setValue:@"2" forKey:@"from_type"];
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
    [dic setValue:_orderDic[@"sub_code"] forKey:@"sub_code"];
    [dic setValue:self.dataDic[@"sub_id"] forKey:@"sub_id"];
    
    [dic setValue:_chargeId forKey:@"charge_company_id"];
    
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

    [BaseRequest POST:TradeSubUpdate_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.modifyOrderRentVCBlock) {

                self.modifyOrderRentVCBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
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
       }else{

           [self showContent:resposeObject[@"msg"]];
       }

    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
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
            
            cell.roomL.text = [NSString stringWithFormat:@"房间：%@%@%@",_roomArr[indexPath.row ][@"build_name"],_roomArr[indexPath.row][@"unit_name"],_roomArr[indexPath.row][@"name"]];
            cell.areaL.text = [NSString stringWithFormat:@"面积：%@㎡",_roomArr[indexPath.row][@"build_size"]];
            cell.priceL.text = [NSString stringWithFormat:@"租金：%@元/月/㎡",_roomArr[indexPath.row][@"total_rent"]];
            
            return cell;
        }
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
                        
                        [self->_orderDic setObject:[NSString stringWithFormat:@"%@,%@",self->_orderDic[@"pay_way2"],ID] forKey:@"pay_way"];
                        [self->_orderDic setObject:[NSString stringWithFormat:@"%@,%@",self->_orderDic[@"pay_name2"],MC] forKey:@"pay_name"];
                    }
                    [tableView reloadData];
                };
                [self.view addSubview:view];
            }
        };

        
        return cell;
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
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        cell.addOrderRentPriceCellAddBlock = ^{
            
            if (!self->_roomArr.count) {
                
                [self showContent:@"请先选择房源"];
            }else{
                
                if (![self->_orderDic[@"rent_month_num"] length] || !self->_orderDic[@"start_time"]) {
                    
                    if (!self->_orderDic[@"start_time"]) {
                        
                        [self showContent:@"请先选择租期开始时间"];
                    }else{
                     
                        [self showContent:@"请先输入租期时长"];
                    }
                }else{
                    
                    if (self->_orderDic[@"pay_way1"] && self->_orderDic[@"pay_way2"]) {
                        
                        ModifyAndAddRentalView *view = [[ModifyAndAddRentalView alloc] initWithFrame:self.view.bounds];
                        view.periodTF.textField.text = self->_orderDic[@"desipot"];
                        view.numL.text = [NSString stringWithFormat:@"期数：%.0f",[self->_orderDic[@"rent_month_num"] floatValue] / [self->_orderDic[@"pay_way2"] floatValue]];
                        [self->_stageArr removeAllObjects];
                        view.modifyAndAddRentalViewComfirmBtnBlock = ^(NSString * _Nonnull str) {
                          
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:@"YYYY-MM-dd"];
                            
                            NSString *unit = @"0";
                            
                            double total = [self MultiplyingNumber:[str doubleValue] num2:([self->_orderDic[@"rent_month_num"] doubleValue] / [self->_orderDic[@"pay_way2"] doubleValue])];
                            double area = 0;
                            for (int i = 0; i < self->_roomArr.count; i++) {
                                
                                area = area + [self->_roomArr[i][@"build_size"] doubleValue];
                            }
                            if (area > 0) {
                                
                                unit = [NSString stringWithFormat:@"%.2f",total / area];
                            }else{
                                
                                unit = [NSString stringWithFormat:@"%.2f",total];
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
                                
                                [self->_stageArr addObject:@{@"unit_rent":unit,@"total_rent":str,@"free_rent":@"0",@"comment":@" ",@"stage_num":[NSString stringWithFormat:@"%d",i + 1],@"stage_start_time":date,@"stage_end_time":endDate,@"pay_time":date,@"remind_time":date}];
                            }
                            [tableView reloadData];

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
