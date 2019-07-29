//
//  SincerityChangeView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SincerityChangeView.h"

@interface SincerityChangeView ()<UITextFieldDelegate>

@end

@implementation SincerityChangeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        _dataArr = [@[] mutableCopy];
//        _selectArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    
    self.backgroundColor = CLWhiteColor;
    
    NSArray *titleArr = @[@"原诚意金：",@"变跟诚意金：",@"审批流程：",@"流程类型：",@"项目角色：",@"审核人员："];
    for (int i = 0; i < titleArr.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = titleArr[i];
        
        if (i == 0) {
            
            _originL = label;
            [self addSubview:_originL];
            
            _originTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            _originTF.userInteractionEnabled = NO;
            _originTF.backgroundColor = CLBackColor;
            [self addSubview:_originTF];
        }else if(i == 1){
            
            _sinceL = label;
            [self addSubview:_sinceL];
            
            _sinceTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            _sinceTF.textField.keyboardType = UIKeyboardTypeNumberPad;
            _sinceTF.textField.delegate = self;
            [self addSubview:_sinceTF];
        }else if(i == 2){
            
            _typeL = label;
            [self addSubview:_typeL];
            
            _typeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_typeBtn addTarget:self action:@selector(ActionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_typeBtn];
        }else if(i == 3){
            
            _auditL = label;
            _auditL.hidden = YES;
            [self addSubview:_auditL];
            
            _auditBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_auditBtn addTarget:self action:@selector(ActionAuditBtn:) forControlEvents:UIControlEventTouchUpInside];
            _auditBtn.hidden = YES;
            [self addSubview:_auditBtn];
        }else if(i == 4){
            
            _roleL = label;
            _roleL.hidden = YES;
            [self addSubview:_roleL];
            
            _roleBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_roleBtn addTarget:self action:@selector(ActionRoleBtn:) forControlEvents:UIControlEventTouchUpInside];
            _roleBtn.hidden = YES;
            [self addSubview:_roleBtn];
        }else if(i == 5){
            
            _personL = label;
            _personL.hidden = YES;
            [self addSubview:_personL];
            
            _personBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_personBtn addTarget:self action:@selector(ActionPersonBtn:) forControlEvents:UIControlEventTouchUpInside];
            _personBtn.hidden = YES;
            [self addSubview:_personBtn];
        }
    }
    
    [_originL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_originTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_sinceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_originTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_sinceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_originTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_sinceTF.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_sinceTF.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self).offset(-10 *SIZE);
    }];
    
    [_auditL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_auditBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_roleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_auditBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_roleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_auditBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_personL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_roleBtn.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_roleBtn.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
}

@end
