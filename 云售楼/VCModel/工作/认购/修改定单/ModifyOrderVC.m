//
//  ModifyOrderVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/24.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ModifyOrderVC.h"

#import "RoomVC.h"
#import "SelectSpePerferVC.h"
#import "AddCallTelegramGroupMemberVC.h"
#import "CallTelegramSimpleCustomVC.h"


#import "AddNemeralHeader.h"

#import "AddNumeralPersonView.h"
#import "AddOrderRoomView.h"
#import "AddOrderView.h"
#import "AddNumeralProcessView.h"
#import "AddNumeralFileView.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

@interface ModifyOrderVC ()<UIScrollViewDelegate>
{
    
    NSInteger _num;
    
    NSString *_minPirce;
    NSString *_project_id;
    NSString *_info_id;
    NSString *_group_id;
    NSString *_sub_id;
    NSString *_role_id;
    
    NSDictionary *_dataDic;
    
    NSArray *_titleArr;
    NSArray *_disOriginArr;
    
    NSMutableDictionary *_roomDic;
    NSMutableDictionary *_ordDic;
    NSMutableDictionary *_progressDic;
    
    NSMutableDictionary *_pay_info;
    
    NSMutableArray *_bankArr;
    NSMutableArray *_certArr;
    NSMutableArray *_personArr;
    NSMutableArray *_proportionArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_typeArr;
    NSMutableArray *_disCountArr;
    NSMutableArray *_progressArr;
    NSMutableArray *_progressAllArr;
    NSMutableArray *_roleArr;
    NSMutableArray *_rolePersonArr;
    NSMutableArray *_rolePersonSelectArr;
    NSMutableArray *_installmentArr;
    NSMutableArray *_imgArr;
    
    NSDateFormatter *_formatter;
    NSDateFormatter *_secondFormatter;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) AddNemeralHeader *personHeader;

@property (nonatomic, strong) AddNumeralPersonView *addNumeralPersonView;

@property (nonatomic, strong) AddNemeralHeader *roomHeader;

@property (nonatomic, strong) AddOrderRoomView *addOrderRoomView;

@property (nonatomic, strong) AddNemeralHeader *orderHeader;

@property (nonatomic, strong) AddOrderView *addOrderView;

@property (nonatomic, strong) AddNemeralHeader *processHeader;

@property (nonatomic, strong) AddNumeralProcessView *addNumeralProcessView;

@property (nonatomic, strong) AddNemeralHeader *addNumeralFileHeader;

@property (nonatomic, strong) AddNumeralFileView *addNumeralFileView;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation ModifyOrderVC

- (instancetype)initWithSubId:(NSString *)sub_id projectId:(NSString *)project_id info_Id:(NSString *)info_id dataDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _dataDic = dataDic;
        
        
        _sub_id = sub_id;
        _group_id = dataDic[@"beneficiary"][0][@"group_id"];
        _project_id = project_id;
        _info_id = info_id;
        
        _bankArr = [@[] mutableCopy];
        
        _roomDic = [@{} mutableCopy];
        
        
        _disCountArr = [@[] mutableCopy];
        
        
        _installmentArr = [@[] mutableCopy];
        
        _progressDic = [@{} mutableCopy];
        
        [self SetOriginData:_dataDic];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _num = 0;
    _titleArr = @[@"权益人信息",@"房源信息",@"定单信息"];
    
    _pay_info = [[NSMutableDictionary alloc] init];
    
    
    _certArr = [@[] mutableCopy];
    _selectArr = [[NSMutableArray alloc] initWithArray:@[@1,@0,@0,@0,@1]];
    _progressArr = [@[] mutableCopy];
    _progressAllArr = [@[] mutableCopy];
    _roleArr = [@[] mutableCopy];
    _rolePersonArr = [@[] mutableCopy];
    _rolePersonSelectArr = [@[] mutableCopy];
    
    
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
    _secondFormatter = [[NSDateFormatter alloc] init];
    [_secondFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    if (!_installmentArr.count) {
        
        [_installmentArr addObject:@{@"pay_time":@"",@"tip_time":@"",@"pay_money":@""}];
    }
    
    [BaseRequest GET:WorkClientAutoBasicConfig_URL parameters:@{@"project_id":_project_id,@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            for (int i = 0; i < [resposeObject[@"data"][5] count]; i++) {
                
                NSDictionary *dic = resposeObject[@"data"][5][i];
                [self->_bankArr addObject:@{@"id":dic[@"config_id"],@"param":dic[@"config_name"]}];
            }
            [self SetOriginData:self->_dataDic];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"获取银行信息失败"];
    }];
}

- (void)SetOriginData:(NSDictionary *)dataDic{
    
    [_roomDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"house_name"]] forKey:@"house_name"];
    [_roomDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"build_name"]] forKey:@"build_name"];
    [_roomDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"unit_name"]] forKey:@"unit_name"];
    [_roomDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"floor_num"]] forKey:@"floor_num"];
    [_roomDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"total_price"]] forKey:@"total_price"];
    [_roomDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"price_way"]] forKey:@"price_way_name"];
    [_roomDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"property_type"]] forKey:@"property_type"];
    [_roomDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"estimated_build_size"]] forKey:@"estimated_build_size"];
    [_roomDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"indoor_size"]] forKey:@"indoor_size"];
    [_roomDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"house_type"]] forKey:@"house_type"];
    [_roomDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"build_unit_price"]] forKey:@"build_unit_price"];
    [_roomDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"house_id"]] forKey:@"house_id"];

    
    _ordDic = [@{} mutableCopy];
    [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"sub_code"]] forKey:@"sub_code"];
    [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"down_pay"]] forKey:@"down_pay"];
    [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"pay_way_name"]] forKey:@"payWay_Name"];
    [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"pay_way"]] forKey:@"payWay_id"];
    [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"total_price"]] forKey:@"total_price"];
    [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"sub_time"]] forKey:@"sub_time"];
    
    _disCountArr = [NSMutableArray arrayWithArray:_dataDic[@"discount"]];
    if (_disCountArr.count) {
        
        if ([_disCountArr[_disCountArr.count - 1][@"type"] isEqualToString:@"抹零"]) {
            
            [_ordDic setObject:_disCountArr[_disCountArr.count - 1][@"num"] forKey:@"spePreferential"];
            [_disCountArr removeObjectAtIndex:(_disCountArr.count - 1)];
        }
    }
    float price = [_ordDic[@"total_price"] floatValue];
    float unit = 0;
    float percent = 0;
    float preferPrice = 0;
    for (int i = 0; i < _disCountArr.count; i++) {
        
        NSDictionary *dic = _disCountArr[i];
        if ([dic[@"type"] isEqualToString:@"单价优惠"]) {
            
            unit = unit + [dic[@"num"] doubleValue];
        }else if ([dic[@"type"] isEqualToString:@"减点"]){
            
            if ([dic[@"is_cumulative"] integerValue] == 1) {
                
                percent = percent + [dic[@"num"] doubleValue] / 100.00;
            }
        }
    }
    if (unit) {
        
        price = [_roomDic[@"estimated_build_size"] doubleValue] * ([_roomDic[@"build_unit_price"] doubleValue] - unit);
    }
    for (int i = 0; i < _disCountArr.count; i++) {
        
        NSDictionary *dic = _disCountArr[i];
        if ([dic[@"type"] isEqualToString:@"减点"]) {
            
            if ([dic[@"is_cumulative"] integerValue] == 1) {
                
                if (percent) {
                    
                    price = price * (1 - percent);
                    percent = 0;
                }
            }else{
                
                price = price * (1 - [dic[@"num"] doubleValue] / 100.00);
            }
        }else if([dic[@"type"] isEqualToString:@"单价优惠"]){
            
            
        }else{
            
            price = price - [dic[@"num"] doubleValue];
        }
    }
    preferPrice = [_ordDic[@"total_price"] floatValue] - price;
    if ([_ordDic[@"spePreferential"] doubleValue]) {
        
        price = price - [_ordDic[@"spePreferential"] doubleValue];
        preferPrice = preferPrice + [_ordDic[@"spePreferential"] doubleValue];
    }
    
    [_ordDic setObject:[NSString stringWithFormat:@"%.2f",price] forKey:@"price"];
    
    [_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [_roomDic[@"estimated_build_size"] floatValue])] forKey:@"sub_unit_price"];
    [_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [_roomDic[@"estimated_build_size"] floatValue])] forKey:@"build_unit_price"];
    [_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [_roomDic[@"indoor_size"] floatValue])] forKey:@"inner_unit_price"];
    
    [_ordDic setObject:[NSString stringWithFormat:@"%.2f",preferPrice] forKey:@"preferPrice"];

    if ([_ordDic[@"payWay_Name"] isEqualToString:@"分期付款"]) {
        
        _installmentArr = [NSMutableArray arrayWithArray:_dataDic[@"back"]];
    }else if ([_ordDic[@"payWay_Name"] isEqualToString:@"综合贷款"]){
        
        [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"back"][0][@"bank_loan_money"]] forKey:@"bank_loan_money"];
        [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"back"][0][@"fund_loan_money"]] forKey:@"fund_loan_money"];
        [_ordDic setObject:[NSString stringWithFormat:@"%.2f",([_ordDic[@"price"] floatValue] - [_dataDic[@"back"][0][@"bank_loan_money"] floatValue] - [_dataDic[@"back"][0][@"fund_loan_money"] floatValue])] forKey:@"downpayment"];
        [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"back"][0][@"bank_loan_limit"]] forKey:@"bank_loan_limit"];
        [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"back"][0][@"fund_loan_limit"]] forKey:@"fund_loan_limit"];
        [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"back"][0][@"bank_bank_id"]] forKey:@"bank_bank_id"];
        [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"back"][0][@"fund_bank_id"]] forKey:@"fund_bank_id"];
        for (int i = 0; i < _bankArr.count; i++) {
            
            if ([_bankArr[i][@"id"] integerValue] == [_ordDic[@"fund_bank_id"] integerValue]) {
                
                [_ordDic setObject:_bankArr[i][@"param"] forKey:@"fund_bank_name"];
            }
            if ([_bankArr[i][@"id"] integerValue] == [_ordDic[@"bank_bank_id"] integerValue]) {
                
                [_ordDic setObject:_bankArr[i][@"param"] forKey:@"bank_bank_name"];
            }
        }
    }else if ([_ordDic[@"payWay_Name"] isEqualToString:@"公积金贷款"] || [_ordDic[@"payWay_Name"] isEqualToString:@"银行按揭贷款"]){
        
        [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"back"][0][@"loan_money"]] forKey:@"loan_money"];
        [_ordDic setObject:[NSString stringWithFormat:@"%.2f",([_ordDic[@"price"] floatValue] - [_dataDic[@"back"][0][@"loan_money"] floatValue])] forKey:@"downpayment"];
        [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"back"][0][@"loan_limit"]] forKey:@"loan_limit"];
        [_ordDic setObject:[NSString stringWithFormat:@"%@",_dataDic[@"back"][0][@"bank_id"]] forKey:@"bank_id"];
        for (int i = 0; i < _bankArr.count; i++) {
            
            if ([_bankArr[i][@"id"] integerValue] == [_ordDic[@"bank_id"] integerValue]) {
                
                [_ordDic setObject:_bankArr[i][@"param"] forKey:@"bank_name"];
            }
        }
    }
    _addOrderView.dataDic = _ordDic;
    _addOrderView.dataArr = _disCountArr;
    _addOrderView.installArr = _installmentArr;
    
    [_progressDic setObject:dataDic[@"progressList"][@"progress_id"] forKey:@"progress_id"];
    [_progressDic setObject:dataDic[@"progressList"][@"check_type"] forKey:@"check_type"];
    [_progressDic setObject:dataDic[@"progressList"][@"progress_name"] forKey:@"progress_name"];
    
    
    _personArr = [[NSMutableArray alloc] initWithArray:_dataDic[@"beneficiary"]];
    _proportionArr = [@[] mutableCopy];
    for (int i = 0; i < _personArr.count; i++) {
        
        [_proportionArr addObject:_personArr[i][@"property"]];
    }
    _imgArr = [@[] mutableCopy];
    _imgArr = [NSMutableArray arrayWithArray:self->_dataDic[@"enclosure"]];
    _addNumeralFileView.dataArr = _imgArr;
}

