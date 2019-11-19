//
//  CallTelegramSimpleCustomVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramSimpleCustomVC.h"

#import "VisitCustomMergeVC.h"

#import "BoxSelectCollCell.h"
#import "BaseHeader.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

#import "BorderTextField.h"
#import "DropBtn.h"

@interface CallTelegramSimpleCustomVC ()<UITextFieldDelegate>
{
    
    NSDateFormatter *_formatter;
    
    NSInteger _numAdd;
    
    NSString *_gender;
    NSString *_project_id;
    NSString *_info_id;
    
    NSDictionary *_dataDic;
    
    NSMutableArray *_certArr;
}
@property (nonatomic, strong) UIScrollView *scrollView;

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

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) BorderTextField *addressBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation CallTelegramSimpleCustomVC

- (instancetype)initWithDataDic:(NSDictionary *)dataDic projectId:(NSString *)projectId info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _project_id = projectId;
        _dataDic = dataDic;
        _info_id = info_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    if (self.configDic.count) {
        
        [self initUI];
    }else{
        
        [self RequestMethod];
    }
    [self PropertyRequestMethod];
}

- (void)initDataSource{
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
    
    
    _certArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:WorkClientAutoColumnConfig_URL parameters:@{@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_configDic = resposeObject[@"data"];
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
            };
            [self.view addSubview:view];
            break;
        }
        case 1:{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
            [view.pickerView setMaximumDate:[NSDate date]];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setYear:60];//设置最大时间为：当前时间推后10天
            [view.pickerView setMinimumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
            view.dateblock = ^(NSDate *date) {
                
                self->_birthBtn.content.text = [self->_formatter stringFromDate:date];
                self->_birthBtn.placeL.text = @"";
            };
            [self.view addSubview:view];
            break;
        }
        default:
            break;
    }
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
    NSMutableDictionary *tempDic = [@{} mutableCopy];
    
    if ([self isEmpty:_nameTF.textField.text]) {
        
        [self alertControllerWithNsstring:@"必填信息" And:@"请填写姓名"];
        return;
    }
    
    if ([_configDic[@"sex"] integerValue] == 1) {
        
        if (!_gender.length) {
            
            [self alertControllerWithNsstring:@"必填信息" And:@"请选择性别"];
            return;
        }
    }
    
    if ([self.trans isEqualToString:@"trans"]) {
        
        
    }else{
        
        if ([_configDic[@"tel"] integerValue] == 1) {
            
            if ([self isEmpty:_phoneTF.textField.text]) {
                
                [self alertControllerWithNsstring:@"必填信息" And:@"请填写电话号码"];
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
    
    [tempDic setObject:_nameTF.textField.text forKey:@"name"];
    if (_gender.length) {
        
        [tempDic setObject:_gender forKey:@"sex"];
    }
    

    if ([self.trans isEqualToString:@"trans"]) {
        
        if ([self checkTel:_phoneTF.textField.text]) {
            
            NSString *tel = _phoneTF.textField.text;
            if ([self checkTel:_phoneTF2.textField.text]) {
                
                tel = [NSString stringWithFormat:@"%@,%@",tel,_phoneTF2.textField.text];
            }
            if ([self checkTel:_phoneTF3.textField.text]) {
                
                tel = [NSString stringWithFormat:@"%@,%@",tel,_phoneTF3.textField.text];
            }
            [tempDic setObject:tel forKey:@"tel"];
        }else{
            
            [tempDic setObject:self.phone forKey:@"tel"];
        }
    }else{
        
        NSString *tel = _phoneTF.textField.text;
        if (![self isEmpty:_phoneTF2.textField.text]) {
            
            tel = [NSString stringWithFormat:@"%@,%@",tel,_phoneTF2.textField.text];
        }
        if (![self isEmpty:_phoneTF3.textField.text]) {
            
            tel = [NSString stringWithFormat:@"%@,%@",tel,_phoneTF3.textField.text];
        }
        [tempDic setObject:tel forKey:@"tel"];
    }
    
    
    if (_certTypeBtn.content.text.length && ![self isEmpty:_certNumTF.textField.text]) {
        
        [tempDic setObject:_certTypeBtn.content.text forKey:@"card_type"];
        [tempDic setObject:_certNumTF.textField.text forKey:@"card_num"];
    }
    
    if (_birthBtn.content.text.length) {
        
        if (![_birthBtn.content.text isEqualToString:@"0000-00-00"]) {
            
            [tempDic setObject:_birthBtn.content.text forKey:@"birth"];
        }
    }
    if (![self isEmpty:_mailCodeTF.textField.text]) {
        
        [tempDic setObject:_mailCodeTF.textField.text forKey:@"mail_code"];
    }
    
    if (![self isEmpty:_addressBtn.textField.text]) {
        
        [tempDic setObject:_addressBtn.textField.text forKey:@"address"];
    }
    
    if (![self isEmpty:_markTV.text]) {
        
        [tempDic setObject:_markTV.text forKey:@"comment"];
    }
    
    [tempDic setObject:_dataDic[@"client_id"] forKey:@"client_id"];
    
    if (self.merge.length) {
        
        [BaseRequest GET:ClientGetGroupTime_URL parameters:@{@"project_id":_project_id,@"group_id":_group_id,@"tel":tempDic[@"tel"]} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if ([resposeObject[@"data"][@"is_main"] integerValue] == 1) {
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"该号码在其他来访组中存在，系统监测到可能存在为一家人有多个经纪人报备，是否需要合并组！" WithCancelBlack:^{
                        
                        [self NextRequest];
                    } WithDefaultBlack:^{
                        
                        VisitCustomMergeVC *nextVC = [[VisitCustomMergeVC alloc] initWithDic:resposeObject[@"data"]];
                        nextVC.visitCustomMergeVCBlock = ^{
                            
                            self.callTelegramSimpleCustomVCEditBlock(tempDic);
                        };
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }];
                }else{
                    
                    [self NextRequest];
                }
            }else{
                
                [self NextRequest];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self NextRequest];
        }];
    }else{
        
        [self NextRequest];
    }
}

