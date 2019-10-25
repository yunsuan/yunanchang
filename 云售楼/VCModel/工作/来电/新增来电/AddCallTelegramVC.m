//
//  AddCallTelegramVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddCallTelegramVC.h"

#import "FollowRecordVC.h"
#import "IntentSurveyVC.h"
#import "AddCallTelegramGroupMemberVC.h"

#import "AddNumeralVC.h"

#import "BoxSelectCollCell.h"
#import "BaseHeader.h"

#import "SinglePickView.h"
#import "DateChooseView.h"
//#import "AddressChooseView3.h"
#import "AdressChooseView.h"

#import "BorderTextField.h"
#import "DropBtn.h"

@interface AddCallTelegramVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
{
    
    NSInteger _numAdd;
    
    NSString *_group;
    NSString *_info_id;
    NSString *_project_id;
    NSString *_gender;
    NSString *_proId;
    NSString *_cityId;
    NSString *_areaId;
    
    
    NSDictionary *_configDic;
    
//    NSMutableDictionary *_propertyDic;
    
    NSArray *_propertyArr;
    
    NSMutableArray *_propertyDArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_approachArr;
    NSMutableArray *_approachArr2;
    NSMutableArray *_certArr;
    NSMutableArray *_clientArr;
    NSMutableArray *_groupArr;
    
    NSDateFormatter *_formatter;
    NSDateFormatter *_secondFormatter;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropBtn *timeBtn;

@property (nonatomic, strong) UILabel *groupL;

@property (nonatomic, strong) UIButton *addGroupBtn;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTextField *nameTF;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) UIButton *maleBtn;

@property (nonatomic, strong) UIButton *femaleBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) BorderTextField *phoneTF;

@property (nonatomic, strong) BorderTextField *phoneTF2;

@property (nonatomic, strong) BorderTextField *phoneTF3;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UILabel *certTypeL;

@property (nonatomic, strong) DropBtn *certTypeBtn;

@property (nonatomic, strong) UILabel *certNumL;

@property (nonatomic, strong) BorderTextField *certNumTF;

@property (nonatomic, strong) UILabel *birthL;

@property (nonatomic, strong) DropBtn *birthBtn;

@property (nonatomic, strong) UILabel *mailCodeL;

@property (nonatomic, strong) BorderTextField *mailCodeTF;

@property (nonatomic, strong) UILabel *customSourceL;

@property (nonatomic, strong) DropBtn *customSourceBtn;

@property (nonatomic, strong) UILabel *approachL;

@property (nonatomic, strong) DropBtn *approachBtn;

@property (nonatomic, strong) DropBtn *approachBtn2;

@property (nonatomic, strong) UILabel *sourceTypeL;

@property (nonatomic, strong) DropBtn *sourceTypeBtn;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) BorderTextField *addressBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UILabel *propertyIntentL;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *propertyIntentColl;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddCallTelegramVC

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
    [self RequestMethod];
    [self PropertyRequestMethod];
}

- (void)initDataSource{
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
    _secondFormatter = [[NSDateFormatter alloc] init];
    [_secondFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    _propertyDArr = [@[] mutableCopy];
    
    _approachArr = [@[] mutableCopy];
    _approachArr2 = [@[] mutableCopy];
    _certArr = [@[] mutableCopy];
    _selectArr = [@[] mutableCopy];
    _clientArr = [@[] mutableCopy];
    _groupArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:WorkClientAutoColumnConfig_URL parameters:@{@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                
                self->_configDic = resposeObject[@"data"];
            }
            [self initUI];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
            [self initUI];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self initUI];
        [self showContent:@"网络错误"];
    }];
}