- (void)DiscountRequest{
    
    NSDictionary *dic = @{@"batch_id":[NSString stringWithFormat:@"%@",self->_roomDic[@"batch_id"]],
                          @"build_id":[NSString stringWithFormat:@"%@",self->_roomDic[@"build_id"]],
                          @"unit_id":[NSString stringWithFormat:@"%@",self->_roomDic[@"unit_id"]],
                          };
    
    [BaseRequest GET:ProjectHouseGetDiscountList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_disOriginArr = resposeObject[@"data"];
            if (self->_addOrderView) {
                
                //                self->_addOrderView
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)PropertyRequestMethod{
    
    [BaseRequest GET:WorkClientAutoBasicConfig_URL parameters:@{@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            for (int i = 0; i < [resposeObject[@"data"][2] count]; i++) {
                
                NSDictionary *dic = @{@"id":resposeObject[@"data"][2][i][@"config_id"],
                                      @"param":resposeObject[@"data"][2][i][@"config_name"]};
                [self->_certArr addObject:dic];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
    
    [BaseRequest GET:ProjectRowGetRowList_URL parameters:@{@"project_id":_project_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_typeArr = [[NSMutableArray alloc] initWithArray:resposeObject[@"data"]];
            //            [self->_table reloadData];
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
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
            self->_addNumeralProcessView.personArr = self->_rolePersonArr;
            self->_addNumeralProcessView.personSelectArr = self->_rolePersonSelectArr;
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}

-(void)updateheadimgbyimg:(UIImage *)img{
    
//    NSData *data1 = [NSData ]
    NSData *data = [self resetSizeOfImageData:img maxSize:150];

    NSString *name = [self->_secondFormatter stringFromDate:[NSDate date]];
    [BaseRequest UpdateFile:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];
//        [formData appendPartWithFileData:data name:@"file_name" fileName:[NSString stringWithFormat:@"%@.jpg",name] mimeType:@"image/jpg"];
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


- (void)ActionNextBtn:(UIButton *)btn{
    
    [_pay_info removeAllObjects];
    BOOL isFull = YES;
    NSInteger percent = 0;
    for (NSString *str in _proportionArr) {
        
        if (!str.length) {
            
            isFull = NO;
            break;
        }else{
            
            percent += [str integerValue];
        }
    }
    if (!isFull) {
        
        [self showContent:@"请填写权益人比例"];
        return;
    }
    
    if (percent != 100) {
        
        [self showContent:@"权益人比例总和不为100"];
        return;
    }
    
    if (!_roomDic.count) {
        
        [self showContent:@"请选择房源"];
        return;
    }
    
    if (!_addOrderView.codeTF.textField.text.length) {
        
        [self showContent:@"请填写定单编号"];
        return;
    }
    
    if (!_addOrderView.timeBtn.content.text) {
        
        [self showContent:@"请选择定单时间"];
        return;
    }
    
    if (!_addOrderView.depositTF.textField.text.length) {
        
        [self showContent:@"请定金金额"];
        return;
    }
    
//    if (!_addOrderView.payWayBtn.content.text.length) {
//
//        [self showContent:@"请选择付款方式"];
//        return;
//    }
    
    if ([_addOrderView.payWayBtn.content.text isEqualToString:@"一次性付款"]) {
        
        [_pay_info removeAllObjects];
    }else if ([_addOrderView.payWayBtn.content.text isEqualToString:@"公积金贷款"]){
        
        if (!_addOrderView.loanPriceTF.textField.text.length) {
            
            [self showContent:@"请输入贷款金额"];
            return;
        }
        if (!_addOrderView.loanBankBtn.content.text.length) {
            
            [self showContent:@"请选择按揭银行"];
            return;
        }
        if (!_addOrderView.loanYearTF.textField.text.length) {
            
            [self showContent:@"请输入按揭年限"];
            return;
        }
        
        [_pay_info setObject:_addOrderView.paymentTF.textField.text forKey:@"downpayment"];
        [_pay_info setObject:@"0" forKey:@"downpayment_repay"];
        [_pay_info setObject:_addOrderView.loanPriceTF.textField.text forKey:@"loan_money"];
        [_pay_info setObject:_addOrderView.loanYearTF.textField.text forKey:@"loan_limit"];
        [_pay_info setObject:_addOrderView.loanBankBtn->str forKey:@"bank_id"];
    }else if ([_addOrderView.payWayBtn.content.text isEqualToString:@"综合贷款"]){
        
        
        if (!_addOrderView.businessLoanPriceTF.textField.text.length) {
            
            [self showContent:@"请输入商业贷款金额"];
            return;
        }
        if (!_addOrderView.businessLoanBankBtn.content.text.length) {
            
            [self showContent:@"请选择商业按揭银行"];
            return;
        }
        if (!_addOrderView.businessLoanYearTF.textField.text.length) {
            
            [self showContent:@"请输入商业按揭年限"];
            return;
        }
        if (!_addOrderView.fundLoanTF.textField.text.length) {
            
            [self showContent:@"请输入公积金贷款金额"];
            return;
        }
        if (!_addOrderView.fundLoanBankBtn.content.text.length) {
            
            [self showContent:@"请选择公积金按揭银行"];
            return;
        }
        if (!_addOrderView.fundLoanYearTF.textField.text.length) {
            
            [self showContent:@"请输入公积金按揭年限"];
            return;
        }
        
        [_pay_info setObject:_addOrderView.paymentTF.textField.text forKey:@"downpayment"];
        [_pay_info setObject:@"0" forKey:@"downpayment_repay"];
        [_pay_info setObject:_addOrderView.businessLoanPriceTF.textField.text forKey:@"bank_loan_money"];
        [_pay_info setObject:_addOrderView.businessLoanYearTF.textField.text forKey:@"bank_loan_limit"];
        [_pay_info setObject:_addOrderView.businessLoanBankBtn->str forKey:@"bank_bank_id"];
        [_pay_info setObject:_addOrderView.fundLoanTF.textField.text forKey:@"fund_loan_money"];
        [_pay_info setObject:_addOrderView.fundLoanYearTF.textField.text forKey:@"fund_loan_limit"];
        [_pay_info setObject:_addOrderView.fundLoanBankBtn->str forKey:@"fund_bank_id"];
    }else if ([_addOrderView.payWayBtn.content.text isEqualToString:@"银行按揭贷款"]){
        
        if (!_addOrderView.loanPriceTF.textField.text.length) {
            
            [self showContent:@"请输入贷款金额"];
            return;
        }
        if (!_addOrderView.loanBankBtn.content.text.length) {
            
            [self showContent:@"请选择按揭银行"];
            return;
        }
        if (!_addOrderView.loanYearTF.textField.text.length) {
            
            [self showContent:@"请输入按揭年限"];
            return;
        }
        
        [_pay_info setObject:_addOrderView.paymentTF.textField.text forKey:@"downpayment"];
        [_pay_info setObject:@"0" forKey:@"downpayment_repay"];
        [_pay_info setObject:_addOrderView.loanPriceTF.textField.text forKey:@"loan_money"];
        [_pay_info setObject:_addOrderView.loanYearTF.textField.text forKey:@"loan_limit"];
        [_pay_info setObject:_addOrderView.loanBankBtn->str forKey:@"bank_id"];
    }else if ([_addOrderView.payWayBtn.content.text isEqualToString:@"分期付款"]){
        
        
    }else{
        
        
    }
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:_personArr];
    for (int i = 0; i < tempArr.count; i++) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:tempArr[i]];
        if (i == 0) {
            
            [dic setObject:@"1" forKey:@"beneficiary_type"];
        }else{
            
            [dic setObject:@"2" forKey:@"beneficiary_type"];
        }
        
        [dic removeObjectForKey:@"client_id"];
        [dic removeObjectForKey:@"comment"];
        [dic removeObjectForKey:@"mail_code"];
        [dic removeObjectForKey:@"tel_show_state"];
        [dic setObject:_group_id forKey:@"group_id"];
        [dic removeObjectForKey:@"beneficiary_id"];
        
        [dic setObject:_proportionArr[i] forKey:@"property"];
        
        //        [dic removeObjectForKey:@"group_id"];
        [tempArr replaceObjectAtIndex:i withObject:dic];
    }
    
    NSArray *advicer_list = self->_dataDic[@"advicer"]; //@[@{@"advicer":self.advicer_id,@"name":self.advicer_name,@"type":@"1",@"property":@"50",@"comment":@"bujj"}];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    NSError *error;
    NSData *tempArrData = [NSJSONSerialization dataWithJSONObject:tempArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *tempArrJson = [[NSString alloc]initWithData:tempArrData encoding:NSUTF8StringEncoding];
    [dic setObject:tempArrJson forKey:@"beneficiary_list"];
    
    //    NSError *error;
    NSData *advicer_listData = [NSJSONSerialization dataWithJSONObject:advicer_list options:NSJSONWritingPrettyPrinted error:&error];
    NSString *advicer_listDataJson = [[NSString alloc]initWithData:advicer_listData encoding:NSUTF8StringEncoding];
    [dic setObject:advicer_listDataJson forKey:@"advicer_list"];
    
    if (_imgArr.count) {

        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:_imgArr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString2 = [[NSString alloc]initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        [dic setObject:jsonString2 forKey:@"enclosure_list"];
    }else{
        
        NSError *error;
        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:_imgArr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString2 = [[NSString alloc]initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        [dic setObject:jsonString2 forKey:@"enclosure_list"];
    }
    
    [dic setObject:self.from_type forKey:@"from_type"];
    if ([self.from_type isEqualToString:@"1"]) {
        
        [dic setObject:tempArr[0][@"group_id"] forKey:@"from_id"];
    }else if ([self.from_type isEqualToString:@"3"]){
        
        [dic setObject:_sub_id forKey:@"from_id"];
    }else if ([self.from_type isEqualToString:@"1"]){
        
        
    }
    
    [dic setObject:_sub_id forKey:@"sub_id"];
    
    [dic setObject:_project_id forKey:@"project_id"];
    [dic setObject:_roomDic[@"house_id"] forKey:@"house_id"];
    [dic setObject:_ordDic[@"price"] forKey:@"sub_total_price"];
    [dic setObject:_ordDic[@"sub_time"] forKey:@"sub_time"];
    if ([dic[@"sub_total_price"] floatValue] < [_minPirce floatValue]) {
        
        [self showContent:[NSString stringWithFormat:@"成交价格不能低于最低总价%@",_minPirce]];
        return;
    }
    [dic setObject:_ordDic[@"sub_unit_price"] forKey:@"sub_unit_price"];
    [dic setObject:_ordDic[@"build_unit_price"] forKey:@"build_unit_price"];
    [dic setObject:_ordDic[@"inner_unit_price"] forKey:@"inner_unit_price"];
    //    [dic setObject:_ordDic[@"payWay_id"] forKey:@"payway"];
    [dic setObject:_ordDic[@"sub_code"] forKey:@"sub_code"];
    [dic setObject:_ordDic[@"down_pay"] forKey:@"down_pay"];
//    [dic setObject:_ordDic[@"payWay_id"] forKey:@"pay_way"];
    if (_ordDic[@"payWay_id"]) {
        
        [dic setObject:_ordDic[@"payWay_id"] forKey:@"payway"];
    }else{
        
        [dic setObject:@"0" forKey:@"payway"];
    }
    if (_pay_info.count) {
        
        NSArray * arr = @[_pay_info];
        NSData *pay_infoData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *pay_infoDataJson = [[NSString alloc]initWithData:pay_infoData encoding:NSUTF8StringEncoding];
        [dic setObject:pay_infoDataJson forKey:@"pay_info"];
    }else{
        
        if ([_addOrderView.payWayBtn.content.text isEqualToString:@"分期付款"]) {
            
            NSData *pay_infoData = [NSJSONSerialization dataWithJSONObject:_installmentArr options:NSJSONWritingPrettyPrinted error:&error];
            NSString *pay_infoDataJson = [[NSString alloc]initWithData:pay_infoData encoding:NSUTF8StringEncoding];
            [dic setObject:pay_infoDataJson forKey:@"pay_info"];
        }
    }
    
    NSMutableArray *discoutArr = [[NSMutableArray alloc] initWithArray:_disCountArr];
    for (int i = 0; i < discoutArr.count; i++) {
        
        NSDictionary *dic = discoutArr[i];
        NSDictionary *tempDic = @{@"name":dic[@"name"],@"type":dic[@"type"],@"num":dic[@"num"],@"describe":@"iOS",@"is_cumulative":dic[@"is_cumulative"],@"sort":[NSString stringWithFormat:@"%d",i]};
        [discoutArr replaceObjectAtIndex:i withObject:tempDic];
    }
    if (_addOrderView.spePreferentialTF.textField.text.length) {
        
        [discoutArr addObject:@{@"name":@"总价优惠",@"type":@"抹零",@"num":_addOrderView.spePreferentialTF.textField.text,@"describe":@"iOS",@"is_cumulative":@"0",@"sort":[NSString stringWithFormat:@"%lu",(unsigned long)_disCountArr.count]}];
    }
    if (discoutArr.count) {
        
        NSData *disCountArrData = [NSJSONSerialization dataWithJSONObject:discoutArr options:NSJSONWritingPrettyPrinted error:&error];
        NSString *disCountArrJson = [[NSString alloc]initWithData:disCountArrData encoding:NSUTF8StringEncoding];
        [dic setObject:disCountArrJson forKey:@"discount_list"];
    }
    
    
//    [dic setObject:_progressDic[@"progress_id"] forKey:@"progress_id"];
//    NSString *param;
//    for (int i = 0; i < _rolePersonSelectArr.count; i++) {
//        
//        if ([_rolePersonSelectArr[i] integerValue] == 1) {
//            
//            if (param.length) {
//                
//                param = [NSString stringWithFormat:@"%@,%@",param,_rolePersonArr[i][@"agent_id"]];
//            }else{
//                
//                param = [NSString stringWithFormat:@"%@",_rolePersonArr[i][@"agent_id"]];
//            }
//        }
//    }
//    if (param.length) {
//        
//        [dic setObject:param forKey:@"param"];
//    }
    
    [BaseRequest POST:ProjectHouseUpdateProjectSub_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.modifyOrderVCBlock) {
                
                self.modifyOrderVCBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}


- (void)initUI{
    
    self.titleLabel.text = @"修改定单";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLBackColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    SS(strongSelf);
    _personHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _personHeader.backgroundColor = CLWhiteColor;
    _personHeader.titleL.text = @"权益人信息";
    _personHeader.addBtn.hidden = YES;
    [_personHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
    _personHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[0] integerValue]){
            
            [strongSelf->_selectArr replaceObjectAtIndex:0 withObject:@0];
            [strongSelf->_personHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addNumeralPersonView.hidden = YES;
            [strongSelf->_roomHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_personHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(40 *SIZE);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:0 withObject:@1];
            [strongSelf->_personHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addNumeralPersonView.hidden = NO;
            [strongSelf->_roomHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_addNumeralPersonView.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(40 *SIZE);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_personHeader];
    
    _addNumeralPersonView = [[AddNumeralPersonView alloc] init];
    _addNumeralPersonView.dataArr = _personArr;
    _addNumeralPersonView.num = _num;
    _addNumeralPersonView.proportion = _proportionArr[_num];
    
    _addNumeralPersonView.addNumeralPersonViewArrBlock = ^(NSInteger num) {
        
        NSDictionary *dic = strongSelf->_personArr[num];
        [strongSelf->_personArr removeObjectAtIndex:num];
        [strongSelf->_personArr insertObject:dic atIndex:0];
        strongSelf->_addNumeralPersonView.dataArr = strongSelf->_personArr;
        strongSelf->_num = 0;
        strongSelf->_addNumeralPersonView.num = strongSelf->_num;
    };
    
    _addNumeralPersonView.addNumeralPersonViewDeleteBlock = ^(NSInteger num) {
        
        if (strongSelf->_num == num) {
            
            strongSelf->_num = num - 1;
            strongSelf->_addNumeralPersonView.num = num - 1;
        }
        [strongSelf->_personArr removeObjectAtIndex:num];
        [strongSelf->_proportionArr removeObjectAtIndex:num];
    };
    
    _addNumeralPersonView.addNumeralPersonViewStrBlock = ^(NSString * _Nonnull str, NSInteger num) {
        
        [strongSelf->_proportionArr replaceObjectAtIndex:num withObject:str];
        NSLog(@"1111111111%@",strongSelf->_proportionArr);
    };
    
    _addNumeralPersonView.addNumeralPersonViewCollBlock = ^(NSInteger num) {
        
        strongSelf->_num = num;
        strongSelf->_addNumeralPersonView.num = num;
        strongSelf->_addNumeralPersonView.proportion = strongSelf->_proportionArr[num];
    };
    _addNumeralPersonView.addNumeralPersonViewAddBlock = ^(NSInteger num) {
        
        AddCallTelegramGroupMemberVC *nextVC = [[AddCallTelegramGroupMemberVC alloc] initWithProjectId:strongSelf->_project_id info_id:strongSelf->_info_id];
        nextVC.group_id = [NSString stringWithFormat:@"%@",strongSelf->_group_id];
        nextVC.trans = @"trans";
//        nextVC.merge = @"merge";
        nextVC.phone = [strongSelf->_personArr[0][@"tel"] componentsSeparatedByString:@","][0];
        nextVC.addCallTelegramGroupMemberVCBlock = ^(NSString * _Nonnull group, NSDictionary * _Nonnull dic) {
            
            [strongSelf->_proportionArr addObject:@""];
            [strongSelf->_personArr addObject:dic];
            strongSelf->_addNumeralPersonView.dataArr = strongSelf->_personArr;
            strongSelf->_num = strongSelf->_personArr.count - 1;
            strongSelf->_addNumeralPersonView.num = strongSelf->_personArr.count - 1;
            strongSelf->_addNumeralPersonView.proportion = strongSelf->_proportionArr[strongSelf->_personArr.count - 1];
            if (strongSelf.modifyOrderVCBlock) {
                
                strongSelf.modifyOrderVCBlock();
            }
        };
        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    _addNumeralPersonView.addNumeralPersonViewEditBlock = ^(NSInteger num) {
        
        CallTelegramSimpleCustomVC *nextVC = [[CallTelegramSimpleCustomVC alloc] initWithDataDic:strongSelf->_personArr[num] projectId:strongSelf->_project_id info_id:strongSelf->_info_id];
        nextVC.group_id = [NSString stringWithFormat:@"%@",strongSelf->_group_id];
        if (num == 0) {
            
            nextVC.hiddenAdd = @"";
        }else{
            
            nextVC.hiddenAdd = @"hidden";
        }
        nextVC.trans = @"trans";
        nextVC.phone = [strongSelf->_personArr[0][@"tel"] componentsSeparatedByString:@","][0];
        nextVC.callTelegramSimpleCustomVCEditBlock = ^(NSDictionary * _Nonnull dic) {
            
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:strongSelf->_personArr[num]];
            [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if (dic[key]) {
                    
                    [tempDic setObject:dic[key] forKey:key];
                }
            }];
            [strongSelf->_personArr replaceObjectAtIndex:num withObject:tempDic];
            strongSelf->_addNumeralPersonView.dataArr = strongSelf->_personArr;
            strongSelf->_addNumeralPersonView.num = num;
            strongSelf->_num = num;
            if (strongSelf.modifyOrderVCBlock) {
                
                strongSelf.modifyOrderVCBlock();
            }
        };
        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    [_scrollView addSubview:_addNumeralPersonView];
    
    _roomHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _roomHeader.titleL.text = @"房源信息";
    _roomHeader.addBtn.hidden = YES;
    [_roomHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _roomHeader.backgroundColor = CLWhiteColor;
    _roomHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[1] integerValue]){
            
            [strongSelf->_selectArr replaceObjectAtIndex:1 withObject:@0];
            [strongSelf->_roomHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addOrderRoomView.hidden = YES;
            [strongSelf->_orderHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_roomHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(40 *SIZE);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:1 withObject:@1];
            [strongSelf->_roomHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addOrderRoomView.hidden = NO;
            [strongSelf->_orderHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_addOrderRoomView.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(40 *SIZE);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_roomHeader];
    
    _addOrderRoomView = [[AddOrderRoomView alloc] init];
    _addOrderRoomView.hidden = YES;
    _addOrderRoomView.dataDic = _roomDic;
    _addOrderRoomView.addOrderRoomViewEditBlock = ^{
        
        RoomVC *nextVC = [[RoomVC alloc] init];
        nextVC.status = @"select";
        nextVC.roomVCBlock = ^(NSDictionary * dic) {
            
            strongSelf->_roomDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            for (int i = 0; i < [strongSelf->_roomDic[@"propertyDetail"] count]; i++) {
                
                if ([strongSelf->_roomDic[@"propertyDetail"][i] containsString:@"最低总价"]) {
                    
                    NSString *str = [NSString stringWithFormat:@"%@",strongSelf->_roomDic[@"propertyDetail"][i]];
                    strongSelf->_minPirce = [NSString stringWithFormat:@"%@",[str componentsSeparatedByString:@" "][1]];
                }
            }
            if (!strongSelf->_minPirce.length) {
                
                strongSelf->_minPirce = @"0";
            }
            
            [strongSelf->_roomDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [strongSelf->_roomDic setObject:@"" forKey:key];
                }
            }];
            strongSelf->_addOrderRoomView.dataDic = strongSelf->_roomDic;
            [strongSelf->_ordDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                
                if ([key isEqualToString:@"sub_code"] || [key isEqualToString:@"pay_way_name"] || [key isEqualToString:@"payWay_id"]  || [key isEqualToString:@"sub_time"]) {
                    
                }else{
                    
                    [strongSelf->_ordDic removeObjectForKey:key];
                }
            }];
            [strongSelf->_disCountArr removeAllObjects];
            [strongSelf->_installmentArr removeAllObjects];
            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",dic[@"total_price"]] forKey:@"total_price"];
            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",dic[@"total_price"]] forKey:@"price"];
            [strongSelf->_ordDic setObject:@"0.00" forKey:@"preferPrice"];
            strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
            strongSelf->_addOrderView.dataArr = strongSelf->_disCountArr;
            strongSelf->_addOrderView.installArr = strongSelf->_installmentArr;
        };
        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    [_scrollView addSubview:_addOrderRoomView];
    
    _orderHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _orderHeader.titleL.text = @"定单信息";
    _orderHeader.addBtn.hidden = YES;
    [_orderHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _orderHeader.backgroundColor = CLWhiteColor;
    _orderHeader.addNemeralHeaderAllBlock = ^{
        
        if (strongSelf->_roomDic.count) {
            
            if ([strongSelf->_selectArr[2] integerValue]){
                
                [strongSelf->_selectArr replaceObjectAtIndex:2 withObject:@0];
                [strongSelf->_orderHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
                strongSelf->_addOrderView.hidden = YES;
                
                if (!strongSelf->_addNumeralProcessView.hidden) {
                    
                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_scrollView).offset(0);
                        make.top.equalTo(strongSelf->_orderHeader.mas_bottom).offset(0 *SIZE);
                        make.width.mas_equalTo(SCREEN_Width);
                        make.height.mas_equalTo(0 *SIZE);
                        make.right.equalTo(strongSelf->_scrollView).offset(0);
                        
                    }];
                }else{
                    
                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_scrollView).offset(0);
                        make.top.equalTo(strongSelf->_orderHeader.mas_bottom).offset(0 *SIZE);
                        make.width.mas_equalTo(SCREEN_Width);
                        make.height.mas_equalTo(0 *SIZE);
                        make.right.equalTo(strongSelf->_scrollView).offset(0);
//                        make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
                    }];
                }
            }else{
                
                [strongSelf->_selectArr replaceObjectAtIndex:2 withObject:@1];
                [strongSelf->_orderHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
                strongSelf->_addOrderView.hidden = NO;
                if (!strongSelf->_addNumeralProcessView.hidden) {
                    
                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_scrollView).offset(0);
                        make.top.equalTo(strongSelf->_addOrderView.mas_bottom).offset(0 *SIZE);
                        make.width.mas_equalTo(SCREEN_Width);
                        make.height.mas_equalTo(0 *SIZE);
                        make.right.equalTo(strongSelf->_scrollView).offset(0);
                        
                    }];
                }else{
                    
                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_scrollView).offset(0);
                        make.top.equalTo(strongSelf->_addOrderView.mas_bottom).offset(0 *SIZE);
                        make.width.mas_equalTo(SCREEN_Width);
                        make.height.mas_equalTo(0 *SIZE);
                        make.right.equalTo(strongSelf->_scrollView).offset(0);
//                        make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
                    }];
                }
            }
        }else{
            
            [strongSelf showContent:@"请先选择房源"];
        }
    };
    [_scrollView addSubview:_orderHeader];
    
    
    _addOrderView = [[AddOrderView alloc] init];
    _addOrderView.hidden = YES;
    _addOrderView.dataArr = _disCountArr;
    _addOrderView.dataDic = _ordDic;
    _addOrderView.addOrderViewAddBlock = ^{
        
        if (strongSelf->_roomDic.count) {
            
            if (strongSelf->_roomDic[@"batch_id"]) {
                
                SelectSpePerferVC *nextVC = [[SelectSpePerferVC alloc] initWithDataArr:strongSelf->_disCountArr];
                nextVC.dic = strongSelf->_roomDic;
                nextVC.selectSpePerferVCBlock = ^(NSDictionary * _Nonnull dic) {
                    
                    [strongSelf->_disCountArr addObject:dic];
                    strongSelf->_addOrderView.dataArr = strongSelf->_disCountArr;
                    double price = [strongSelf->_ordDic[@"total_price"] doubleValue];
                                double unit = 0;
                                double percent = 0;
                                double preferPrice = 0;
                                for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                    
                                    NSDictionary *dic = strongSelf->_disCountArr[i];
                                    if ([dic[@"type"] isEqualToString:@"单价优惠"]) {
                                        
                                        unit = [self AddNumber:unit num2:[dic[@"num"] doubleValue]];
                    //                    unit = unit + [dic[@"num"] doubleValue];
                                    }else if ([dic[@"type"] isEqualToString:@"减点"]){
                                        
                                        if ([dic[@"is_cumulative"] integerValue] == 1) {
                                            
                                            percent = [self AddNumber:percent num2:([dic[@"num"] doubleValue] / 100.00)];
                    //                        percent = percent + [dic[@"num"] doubleValue] / 100.00;
                                        }
                                    }
                                }
                    if (unit) {
                        
                        price = [self MultiplyingNumber:[strongSelf->_roomDic[@"estimated_build_size"] doubleValue] num2:[self DecimalNumber:[strongSelf->_roomDic[@"build_unit_price"] doubleValue] num2:unit]];
//                        price = [strongSelf->_roomDic[@"estimated_build_size"] doubleValue] * ([strongSelf->_roomDic[@"build_unit_price"] doubleValue] - unit);
                    }
                    for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                    
                                    NSDictionary *dic = strongSelf->_disCountArr[i];
                                    if ([dic[@"type"] isEqualToString:@"减点"]) {
                                        
                                        if ([dic[@"is_cumulative"] integerValue] == 1) {
                                            
                                            if (percent) {
                                                
                                                price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:percent]];
                    //                            price = price * (1 - percent);
                                                percent = 0;
                                            }
                                        }else{
                                            
                                            price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:([dic[@"num"] doubleValue] / 100.00)]];
                    //                        price = price * (1 - [dic[@"num"] doubleValue] / 100.00);
                                        }
                                    }else if([dic[@"type"] isEqualToString:@"单价优惠"]){
                                        
                                        
                                    }else{
                                        
                                        price = [self DecimalNumber:price num2:[dic[@"num"] doubleValue]];
                    //                    price = price - [dic[@"num"] doubleValue];
                                    }
                                }
                                
                                preferPrice = [self DecimalNumber:[strongSelf->_ordDic[@"total_price"] doubleValue] num2:price];
//                    preferPrice = [strongSelf->_ordDic[@"total_price"] floatValue] - price;
                    if ([strongSelf->_ordDic[@"spePreferential"] doubleValue]) {
                        
                        preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
//                        preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
                        price = [self DecimalNumber:price num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
//                        price = [self DecimalNumber:price num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
                    }
                    
                    [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"estimated_build_size"] floatValue])] forKey:@"sub_unit_price"];
                    [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"estimated_build_size"] floatValue])] forKey:@"build_unit_price"];
                    [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"indoor_size"] floatValue])] forKey:@"inner_unit_price"];
                    [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",price] forKey:@"price"];
                    [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",preferPrice] forKey:@"preferPrice"];
                    strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
                };
                [strongSelf.navigationController pushViewController:nextVC animated:YES];

            }else{
                
                [BaseRequest GET:ProjectHouseGetDetailInfo_URL parameters:@{@"house_id":strongSelf->_roomDic[@"house_id"]} success:^(id  _Nonnull resposeObject) {
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        NSLog(@"%@",resposeObject);
//                        self->_fjxx = resposeObject[@"data"];
                        [strongSelf->_roomDic setObject:resposeObject[@"data"][@"batch_id"] forKey:@"batch_id"];
                        [strongSelf->_roomDic setObject:resposeObject[@"data"][@"build_id"] forKey:@"build_id"];
                        [strongSelf->_roomDic setObject:resposeObject[@"data"][@"unit_id"] forKey:@"unit_id"];
                        SelectSpePerferVC *nextVC = [[SelectSpePerferVC alloc] initWithDataArr:strongSelf->_disCountArr];
                        nextVC.dic = strongSelf->_roomDic;
                        nextVC.selectSpePerferVCBlock = ^(NSDictionary * _Nonnull dic) {
                            
                            [strongSelf->_disCountArr addObject:dic];
                            strongSelf->_addOrderView.dataArr = strongSelf->_disCountArr;
                            double price = [strongSelf->_ordDic[@"total_price"] doubleValue];
                                                            double unit = 0;
                                                            double percent = 0;
                                                            double preferPrice = 0;
                                                            for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                                                
                                                                NSDictionary *dic = strongSelf->_disCountArr[i];
                                                                if ([dic[@"type"] isEqualToString:@"单价优惠"]) {
                                                                    
                                                                    unit = [self AddNumber:unit num2:[dic[@"num"] doubleValue]];
                                                //                    unit = unit + [dic[@"num"] doubleValue];
                                                                }else if ([dic[@"type"] isEqualToString:@"减点"]){
                                                                    
                                                                    if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                                        
                                                                        percent = [self AddNumber:percent num2:([dic[@"num"] doubleValue] / 100.00)];
                                                //                        percent = percent + [dic[@"num"] doubleValue] / 100.00;
                                                                    }
                                                                }
                                                            }
                                                if (unit) {
                                                    
                                                    price = [self MultiplyingNumber:[strongSelf->_roomDic[@"estimated_build_size"] doubleValue] num2:[self DecimalNumber:[strongSelf->_roomDic[@"build_unit_price"] doubleValue] num2:unit]];
                            //                        price = [strongSelf->_roomDic[@"estimated_build_size"] doubleValue] * ([strongSelf->_roomDic[@"build_unit_price"] doubleValue] - unit);
                                                }
                                                for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                                                
                                                                NSDictionary *dic = strongSelf->_disCountArr[i];
                                                                if ([dic[@"type"] isEqualToString:@"减点"]) {
                                                                    
                                                                    if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                                        
                                                                        if (percent) {
                                                                            
                                                                            price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:percent]];
                                                //                            price = price * (1 - percent);
                                                                            percent = 0;
                                                                        }
                                                                    }else{
                                                                        
                                                                        price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:([dic[@"num"] doubleValue] / 100.00)]];
                                                //                        price = price * (1 - [dic[@"num"] doubleValue] / 100.00);
                                                                    }
                                                                }else if([dic[@"type"] isEqualToString:@"单价优惠"]){
                                                                    
                                                                    
                                                                }else{
                                                                    
                                                                    price = [self DecimalNumber:price num2:[dic[@"num"] doubleValue]];
                                                //                    price = price - [dic[@"num"] doubleValue];
                                                                }
                                                            }
                                                            
                                                            preferPrice = [self DecimalNumber:[strongSelf->_ordDic[@"total_price"] doubleValue] num2:price];
