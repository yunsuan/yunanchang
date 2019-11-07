//
//  AddIntentStoreIntentView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddIntentStoreIntentView.h"

@interface AddIntentStoreIntentView ()<UITextFieldDelegate>

@end

@implementation AddIntentStoreIntentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
//    if (textField == _proportionTF.textField) {
//
//        if ([textField.text integerValue] > 100) {
//
//            textField.text = @"100";
//        }
//    }
    if (self.addIntentStoreIntentViewStrBlock) {

        self.addIntentStoreIntentViewStrBlock(textField.text, textField.tag);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _sincerityTF.textField) {
        
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


- (void)ActionTimeBtn:(UIButton *)btn{
    
    if (self.addIntentStoreIntentViewTimeBlock) {

        self.addIntentStoreIntentViewTimeBlock();
    }
}

- (void)ActionPeriodTimeBtn:(UIButton *)btn{
    
    if (self.addIntentStoreIntentViewPeriod1Block) {

        self.addIntentStoreIntentViewPeriod1Block();
    }
}

- (void)ActionPeriodTime2Btn:(UIButton *)btn{
    
    if (self.addIntentStoreIntentViewPeriod2Block) {

        self.addIntentStoreIntentViewPeriod2Block();
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _codeTF.textField.text = dataDic[@"code"];
    _sincerityTF.textField.text = dataDic[@"sincerity"];
    _timeBtn.content.text = dataDic[@"time"];
    _intentPeriodLBtn1.content.text = dataDic[@"min"];
    _intentPeriodLBtn2.content.text = dataDic[@"max"];
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;

    NSArray *titleArr = @[@"意向编号：",@"诚意金：",@"意向租期：",@"登记时间："];
    for (int i = 0; i < 4; i++) {
    
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
                _sincerityL = label;
                [self addSubview:_sincerityL];
                
                _sincerityTF = tf;
                [self addSubview:_sincerityTF];
                break;
            }
            
            case 2:
            {
                
                _intentPeriodL = label;
                [self addSubview:_intentPeriodL];
                
                _intentPeriodLBtn1 = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
                [_intentPeriodLBtn1 addTarget:self action:@selector(ActionPeriodTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_intentPeriodLBtn1];
                break;
            }
            
            case 3:
            {
                _timeL = label;
                [self addSubview:_timeL];
                
                _timeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_timeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_timeBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _intentPeriodLBtn2 = [[DropBtn alloc] initWithFrame:_intentPeriodLBtn1.frame];
    [_intentPeriodLBtn2 addTarget:self action:@selector(ActionPeriodTime2Btn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_intentPeriodLBtn2];
    
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
    
    [_sincerityL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_sincerityTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_intentPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_sincerityTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_intentPeriodLBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_sincerityTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_intentPeriodLBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(218 *SIZE);
        make.top.equalTo(self->_sincerityTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_intentPeriodLBtn1.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_intentPeriodLBtn1.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self).offset(-10 *SIZE);
    }];
}
@end
