//
//  AddOrderRentInfoView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddOrderRentInfoView.h"

@interface AddOrderRentInfoView ()<UITextFieldDelegate>

@end

@implementation AddOrderRentInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.addOrderRentInfoViewStrBlock) {

        self.addOrderRentInfoViewStrBlock(textField.text, textField.tag);
    }
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    if (self.addOrderRentInfoViewBtnBlock) {

        self.addOrderRentInfoViewBtnBlock(btn.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _codeTF.textField.text = dataDic[@"codeName"];
    _signerTF.textField.text = dataDic[@"signer"];
    _signTypeBtn.content.text = dataDic[@"typeName"];
    _signTypeBtn->str = dataDic[@"typeId"];
    _signNumTF.textField.text = dataDic[@"signNum"];
    _priceTF.textField.text = dataDic[@"price"];
    _intentPeriodLBtn1.content.text = dataDic[@"min"];
    _intentPeriodLBtn2.content.text = dataDic[@"max"];
    _payWayBtn.content.text = dataDic[@"payWay"];
    _payWayBtn->str = dataDic[@"payWayId"];
    _timeBtn.content.text = dataDic[@"remindTime"];
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;

    NSArray *titleArr = @[@"定租编号：",@"签约人：",@"签约人证件类型：",@"签约人证件号码：",@"定金金额：",@"租期：",@"付款方式：",@"提醒签约时间："];
    for (int i = 0; i < 8; i++) {
    
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.text = titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        tf.textField.tag = i;
        tf.textField.delegate = self;
        switch (i) {
            case 0:
            {
            
                _codeL = label;
                [self addSubview:_codeL];
                
                _codeTF = tf;
                [self addSubview:_codeTF];
                break;
            }
            
            case 1:
            {
                _signerL = label;
                [self addSubview:_signerL];
                
                _signerTF = tf;
                [self addSubview:_signerTF];
                break;
            }
            
            case 2:
            {
                
                _signTypeL = label;
                [self addSubview:_signTypeL];
                
                _signTypeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_signTypeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _signTypeBtn.tag = 2;
                [self addSubview:_signTypeBtn];
                break;
            }
            
            case 3:
            {
                _signNumL = label;
                [self addSubview:_signNumL];
                
                _signNumTF = tf;
                [self addSubview:_signNumTF];
                break;
            }
            case 4:
            {
                
                _priceL = label;
                [self addSubview:_priceL];
                
                _priceTF = tf;
                [self addSubview:_priceTF];
                
                _intentPeriodLBtn1 = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
                [_intentPeriodLBtn1 addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _intentPeriodLBtn1.tag = 4;
                [self addSubview:_intentPeriodLBtn1];
                break;
            }
            case 5:
            {
                
                _intentPeriodL = label;
                [self addSubview:_intentPeriodL];
                
                _intentPeriodLBtn2 = [[DropBtn alloc] initWithFrame:_intentPeriodLBtn1.frame];
                [_intentPeriodLBtn2 addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _intentPeriodLBtn2.tag = 5;
                [self addSubview:_intentPeriodLBtn2];
                break;
            }
            case 6:
            {
                
                _payWayL = label;
                [self addSubview:_payWayL];
                
                _payWayBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_payWayBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _payWayBtn.tag = 6;
                [self addSubview:_payWayBtn];
                break;
            }
            case 7:
            {
                
                _timeL = label;
                [self addSubview:_timeL];
                
                _timeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_timeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _timeBtn.tag = 7;
                [self addSubview:_timeBtn];
                break;
            }
            default:
                break;
        }
    }
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_signerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_signerTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_signTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_signerTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_signTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_signerTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_signNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_signTypeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_signNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_signTypeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_signNumTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_signNumTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_intentPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_intentPeriodLBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_intentPeriodLBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(218 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_intentPeriodLBtn1.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_intentPeriodLBtn1
                         .mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_payWayBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_payWayBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self).offset(-10 *SIZE);
    }];
}

@end