//                            preferPrice = [strongSelf->_ordDic[@"total_price"] floatValue] - price;
                            if ([strongSelf->_ordDic[@"spePreferential"] doubleValue]) {
                                
                                preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
                                //                        preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
                                                        price = [self DecimalNumber:price num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
//                                price = [self DecimalNumber:price num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
                            }
                            
                            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"estimated_build_size"] floatValue])] forKey:@"sub_unit_price"];
                            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"estimated_build_size"] floatValue])] forKey:@"build_unit_price"];
                            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"indoor_size"] floatValue])] forKey:@"inner_unit_price"];
                            
                            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",price] forKey:@"price"];
                            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",preferPrice] forKey:@"preferPrice"];
                            strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
                        };
                        [strongSelf.navigationController pushViewController:nextVC animated:YES];

                    }
                    else{
                        
                    }
                } failure:^(NSError * _Nonnull error) {
                    [strongSelf showContent:@"网络错误"];
                }];
            }
        }else{
            
            [strongSelf showContent:@"请选择房源"];
        }
    };
    
    _addOrderView.addOrderViewStrBlock = ^(NSString * _Nonnull str, NSInteger index) {
        
        if (index == 0) {
            
            [strongSelf->_ordDic setObject:str forKey:@"sub_code"];
        }else if (index == 1){
            
            [strongSelf->_ordDic setObject:str forKey:@"down_pay"];
            double price = [strongSelf->_ordDic[@"total_price"] doubleValue];
                                                                        double unit = 0;
                                                                        double percent = 0;
                                                                        double preferPrice = 0;
                                                                        for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                                                            
                                                                            NSDictionary *dic = strongSelf->_disCountArr[i];
                                                                            if ([dic[@"type"] isEqualToString:@"单价优惠"]) {
                                                                                
                                                                                unit = [self AddNumber:unit num2:[dic[@"num"] doubleValue]];
                                                            //                    unit = unit + [dic[@"num"] doubleValue];
                                                                            }else if ([dic[@"type"] isEqualToString:@"减点"]){
                                                                                
                                                                                if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                                                    
                                                                                    percent = [self AddNumber:percent num2:([dic[@"num"] doubleValue] / 100.00)];
                                                            //                        percent = percent + [dic[@"num"] doubleValue] / 100.00;
                                                                                }
                                                                            }
                                                                        }
                                                            if (unit) {
                                                                
                                                                price = [self MultiplyingNumber:[strongSelf->_roomDic[@"estimated_build_size"] doubleValue] num2:[self DecimalNumber:[strongSelf->_roomDic[@"build_unit_price"] doubleValue] num2:unit]];
                                        //                        price = [strongSelf->_roomDic[@"estimated_build_size"] doubleValue] * ([strongSelf->_roomDic[@"build_unit_price"] doubleValue] - unit);
                                                            }
                                                            for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                                                            
                                                                            NSDictionary *dic = strongSelf->_disCountArr[i];
                                                                            if ([dic[@"type"] isEqualToString:@"减点"]) {
                                                                                
                                                                                if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                                                    
                                                                                    if (percent) {
                                                                                        
                                                                                        price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:percent]];
                                                            //                            price = price * (1 - percent);
                                                                                        percent = 0;
                                                                                    }
                                                                                }else{
                                                                                    
                                                                                    price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:([dic[@"num"] doubleValue] / 100.00)]];
                                                            //                        price = price * (1 - [dic[@"num"] doubleValue] / 100.00);
                                                                                }
                                                                            }else if([dic[@"type"] isEqualToString:@"单价优惠"]){
                                                                                
                                                                                
                                                                            }else{
                                                                                
                                                                                price = [self DecimalNumber:price num2:[dic[@"num"] doubleValue]];
                                                            //                    price = price - [dic[@"num"] doubleValue];
                                                                            }
                                                                        }
                                                                        
                                                                        preferPrice = [self DecimalNumber:[strongSelf->_ordDic[@"total_price"] doubleValue] num2:price];
            //                            preferPrice = [strongSelf->_ordDic[@"total_price"] floatValue] - price;
                                        if ([strongSelf->_ordDic[@"spePreferential"] doubleValue]) {
                                            
                                            preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
                                            //                        preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
                                                                    price = [self DecimalNumber:[strongSelf->_ordDic[@"total_price"] doubleValue] num2:preferPrice];
                                        }
            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",price] forKey:@"price"];
            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",preferPrice] forKey:@"preferPrice"];
            strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
        }else if (index == 3){
            
            [strongSelf->_ordDic setObject:str forKey:@"spePreferential"];
            
            double price = [strongSelf->_ordDic[@"total_price"] doubleValue];
                                            double unit = 0;
                                            double percent = 0;
                                            double preferPrice = 0;
                                            for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                                
                                                NSDictionary *dic = strongSelf->_disCountArr[i];
                                                if ([dic[@"type"] isEqualToString:@"单价优惠"]) {
                                                    
                                                    unit = [self AddNumber:unit num2:[dic[@"num"] doubleValue]];
                                //                    unit = unit + [dic[@"num"] doubleValue];
                                                }else if ([dic[@"type"] isEqualToString:@"减点"]){
                                                    
                                                    if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                        
                                                        percent = [self AddNumber:percent num2:([dic[@"num"] doubleValue] / 100.00)];
                                //                        percent = percent + [dic[@"num"] doubleValue] / 100.00;
                                                    }
                                                }
                                            }
                                if (unit) {
                                    
                                    price = [self MultiplyingNumber:[strongSelf->_roomDic[@"estimated_build_size"] doubleValue] num2:[self DecimalNumber:[strongSelf->_roomDic[@"build_unit_price"] doubleValue] num2:unit]];
            //                        price = [strongSelf->_roomDic[@"estimated_build_size"] doubleValue] * ([strongSelf->_roomDic[@"build_unit_price"] doubleValue] - unit);
                                }
                                for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                                
                                                NSDictionary *dic = strongSelf->_disCountArr[i];
                                                if ([dic[@"type"] isEqualToString:@"减点"]) {
                                                    
                                                    if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                        
                                                        if (percent) {
                                                            
                                                            price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:percent]];
                                //                            price = price * (1 - percent);
                                                            percent = 0;
                                                        }
                                                    }else{
                                                        
                                                        price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:([dic[@"num"] doubleValue] / 100.00)]];
                                //                        price = price * (1 - [dic[@"num"] doubleValue] / 100.00);
                                                    }
                                                }else if([dic[@"type"] isEqualToString:@"单价优惠"]){
                                                    
                                                    
                                                }else{
                                                    
                                                    price = [self DecimalNumber:price num2:[dic[@"num"] doubleValue]];
                                //                    price = price - [dic[@"num"] doubleValue];
                                                }
                                            }
                                            
                                            preferPrice = [self DecimalNumber:[strongSelf->_ordDic[@"total_price"] doubleValue] num2:price];
            