- (void)PropertyRequestMethod{
    
    [BaseRequest GET:WorkClientAutoBasicConfig_URL parameters:@{@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            for (int i = 0; i < [resposeObject[@"data"][0] count]; i++) {
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"id":resposeObject[@"data"][0][i][@"config_id"],
                                                                                             @"param":resposeObject[@"data"][0][i][@"config_name"]
                                                                                             }];
                if (resposeObject[@"data"][0][i][@"child"]) {
                    
                    [dic setObject:resposeObject[@"data"][0][i][@"child"] forKey:@"child"];
                }
                [self->_approachArr addObject:dic];
            }
            
            for (int i = 0; i < [resposeObject[@"data"][2] count]; i++) {
                
                NSDictionary *dic = @{@"id":resposeObject[@"data"][2][i][@"config_id"],
                                      @"param":resposeObject[@"data"][2][i][@"config_name"]};
                [self->_certArr addObject:dic];
            }
            
            self->_propertyArr = resposeObject[@"data"][3];
            [self->_selectArr removeAllObjects];
            for (int i = 0; i < self->_propertyArr.count; i++) {
                
                [self->_selectArr addObject:@0];
            }
            [self->_propertyIntentColl reloadData];
            [self->_propertyIntentColl mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self->_scrollView).offset(30 *SIZE);
                make.top.equalTo(self->_propertyIntentL.mas_bottom).offset(20 *SIZE);
                make.width.mas_equalTo(300 *SIZE);
                make.height.mas_equalTo(self->_propertyIntentColl.collectionViewLayout.collectionViewContentSize.height);
                make.bottom.equalTo(self->_scrollView).offset(-20 *SIZE);
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    _maleBtn.selected = NO;
    _femaleBtn.selected = NO;
    if (btn.tag == 0) {
        
        _maleBtn.selected = YES;
        _gender = @"1";
    }else{
        
        _femaleBtn.selected = YES;
        _gender = @"2";
    }
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
    view.pickerView.datePickerMode = UIDatePickerModeDateAndTime;
    view.dateblock = ^(NSDate *date) {
        
        self->_timeBtn.content.text = [self->_secondFormatter stringFromDate:date];
        self->_timeBtn.placeL.text = @"";
//        self->_birthBtn.content.text = [self->_formatter stringFromDate:date];
//        self->_birthBtn.placeL.text = @"";
    };
    [self.view addSubview:view];
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    switch (btn.tag) {
        case 0:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:_certArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                self->_certTypeBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                self->_certTypeBtn->str = [NSString stringWithFormat:@"%@",ID];
                self->_certTypeBtn.placeL.text = @"";
                if ([self->_certTypeBtn.content.text containsString:@"身份证"]) {
                    
                    if (self->_certNumTF.textField.text.length) {
                        
                        if ([self validateIDCardNumber:self->_certNumTF.textField.text]) {
                            
                            self->_birthBtn.placeL.text = @"";
                            self->_birthBtn.content.text = [self subsIDStrToDate:self->_certNumTF.textField.text];
                        }else{
                            
                            [self showContent:@"请输入正确的身份证号"];
                        }
                    }else{
                        
                        [self showContent:@"请输入正确的身份证号"];
                    }
                }
            };
            [self.view addSubview:view];
            break;
        }
        case 1:{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
            view.dateblock = ^(NSDate *date) {
                
                self->_birthBtn.content.text = [self->_formatter stringFromDate:date];
                self->_birthBtn.placeL.text = @"";
            };
            [self.view addSubview:view];
            break;
        }
        case 2:{
            
//            AddressChooseView3 *addressChooseView = [[AddressChooseView3 alloc] initWithFrame:self.view.frame withdata:@[]];
//            WS(weakself);
//            addressChooseView.addressChooseView3ConfirmBlock = ^(NSString *city, NSString *area, NSString *cityid, NSString *areaid) {
            AdressChooseView *addressChooseView = [[AdressChooseView alloc] initWithFrame:self.view.bounds withdata:@[]];
            WS(weakself);
            addressChooseView.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
            
                NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
                
                NSError *err;
                NSArray *proArr = [NSJSONSerialization JSONObjectWithData:JSONData
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&err];
                NSString *pro = [cityid substringToIndex:2];
                pro = [NSString stringWithFormat:@"%@0000",pro];
                NSString *proName;
                if ([pro isEqualToString:@"900000"]) {
                    proName = @"海外";
                }
                else{
                    for (NSDictionary *dic in proArr) {
                        
                        if([dic[@"code"] isEqualToString:pro]){
                            
                            proName = dic[@"name"];
                            break;
                        }
                    }
                }
                self->_customSourceBtn.content.text = [NSString stringWithFormat:@"%@/%@/%@",proName,city,area];
                self->_customSourceBtn.placeL.text = @"";
                self->_proId = pro;
                self->_cityId = cityid;
                self->_areaId = areaid;
            };
            [self.view addSubview:addressChooseView];
            break;
        }
        case 3:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:_approachArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                self->_approachBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                self->_approachBtn->str = [NSString stringWithFormat:@"%@",ID];
                self->_approachBtn.placeL.text = @"";
                [self->_approachArr2 removeAllObjects];
                
                for (int j = 0; j < self->_approachArr.count; j++) {
                    
                    if ([ID integerValue] == [self->_approachArr[j][@"id"] integerValue]) {
                        
                        NSArray *arr = self->_approachArr[j][@"child"];
                        for (NSDictionary *dic in arr) {
                            
                            [self->_approachArr2 addObject:@{@"id":dic[@"config_id"],@"param":dic[@"config_name"]}];
                        }
                    }
                }
                if (self->_approachArr2.count) {
                    
                    self->_approachBtn2.hidden = NO;
                    [self->_sourceTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                        make.top.equalTo(self->_approachBtn2.mas_bottom).offset(31 *SIZE);
                        make.width.mas_equalTo(70 *SIZE);
                    }];
                    
                    [self->_sourceTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
                        make.top.equalTo(self->_approachBtn2.mas_bottom).offset(21 *SIZE);
                        make.width.mas_equalTo(258 *SIZE);
                        make.height.mas_equalTo(33 *SIZE);
                    }];
                }else{
                    
                    self->_approachBtn2.hidden = YES;
                    self->_approachBtn2.placeL.text = @"请选择认知途径";
                    self->_approachBtn2.content.text = @"";
                    self->_approachBtn2->str = @"";
                    [self->_sourceTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                        make.top.equalTo(self->_approachBtn.mas_bottom).offset(31 *SIZE);
                        make.width.mas_equalTo(70 *SIZE);
                    }];
                    
                    [self->_sourceTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
                        make.top.equalTo(self->_approachBtn.mas_bottom).offset(21 *SIZE);
                        make.width.mas_equalTo(258 *SIZE);
                        make.height.mas_equalTo(33 *SIZE);
                    }];
                }
            };
            [self.view addSubview:view];
            break;
        }
        case 5:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:_approachArr2];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                self->_approachBtn2.content.text = [NSString stringWithFormat:@"%@",MC];
                self->_approachBtn2->str = [NSString stringWithFormat:@"%@",ID];
                self->_approachBtn2.placeL.text = @"";
            };
            [self.view addSubview:view];
            break;
        }
        default:
            break;
    }
}

