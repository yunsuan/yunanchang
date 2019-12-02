//
//  AddSignRentAreaView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddSignRentAreaView.h"

@interface AddSignRentAreaView ()<UITextFieldDelegate>

@end


@implementation AddSignRentAreaView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.addSignRentAreaViewStrBlock) {

        self.addSignRentAreaViewStrBlock(textField.text);
    }
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (self.addSignRentAreaViewStrBlock) {

        self.addSignRentAreaViewStrBlock(textField.text);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _chargeAreaTF.textField) {
        
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
            
            //小数点后最多能输入两位
            if (isHaveDian) {
                NSRange ran = [textField.text rangeOfString:@"."];
                //由于range.location是NSUInteger类型的，所以不能通过(range.location - ran.location) > 2来判断
                if (range.location > ran.location) {
                    if ([textField.text pathExtension].length > 1) {
                        NSLog(@"小数点后最多有两位小数");
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

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _rentAreaL.text = [NSString stringWithFormat:@"租赁面积：%@",dataDic[@""]];
    _chargeAreaTF.textField.text = dataDic[@""];
    _realAreaL.text = [NSString stringWithFormat:@"实际面积：%@",dataDic[@""]];
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;

    NSArray *titleArr = @[@"租赁面积：",@"差异面积：",@"实际面积："];
    for (int i = 0; i < 3; i++) {
    
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
            
                _rentAreaL = label;
                [self addSubview:_rentAreaL];
                
                break;
            }
            
            case 1:
            {
                _chargeAreaL = label;
                [self addSubview:_chargeAreaL];
                
                _chargeAreaTF = tf;
                [_chargeAreaTF.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                _chargeAreaTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                [self addSubview:_chargeAreaTF];
                break;
            }
            
            case 2:
            {
                
                _realAreaL = label;
                [self addSubview:_realAreaL];

                break;
            }
            default:
                break;
        }
    }
    
    [_rentAreaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_chargeAreaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_rentAreaL.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_chargeAreaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_rentAreaL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_realAreaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_chargeAreaTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
        make.bottom.equalTo(self).offset(-10 *SIZE);
    }];
}

@end