//            preferPrice = [strongSelf->_ordDic[@"total_price"] floatValue] - price;
//            preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];;
            preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
            price = [self DecimalNumber:[strongSelf->_ordDic[@"total_price"] doubleValue] num2:preferPrice];
//            price = [strongSelf->_ordDic[@"total_price"] floatValue] - preferPrice;
            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",price] forKey:@"price"];
            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",preferPrice] forKey:@"preferPrice"];
            strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
        }else if (index == 7){
            
            //            [strongSelf->_ordDic setObject:str forKey:@"down_pay"];
        }else if (index == 9){ //综合贷款-商贷金额
            
            [strongSelf->_ordDic setObject:str forKey:@"bank_loan_money"];
            if ([strongSelf->_ordDic[@"fund_loan_money"] length]) {
                
                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",[strongSelf DecimalNumber:[strongSelf DecimalNumber:[strongSelf->_ordDic[@"price"] doubleValue] num2:[strongSelf->_ordDic[@"bank_loan_money"] doubleValue]] num2:[strongSelf->_ordDic[@"fund_loan_money"] doubleValue]]] forKey:@"downpayment"];
//                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",[strongSelf DecimalNumber:[strongSelf DecimalNumber:[strongSelf->_ordDic[@"price"] doubleValue] num2:[strongSelf->_ordDic[@"bank_loan_money"] doubleValue]] num2:[strongSelf->_ordDic[@"fund_loan_money"] doubleValue]]] forKey:@"downpayment"];
            }
        }else if (index == 11){ //综合贷款-商贷年限
            
            [strongSelf->_ordDic setObject:str forKey:@"bank_loan_limit"];
        }else if (index == 12){ //综合贷款-公积金金额
            
            [strongSelf->_ordDic setObject:str forKey:@"fund_loan_money"];
            if ([strongSelf->_ordDic[@"bank_loan_money"] length]) {
                
                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",[strongSelf DecimalNumber:[strongSelf DecimalNumber:[strongSelf->_ordDic[@"price"] doubleValue] num2:[strongSelf->_ordDic[@"bank_loan_money"] doubleValue]] num2:[strongSelf->_ordDic[@"fund_loan_money"] doubleValue]]] forKey:@"downpayment"];
//                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",[strongSelf DecimalNumber:[strongSelf DecimalNumber:[strongSelf->_ordDic[@"price"] doubleValue] num2:[strongSelf->_ordDic[@"bank_loan_money"] doubleValue]] num2:[strongSelf->_ordDic[@"fund_loan_money"] doubleValue]]] forKey:@"downpayment"];
            }
        }else if (index == 14){ //综合贷款-公积金年限
            
            [strongSelf->_ordDic setObject:str forKey:@"fund_loan_limit"];
        }else if (index == 15){ //银行、公积金贷款-贷款金额
            
            [strongSelf->_ordDic setObject:str forKey:@"loan_money"];
            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",[strongSelf DecimalNumber:[strongSelf->_ordDic[@"price"] doubleValue] num2:[strongSelf->_ordDic[@"loan_money"] doubleValue]]] forKey:@"downpayment"];
//            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",[strongSelf DecimalNumber:[strongSelf->_ordDic[@"price"] doubleValue] num2:[strongSelf->_ordDic[@"loan_money"] doubleValue]]] forKey:@"downpayment"];
        }else if (index == 17){//银行、公积金贷款-贷款年限
            
            [strongSelf->_ordDic setObject:str forKey:@"loan_limit"];
        }
        strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
    };
    
    _addOrderView.addOrderViewDropBlock = ^(NSInteger index) {
        
        if (index == 0) {
            
            NSMutableArray * payArr = [[NSMutableArray alloc] initWithArray:[strongSelf getDetailConfigArrByConfigState:PAY_WAY]];
            [payArr insertObject:@{@"param":@"未定",
                                   @"id":@""
                                   } atIndex:0];
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:payArr];
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:[strongSelf getDetailConfigArrByConfigState:PAY_WAY]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                [strongSelf->_ordDic setObject:strongSelf->_ordDic[@"total_price"] forKey:@"price"];
                [strongSelf->_ordDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if ([key isEqualToString:@"sub_code"] || [key isEqualToString:@"down_pay"] || [key isEqualToString:@"total_price"] || [key isEqualToString:@"price"] || [key isEqualToString:@"sub_time"]) {
                        
                    }else{
                        
                        [strongSelf->_ordDic removeObjectForKey:key];
                    }
                }];
                [strongSelf->_installmentArr removeAllObjects];
                [strongSelf->_disCountArr removeAllObjects];
                
                if (strongSelf->_disOriginArr.count) {
                    
                    for (int i = 0; i < strongSelf->_disOriginArr.count; i++) {
                        
                        if ([strongSelf->_disOriginArr[i][@"pay_way_name"] isEqualToString:MC]) {
                            
                            [strongSelf->_disCountArr addObject:strongSelf->_disOriginArr[i]];
                        }
                    }
                    double price = [strongSelf->_ordDic[@"total_price"] doubleValue];
                                                    double unit = 0;
                                                    double percent = 0;
                                                    double preferPrice = 0;
                                                    for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                                        
                                                        NSDictionary *dic = strongSelf->_disCountArr[i];
                                                        if ([dic[@"type"] isEqualToString:@"单价优惠"]) {
                                                            
                                                            unit = [self AddNumber:unit num2:[dic[@"num"] doubleValue]];
                                        //                    unit = unit + [dic[@"num"] doubleValue];
                                                        }else if ([dic[@"type"] isEqualToString:@"减点"]){
                                                            
                                                            if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                                
                                                                percent = [self AddNumber:percent num2:([dic[@"num"] doubleValue] / 100.00)];
                                        //                        percent = percent + [dic[@"num"] doubleValue] / 100.00;
                                                            }
                                                        }
                                                    }
                                        if (unit) {
                                            
                                            price = [self MultiplyingNumber:[strongSelf->_roomDic[@"estimated_build_size"] doubleValue] num2:[self DecimalNumber:[strongSelf->_roomDic[@"build_unit_price"] doubleValue] num2:unit]];
                    //                        price = [strongSelf->_roomDic[@"estimated_build_size"] doubleValue] * ([strongSelf->_roomDic[@"build_unit_price"] doubleValue] - unit);
                                        }
                                        for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                                        
                                                        NSDictionary *dic = strongSelf->_disCountArr[i];
                                                        if ([dic[@"type"] isEqualToString:@"减点"]) {
                                                            
                                                            if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                                
                                                                if (percent) {
                                                                    
                                                                    price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:percent]];
                                        //                            price = price * (1 - percent);
                                                                    percent = 0;
                                                                }
                                                            }else{
                                                                
                                                                price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:([dic[@"num"] doubleValue] / 100.00)]];
                                        //                        price = price * (1 - [dic[@"num"] doubleValue] / 100.00);
                                                            }
                                                        }else if([dic[@"type"] isEqualToString:@"单价优惠"]){
                                                            
                                                            
                                                        }else{
                                                            
                                                            price = [self DecimalNumber:price num2:[dic[@"num"] doubleValue]];
                                        //                    price = price - [dic[@"num"] doubleValue];
                                                        }
                                                    }
                                                    
                                                    preferPrice = [self DecimalNumber:[strongSelf->_ordDic[@"total_price"] doubleValue] num2:price];
