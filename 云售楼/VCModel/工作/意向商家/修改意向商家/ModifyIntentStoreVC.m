//
//  ModifyIntentStoreVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ModifyIntentStoreVC.h"

#import "AddIntentSelectStoreVC.h"
#import "AddStoreVC.h"
#import "ShopRoomVC.h"

#import "AddNemeralHeader.h"
#import "AddIntentStoreRoomView.h"
#import "AddNumeralProcessView.h"
#import "AddIntentStoreIntentView.h"
#import "AddIntentStoreInfoView.h"
#import "AddNumeralFileView.h"


#import "SinglePickView.h"
#import "DateChooseView.h"
#import "MinMaxDateChooseView.h"

@interface ModifyIntentStoreVC (){
    
    NSString *_info_id;
    NSString *_project_id;
    NSString *_role_id;
    NSString *_chargeId;
    NSString *_row_id;
    
    NSDictionary *_dataDic;
    
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

@property (nonatomic, strong) AddNemeralHeader *roomHeader;

@property (nonatomic, strong) AddIntentStoreRoomView *addIntentStoreRoomView;

@property (nonatomic, strong) AddNemeralHeader *storeHeader;

@property (nonatomic, strong) AddIntentStoreInfoView *addIntentStoreInfoView;

@property (nonatomic, strong) AddNemeralHeader *intentHeader;

@property (nonatomic, strong) AddIntentStoreIntentView *addIntentStoreIntentView;

//@property (nonatomic, strong) AddNemeralHeader *processHeader;
//
//@property (nonatomic, strong) AddNumeralProcessView *addNumeralProcessView;

@property (nonatomic, strong) AddNemeralHeader *addNumeralFileHeader;

@property (nonatomic, strong) AddNumeralFileView *addNumeralFileView;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation ModifyIntentStoreVC

- (instancetype)initWithRowId:(NSString *)row_id projectId:(NSString *)project_id info_Id:(NSString *)info_id dataDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _row_id = row_id;
        _project_id = project_id;
        _info_id = info_id;
        
        _dataDic = dataDic;
        
        _intentDic = [@{} mutableCopy];
        [_intentDic setValue:[NSString stringWithFormat:@"%@",dataDic[@"row_code"]] forKey:@"row_code"];
        [_intentDic setValue:[NSString stringWithFormat:@"%@",dataDic[@"sincerity"]] forKey:@"sincerity"];
        [_intentDic setValue:dataDic[@"start_time"] forKey:@"start_time"];
        [_intentDic setValue:dataDic[@"end_time"] forKey:@"end_time"];
        [_intentDic setValue:dataDic[@"sign_time"] forKey:@"sign_time"];
//        [_intentDic setValue:[NSString stringWithFormat:@"%@",dataDic[@"from_id"]] forKey:@"from_id"];
        _chargeId = [NSString stringWithFormat:@"%@",dataDic[@"shop_detail_list"][@"charge_company_id"]];
        
        
        _progressDic = [@{} mutableCopy];
        [_progressDic setObject:dataDic[@"progressList"][@"progress_id"] forKey:@"progress_id"];
        [_progressDic setObject:dataDic[@"progressList"][@"check_type"] forKey:@"check_type"];
        
        _roomArr = [[NSMutableArray alloc] initWithArray:self->_dataDic[@"shop_list"]];
        _storeArr = [[NSMutableArray alloc] initWithArray:@[@{@"business_name":self->_dataDic[@"business_name"],@"contact":self->_dataDic[@"contact"],@"lease_money":self->_dataDic[@"lease_money"],@"lease_size":self->_dataDic[@"lease_size"],@"create_time":self->_dataDic[@"create_time"],@"format_name":self->_dataDic[@"format_name"],@"business_id":[NSString stringWithFormat:@"%@",self->_dataDic[@"from_id"]]}]];
        
        _imgArr = [@[] mutableCopy];
        _imgArr = [NSMutableArray arrayWithArray:self->_dataDic[@"enclosure"]];
//        _addNumeralFileView.dataArr = _imgArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"房源信息",@"商家信息",@"意向信息"];
    _selectArr = [[NSMutableArray alloc] initWithArray:@[@1,@0,@0,@0]];
    
//    _intentDic = [@{} mutableCopy];
    
//    _progressDic = [@{} mutableCopy];
//
//    _roomArr = [@[] mutableCopy];
//
//    _storeArr = [@[] mutableCopy];
    
//    _progressArr = [@[] mutableCopy];
//    _progressAllArr = [@[] mutableCopy];
    
//    _roleArr = [@[] mutableCopy];
//    _rolePersonArr = [@[] mutableCopy];
//    _rolePersonSelectArr = [@[] mutableCopy];
//    _imgArr = [@[] mutableCopy];
    
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
    
