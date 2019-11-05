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

- (void)ActionTimeBtn:(UIButton *)btn{
    
    if (self.addIntentStoreIntentViewTimeBlock) {

        self.addIntentStoreIntentViewTimeBlock();
    }
}

- (void)ActionPeriodTimeBtn:(UIButton *)btn{
    
    if (self.addIntentStoreIntentViewPeriodBlock) {

        self.addIntentStoreIntentViewPeriodBlock();
    }
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
                
                _intentPeriodLBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_intentPeriodLBtn addTarget:self action:@selector(ActionPeriodTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_intentPeriodLBtn];
                break;
            }
            
            case 3:
            {
                _timeL = label;
                [self addSubview:_timeL];
                
                _timeBtn = [[DropBtn alloc] initWithFrame:tf.frame];
                [_intentPeriodLBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
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
    
    [_intentPeriodLBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_sincerityTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_intentPeriodLBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_intentPeriodLBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self).offset(-10 *SIZE);
    }];
}
@end