//                    preferPrice = [strongSelf->_ordDic[@"total_price"] floatValue] - price;
                    if ([strongSelf->_ordDic[@"spePreferential"] doubleValue]) {
                        
                        preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
//                        preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];;
                        price = [self DecimalNumber:price num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
//                        price = [self DecimalNumber:price num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
                    }
                    
                    [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"estimated_build_size"] floatValue])] forKey:@"sub_unit_price"];
                    [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"estimated_build_size"] floatValue])] forKey:@"build_unit_price"];
                    [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"indoor_size"] floatValue])] forKey:@"inner_unit_price"];
                    
                    [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",price] forKey:@"price"];
                    [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",preferPrice] forKey:@"preferPrice"];
                    strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
                }else{
                    
                    if (strongSelf->_roomDic[@"batch_id"]) {
                        
                        NSDictionary *dic = @{@"batch_id":[NSString stringWithFormat:@"%@",strongSelf->_roomDic[@"batch_id"]],
                                              @"build_id":[NSString stringWithFormat:@"%@",strongSelf->_roomDic[@"build_id"]],
                                              @"unit_id":[NSString stringWithFormat:@"%@",strongSelf->_roomDic[@"unit_id"]],
                                              };
                        
                        [BaseRequest GET:ProjectHouseGetDiscountList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
                            
                            if ([resposeObject[@"code"] integerValue] == 200) {
                                
                                strongSelf->_disOriginArr = resposeObject[@"data"];
                                for (int i = 0; i < strongSelf->_disOriginArr.count; i++) {
                                    
                                    if ([strongSelf->_disOriginArr[i][@"pay_way_name"] isEqualToString:MC]) {
                                        
                                        [strongSelf->_disCountArr addObject:strongSelf->_disOriginArr[i]];
                                    }
                                }
                                double price = [strongSelf->_ordDic[@"total_price"] doubleValue];
                                                                double unit = 0;
                                                                double percent = 0;
                                                                double preferPrice = 0;
                                                                for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                                                    
                                                                    NSDictionary *dic = strongSelf->_disCountArr[i];
                                                                    if ([dic[@"type"] isEqualToString:@"单价优惠"]) {
                                                                        
                                                                        unit = [self AddNumber:unit num2:[dic[@"num"] doubleValue]];
                                                    //                    unit = unit + [dic[@"num"] doubleValue];
                                                                    }else if ([dic[@"type"] isEqualToString:@"减点"]){
                                                                        
                                                                        if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                                            
                                                                            percent = [self AddNumber:percent num2:([dic[@"num"] doubleValue] / 100.00)];
                                                    //                        percent = percent + [dic[@"num"] doubleValue] / 100.00;
                                                                        }
                                                                    }
                                                                }
                                                    if (unit) {
                                                        
                                                        price = [self MultiplyingNumber:[strongSelf->_roomDic[@"estimated_build_size"] doubleValue] num2:[self DecimalNumber:[strongSelf->_roomDic[@"build_unit_price"] doubleValue] num2:unit]];
                                //                        price = [strongSelf->_roomDic[@"estimated_build_size"] doubleValue] * ([strongSelf->_roomDic[@"build_unit_price"] doubleValue] - unit);
                                                    }
                                                    for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                                                    
                                                                    NSDictionary *dic = strongSelf->_disCountArr[i];
                                                                    if ([dic[@"type"] isEqualToString:@"减点"]) {
                                                                        
                                                                        if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                                            
                                                                            if (percent) {
                                                                                
                                                                                price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:percent]];
                                                    //                            price = price * (1 - percent);
                                                                                percent = 0;
                                                                            }
                                                                        }else{
                                                                            
                                                                            price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:([dic[@"num"] doubleValue] / 100.00)]];
                                                    //                        price = price * (1 - [dic[@"num"] doubleValue] / 100.00);
                                                                        }
                                                                    }else if([dic[@"type"] isEqualToString:@"单价优惠"]){
                                                                        
                                                                        
                                                                    }else{
                                                                        
                                                                        price = [self DecimalNumber:price num2:[dic[@"num"] doubleValue]];
                                                    //                    price = price - [dic[@"num"] doubleValue];
                                                                    }
                                                                }
                                                                
                                                                preferPrice = [self DecimalNumber:[strongSelf->_ordDic[@"total_price"] doubleValue] num2:price];