    if (!_addIntentStoreIntentView.codeTF.textField.text.length) {
        
        [self showContent:@"请输入意向编号"];
        return;
    }
    
    if (!_addIntentStoreIntentView.sincerityTF.textField.text.length) {
        
        [self showContent:@"请输入诚意金"];
        return;
    }
    if (!_addIntentStoreIntentView.intentPeriodLBtn1.content.text.length) {
        
        [self showContent:@"请选择租期开始时间"];
        return;
    }
    
    if (!_addIntentStoreIntentView.intentPeriodLBtn2.content.text.length) {
        
        [self showContent:@"请选择租期结束时间"];
        return;
    }
    
    if (!_addIntentStoreIntentView.timeBtn.content.text.length) {
        
        [self showContent:@"请选择登记时间"];
        return;
    }
//    if (!_addNumeralProcessView.typeBtn.content.text.length) {
//        [self showContent:@"请选择审批流程"];
//        return;
//    }
//    if ([_progressDic[@"check_type"] integerValue] == 1) {
//
//        if (!_addNumeralProcessView.auditBtn.content.text.length) {
//            [self showContent:@"请选择流程类型"];
//            return;
//        }
//    }
//    NSString *param;
//    if ([_addNumeralProcessView.auditBtn.content.text isEqualToString:@"自由流程"]) {
//
//        for (int i = 0; i < _rolePersonSelectArr.count; i++) {
//
//            if ([_rolePersonSelectArr[i] integerValue] == 1) {
//
//                if (param.length) {
//
//                    param = [NSString stringWithFormat:@"%@,%@",param,_rolePersonArr[i][@"agent_id"]];
//                }else{
//
//                    param = [NSString stringWithFormat:@"%@",_rolePersonArr[i][@"agent_id"]];
//                }
//            }
//        }
//        if (!param.length) {
//
//            [self showContent:@"请选择审核人员"];
//            return;
//        }
//    }
    
    NSMutableDictionary *dic = [@{} mutableCopy];
    
