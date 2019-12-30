//
//  AddEncumbrancerVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/1.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddEncumbrancerVC.h"

#import "SinglePickView.h"
#import "DateChooseView.h"
#import "AdressChooseView.h"

#import "BaseHeader.h"

#import "BorderTextField.h"
#import "DropBtn.h"

@interface AddEncumbrancerVC ()<UITextFieldDelegate>
{
    NSInteger _numAdd;
    
    NSString *_gender;
    NSString *_proId;
    NSString *_cityId;
    NSString *_areaId;
    
    NSMutableArray *_certArr;
    NSMutableArray *_approachArr;
    NSMutableArray *_approachArr2;
    
    NSDateFormatter *_formatter;
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

@property (nonatomic, strong) UILabel *proportionL;

@property (nonatomic, strong) BorderTextField *proportionTF;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddEncumbrancerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];

    _approachArr = [@[] mutableCopy];
    _approachArr2 = [@[] mutableCopy];
    _certArr = [@[] mutableCopy];

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
            
            AdressChooseView *addressChooseView = [[AdressChooseView alloc] initWithFrame:self.view.bounds withdata:@[]];
//            WS(weakself);
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
                self->_proId = pro;
                self->_cityId = cityid;
                self->_areaId = areaid;
            };
            [self.view addSubview:addressChooseView];
            break;
        }
        case 3:{
            
            
            break;
        }
        case 5:{
            
            
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
    
    if (!_birthBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"必填信息" And:@"请选择出生年月"];
        return;
    }
    
    if ([self isEmpty:_mailCodeTF.textField.text]) {
        
        [self alertControllerWithNsstring:@"必填信息" And:@"请输入邮政编码"];
        return;
    }
    
    if ([self isEmpty:_addressBtn.textField.text]) {
        
        [self alertControllerWithNsstring:@"必填信息" And:@"请选择通讯地址"];
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

    [allDic setObject:@"1" forKey:@"source"];
    [allDic setObject:@"1" forKey:@"type"];

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
    
    if (textField == _certNumTF.textField){
        
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
            
//            [BaseRequest GET:TelRepeatCheck_URL parameters:@{@"project_id":_project_id,@"tel":textField.text} success:^(id  _Nonnull resposeObject) {
//
//                if ([resposeObject[@"code"] integerValue] == 400) {
//
//                    [self alertControllerWithNsstring:@"号码重复" And:resposeObject[@"msg"] WithDefaultBlack:^{
//
//                        textField.text = @"";
//                    }];
//                }else{
//
//
//                }
//            } failure:^(NSError * _Nonnull error) {
//
//                //            self
//            }];
        }
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"权益人信息";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_scrollView];
    
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
    
    for (int i = 0; i < 8; i++) {
        
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
            case 7:
            {
                _proportionTF = tf;
//                _proportionTF.textField.placeholder = @"请输入邮政编码";
                _proportionTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                _proportionTF.textField.delegate = self;
                [_scrollView addSubview:_proportionTF];
                break;
            }

            default:
                break;
        }
    }

    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:IMAGE_WITH_NAME(@"add_1") forState:UIControlStateNormal];
    [_scrollView addSubview:_addBtn];
    
    NSArray *titleArr = @[@"组别成员：",@"客户姓名：",@"性别：",@"手机号码：",@"证件类型：",@"证件号：",@"出生年月：",@"邮政编码：",@"客户来源：",@"认知途径：",@"来源类型：",@"通讯地址：",@"备注：",@"产权比例："];
    
    for (int i = 0; i < 14; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.text = titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        switch (i) {
            case 0:
            {
            
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
                [_scrollView addSubview:_birthL];
                break;
            }
                
            case 7:
            {
                _mailCodeL = label;
                [_scrollView addSubview:_mailCodeL];
                break;
            }
                
            case 8:
            {
//                _customSourceL = label;
//                [_scrollView addSubview:_customSourceL];
                break;
            }
            case 9:
            {
//                _approachL = label;
//                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_approachL.text]];
//                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
//                _approachL.attributedText = attr;
//                [_scrollView addSubview:_approachL];
                break;
            }
            case 10:
            {
//                _sourceTypeL = label;
//                [_scrollView addSubview:_sourceTypeL];
                break;
            }
            case 11:
            {
                _addressL = label;
                [_scrollView addSubview:_addressL];
                break;
            }
            case 12:
            {
//                _markL = label;
//                [_scrollView addSubview:_markL];
                break;
            }
            case 13:
            {
                _proportionL = label;
                [_scrollView addSubview:_proportionL];
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
                
//                _customSourceBtn = btn;
//                _customSourceBtn.placeL.text = @"请选择客户来源";
//                [_scrollView addSubview:_customSourceBtn];
                break;
            }
            case 3:
            {
                
//                _approachBtn = btn;
//                _approachBtn.placeL.text = @"请选择认知途径";
//                [_scrollView addSubview:_approachBtn];
                break;
            }
            case 4:
            {
                
//                _sourceTypeBtn = btn;
//                _sourceTypeBtn.content.text = @"自行添加";
//                _sourceTypeBtn.dropimg.hidden = YES;
//                _sourceTypeBtn.backgroundColor = CLLineColor;
//                [_scrollView addSubview:_sourceTypeBtn];
                break;
            }
            case 5:{
                
//                _approachBtn2 = btn;
//                _approachBtn2.hidden = YES;
//                _approachBtn2.placeL.text = @"请选择认知途径";
//                [_scrollView addSubview:_approachBtn2];
                break;
            }
            default:
                break;
        }
    }
    
//    _markTV = [[UITextView alloc] init];
//    _markTV.layer.cornerRadius = 5 *SIZE;
//    _markTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
//    _markTV.layer.borderWidth = SIZE;
//    _markTV.clipsToBounds = YES;
//    [_scrollView addSubview:_markTV];
    
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
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_scrollView).offset(52 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_scrollView).offset(47 *SIZE);
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
    
    [_proportionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_addressBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_proportionTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_addressBtn.mas_bottom).offset(24 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_scrollView).offset(-20 *SIZE);
    }];
    
//    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
//        make.top.equalTo(self->_addressBtn.mas_bottom).offset(31 *SIZE);
//        make.width.mas_equalTo(70 *SIZE);
//    }];
//
//    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
//        make.top.equalTo(self->_addressBtn.mas_bottom).offset(24 *SIZE);
//        make.width.mas_equalTo(258 *SIZE);
//        make.height.mas_equalTo(77 *SIZE);
//        make.bottom.equalTo(self->_scrollView).offset(-20 *SIZE);
//    }];
}

@end
