//
//  AddOrderRentInfoCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/13.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddOrderRentInfoCell.h"

@interface AddOrderRentInfoCell ()<UITextFieldDelegate>

@end

@implementation AddOrderRentInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.addOrderRentInfoCellStrBlock) {

        self.addOrderRentInfoCellStrBlock(textField.text, textField.tag);
    }
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    if (self.addOrderRentInfoCellBtnBlock) {

        self.addOrderRentInfoCellBtnBlock(btn.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _codeTF.textField.text = dataDic[@"sub_code"];
    _signerTF.textField.text = dataDic[@"signatory"];
    _signTypeBtn.content.text = dataDic[@"typeName"];
    _signTypeBtn->str = dataDic[@"card_type"];
    _signNumTF.textField.text = dataDic[@"card_num"];
    _priceTF.textField.text = dataDic[@"down_pay"];
    _openTimeBtn.content.text = dataDic[@"open_time"];
    _signTimeBtn.content.text = dataDic[@"sub_time"];
    _rentTimeBeginBtn.content.text = dataDic[@"start_time"];
    if (dataDic[@"rent_month_num"]) {
        
        _rentTimePeriodTF.textField.text = [NSString stringWithFormat:@"%@",dataDic[@"rent_month_num"]];
    }
    _payWayBtn1.content.text = dataDic[@"pay_name1"];
    _payWayBtn1->str = dataDic[@"pay_way1"];
    _payWayBtn2.content.text = dataDic[@"pay_name2"];
    _payWayBtn2->str = dataDic[@"pay_way2"];
    _remindTimeBtn.content.text = dataDic[@"remind_time"];
    _depositTF.textField.text = dataDic[@"deposit"];
}

- (void)setSignDic:(NSMutableDictionary *)signDic{
    
    _codeTF.textField.text = signDic[@"contact_code"];
    _signerTF.textField.text = signDic[@"signatory"];
    _signTypeBtn.content.text = signDic[@"typeName"];
    _signTypeBtn->str = signDic[@"card_type"];
    _signNumTF.textField.text = signDic[@"card_num"];
    _priceTF.textField.text = signDic[@"down_pay"];
    _openTimeBtn.content.text = signDic[@"open_time"];
    _signTimeBtn.content.text = signDic[@"contact_time"];
    _rentTimeBeginBtn.content.text = signDic[@"start_time"];
    if (signDic[@"rent_month_num"]) {
        
        _rentTimePeriodTF.textField.text = [NSString stringWithFormat:@"%@",signDic[@"rent_month_num"]];
    }
    _payWayBtn1.content.text = signDic[@"pay_name1"];
    _payWayBtn1->str = signDic[@"pay_way1"];
    _payWayBtn2.content.text = signDic[@"pay_name2"];
    _payWayBtn2->str = signDic[@"pay_way2"];
    _remindTimeBtn.content.text = signDic[@"remind_time"];
    _depositTF.textField.text = signDic[@"deposit"];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _priceTF.textField) {
        
        BOOL isHaveDian;
        
        //判断是否有小数点
        if ([textField.text containsString:@"."]) {
            isHaveDian = YES;
        }else{
            isHaveDian = NO;
        }
        
        if (string.length > 0) {
            
            //当前输入的字符
            unichar single = [string characterAtIndex:0];
            NSLog(@"single = %c",single);
            
            //不能输入.0~9以外的字符
            if (!((single >= '0' && single <= '9') || single == '.')){
                NSLog(@"您输入的格式不正确");
                return NO;
            }
            
            //只能有一个小数点
            if (isHaveDian && single == '.') {
                NSLog(@"只能输入一个小数点");
                return NO;
            }
            
            //如果第一位是.则前面加上0
            if ((textField.text.length == 0) && (single == '.')) {
                textField.text = @"0";
            }
            
            //如果第一位是0则后面必须输入.
            if ([textField.text hasPrefix:@"0"]) {
                if (textField.text.length > 1) {
                    NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                    if (![secondStr isEqualToString:@"."]) {
                        NSLog(@"第二个字符必须是小数点");
                        return NO;
                    }
                }else{
                    if (![string isEqualToString:@"."]) {
                        NSLog(@"第二个字符必须是小数点");
                        return NO;
                    }
                }
            }
            
//            //小数点后最多能输入两位
//            if (isHaveDian) {
//                NSRange ran = [textField.text rangeOfString:@"."];
//                //由于range.location是NSUInteger类型的，所以不能通过(range.location - ran.location) > 2来判断
//                if (range.location > ran.location) {
//                    if ([textField.text pathExtension].length > 1) {
//                        NSLog(@"小数点后最多有两位小数");
//                        return NO;
//                    }
//                }
//            }
            
        }
        
        return YES;
    }else if (textField == _rentTimePeriodTF.textField) {
            
            BOOL isHaveDian;
            
            //判断是否有小数点
            if ([textField.text containsString:@"."]) {
                isHaveDian = YES;
            }else{
                isHaveDian = NO;
            }
            
            if (string.length > 0) {
                
                //当前输入的字符
                unichar single = [string characterAtIndex:0];
                NSLog(@"single = %c",single);
                
                //不能输入.0~9以外的字符
                if (!((single >= '0' && single <= '9'))){
                    NSLog(@"您输入的格式不正确");
                    return NO;
                }
                
                //只能有一个小数点
                if (isHaveDian && single == '.') {
                    NSLog(@"只能输入一个小数点");
                    return NO;
                }
                
                //如果第一位是.则前面加上0
                if ((textField.text.length == 0) && (single == '.')) {
                    textField.text = @"0";
                }
                
                //如果第一位是0则后面必须输入.
                if ([textField.text hasPrefix:@"0"]) {
                    if (textField.text.length > 1) {
                        NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                        if (![secondStr isEqualToString:@"."]) {
                            NSLog(@"第二个字符必须是小数点");
                            return NO;
                        }
                    }else{
                        if (![string isEqualToString:@"."]) {
                            NSLog(@"第二个字符必须是小数点");
                            return NO;
                        }
                    }
                }
            }
            
            return YES;
        }else{
        
        return YES;
    }
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;

    NSArray *titleArr = @[@"定租编号：",@"签约人：",@"签约人证件类型：",@"签约人证件号码：",@"定金金额：",@"开业时间：",@"定租时间：",@"提醒签约时间：",@"租期开始时间：",@"租期时长：",@"付款方式：",@"押金金额："];
    for (int i = 0; i < 12; i++) {
    
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
                [self.contentView addSubview:_codeL];
                
                _codeTF = tf;
                _codeTF.textField.keyboardType = UIKeyboardTypeASCIICapable;
                [self.contentView addSubview:_codeTF];
                break;
            }
            
            case 1:
            {
                _signerL = label;
                [self.contentView addSubview:_signerL];
                
                _signerTF = tf;
                [self.contentView addSubview:_signerTF];
                break;
            }
            
            case 2:
            {
                
                _signTypeL = label;
                [self.contentView addSubview:_signTypeL];
                
                _signTypeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_signTypeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _signTypeBtn.tag = 2;
                [self.contentView addSubview:_signTypeBtn];
                break;
            }
            
            case 3:
            {
                _signNumL = label;
                [self.contentView addSubview:_signNumL];
                
                _signNumTF = tf;
                _signNumTF.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                [self.contentView addSubview:_signNumTF];
                break;
            }
            case 4:
            {
                
                _priceL = label;
                [self.contentView addSubview:_priceL];
                
                _priceTF = tf;
                _priceTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                [self.contentView addSubview:_priceTF];
                
                break;
            }
            case 5:
            {
                
                _openTimeL = label;
                [self.contentView addSubview:_openTimeL];
                
                _openTimeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_openTimeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _openTimeBtn.tag = 5;
                [self.contentView addSubview:_openTimeBtn];
                break;
            }
            case 6:
            {
                
                _signTimeL = label;
                [self.contentView addSubview:_signTimeL];
                
                _signTimeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_signTimeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _signTimeBtn.tag = 6;
                [self.contentView addSubview:_signTimeBtn];
                break;
            }
            case 7:
            {
                
                _remindTimeL = label;
                [self.contentView addSubview:_remindTimeL];
                
                _remindTimeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_remindTimeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _remindTimeBtn.tag = 7;
                [self.contentView addSubview:_remindTimeBtn];
                break;
            }
            case 8:
            {
                
                _rentTimeBeginL = label;
                [self.contentView addSubview:_rentTimeBeginL];
                
                _rentTimeBeginBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_rentTimeBeginBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _rentTimeBeginBtn.tag = 8;
                [self.contentView addSubview:_rentTimeBeginBtn];
                break;
            }
            case 9:
            {
                
                _rentTimePeriodL = label;
                [self.contentView addSubview:_rentTimePeriodL];
                
                _rentTimePeriodTF = tf;
                _rentTimePeriodTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                [self.contentView addSubview:_rentTimePeriodTF];
                
                break;
            }
            case 10:
            {
                
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                
                _payWayBtn1 = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
                [_payWayBtn1 addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _payWayBtn1.tag = 10;
                [self.contentView addSubview:_payWayBtn1];
                
                _payWayBtn2 = [[DropBtn alloc] initWithFrame:_payWayBtn1.frame];
                [_payWayBtn2 addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _payWayBtn2.tag = 11;
                [self.contentView addSubview:_payWayBtn2];
                break;
            }
            case 11:
            {
                
                _depositL = label;
                [self.contentView addSubview:_depositL];
                
                _depositTF = tf;
                _depositTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                [self.contentView addSubview:_depositTF];
                break;
            }
            default:
                break;
        }
    }
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self.contentView).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_signerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_signerTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_signTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_signerTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_signTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_signerTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_signNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_signTypeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_signNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_signTypeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_signNumTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_signNumTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_openTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_openTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_signTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_openTimeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_signTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_openTimeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_remindTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_signTimeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_remindTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_signTimeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_rentTimeBeginL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_remindTimeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_rentTimeBeginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_remindTimeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_rentTimePeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_rentTimeBeginBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_rentTimePeriodTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_rentTimeBeginBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_rentTimePeriodTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payWayBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_rentTimePeriodTF
                         .mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payWayBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(218 *SIZE);
        make.top.equalTo(self->_rentTimePeriodTF
                         .mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_depositL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_payWayBtn1.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_depositTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_payWayBtn1.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
}

@end
