//
//  AddNumeralInfoView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddNumeralInfoView.h"

@interface AddNumeralInfoView ()<UITextFieldDelegate>
{
    
    NSMutableArray *_cateArr;
}

@end

@implementation AddNumeralInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setTypeArr:(NSMutableArray *)typeArr{
    
    _cateArr = [[NSMutableArray alloc] initWithArray:typeArr];
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _typeBtn.content.text = dataDic[@"config_name"];
    _typeBtn->str = dataDic[@"config_id"];
    _numTF.textField.text = dataDic[@"row_code"];
    _freeTF.textField.text = dataDic[@"sincerity"];
    _infoTimeBtn.content.text = dataDic[@"row_time"];
    _failTimeBtn.content.text = dataDic[@"end_time"];
}

- (void)ActionTypeBtn:(UIButton *)btn{
    
    if (self.addNumeralInfoViewDropBlock) {
        
        self.addNumeralInfoViewDropBlock();
    }
}

- (void)ActionInfoTimeBtn:(UIButton *)btn{
    
    if (self.addNumeralInfoViewInfoTimeBlock) {
        
        self.addNumeralInfoViewInfoTimeBlock();
    }
}

- (void)ActionFailTimeBtn:(UIButton *)btn{
    
    if (self.addNumeralInfoViewFailTimeBlock) {
        
        self.addNumeralInfoViewFailTimeBlock();
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.addNumeralInfoViewStrBlock) {
        
        self.addNumeralInfoViewStrBlock(textField.text, textField.tag);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _numTF.textField) {
        
        return [self validateNumber:string];
    }else if (textField == _freeTF.textField){
        
        return [self validateNumber:string];
    }else{
        
        return YES;
    }
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;
    
    NSArray *titleArr = @[@"项目名称：",@"排号类别：",@"排号号码：",@"诚意金：",@"排号时间：",@"失效时间："];
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = titleArr[i];
        
        if (i == 1) {
            
            _typeL = label;
            [self addSubview:_typeL];
            
            _typeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_typeBtn addTarget:self action:@selector(ActionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_typeBtn];
        }else{
            
            BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            tf.textField.tag = i;
            tf.textField.delegate = self;
            if (i == 0) {
                
                _nameL = label;
                [self addSubview:_nameL];
                
                _nameTF = tf;
                _nameTF.userInteractionEnabled = NO;
                _nameTF.backgroundColor = CLBackColor;
                [self addSubview:_nameTF];
            }else if (i == 2){
                
                _numL = label;
                [self addSubview:_numL];
                
                _numTF = tf;
                _numTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                [self addSubview:_numTF];
            }else if (i == 3){
                
                _freeL = label;
                [self addSubview:_freeL];
                
                _freeTF = tf;
                _freeTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                [self addSubview:_freeTF];
            }else if (i == 4){
                
                _infoTimeL = label;
                [self addSubview:_infoTimeL];
                
                _infoTimeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
                [_infoTimeBtn addTarget:self action:@selector(ActionInfoTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_infoTimeBtn];
            }else{
                
                _failTimeL = label;
                [self addSubview:_failTimeL];
                
                _failTimeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
                [_failTimeBtn addTarget:self action:@selector(ActionFailTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_failTimeBtn];
            }
        }
    }
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_numTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_freeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_numTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_freeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_numTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_infoTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_freeTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_infoTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_freeTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_failTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_infoTimeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_failTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_infoTimeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self).offset(-10 *SIZE);
    }];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

@end