    [dic setValue:_row_id forKey:@"row_id"];
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
    [dic setValue:_project_id forKey:@"project_id"];
    [dic setValue:_addIntentStoreIntentView.codeTF.textField.text forKey:@"row_code"];
    [dic setValue:_addIntentStoreIntentView.sincerityTF.textField.text forKey:@"sincerity"];
    [dic setValue:_addIntentStoreIntentView.intentPeriodLBtn1.content.text forKey:@"start_time"];
    [dic setValue:_addIntentStoreIntentView.intentPeriodLBtn2.content.text forKey:@"end_time"];
    [dic setValue:_chargeId forKey:@"charge_company_id"];
    [dic setValue:[_addIntentStoreIntentView.timeBtn.content.text componentsSeparatedByString:@" "][0] forKey:@"sign_time"];
    if (_imgArr.count) {
        
        NSError *error;
        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:_imgArr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString2 = [[NSString alloc]initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        [dic setObject:jsonString2 forKey:@"enclosure_list"];
    }else{
        
        NSError *error;
        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:_imgArr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString2 = [[NSString alloc]initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        [dic setObject:jsonString2 forKey:@"enclosure_list"];
    }
//    [dic setObject:_progressDic[@"progress_id"] forKey:@"current_progress"];
//    if (param.length) {
//
//        [dic setObject:param forKey:@"param"];
//    }
    [BaseRequest POST:ShopRowUpdateTradeRow_URL parameters:dic success:^(id  _Nonnull resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {

            if (self.modifyIntentStoreVCBlock) {

                self.modifyIntentStoreVCBlock();
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
           self->_addNumeralFileView.dataArr = self->_imgArr;
       }else{

           [self showContent:resposeObject[@"msg"]];
       }

    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
    }];
}

- (void)initUI{
    
    self.titleLabel.text = @"修改意向商家";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLBackColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    SS(strongSelf);
    
#pragma mark -- 房源信息 --
    _roomHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _roomHeader.backgroundColor = CLWhiteColor;
    _roomHeader.titleL.text = @"房源信息";
    _roomHeader.addBtn.hidden = YES;
    [_roomHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
    _roomHeader.addNemeralHeaderAllBlock = ^{
      
        if ([strongSelf->_selectArr[0] integerValue]){
            
            [strongSelf->_selectArr replaceObjectAtIndex:0 withObject:@0];
            [strongSelf->_roomHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addIntentStoreRoomView.hidden = YES;
            [strongSelf->_addIntentStoreRoomView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_roomHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:0 withObject:@1];
            [strongSelf->_roomHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addIntentStoreRoomView.hidden = NO;
            [strongSelf->_addIntentStoreRoomView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_roomHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_roomHeader];
    
    _addIntentStoreRoomView = [[AddIntentStoreRoomView alloc] init];
    _addIntentStoreRoomView.dataArr = self->_roomArr;
    _addIntentStoreRoomView.addIntentStoreRoomViewAddBlock = ^{
        
        ShopRoomVC *nextVC = [[ShopRoomVC alloc] init];
        nextVC.project_id = strongSelf->_project_id;
        nextVC.roomArr = strongSelf->_roomArr;
        nextVC.shopRoomVCBlock = ^(NSDictionary * _Nonnull dic, NSString * _Nonnull chargeId) {
                
            if (!strongSelf->_chargeId) {
                
                strongSelf->_chargeId = chargeId;
            }
            [strongSelf->_roomArr addObject:dic];
            strongSelf->_addIntentStoreRoomView.dataArr = strongSelf->_roomArr;
        };
        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    _addIntentStoreRoomView.addIntentStoreRoomViewDeleteBlock = ^(NSInteger idx) {
        
        [strongSelf->_roomArr removeObjectAtIndex:idx];
        strongSelf->_addIntentStoreRoomView.dataArr = strongSelf->_roomArr;
    };
    [_scrollView addSubview:_addIntentStoreRoomView];
    
    
#pragma mark -- 商家信息 --
    _storeHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _storeHeader.backgroundColor = CLWhiteColor;
    _storeHeader.titleL.text = @"商家信息";
    _storeHeader.addBtn.hidden = YES;
    [_storeHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _storeHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[1] integerValue]){
        
            [strongSelf->_selectArr replaceObjectAtIndex:1 withObject:@0];
            [strongSelf->_storeHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addIntentStoreInfoView.hidden = YES;
            [strongSelf->_addIntentStoreInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_storeHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:1 withObject:@1];
            [strongSelf->_storeHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addIntentStoreInfoView.hidden = NO;
            [strongSelf->_addIntentStoreInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_storeHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_storeHeader];
    
    _addIntentStoreInfoView = [[AddIntentStoreInfoView alloc] init];
    _addIntentStoreInfoView.dataArr = self->_storeArr;
    _addIntentStoreInfoView.hidden = YES;
    _addIntentStoreInfoView.addIntentStoreInfoViewAddBlock = ^{
        
        AddStoreVC *nextVC = [[AddStoreVC alloc] initWithProjectId:strongSelf->_project_id info_id:strongSelf->_info_id];
        nextVC.status = @"direct";
        nextVC.addStoreVCDicBlock = ^(NSDictionary * _Nonnull dic) {
          
            [strongSelf->_storeArr addObject:dic];
            strongSelf->_addIntentStoreInfoView.dataArr = strongSelf->_storeArr;
        };
        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    _addIntentStoreInfoView.addIntentStoreInfoViewDeleteBlock = ^(NSInteger idx) {
        
        [strongSelf->_storeArr removeObjectAtIndex:idx];
        strongSelf->_addIntentStoreInfoView.dataArr = strongSelf->_storeArr;
    };
    _addIntentStoreInfoView.addIntentStoreInfoViewSelectBlock = ^{
        
        AddIntentSelectStoreVC *nextVC = [[AddIntentSelectStoreVC alloc] initWithProjectId:strongSelf->_project_id info_id:strongSelf->_info_id];
        nextVC.addIntentSelectStoreVCBlock = ^(NSDictionary * _Nonnull dic) {
            [strongSelf->_storeArr addObject:dic];
            strongSelf->_addIntentStoreInfoView.dataArr = strongSelf->_storeArr;
        };
        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    [_scrollView addSubview:_addIntentStoreInfoView];

   
#pragma mark -- 意向信息 --
    _intentHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _intentHeader.backgroundColor = CLWhiteColor;
    _intentHeader.titleL.text = @"意向信息";
    _intentHeader.addBtn.hidden = YES;
    [_intentHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
    _intentHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[2] integerValue]){
        
            [strongSelf->_selectArr replaceObjectAtIndex:2 withObject:@0];
            [strongSelf->_intentHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addIntentStoreIntentView.hidden = YES;
            [strongSelf->_addIntentStoreIntentView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_intentHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:2 withObject:@1];
            [strongSelf->_intentHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addIntentStoreIntentView.hidden = NO;
            [strongSelf->_addIntentStoreIntentView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_intentHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_intentHeader];
    
    _addIntentStoreIntentView = [[AddIntentStoreIntentView alloc] init];
    _addIntentStoreIntentView.hidden = YES;
    _addIntentStoreIntentView.dataDic = _intentDic;
    _addIntentStoreIntentView.addIntentStoreIntentViewPeriod1Block = ^{
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
        view.dateblock = ^(NSDate *date) {
            
            [strongSelf->_intentDic setObject:[[strongSelf->_secondFormatter stringFromDate:date] componentsSeparatedByString:@" "][0] forKey:@"min"];
            strongSelf->_addIntentStoreIntentView.dataDic = strongSelf->_intentDic;
        };
        [strongSelf.view addSubview:view];
    };
    
    _addIntentStoreIntentView.addIntentStoreIntentViewPeriod2Block = ^{
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
        view.dateblock = ^(NSDate *date) {
            
            [strongSelf->_intentDic setObject:[[strongSelf->_secondFormatter stringFromDate:date] componentsSeparatedByString:@" "][0] forKey:@"max"];
            strongSelf->_addIntentStoreIntentView.dataDic = strongSelf->_intentDic;
        };
        [strongSelf.view addSubview:view];
    };
    
    _addIntentStoreIntentView.addIntentStoreIntentViewTimeBlock = ^{
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
        view.pickerView.datePickerMode = UIDatePickerModeDateAndTime;
        [view.pickerView setCalendar:[NSCalendar currentCalendar]];
        [view.pickerView setMaximumDate:[NSDate date]];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:15];//设置最大时间为：当前时间推后10天
        [view.pickerView setMinimumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
        view.dateblock = ^(NSDate *date) {
            
            [strongSelf->_intentDic setObject:[strongSelf->_secondFormatter stringFromDate:date] forKey:@"time"];
            strongSelf->_addIntentStoreIntentView.dataDic = strongSelf->_intentDic;
        };
        [strongSelf.view addSubview:view];
    };
    
    _addIntentStoreIntentView.addIntentStoreIntentViewStrBlock = ^(NSString * _Nonnull str, NSInteger idx) {
        
        if (idx == 0) {
            
            [strongSelf->_intentDic setValue:str forKey:@"code"];
        }else{
            
            [strongSelf->_intentDic setValue:str forKey:@"sincerity"];
        }
        strongSelf->_addIntentStoreIntentView.dataDic = strongSelf->_intentDic;
    };
    [_scrollView addSubview:_addIntentStoreIntentView];
    
#pragma mark -- 附件文件 --
    _addNumeralFileHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _addNumeralFileHeader.titleL.text = @"附件文件";
    _addNumeralFileHeader.addBtn.hidden = YES;
    [_addNumeralFileHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _addNumeralFileHeader.backgroundColor = CLWhiteColor;
    _addNumeralFileHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[3] integerValue]){

            [strongSelf->_selectArr replaceObjectAtIndex:3 withObject:@0];
            [strongSelf->_addNumeralFileHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addNumeralFileView.hidden = YES;
            [strongSelf->_addNumeralFileView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_addNumeralFileHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
                make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
            }];
        }else{

            [strongSelf->_selectArr replaceObjectAtIndex:3 withObject:@1];
            [strongSelf->_addNumeralFileHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addNumeralFileView.hidden = NO;
            [strongSelf->_addNumeralFileView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_addNumeralFileHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
                make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_addNumeralFileHeader];

    _addNumeralFileView = [[AddNumeralFileView alloc] init];
    _addNumeralFileView.hidden = YES;
    _addNumeralFileView.dataArr = _imgArr;
    _addNumeralFileView.addNumeralFileViewAddBlock = ^{

        [ZZQAvatarPicker startSelected:^(UIImage * _Nonnull image) {

            if (image) {

                [strongSelf updateheadimgbyimg:image];
            }
        }];
    };
    _addNumeralFileView.addNumeralFileViewDeleteBlock = ^(NSInteger idx) {

        [strongSelf->_imgArr removeObjectAtIndex:idx];
        strongSelf->_addNumeralFileView.dataArr = strongSelf->_imgArr;
    };
    _addNumeralFileView.addNumeralFileViewSelectBlock = ^(NSInteger idx) {
      
        ChangeFileNameView *view = [[ChangeFileNameView alloc] initWithFrame:strongSelf.view.bounds name:strongSelf->_imgArr[idx][@"name"]];
        view.changeFileNameViewBlock = ^(NSString * _Nonnull name) {
          
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:strongSelf->_imgArr[idx]];
            [tempDic setValue:name forKey:@"name"];
            [strongSelf->_imgArr replaceObjectAtIndex:idx withObject:tempDic];
            strongSelf->_addNumeralFileView.dataArr = strongSelf->_imgArr;
        };
        [strongSelf.view addSubview:view];
    };
    [_scrollView addSubview:_addNumeralFileView];
    
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
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE);
    }];
    
    [_roomHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_addIntentStoreRoomView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_roomHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_storeHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_addIntentStoreRoomView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
        
    [_addIntentStoreInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_storeHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_intentHeader mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_addIntentStoreInfoView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];

    [_addIntentStoreIntentView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_intentHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];

    [_addNumeralFileHeader mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_addIntentStoreIntentView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];

    [_addNumeralFileView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_addNumeralFileHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0);
        make.right.equalTo(self->_scrollView).offset(0);
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
    }];
}

@end