//                                preferPrice = [strongSelf->_ordDic[@"total_price"] floatValue] - price;
                                if ([strongSelf->_ordDic[@"spePreferential"] doubleValue]) {
                                    
                                    preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
//                                    preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];;
                                    price = [self DecimalNumber:price num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
//                                    price = [self DecimalNumber:price num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
                                }
                                
                                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"estimated_build_size"] floatValue])] forKey:@"sub_unit_price"];
                                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"estimated_build_size"] floatValue])] forKey:@"build_unit_price"];
                                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"indoor_size"] floatValue])] forKey:@"inner_unit_price"];
                                
                                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",price] forKey:@"price"];
                                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",preferPrice] forKey:@"preferPrice"];
                                strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    strongSelf->_addOrderView.installArr = strongSelf->_installmentArr;
                                    strongSelf->_addOrderView.dataArr = strongSelf->_disCountArr;
                                    strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
                                });
                            }else{
                                
                                [strongSelf showContent:resposeObject[@"msg"]];
                            }
                        } failure:^(NSError * _Nonnull error) {
                            
                            //                        [strongSelf showContent:@"网络错误"];
                        }];
                    }else{
                        
                        [BaseRequest GET:ProjectHouseGetDetailInfo_URL parameters:@{@"house_id":strongSelf->_roomDic[@"house_id"]} success:^(id  _Nonnull resposeObject) {
                            if ([resposeObject[@"code"] integerValue] == 200) {
                                
                                [strongSelf->_roomDic setObject:resposeObject[@"data"][@"batch_id"] forKey:@"batch_id"];
                                [strongSelf->_roomDic setObject:resposeObject[@"data"][@"build_id"] forKey:@"build_id"];
                                [strongSelf->_roomDic setObject:resposeObject[@"data"][@"unit_id"] forKey:@"unit_id"];
                                NSDictionary *dic = @{@"batch_id":[NSString stringWithFormat:@"%@",strongSelf->_roomDic[@"batch_id"]],
                                                      @"build_id":[NSString stringWithFormat:@"%@",strongSelf->_roomDic[@"build_id"]],
                                                      @"unit_id":[NSString stringWithFormat:@"%@",strongSelf->_roomDic[@"unit_id"]],
                                                      };
                                
                                [BaseRequest GET:ProjectHouseGetDiscountList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
                                    
                                    if ([resposeObject[@"code"] integerValue] == 200) {
                                        
                                        strongSelf->_disOriginArr = resposeObject[@"data"];
                                        for (int i = 0; i < strongSelf->_disOriginArr.count; i++) {
                                            
                                            if ([strongSelf->_disOriginArr[i][@"pay_way_name"] isEqualToString:MC]) {
                                                
                                                [strongSelf->_disCountArr addObject:strongSelf->_disOriginArr[i]];
                                            }
                                        }
                                        double price = [strongSelf->_ordDic[@"total_price"] doubleValue];
                                                                        double unit = 0;
                                                                        double percent = 0;
                                                                        double preferPrice = 0;
                                                                        for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                                                            
                                                                            NSDictionary *dic = strongSelf->_disCountArr[i];
                                                                            if ([dic[@"type"] isEqualToString:@"单价优惠"]) {
                                                                                
                                                                                unit = [self AddNumber:unit num2:[dic[@"num"] doubleValue]];
                                                            //                    unit = unit + [dic[@"num"] doubleValue];
                                                                            }else if ([dic[@"type"] isEqualToString:@"减点"]){
                                                                                
                                                                                if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                                                    
                                                                                    percent = [self AddNumber:percent num2:([dic[@"num"] doubleValue] / 100.00)];
                                                            //                        percent = percent + [dic[@"num"] doubleValue] / 100.00;
                                                                                }
                                                                            }
                                                                        }
                                                            if (unit) {
                                                                
                                                                price = [self MultiplyingNumber:[strongSelf->_roomDic[@"estimated_build_size"] doubleValue] num2:[self DecimalNumber:[strongSelf->_roomDic[@"build_unit_price"] doubleValue] num2:unit]];
                                        //                        price = [strongSelf->_roomDic[@"estimated_build_size"] doubleValue] * ([strongSelf->_roomDic[@"build_unit_price"] doubleValue] - unit);
                                                            }
                                                            for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                                                            
                                                                            NSDictionary *dic = strongSelf->_disCountArr[i];
                                                                            if ([dic[@"type"] isEqualToString:@"减点"]) {
                                                                                
                                                                                if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                                                    
                                                                                    if (percent) {
                                                                                        
                                                                                        price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:percent]];
                                                            //                            price = price * (1 - percent);
                                                                                        percent = 0;
                                                                                    }
                                                                                }else{
                                                                                    
                                                                                    price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:([dic[@"num"] doubleValue] / 100.00)]];
                                                            //                        price = price * (1 - [dic[@"num"] doubleValue] / 100.00);
                                                                                }
                                                                            }else if([dic[@"type"] isEqualToString:@"单价优惠"]){
                                                                                
                                                                                
                                                                            }else{
                                                                                
                                                                                price = [self DecimalNumber:price num2:[dic[@"num"] doubleValue]];
                                                            //                    price = price - [dic[@"num"] doubleValue];
                                                                            }
                                                                        }
                                                                        
                                                                        preferPrice = [self DecimalNumber:[strongSelf->_ordDic[@"total_price"] doubleValue] num2:price];