- (void)NextRequest{
    
    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    NSMutableDictionary *tempDic = [@{} mutableCopy];
    
    if ([self isEmpty:_nameTF.textField.text]) {
        
        [self alertControllerWithNsstring:@"必填信息" And:@"请填写姓名"];
        return;
    }
    
    if ([_configDic[@"sex"] integerValue] == 1) {
        
        if (!_gender.length) {
            
            [self alertControllerWithNsstring:@"必填信息" And:@"请选择性别"];
            return;
        }
    }
    
    if ([self.trans isEqualToString:@"trans"]) {
        
        
    }else{
        
        if ([_configDic[@"tel"] integerValue] == 1) {
            
            if ([self isEmpty:_phoneTF.textField.text]) {
                
                [self alertControllerWithNsstring:@"必填信息" And:@"请填写电话号码"];
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
    
    [tempDic setObject:_nameTF.textField.text forKey:@"name"];
    if (_gender.length) {
        
        [tempDic setObject:_gender forKey:@"sex"];
    }
    
    
    if ([self.trans isEqualToString:@"trans"]) {
        
        if ([self checkTel:_phoneTF.textField.text]) {
            
            NSString *tel = _phoneTF.textField.text;
            if ([self checkTel:_phoneTF2.textField.text]) {
                
                tel = [NSString stringWithFormat:@"%@,%@",tel,_phoneTF2.textField.text];
            }
            if ([self checkTel:_phoneTF3.textField.text]) {
                
                tel = [NSString stringWithFormat:@"%@,%@",tel,_phoneTF3.textField.text];
            }
            [tempDic setObject:tel forKey:@"tel"];
        }else{
            
            [tempDic setObject:self.phone forKey:@"tel"];
        }
    }else{
        
        NSString *tel = _phoneTF.textField.text;
        if (![self isEmpty:_phoneTF2.textField.text]) {
            
            tel = [NSString stringWithFormat:@"%@,%@",tel,_phoneTF2.textField.text];
        }
        if (![self isEmpty:_phoneTF3.textField.text]) {
            
            tel = [NSString stringWithFormat:@"%@,%@",tel,_phoneTF3.textField.text];
        }
        [tempDic setObject:tel forKey:@"tel"];
    }
    
    
    if (_certTypeBtn.content.text.length && ![self isEmpty:_certNumTF.textField.text]) {
        
        [tempDic setObject:_certTypeBtn.content.text forKey:@"card_type"];
        [tempDic setObject:_certNumTF.textField.text forKey:@"card_num"];
    }
    
    if (_birthBtn.content.text.length) {
        
        if (![_birthBtn.content.text isEqualToString:@"0000-00-00"]) {
            
            [tempDic setObject:_birthBtn.content.text forKey:@"birth"];
        }
    }
    if (![self isEmpty:_mailCodeTF.textField.text]) {
        
        [tempDic setObject:_mailCodeTF.textField.text forKey:@"mail_code"];
    }
    
    if (![self isEmpty:_addressBtn.textField.text]) {
        
        [tempDic setObject:_addressBtn.textField.text forKey:@"address"];
    }
    
    if (![self isEmpty:_markTV.text]) {
        
        [tempDic setObject:_markTV.text forKey:@"comment"];
    }
    
    [tempDic setObject:_dataDic[@"client_id"] forKey:@"client_id"];
    
    if (![self.trans isEqualToString:@"trans"]) {
        
        [BaseRequest POST:WorkClientAutoClientUpdate_URL parameters:tempDic success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                self.callTelegramSimpleCustomVCEditBlock(tempDic);
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }else{
        
        self.callTelegramSimpleCustomVCEditBlock(tempDic);
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    }
    if (textField == _phoneTF.textField || textField == _phoneTF2.textField || textField == _phoneTF3.textField) {
        
        if (![self.trans isEqualToString:@"trans"]) {
            
            if (![self checkTel:textField.text]) {
                
                [self alertControllerWithNsstring:@"号码错误" And:@"请检查号码" WithDefaultBlack:^{
                    
                    textField.text = @"";
                }];
                return;
            }
        }
        
        [BaseRequest GET:TelRepeatCheck_URL parameters:@{@"project_id":_project_id,@"tel":textField.text,@"is_client":@"1"} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 400) {
                
                [self alertControllerWithNsstring:@"号码重复" And:resposeObject[@"msg"] WithDefaultBlack:^{
                    
//                    textField.text = @"";
                }];
            }else{
                
                
            }
        } failure:^(NSError * _Nonnull error) {
            
            //            self
        }];
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"添加组员";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_scrollView];
    
    BaseHeader *header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    header.titleL.text = @"组员信息";
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
                _certNumTF.textField.delegate = self;
                _certNumTF.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
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
                _addressBtn.textField.placeholder = @"请输入地址";
                [_scrollView addSubview:_addressBtn];
                break;
            }
            default:
                break;
        }
    }
    
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.tag = 3;
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:IMAGE_WITH_NAME(@"add_1") forState:UIControlStateNormal];
    if (self.hiddenAdd.length) {
        
        _addBtn.hidden = YES;
    }
    [_scrollView addSubview:_addBtn];
    
    NSArray *titleArr = @[@"姓名：",@"性别：",@"联系号码：",@"证件类型：",@"证件号：",@"出生年月：",@"邮政编码：",@"通讯地址：",@"备注："];
    
    for (int i = 0; i < 9; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                
                _nameL = label;
                if ([_configDic[@"name"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_nameL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _nameL.attributedText = attr;
                }
                [_scrollView addSubview:_nameL];
                break;
            }
                
            case 1:
            {
                _genderL = label;
                if ([_configDic[@"sex"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_genderL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _genderL.attributedText = attr;
                }
                [_scrollView addSubview:_genderL];
                break;
            }
                
            case 2:
            {
                _phoneL = label;
                if ([_configDic[@"tel"] integerValue] == 1) {
                    
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_phoneL.text]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                    _phoneL.attributedText = attr;
                }
                [_scrollView addSubview:_phoneL];
                break;
            }
                
            case 3:
            {
                _certTypeL = label;
                [_scrollView addSubview:_certTypeL];
                break;
            }
                
            case 4:
            {
                _certNumL = label;
                [_scrollView addSubview:_certNumL];
                break;
            }
                
            case 5:
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
                
            case 6:
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
                
                
            case 7:
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
            case 8:{
                
                _markL = label;
                [_scrollView addSubview:_markL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 2; i++) {
        
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
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    //    _nextBtn.layer.cornerRadius = 5 *SIZE;
    //    _nextBtn.clipsToBounds = YES;
    [self.view addSubview:_nextBtn];
    
    [self MasonryUI];
    
    _nameTF.textField.text = _dataDic[@"name"];
    if ([_dataDic[@"sex"] integerValue] == 1) {
        
        _maleBtn.selected = YES;
        _gender = @"1";
    }else{
        
        _femaleBtn.selected = YES;
        _gender = @"2";
    }
    
    NSArray *arr = [_dataDic[@"tel"] componentsSeparatedByString:@","];
    if (arr.count == 1) {
        
        _phoneTF.textField.text = arr[0];
    }else if (arr.count == 2){
        
        _phoneTF.textField.text = arr[0];
        _phoneTF2.textField.text = arr[1];
        [self ActionAddBtn:_addBtn];
    }else{
        
        _phoneTF.textField.text = arr[0];
        [self ActionAddBtn:_addBtn];
        _phoneTF2.textField.text = arr[1];
        [self ActionAddBtn:_addBtn];
        _phoneTF3.textField.text = arr[2];
    }
    
    if ([_dataDic[@"card_type"] length]) {
        
        _certTypeBtn.content.text = _dataDic[@"card_type"];
        _certTypeBtn.placeL.text = @"";
        _certNumTF.textField.text = _dataDic[@"card_num"];
        for (int i = 0; i < _certArr.count; i++) {
            
            if ([_dataDic[@"card_type"] isEqualToString:_certArr[i][@"param"]]) {
                
                _certTypeBtn->str = _certArr[i][@"id"];
                break;
            }
        }
    }
    
    if (![_dataDic[@"birth"] isKindOfClass:[NSNull class]] && [_dataDic[@"birth"] length]) {
        
        _birthBtn.content.text = _dataDic[@"birth"];
        _birthBtn.placeL.text = @"";
    }
    _mailCodeTF.textField.text = _dataDic[@"mail_code"];
    _addressBtn.textField.text = _dataDic[@"address"];
    _markTV.text = _dataDic[@"comment"];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE);
    }];
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_scrollView).offset(50 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_scrollView).offset(46 *SIZE);
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
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(313 *SIZE);
        make.top.equalTo(self->_maleBtn.mas_bottom).offset(27 *SIZE);
        make.width.mas_equalTo(25 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
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
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_addressBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_addressBtn.mas_bottom).offset(24 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
        make.bottom.equalTo(self->_scrollView).offset(-20 *SIZE);
    }];
}

@end
