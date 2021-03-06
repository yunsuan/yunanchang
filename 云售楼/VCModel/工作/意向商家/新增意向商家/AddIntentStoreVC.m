//
//  AddIntentStoreVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddIntentStoreVC.h"

#import "AddIntentSelectStoreVC.h"
#import "AddStoreVC.h"
#import "ShopRoomVC.h"
#import "ModifyNoChangeStoreVC.h"

//#import "AddNemeralHeader.h"
//#import "AddIntentStoreRoomView.h"
//#import "AddNumeralProcessView.h"
//#import "AddIntentStoreIntentView.h"
//#import "AddIntentStoreInfoView.h"
//#import "AddNumeralFileView.h"

#import "TitleRightBtnHeader.h"

#import "AddIntentStoreAddCell.h"
#import "AddIntentStoreRoomCell.h"

#import "AddIntentStoreDoubleBtnCell.h"
#import "StoreCell.h"

#import "AddIntentStoreIntentCell.h"

#import "AddIntentStoreProccessCell.h"

#import "AddIntentStoreFileCell.h"


#import "SinglePickView.h"
#import "DateChooseView.h"
#import "MinMaxDateChooseView.h"

@interface AddIntentStoreVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_info_id;
    NSString *_project_id;
    NSString *_role_id;
    NSString *_chargeId;
    
    NSArray *_titleArr;
    
    NSMutableDictionary *_intentDic;
    
    NSMutableDictionary *_progressDic;
    
    NSMutableArray *_roomArr;
    NSMutableArray *_storeArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_progressArr;
    NSMutableArray *_progressAllArr;
    NSMutableArray *_roleArr;
    NSMutableArray *_rolePersonArr;
    NSMutableArray *_rolePersonSelectArr;
    NSMutableArray *_imgArr;
    
    NSDateFormatter *_secondFormatter;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddIntentStoreVC

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
    
    _titleArr = @[@"房源信息",@"商家信息",@"意向信息",@"流程信息",@"附件文件"];
    _selectArr = [[NSMutableArray alloc] initWithArray:@[@1,@0,@0,@0,@0]];
    
    _intentDic = [@{} mutableCopy];
    
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
    [_secondFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    if (self.dataDic) {
        
        _storeArr = [[NSMutableArray alloc] initWithArray:@[self.dataDic]];
//        _storeArr = [[NSMutableArray alloc] initWithArray:@[@{@"business_name":self->_dataDic[@"business_name"],@"contact":self->_dataDic[@"contact"],@"lease_money":self->_dataDic[@"lease_money"],@"lease_size":self->_dataDic[@"lease_size"],@"create_time":self->_dataDic[@"create_time"],@"format_name":self->_dataDic[@"format_name"],@"business_id":[NSString stringWithFormat:@"%@",self->_dataDic[@"business_id"]]}]];
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
    
    if (!_intentDic[@"row_code"]) {

        [self showContent:@"请输入意向编号"];
        return;
    }

    if (!_intentDic[@"sincerity"]) {

        [self showContent:@"请输入诚意金"];
        return;
    }
    if (!_intentDic[@"start_time"]) {

        [self showContent:@"请选择租期开始时间"];
        return;
    }

    if (!_intentDic[@"end_time"]) {

        [self showContent:@"请选择租期结束时间"];
        return;
    }

    if (!_intentDic[@"sign_time"]) {

        [self showContent:@"请选择登记时间"];
        return;
    }
    if (!_progressDic[@"progress_name"]) {
        [self showContent:@"请选择审批流程"];
        return;
    }
    if ([_progressDic[@"check_type"] integerValue] == 1) {

        if (!_progressDic[@"auditMC"]) {
            [self showContent:@"请选择流程类型"];
            return;
        }
    }
    NSString *param;
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
    [dic setValue:store forKey:@"from_id"];
    
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
    
    [dic setValue:_project_id forKey:@"project_id"];
    [dic setValue:_intentDic[@"row_code"] forKey:@"row_code"];
    [dic setValue:_intentDic[@"sincerity"] forKey:@"sincerity"];
    [dic setValue:_intentDic[@"end_time"] forKey:@"end_time"];
    [dic setValue:_intentDic[@"start_time"] forKey:@"start_time"];
//    [dic setValue:_chargeId forKey:@"charge_company_id"];
    [dic setValue:[_intentDic[@"sign_time"] componentsSeparatedByString:@" "][0] forKey:@"sign_time"];
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
    [BaseRequest POST:ShopRowAdd_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.addIntentStoreVCBlock) {
                
                self.addIntentStoreVCBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
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
    }else{
        
        [_storeArr removeAllObjects];
    }
    [tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
#pragma mark -- 房源 --
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
                nextVC.isIntent = @"intent";
                nextVC.shopRoomVCBlock = ^(NSDictionary * _Nonnull dic, NSString * _Nonnull chargeId) {

                    if (!self->_chargeId) {

                        self->_chargeId = chargeId;
                    }
                    [self->_roomArr addObject:dic];
                    if (![self->_intentDic[@"sincerity"] length]) {
                        
                        for (int i = 0; i < [self->_roomArr[0][@"cost_set_list"][@"fixed"] count]; i++) {
                            
                            if ([self->_roomArr[0][@"cost_set_list"][@"fixed"][i][@"name"] isEqualToString:@"诚意金"]) {
                                
                                if ([self->_roomArr[0][@"cost_set_list"][@"fixed"][i][@"is_execute"] integerValue] == 1) {
                                    
                                    [self->_intentDic setValue:self->_roomArr[0][@"cost_set_list"][@"fixed"][i][@"param"] forKey:@"sincerity"];
                                }
                            }
                        }
                    }
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
        
#pragma mark -- 商家信息 --
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
        
#pragma mark -- 意向信息 --
    }else if (indexPath.section == 2){
        
        AddIntentStoreIntentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddIntentStoreIntentCell"];
        
        if (!cell) {
            
            cell = [[AddIntentStoreIntentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddIntentStoreIntentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _intentDic;
        
        cell.addIntentStoreIntentCellStrBlock = ^(NSString * _Nonnull str, NSInteger idx) {
          
            if (idx == 0) {

                [self->_intentDic setValue:str forKey:@"row_code"];
            }else{

                [self->_intentDic setValue:str forKey:@"sincerity"];
            }
            [tableView reloadData];
        };
        
        cell.addIntentStoreIntentCellTimeBlock = ^{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
            view.pickerView.datePickerMode = UIDatePickerModeDateAndTime;
            [view.pickerView setCalendar:[NSCalendar currentCalendar]];
            [view.pickerView setMaximumDate:[NSDate date]];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setDay:15];//设置最大时间为：当前时间推后10天
            [view.pickerView setMinimumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
            view.dateblock = ^(NSDate *date) {

                [self->_intentDic setObject:[self->_secondFormatter stringFromDate:date] forKey:@"sign_time"];
                [tableView reloadData];
            };
            [self.view addSubview:view];
        };
        
        cell.addIntentStoreIntentCellPeriod1Block = ^{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
            view.dateblock = ^(NSDate *date) {

                [self->_intentDic setObject:[[self->_secondFormatter stringFromDate:date] componentsSeparatedByString:@" "][0] forKey:@"start_time"];
                [tableView reloadData];
            };
            [self.view addSubview:view];
        };
        
        cell.addIntentStoreIntentCellPeriod2Block = ^{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
            view.dateblock = ^(NSDate *date) {

                [self->_intentDic setObject:[[self->_secondFormatter stringFromDate:date] componentsSeparatedByString:@" "][0] forKey:@"end_time"];
                [tableView reloadData];
            };
            [self.view addSubview:view];
        };
        
        return cell;
    }else if (indexPath.section == 3){
        
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

                [BaseRequest GET:ShopGetProgress_URL parameters:@{@"project_id":self->_project_id,@"config_type":@"1",@"progress_defined_id":@"4"} success:^(id  _Nonnull resposeObject) {

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
            if (self.addIntentStoreVCBlock) {
                
                self.addIntentStoreVCBlock();
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"新增意向商家";
    
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
    
//    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.view).offset(0);
//        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE);
//    }];
//
//    [_roomHeader mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(0);
//        make.top.equalTo(self->_scrollView).offset(0 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(40 *SIZE);
//    }];
//
//    [_addIntentStoreRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(0);
//        make.top.equalTo(self->_roomHeader.mas_bottom).offset(0 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.right.equalTo(self->_scrollView).offset(0);
//    }];
//
//    [_storeHeader mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(0);
//        make.top.equalTo(self->_addIntentStoreRoomView.mas_bottom).offset(0 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(40 *SIZE);
//    }];
//
//    [_addIntentStoreInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(0);
//        make.top.equalTo(self->_storeHeader.mas_bottom).offset(0 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(0 *SIZE);
//        make.right.equalTo(self->_scrollView).offset(0);
//    }];
//
//    [_intentHeader mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(0);
//        make.top.equalTo(self->_addIntentStoreInfoView.mas_bottom).offset(0 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(40 *SIZE);
//        make.right.equalTo(self->_scrollView).offset(0);
//    }];
//
//    [_addIntentStoreIntentView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(0);
//        make.top.equalTo(self->_intentHeader.mas_bottom).offset(0 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(0 *SIZE);
//        make.right.equalTo(self->_scrollView).offset(0);
//    }];
//
//    [_processHeader mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(0);
//        make.top.equalTo(self->_addIntentStoreIntentView.mas_bottom).offset(0 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(40 *SIZE);
//        make.right.equalTo(self->_scrollView).offset(0);
////        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
//    }];
//
//    [_addNumeralProcessView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(0);
//        make.top.equalTo(self->_processHeader.mas_bottom).offset(0 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(0);
//        make.right.equalTo(self->_scrollView).offset(0);
////        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
//    }];
//
//    [_addNumeralFileHeader mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(0);
//        make.top.equalTo(self->_addNumeralProcessView.mas_bottom).offset(0 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(40 *SIZE);
//        make.right.equalTo(self->_scrollView).offset(0);
//    }];
//
//    [_addNumeralFileView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(0);
//        make.top.equalTo(self->_addNumeralFileHeader.mas_bottom).offset(0 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(0);
//        make.right.equalTo(self->_scrollView).offset(0);
//        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
//    }];
}

@end
