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
    
    _codeTF.textField.text = dataDic[@"codeName"];
    _signerTF.textField.text = dataDic[@"signer"];
    _signTypeBtn.content.text = dataDic[@"typeName"];
    _signTypeBtn->str = dataDic[@"typeId"];
    _signNumTF.textField.text = dataDic[@"signNum"];
    _priceTF.textField.text = dataDic[@"price"];
    _intentPeriodLBtn1.content.text = dataDic[@"min"];
    _intentPeriodLBtn2.content.text = dataDic[@"max"];
    _payWayBtn1.content.text = dataDic[@"payWay"];
    _payWayBtn1->str = dataDic[@"payWayId"];
    _payWayBtn2.content.text = dataDic[@"payWay"];
    _payWayBtn2->str = dataDic[@"payWayId"];
    _timeBtn.content.text = dataDic[@"remindTime"];
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
    }else{
        
        return YES;
    }
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
                if (@available(iOS 10.0, *)) {
                    
                    _signNumTF.textField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
                } else {
                    
                    _signNumTF.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                }
                [self.contentView addSubview:_signNumTF];
                break;
            }
            case 4:
            {
                
                _priceL = label;
                [self.contentView addSubview:_priceL];
                
                _priceTF = tf;
                [self.contentView addSubview:_priceTF];
                
                _intentPeriodLBtn1 = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
                [_intentPeriodLBtn1 addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _intentPeriodLBtn1.tag = 4;
                [self.contentView addSubview:_intentPeriodLBtn1];
                break;
            }
            case 5:
            {
                
                _intentPeriodL = label;
                [self.contentView addSubview:_intentPeriodL];
                
                _intentPeriodLBtn2 = [[DropBtn alloc] initWithFrame:_intentPeriodLBtn1.frame];
                [_intentPeriodLBtn2 addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _intentPeriodLBtn2.tag = 5;
                [self.contentView addSubview:_intentPeriodLBtn2];
                break;
            }
            case 6:
            {
                
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                
                _payWayBtn1 = [[DropBtn alloc] initWithFrame:_intentPeriodLBtn1.frame];
                [_payWayBtn1 addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _payWayBtn1.tag = 6;
                [self.contentView addSubview:_payWayBtn1];
                
                _payWayBtn2 = [[DropBtn alloc] initWithFrame:_intentPeriodLBtn1.frame];
                [_payWayBtn2 addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _payWayBtn2.tag = 8;
                [self.contentView addSubview:_payWayBtn2];
                break;
            }
            case 7:
            {
                
                _timeL = label;
                [self.contentView addSubview:_timeL];
                
                _timeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_timeBtn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
                _timeBtn.tag = 7;
                [self.contentView addSubview:_timeBtn];
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
    
    [_intentPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_intentPeriodLBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_intentPeriodLBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(218 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_intentPeriodLBtn1.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_payWayBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_intentPeriodLBtn1
                         .mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_payWayBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(218 *SIZE);
        make.top.equalTo(self->_intentPeriodLBtn1
                         .mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_payWayBtn1.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_payWayBtn1.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
}

@end