//                                        preferPrice = [strongSelf->_ordDic[@"total_price"] floatValue] - price;
                                        if ([strongSelf->_ordDic[@"spePreferential"] doubleValue]) {
                                            
                                            preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
//                                            preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];;
                                            price = [self DecimalNumber:price num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];

//                                            price = [self DecimalNumber:price num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
                                        }
                                        
                                        [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"estimated_build_size"] floatValue])] forKey:@"sub_unit_price"];
                                        [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"estimated_build_size"] floatValue])] forKey:@"build_unit_price"];
                                        [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"indoor_size"] floatValue])] forKey:@"inner_unit_price"];
                                        
                                        [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",price] forKey:@"price"];
                                        [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",preferPrice] forKey:@"preferPrice"];
                                        strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            
                                            strongSelf->_addOrderView.installArr = strongSelf->_installmentArr;
                                            strongSelf->_addOrderView.dataArr = strongSelf->_disCountArr;
                                            strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
                                        });
                                    }else{
                                        
                                        [strongSelf showContent:resposeObject[@"msg"]];
                                    }
                                } failure:^(NSError * _Nonnull error) {
                                    
                                    //                        [strongSelf showContent:@"网络错误"];
                                }];
                            }else{
                                
                            }
                        } failure:^(NSError * _Nonnull error) {
                            [strongSelf showContent:@"网络错误"];
                        }];
                    }
                }
                [strongSelf->_installmentArr addObject:@{@"pay_time":@"",@"tip_time":@"",@"pay_money":@""}];
                
                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"payWay_Name"];
                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"payWay_id"];
                strongSelf->_addOrderView.installArr = strongSelf->_installmentArr;
                strongSelf->_addOrderView.dataArr = strongSelf->_disCountArr;
                strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
            };
            [strongSelf.view addSubview:view];
        }else if (index == 10){
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:[strongSelf getDetailConfigArrByConfigState:BANK_TYPE]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"bank_bank_name"];
                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"bank_bank_id"];
                strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
            };
            [strongSelf.view addSubview:view];
        }else if (index == 13){
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:[strongSelf getDetailConfigArrByConfigState:BANK_TYPE]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"fund_bank_name"];
                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"fund_bank_id"];
                strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
            };
            [strongSelf.view addSubview:view];
        }else if (index == 16){
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:[strongSelf getDetailConfigArrByConfigState:BANK_TYPE]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"bank_name"];
                [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"bank_id"];
                strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
            };
            [strongSelf.view addSubview:view];
        }else if( index == 18){
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
            view.dateblock = ^(NSDate *date) {
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                [strongSelf->_ordDic setObject:[formatter stringFromDate:date] forKey:@"sub_time"];
                strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
            };
            [strongSelf.view addSubview:view];
        }
    };
    
    _addOrderView.addOrderViewDeleteBlock = ^(NSInteger index) {
        
        [strongSelf->_disCountArr removeObjectAtIndex:index];
        double price = [strongSelf->_ordDic[@"total_price"] doubleValue];
                                        double unit = 0;
                                        double percent = 0;
                                        double preferPrice = 0;
                                        for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                            
                                            NSDictionary *dic = strongSelf->_disCountArr[i];
                                            if ([dic[@"type"] isEqualToString:@"单价优惠"]) {
                                                
                                                unit = [self AddNumber:unit num2:[dic[@"num"] doubleValue]];
                            //                    unit = unit + [dic[@"num"] doubleValue];
                                            }else if ([dic[@"type"] isEqualToString:@"减点"]){
                                                
                                                if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                    
                                                    percent = [self AddNumber:percent num2:([dic[@"num"] doubleValue] / 100.00)];
                            //                        percent = percent + [dic[@"num"] doubleValue] / 100.00;
                                                }
                                            }
                                        }
                            if (unit) {
                                
                                price = [self MultiplyingNumber:[strongSelf->_roomDic[@"estimated_build_size"] doubleValue] num2:[self DecimalNumber:[strongSelf->_roomDic[@"build_unit_price"] doubleValue] num2:unit]];
        //                        price = [strongSelf->_roomDic[@"estimated_build_size"] doubleValue] * ([strongSelf->_roomDic[@"build_unit_price"] doubleValue] - unit);
                            }
                            for (int i = 0; i < strongSelf->_disCountArr.count; i++) {
                                            
                                            NSDictionary *dic = strongSelf->_disCountArr[i];
                                            if ([dic[@"type"] isEqualToString:@"减点"]) {
                                                
                                                if ([dic[@"is_cumulative"] integerValue] == 1) {
                                                    
                                                    if (percent) {
                                                        
                                                        price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:percent]];
                            //                            price = price * (1 - percent);
                                                        percent = 0;
                                                    }
                                                }else{
                                                    
                                                    price = [self MultiplyingNumber:price num2:[self DecimalNumber:1.0 num2:([dic[@"num"] doubleValue] / 100.00)]];
                            //                        price = price * (1 - [dic[@"num"] doubleValue] / 100.00);
                                                }
                                            }else if([dic[@"type"] isEqualToString:@"单价优惠"]){
                                                
                                                
                                            }else{
                                                
                                                price = [self DecimalNumber:price num2:[dic[@"num"] doubleValue]];
                            //                    price = price - [dic[@"num"] doubleValue];
                                            }
                                        }
                                        
                                        preferPrice = [self DecimalNumber:[strongSelf->_ordDic[@"total_price"] doubleValue] num2:price];