- (void)ActionAddGroupBtn:(UIButton *)btn{
    
    AddCallTelegramGroupMemberVC *nextVC = [[AddCallTelegramGroupMemberVC alloc] initWithProjectId:_project_id info_id:_info_id];
    nextVC.configDic = self->_configDic;
    nextVC.addCallTelegramGroupMemberVCBlock = ^(NSString * group, NSDictionary * dic) {
        
        self->_group = group;
        if (self->_groupL.text.length) {
            
            self->_groupL.text = [NSString stringWithFormat:@"%@,%@",self->_groupL.text,self->_group];
        }else{
            
            
        }
        [self->_groupArr addObject:dic];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    if (_numAdd == 0) {
        
        _numAdd += 1;
        _phoneTF2.hidden = NO;
        
        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(31 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_scrollView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
    }else{
        
        _phoneTF3.hidden = NO;
        
        [_certTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
            make.top.equalTo(self->_phoneTF3.mas_bottom).offset(31 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_certTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_scrollView).offset(80 *SIZE);
            make.top.equalTo(self->_phoneTF3.mas_bottom).offset(21 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
//    NSMutableArray *clientArr = [@[] mutableCopy];
    NSMutableDictionary *allDic = [@{} mutableCopy];
    NSMutableDictionary *tempDic = [@{} mutableCopy];
    if ([self isEmpty:_nameTF.textField.text]) {

        [self alertControllerWithNsstring:@"必填信息" And:@"请填写姓名"];
        return;
    }

    if (!_gender.length) {
        
        [self alertControllerWithNsstring:@"必填信息" And:@"请选择性别"];
        return;
    }

    if ([self isEmpty:_phoneTF.textField.text]) {
        
        [self alertControllerWithNsstring:@"必填信息" And:@"请填写电话号码"];
        return;
    }
    
    if (_certTypeBtn.content.text.length && ![self isEmpty:_certNumTF.textField.text]) {
        
        if ([_certTypeBtn.content.text containsString:@"身份证"]) {
            
            if (_certNumTF.textField.text.length) {
                
                if ([self validateIDCardNumber:_certNumTF.textField.text]) {
                    
                    _birthBtn.placeL.text = @"";
                    _birthBtn.content.text = [self subsIDStrToDate:_certNumTF.textField.text];
                }else{
                    
                    [self showContent:@"请输入正确的身份证号"];
                    return;
                }
            }else{
                
                [self showContent:@"请输入正确的身份证号"];
                return;
            }
        }
    }

    if ([_configDic[@"birth"] integerValue] == 1) {

        if (!_birthBtn.content.text.length) {

            [self alertControllerWithNsstring:@"必填信息" And:@"请选择出生年月"];
            return;
        }
    }

    if ([_configDic[@"mail"] integerValue] == 1) {

        if ([self isEmpty:_mailCodeTF.textField.text]) {

            [self alertControllerWithNsstring:@"必填信息" And:@"请输入邮政编码"];
            return;
        }
    }

    if ([_configDic[@"address"] integerValue] == 1) {

        if ([self isEmpty:_addressBtn.textField.text]) {

            [self alertControllerWithNsstring:@"必填信息" And:@"请选择通讯地址"];
            return;
        }
    }
    
    if (!_approachBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"必填信息" And:@"请选择认知途径"];
        return;
    }
    
    if (!_approachBtn2.hidden) {
        
        if (!_approachBtn2.content.text.length) {
            
            [self alertControllerWithNsstring:@"必填信息" And:@"请选择认知途径"];
            return;
        }
    }

    [_propertyDArr removeAllObjects];
    for (int i = 0 ; i < _selectArr.count; i++) {

        if ([_selectArr[i] integerValue] == 1) {

            [_propertyDArr addObject:@{@"id":_propertyArr[i][@"config_id"],
                                       @"param":_propertyArr[i][@"config_name"]
                                       }];
        }
    }

    if (!_propertyDArr.count) {

        [self alertControllerWithNsstring:@"必填信息" And:@"请选择物业意向"];
        return;
    }

    [tempDic setObject:_nameTF.textField.text forKey:@"name"];
    if (_gender.length) {

        [tempDic setObject:_gender forKey:@"sex"];
    }
    
    NSString *tel = _phoneTF.textField.text;
    if (![self isEmpty:_phoneTF2.textField.text]) {
        
        tel = [NSString stringWithFormat:@"%@,%@",tel,_phoneTF2.textField.text];
    }
    if (![self isEmpty:_phoneTF3.textField.text]) {
        
        tel = [NSString stringWithFormat:@"%@,%@",tel,_phoneTF3.textField.text];
    }
    [tempDic setObject:tel forKey:@"tel"];
    
    if (_certTypeBtn.content.text.length && ![self isEmpty:_certNumTF.textField.text]) {

        [tempDic setObject:_certTypeBtn.content.text forKey:@"card_type"];
        [tempDic setObject:_certNumTF.textField.text forKey:@"card_num"];
        
    }else{
        
        [tempDic setObject:@"" forKey:@"card_type"];
        [tempDic setObject:@"" forKey:@"card_num"];
    }

    if (_birthBtn.content.text.length) {

        [tempDic setObject:_birthBtn.content.text forKey:@"birth"];
    }else{
        
        [tempDic setObject:@"" forKey:@"birth"];
    }
    if (![self isEmpty:_mailCodeTF.textField.text]) {

        [tempDic setObject:_mailCodeTF.textField.text forKey:@"mail_code"];
    }else{
        
        [tempDic setObject:@"" forKey:@"mail_code"];
    }

    if (![self isEmpty:_addressBtn.textField.text]) {

        [tempDic setObject:_addressBtn.textField.text forKey:@"address"];
    }else{
        
        [tempDic setObject:@"" forKey:@"address"];
    }


    if (![self isEmpty:_markTV.text]) {

        [tempDic setObject:_markTV.text forKey:@"comment"];
    }else{
        
        [tempDic setObject:@"" forKey:@"comment"];
    }

    [_clientArr removeAllObjects];
    _clientArr = [NSMutableArray arrayWithArray:_groupArr];
    [_clientArr insertObject:tempDic atIndex:0];

    [allDic setObject:_project_id forKey:@"project_id"];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_clientArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    [allDic setObject:jsonString forKey:@"client_list"];
    [allDic setObject:@"1" forKey:@"source"];
    [allDic setObject:@"1" forKey:@"type"];
    [allDic setObject:_approachBtn->str forKey:@"listen_way"];
    if (_customSourceBtn.content.text.length) {
        
        [allDic setObject:_proId forKey:@"province"];
        [allDic setObject:_cityId forKey:@"city"];
        [allDic setObject:_areaId forKey:@"district"];
    }
    if (_approachBtn2.content.text.length) {
        
        [allDic setObject:_approachBtn2->str forKey:@"listen_way_detail"];
    }
//    IntentSurveyVC *nextVC = [[IntentSurveyVC alloc] initWithPropertyId:_property_id];
    IntentSurveyVC *nextVC = [[IntentSurveyVC alloc] initWithData:_propertyDArr];
    nextVC.allDic = [[NSMutableDictionary alloc] initWithDictionary:allDic];
    nextVC.info_id = _info_id;
    nextVC.intentSurveyVCBlock = ^{
      
        if (self.addCallTelegramVCBlock) {
            
            self.addCallTelegramVCBlock();
        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _phoneTF.textField) {
        
        return [self validateNumber:string];
    }else if (textField == _phoneTF2.textField){
        
        return [self validateNumber:string];
    }else if (textField == _phoneTF3.textField){
        
        return [self validateNumber:string];
    }else if (textField == _mailCodeTF.textField){
        
        return [self validateNumber:string];
    }else{
        
        return YES;
    }
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField == _phoneTF.textField || textField == _phoneTF2.textField || textField == _phoneTF3.textField) {
        
        if (textField.text.length > 11) {
            
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _nameTF.textField) {
        
        if ([self isEmpty:textField.text]) {
            
            if (_group.length) {
                
                _groupL.text = [NSString stringWithFormat:@"组别成员：%@",_group];
            }else{
                
                _groupL.text = [NSString stringWithFormat:@"组别成员："];
            }
        }else{
            
            if (_group.length) {
                
                _groupL.text = [NSString stringWithFormat:@"组别成员：%@,%@",textField.text,_group];
            }else{
                
                _groupL.text = [NSString stringWithFormat:@"组别成员：%@",textField.text];
            }
        }
    }else if (textField == _certNumTF.textField){
        
        if ([_certTypeBtn.content.text containsString:@"身份证"]) {
            
            if (_certNumTF.textField.text.length) {
                
                if ([self validateIDCardNumber:_certNumTF.textField.text]) {
                    
                    _birthBtn.placeL.text = @"";
                    _birthBtn.content.text = [self subsIDStrToDate:_certNumTF.textField.text];
                    return;
                }else{
                    
                    textField.text = @"";
                    [self showContent:@"请输入正确的身份证号"];
                    return;
                }
            }else{
                
                textField.text = @"";
                [self showContent:@"请输入正确的身份证号"];
                return;
            }
        }
    }else{
        
        if (([_phoneTF.textField.text isEqualToString:_phoneTF2.textField.text] && _phoneTF.textField.text.length && _phoneTF2.textField.text.length)) {
            
            [self alertControllerWithNsstring:@"号码重复" And:@"请检查号码" WithDefaultBlack:^{
                
                self->_phoneTF2.textField.text = @"";
            }];
            return;
        }else if (([_phoneTF.textField.text isEqualToString:_phoneTF3.textField.text] && _phoneTF.textField.text.length && _phoneTF3.textField.text.length)){
            
            [self alertControllerWithNsstring:@"号码重复" And:@"请检查号码" WithDefaultBlack:^{
                
                self->_phoneTF3.textField.text = @"";
            }];
            return;
        }else if (([_phoneTF3.textField.text isEqualToString:_phoneTF2.textField.text] && _phoneTF3.textField.text.length && _phoneTF2.textField.text.length)){
            
            [self alertControllerWithNsstring:@"号码重复" And:@"请检查号码" WithDefaultBlack:^{
                
                self->_phoneTF3.textField.text = @"";
            }];
            return;
        }
        if (textField == _phoneTF.textField || textField == _phoneTF2.textField || textField == _phoneTF3.textField) {
            
            [BaseRequest GET:TelRepeatCheck_URL parameters:@{@"project_id":_project_id,@"tel":textField.text} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 400) {
                    
                    [self alertControllerWithNsstring:@"号码重复" And:resposeObject[@"msg"] WithDefaultBlack:^{
                        
//                        textField.text = @"";
                    }];
                }else{
                    
                    
                }
            } failure:^(NSError * _Nonnull error) {
                
                //            self
            }];
        }
    }
}


#pragma mark -- CollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _propertyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BoxSelectCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoxSelectCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BoxSelectCollCell alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 20 *SIZE)];
    }
    
    cell.tag = 1;
    
    [cell setIsSelect:[_selectArr[indexPath.item] integerValue]];
    
    cell.titleL.text = _propertyArr[indexPath.item][@"config_name"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    for (int i = 0; i < _selectArr.count; i++) {
//
//        [_selectArr replaceObjectAtIndex:i withObject:@0];
//    }
//    _property_id = [NSString stringWithFormat:@"%@",_propertyArr[indexPath.item][@"config_id"]];
    
    if ([_selectArr[indexPath.item] integerValue] == 1) {
     
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@0];
    }else{
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    }
    
    [collectionView reloadData];
}

- (void)initUI{
    
    self.titleLabel.text = @"新增来电";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_scrollView];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLTitleLabColor;
    _timeL.text = @"来电时间：";
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _timeL.adjustsFontSizeToFitWidth = YES;
    [_scrollView addSubview:_timeL];
    
    _timeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    [_timeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_timeBtn];
    
    BaseHeader *header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    header.titleL.text = @"客户信息";
    [_scrollView addSubview:header];
    
    NSArray *btnArr = @[@"男",@"女"];
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
        [btn setImage:IMAGE_WITH_NAME(@"default") forState:UIControlStateNormal];
        [btn setImage:IMAGE_WITH_NAME(@"selected") forState:UIControlStateSelected];
    
        switch (i) {
            case 0:
            {
                _maleBtn = btn;
                [_scrollView addSubview:_maleBtn];
                
                break;
            }
            case 1:
            {
                _femaleBtn = btn;
                [_scrollView addSubview:_femaleBtn];
                
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 7; i++) {
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        switch (i) {
            case 0:
            {
                _nameTF = tf;
                _nameTF.textField.delegate = self;
                _nameTF.textField.placeholder = @"姓名";
                [_scrollView addSubview:_nameTF];
                break;
            }
            case 1:
            {
                _phoneTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 217 *SIZE, 33 *SIZE)];
                _phoneTF.textField.placeholder = @"请输入手机号码";
                _phoneTF.textField.delegate = self;
                _phoneTF.textField.keyboardType = UIKeyboardTypePhonePad;
                [_phoneTF.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                [_scrollView addSubview:_phoneTF];
                break;
            }
            case 2:
            {
                _phoneTF2 = tf;
                _phoneTF2.hidden = YES;
                _phoneTF2.textField.placeholder = @"请输入手机号码";
                _phoneTF2.textField.delegate = self;
                _phoneTF2.textField.keyboardType = UIKeyboardTypePhonePad;
                [_phoneTF2.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                [_scrollView addSubview:_phoneTF2];
                break;
            }
            case 3:
            {
                _phoneTF3 = tf;
                _phoneTF3.hidden = YES;
                _phoneTF3.textField.placeholder = @"请输入手机号码";
                _phoneTF3.textField.delegate = self;
                _phoneTF3.textField.keyboardType = UIKeyboardTypePhonePad;
                [_phoneTF3.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                [_scrollView addSubview:_phoneTF3];
                break;
            }
            case 4:
            {
                _certNumTF = tf;
                _certNumTF.textField.placeholder = @"请输入证件号";
                _certNumTF.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                _certNumTF.textField.delegate = self;
                [_scrollView addSubview:_certNumTF];
                break;
            }
            case 5:
            {
                _mailCodeTF = tf;
                _mailCodeTF.textField.placeholder = @"请输入邮政编码";
                _mailCodeTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                _mailCodeTF.textField.delegate = self;
                [_scrollView addSubview:_mailCodeTF];
                break;
            }
            case 6:
            {
                
                _addressBtn = tf;
                _addressBtn.textField.placeholder = @"请输入通讯地址";
                [_scrollView addSubview:_addressBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _addGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addGroupBtn addTarget:self action:@selector(ActionAddGroupBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addGroupBtn setImage:IMAGE_WITH_NAME(@"add_5") forState:UIControlStateNormal];
    [_scrollView addSubview:_addGroupBtn];

    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:IMAGE_WITH_NAME(@"add_1") forState:UIControlStateNormal];
    [_scrollView addSubview:_addBtn];
    
    NSArray *titleArr = @[@"组别成员：",@"姓名：",@"性别：",@"联系号码：",@"证件类型：",@"证件号：",@"出生年月：",@"邮政编码：",@"客户来源：",@"认知途径：",@"来源类型：",@"通讯地址：",@"备注：",@"物业意向："];
    
    for (int i = 0; i < 14; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.text = titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        switch (i) {
            case 0:
            {
                _groupL = label;
                [_scrollView addSubview:_groupL];
                break;
            }
                
            case 1:
            {
                _nameL = label;

                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_nameL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _nameL.attributedText = attr;
                [_scrollView addSubview:_nameL];
                break;
            }
              
            case 2:
            {
                _genderL = label;
                    
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_genderL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _genderL.attributedText = attr;
                [_scrollView addSubview:_genderL];
                break;
            }
                
            case 3:
            {
                _phoneL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_phoneL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _phoneL.attributedText = attr;
                [_scrollView addSubview:_phoneL];
                break;
            }
                
            case 4:
            {
                _certTypeL = label;
                [_scrollView addSubview:_certTypeL];
                break;
            }
                
            case 5:
            {
                _certNumL = label;
                [_scrollView addSubview:_certNumL];
                break;
            }
                
            case 6:
            {
                _birthL = label;
                if ([_configDic[@"birth"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_birthL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _birthL.attributedText = attr;
                }
                [_scrollView addSubview:_birthL];
                break;
            }
                
            case 7:
            {
                _mailCodeL = label;
                if ([_configDic[@"mail"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_mailCodeL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _mailCodeL.attributedText = attr;
                }
                [_scrollView addSubview:_mailCodeL];
                break;
            }
            
            case 8:
            {
                _customSourceL = label;
                [_scrollView addSubview:_customSourceL];
                break;
            }
            case 9:
            {
                _approachL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_approachL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _approachL.attributedText = attr;
                [_scrollView addSubview:_approachL];
                break;
            }
            case 10:
            {
                _sourceTypeL = label;
                [_scrollView addSubview:_sourceTypeL];
                break;
            }
            case 11:
            {
                _addressL = label;
                if ([_configDic[@"address"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_addressL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _addressL.attributedText = attr;
                }
                [_scrollView addSubview:_addressL];
                break;
            }
            case 12:
            {
                _markL = label;
                [_scrollView addSubview:_markL];
                break;
            }
            case 13:
            {
                _propertyIntentL = label;
                [_scrollView addSubview:_propertyIntentL];
                break;
            }
            
            default:
                break;
        }
    }
    
    for (int i = 0; i < 6; i++) {
        
        DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                
                _certTypeBtn = btn;
                _certTypeBtn.placeL.text = @"请选择证件类型";
                [_scrollView addSubview:_certTypeBtn];
                break;
            }
            case 1:
            {
                
                _birthBtn = btn;
                _birthBtn.placeL.text = @"请选择出生年月";
                [_scrollView addSubview:_birthBtn];
                break;
            }
            case 2:
            {
                
                _customSourceBtn = btn;
                _customSourceBtn.placeL.text = @"请选择客户来源";
                [_scrollView addSubview:_customSourceBtn];
                break;
            }
            case 3:
            {
                
                _approachBtn = btn;
                _approachBtn.placeL.text = @"请选择认知途径";
                [_scrollView addSubview:_approachBtn];
                break;
            }
            case 4:
            {
                
                _sourceTypeBtn = btn;
                _sourceTypeBtn.content.text = @"自行添加";
                _sourceTypeBtn.dropimg.hidden = YES;
                _sourceTypeBtn.backgroundColor = CLLineColor;
                [_scrollView addSubview:_sourceTypeBtn];
                break;
            }
            case 5:{
                
                _approachBtn2 = btn;
                _approachBtn2.hidden = YES;
                _approachBtn2.placeL.text = @"请选择认知途径";
                [_scrollView addSubview:_approachBtn2];
                break;
            }
            default:
                break;
        }
    }
    
    _markTV = [[UITextView alloc] init];
    _markTV.layer.cornerRadius = 5 *SIZE;
    _markTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _markTV.layer.borderWidth = SIZE;
    _markTV.clipsToBounds = YES;
    [_scrollView addSubview:_markTV];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(100 *SIZE, 20 *SIZE);
    
    _propertyIntentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 255 *SIZE, 100 *SIZE) collectionViewLayout:_flowLayout];
    _propertyIntentColl.backgroundColor = CLWhiteColor;
    _propertyIntentColl.delegate = self;
    _propertyIntentColl.dataSource = self;
    [_propertyIntentColl registerClass:[BoxSelectCollCell class] forCellWithReuseIdentifier:@"BoxSelectCollCell"];
    [_scrollView addSubview:_propertyIntentColl];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"下一步 意向调查" forState:UIControlStateNormal];
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
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_scrollView).offset(50 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_scrollView).offset(46 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_groupL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_timeBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_lessThanOrEqualTo(280 *SIZE);
    }];
    
    [_addGroupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_groupL.mas_right).offset(5 *SIZE);
        make.top.equalTo(self->_timeBtn.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(20 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];

    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_groupL.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_groupL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_genderL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_maleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_femaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(150 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_maleBtn.mas_bottom).offset(33 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_maleBtn.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(217 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(313 *SIZE);
        make.top.equalTo(self->_maleBtn.mas_bottom).offset(27 *SIZE);
        make.width.mas_equalTo(25 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [_phoneTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneTF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];

    [_certTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_certNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_certTypeBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_certNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_certTypeBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_birthL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_certNumTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_birthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_certNumTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_mailCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_birthBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_mailCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_birthBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_mailCodeTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_mailCodeTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_customSourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_addressBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_customSourceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_addressBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_approachL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_customSourceBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_approachBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_customSourceBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_approachBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_approachBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_sourceTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_approachBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_sourceTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_approachBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_sourceTypeBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_sourceTypeBtn.mas_bottom).offset(24 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
    }];

    [_propertyIntentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_markTV.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_propertyIntentColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(30 *SIZE);
        make.top.equalTo(self->_propertyIntentL.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(self->_propertyIntentColl.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self->_scrollView).offset(-20 *SIZE);
    }];

}

@end