//        preferPrice = [strongSelf->_ordDic[@"total_price"] floatValue] - price;
        if ([strongSelf->_ordDic[@"spePreferential"] doubleValue]) {
            
            price = [self DecimalNumber:price num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
//            price = [self DecimalNumber:price num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
            preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
            //            preferPrice = [self AddNumber:preferPrice num2:[strongSelf->_ordDic[@"spePreferential"] doubleValue]];
        }
        
        [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"estimated_build_size"] floatValue])] forKey:@"sub_unit_price"];
        [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"estimated_build_size"] floatValue])] forKey:@"build_unit_price"];
        [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",(price / [strongSelf->_roomDic[@"indoor_size"] floatValue])] forKey:@"inner_unit_price"];
        
        [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",price] forKey:@"price"];
        [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%.2f",preferPrice] forKey:@"preferPrice"];
        strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
    };
    
    _addOrderView.addOrderViewInstallmentAddBlock = ^(NSInteger index) {
        
        [strongSelf->_installmentArr addObject:@{@"pay_time":@"",@"tip_time":@"",@"pay_money":@""}];
        strongSelf->_addOrderView.installArr = strongSelf->_installmentArr;
    };
    
    _addOrderView.addOrderViewTimeBlock = ^(NSInteger index) {
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.frame];
        view.dateblock = ^(NSDate *date) {
            
            NSDictionary *dic = @{@"pay_time":[strongSelf->_formatter stringFromDate:date],@"tip_time":[strongSelf->_formatter stringFromDate:[NSDate dateWithTimeInterval:-24 * 60 * 60 sinceDate:date]],@"pay_money":strongSelf->_installmentArr[index][@"pay_money"]};
            [strongSelf->_installmentArr replaceObjectAtIndex:index withObject:dic];
            strongSelf->_addOrderView.installArr = strongSelf->_installmentArr;
        };
        [strongSelf.view addSubview:view];
        
    };
    
    _addOrderView.addOrderViewInstallmentStrBlock = ^(NSInteger index, NSString * _Nonnull str) {
        
        NSDictionary *dic = @{@"pay_time":strongSelf->_installmentArr[index][@"pay_time"],@"tip_time":strongSelf->_installmentArr[index][@"tip_time"],@"pay_money":str};
        [strongSelf->_installmentArr replaceObjectAtIndex:index withObject:dic];
        strongSelf->_addOrderView.installArr = strongSelf->_installmentArr;
    };
    
    [_scrollView addSubview:_addOrderView];
    
    _processHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _processHeader.hidden = YES;
    _processHeader.titleL.text = @"流程信息";
    _processHeader.addBtn.hidden = YES;
    [_processHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _processHeader.backgroundColor = CLWhiteColor;
    _processHeader.addNemeralHeaderAllBlock = ^{
        
        if (strongSelf->_roomDic.count) {
            
            if ([strongSelf->_selectArr[3] integerValue]){
                
                [strongSelf->_selectArr replaceObjectAtIndex:3 withObject:@0];
                [strongSelf->_processHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
                strongSelf->_addNumeralProcessView.hidden = YES;
//                if (strongSelf->_addOrderView.hidden) {
//
//                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//                        make.left.equalTo(strongSelf->_scrollView).offset(0);
//                        make.top.equalTo(strongSelf->_orderHeader.mas_bottom).offset(0 *SIZE);
//                        make.width.mas_equalTo(SCREEN_Width);
//                        make.height.mas_equalTo(0 *SIZE);
//                        make.right.equalTo(strongSelf->_scrollView).offset(0);
//                        make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
//                    }];
//                }else{
//
//                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//                        make.left.equalTo(strongSelf->_scrollView).offset(0);
//                        make.top.equalTo(strongSelf->_addOrderView.mas_bottom).offset(0 *SIZE);
//                        make.width.mas_equalTo(SCREEN_Width);
//                        make.height.mas_equalTo(0 *SIZE);
//                        make.right.equalTo(strongSelf->_scrollView).offset(0);
//                        make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
//                    }];
//                }
//
//
//                [strongSelf->_addNumeralProcessView mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//                    make.left.equalTo(strongSelf->_scrollView).offset(0);
//                    make.top.equalTo(strongSelf->_processHeader.mas_bottom).offset(0 *SIZE);
//                    make.width.mas_equalTo(SCREEN_Width);
//                    make.height.mas_equalTo(0);
//                    make.right.equalTo(strongSelf->_scrollView).offset(0);
//                    //                    make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
//                }];
                
                [strongSelf->_addNumeralFileHeader mas_remakeConstraints:^(MASConstraintMaker *make) {

                    make.left.equalTo(strongSelf->_scrollView).offset(0);
                    make.top.equalTo(strongSelf->_processHeader.mas_bottom).offset(0 *SIZE);
                    make.width.mas_equalTo(SCREEN_Width);
                    make.height.mas_equalTo(40 *SIZE);
                    make.right.equalTo(strongSelf->_scrollView).offset(0);
                }];
                
            }else{
                
                [strongSelf->_selectArr replaceObjectAtIndex:3 withObject:@1];
                [strongSelf->_processHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
                strongSelf->_addNumeralProcessView.hidden = NO;
                
//                if (strongSelf->_addOrderView.hidden) {
//
//                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//                        make.left.equalTo(strongSelf->_scrollView).offset(0);
//                        make.top.equalTo(strongSelf->_orderHeader.mas_bottom).offset(0 *SIZE);
//                        make.width.mas_equalTo(SCREEN_Width);
//                        make.height.mas_equalTo(0 *SIZE);
//                        make.right.equalTo(strongSelf->_scrollView).offset(0);
//                    }];
//                }else{
//
//                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//                        make.left.equalTo(strongSelf->_scrollView).offset(0);
//                        make.top.equalTo(strongSelf->_addOrderView.mas_bottom).offset(0 *SIZE);
//                        make.width.mas_equalTo(SCREEN_Width);
//                        make.height.mas_equalTo(0 *SIZE);
//                        make.right.equalTo(strongSelf->_scrollView).offset(0);
//                    }];
//                }
//
//                [strongSelf->_addNumeralProcessView mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//                    make.left.equalTo(strongSelf->_scrollView).offset(0);
//                    make.top.equalTo(strongSelf->_processHeader.mas_bottom).offset(0 *SIZE);
//                    make.width.mas_equalTo(SCREEN_Width);
//                    //                    make.height.mas_equalTo(0);
//                    make.right.equalTo(strongSelf->_scrollView).offset(0);
//                    make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
//                }];
                
                [strongSelf->_addNumeralFileHeader mas_remakeConstraints:^(MASConstraintMaker *make) {

                    make.left.equalTo(strongSelf->_scrollView).offset(0);
                    make.top.equalTo(strongSelf->_addNumeralProcessView.mas_bottom).offset(0 *SIZE);
                    make.width.mas_equalTo(SCREEN_Width);
                    make.height.mas_equalTo(40 *SIZE);
                    make.right.equalTo(strongSelf->_scrollView).offset(0);
                }];
                
            }
        }else{
            
            [strongSelf showContent:@"请先选择房源"];
        }
    };
    [_scrollView addSubview:_processHeader];
    
    _addNumeralProcessView = [[AddNumeralProcessView alloc] init];
    _addNumeralProcessView.hidden = YES;
    _addNumeralProcessView.dataDic = _progressDic;
    _addNumeralProcessView.addNumeralProcessViewAuditBlock = ^{
        
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:@[@{@"param":@"自由流程",@"id":@"1"},@{@"param":@"固定流程",@"id":@"2"}]];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"auditMC"];
            [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"auditID"];
            strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
        };
        [strongSelf.view addSubview:view];
    };
    _addNumeralProcessView.addNumeralProcessViewTypeBlock = ^{
        
        if (strongSelf->_progressArr.count) {
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_progressArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                if ([MC containsString:@"自由"]) {
                    
                    [strongSelf->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                    [strongSelf->_progressDic setObject:@"1" forKey:@"auditID"];
                }else if ([MC containsString:@"固定"]){
                    
                    [strongSelf->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                    [strongSelf->_progressDic setObject:@"2" forKey:@"auditID"];
                }else{
                    
                    [strongSelf->_progressDic removeObjectForKey:@"auditMC"];
                    [strongSelf->_progressDic removeObjectForKey:@"auditID"];
                }
                if (![MC isEqualToString:strongSelf->_progressDic[@"progress_name"]]) {
                    
                    [strongSelf->_rolePersonArr removeAllObjects];
                    [strongSelf->_rolePersonSelectArr removeAllObjects];
                    strongSelf->_addNumeralProcessView.personArr = strongSelf->_rolePersonArr;
                    strongSelf->_addNumeralProcessView.personSelectArr = strongSelf->_rolePersonSelectArr;
                    [strongSelf->_progressDic removeObjectForKey:@"role_name"];
                    [strongSelf->_progressDic removeObjectForKey:@"role_id"];
                }
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"progress_name"];
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"progress_id"];
                for (int i = 0; i < strongSelf->_progressAllArr.count; i++) {
                    
                    if ([ID integerValue] == [strongSelf->_progressAllArr[i][@"progress_id"] integerValue]) {
                        
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",strongSelf->_progressAllArr[i][@"check_type"]] forKey:@"check_type"];
                    }
                }
                if ([strongSelf->_progressDic[@"check_type"] integerValue] == 1) {
                    
                    [strongSelf->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                    [strongSelf->_progressDic setObject:@"1" forKey:@"auditID"];
                }else if ([strongSelf->_progressDic[@"check_type"] integerValue] == 2) {
                    
                    [strongSelf->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                    [strongSelf->_progressDic setObject:@"2" forKey:@"auditID"];
                }
                strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
            };
            [strongSelf.view addSubview:view];
        }else{
            NSDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"project_id":strongSelf->_project_id,@"config_type":@"1"}];
            if ([strongSelf.status isEqualToString:@"2"]) {
                
                [dic setValue:@"2" forKey:@"config_type"];
            }
            if ([strongSelf.from_type isEqualToString:@"1"]) {
                
                [dic setValue:@"2" forKey:@"progress_defined_id"];
            }else if ([strongSelf.from_type isEqualToString:@"3"]){
                
                [dic setValue:@"4" forKey:@"progress_defined_id"];
            }else if ([strongSelf.from_type isEqualToString:@"4"]){
                
                [dic setValue:@"5" forKey:@"progress_defined_id"];
            }
            
            [BaseRequest GET:ProjectProgressGet_URL parameters:dic success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [strongSelf->_progressArr removeAllObjects];
                    [strongSelf->_progressAllArr removeAllObjects];
                    strongSelf->_progressAllArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
                    for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                        
                        [strongSelf->_progressArr addObject:@{@"param":[NSString stringWithFormat:@"%@",resposeObject[@"data"][i][@"progress_name"]],@"id":resposeObject[@"data"][i][@"progress_id"]}];
                    }
                    
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_progressArr];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        
                        if ([MC containsString:@"自由"]) {
                            
                            [strongSelf->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                            [strongSelf->_progressDic setObject:@"1" forKey:@"auditID"];
                        }else if ([MC containsString:@"固定"]){
                            
                            [strongSelf->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                            [strongSelf->_progressDic setObject:@"2" forKey:@"auditID"];
                        }else{
                            
                            [strongSelf->_progressDic removeObjectForKey:@"auditMC"];
                            [strongSelf->_progressDic removeObjectForKey:@"auditID"];
                        }
                        if (![MC isEqualToString:strongSelf->_progressDic[@"progress_name"]]) {
                            
                            [strongSelf->_rolePersonArr removeAllObjects];
                            [strongSelf->_rolePersonSelectArr removeAllObjects];
                            strongSelf->_addNumeralProcessView.personArr = strongSelf->_rolePersonArr;
                            strongSelf->_addNumeralProcessView.personSelectArr = strongSelf->_rolePersonSelectArr;
                            [strongSelf->_progressDic removeObjectForKey:@"role_name"];
                            [strongSelf->_progressDic removeObjectForKey:@"role_id"];
                        }
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"progress_name"];
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"progress_id"];
                        for (int i = 0; i < strongSelf->_progressAllArr.count; i++) {
                            
                            if ([ID integerValue] == [strongSelf->_progressAllArr[i][@"progress_id"] integerValue]) {
                                
                                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",strongSelf->_progressAllArr[i][@"check_type"]] forKey:@"check_type"];
                            }
                        }
                        if ([strongSelf->_progressDic[@"check_type"] integerValue] == 1) {
                            
                            [strongSelf->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                            [strongSelf->_progressDic setObject:@"1" forKey:@"auditID"];
                        }else if ([strongSelf->_progressDic[@"check_type"] integerValue] == 2) {
                            
                            [strongSelf->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                            [strongSelf->_progressDic setObject:@"2" forKey:@"auditID"];
                        }
                        strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
                    };
                    [strongSelf.view addSubview:view];
                }else{
                    
                    
                }
            } failure:^(NSError * _Nonnull error) {
                
                
            }];
        }
    };
    
    _addNumeralProcessView.addNumeralProcessViewRoleBlock = ^{
        
        if (strongSelf->_roleArr.count) {
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_roleArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                if (![MC isEqualToString:strongSelf->_progressDic[@"role_name"]]) {
                    
                    [strongSelf->_rolePersonArr removeAllObjects];
                    [strongSelf->_rolePersonSelectArr removeAllObjects];
                    strongSelf->_addNumeralProcessView.personArr = strongSelf->_rolePersonArr;
                    strongSelf->_addNumeralProcessView.personSelectArr = strongSelf->_rolePersonSelectArr;
                }
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"role_name"];
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"role_id"];
                strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
                [strongSelf RequestMethod];
            };
            [strongSelf.view addSubview:view];
        }else{
            
            [BaseRequest GET:ProjectRoleListAll_URL parameters:@{@"project_id":strongSelf->_project_id} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    for (NSDictionary *dic in resposeObject[@"data"]) {
                        
                        [strongSelf->_roleArr addObject:@{@"param":[NSString stringWithFormat:@"%@/%@",dic[@"project_name"],dic[@"role_name"]],@"id":dic[@"role_id"]}];
                    }
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_roleArr];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"role_name"];
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"role_id"];
                        strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
                        [strongSelf RequestMethod];
                    };
                    [strongSelf.view addSubview:view];
                }else{
                    
                    
                }
            } failure:^(NSError * _Nonnull error) {
                
                NSLog(@"%@",error);
            }];
        }
    };
    
    _addNumeralProcessView.addNumeralProcessViewSelectBlock = ^(NSArray * _Nonnull arr) {
        
        strongSelf->_rolePersonSelectArr = [NSMutableArray arrayWithArray:arr];
    };
    [_scrollView addSubview:_addNumeralProcessView];
    
    _addNumeralFileHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _addNumeralFileHeader.titleL.text = @"附件文件";
    _addNumeralFileHeader.addBtn.hidden = YES;
    [_addNumeralFileHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _addNumeralFileHeader.backgroundColor = CLWhiteColor;
    _addNumeralFileHeader.addNemeralHeaderAllBlock = ^{

//        strongSelf->_coll.hidden = YES;
        if ([strongSelf->_selectArr[4] integerValue]){

            [strongSelf->_selectArr replaceObjectAtIndex:4 withObject:@0];
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

            [strongSelf->_selectArr replaceObjectAtIndex:4 withObject:@1];
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
    
    [_personHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        //        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_addNumeralPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(40 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_roomHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_addNumeralPersonView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_addOrderRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_roomHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_orderHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_roomHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_addOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_orderHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_processHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_orderHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
//        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
    }];
    
    [_addNumeralProcessView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_processHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(0);
        make.right.equalTo(self->_scrollView).offset(0);
        //        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
    }];
    
    [_addNumeralFileHeader mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_processHeader.mas_bottom).offset(0 *SIZE);
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
