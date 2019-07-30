//
//  NumeralBackNumView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NumeralBackNumView.h"

@interface NumeralBackNumView ()<UITextFieldDelegate>
{
    
    NSMutableArray *_dataArr;
}

@end

@implementation NumeralBackNumView

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

- (void)setPersonArr:(NSMutableArray *)personArr{
    
    _dataArr = [NSMutableArray arrayWithArray:personArr];
    
}

- (void)ActionTypeBtn:(UIButton *)btn{
    
    if (self.numeralBackNumViewTypeBlock) {
        
        self.numeralBackNumViewTypeBlock();
    }
}

- (void)ActionAuditBtn:(UIButton *)btn{
    
    if (self.numeralBackNumViewAuditBlock) {
        
        self.numeralBackNumViewAuditBlock();
    }
}

- (void)ActionRoleBtn:(UIButton *)btn{
    
    if (self.numeralBackNumViewRoleBlock) {
        
        self.numeralBackNumViewRoleBlock();
    }
}

- (void)ActionPersonBtn:(UIButton *)btn{
    
    if (self.numeralBackNumViewPersonBlock) {
        
        self.numeralBackNumViewPersonBlock();
    }
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    
    _typeBtn.content.text = dataDic[@"progress_name"];
    
    _roleBtn.content.text = dataDic[@"role_name"];
    _roleBtn->str = dataDic[@"role_id"];
    
    _auditBtn.content.text = dataDic[@"auditMC"];
    _auditBtn->str = dataDic[@"auditID"];
    
    _personBtn.content.text = dataDic[@"person_name"];
    _personBtn->str = dataDic[@"person_id"];
    
    if ([dataDic[@"check_type"] integerValue] == 3) {
        
        _auditBtn.backgroundColor = CLWhiteColor;
        _auditBtn.userInteractionEnabled = YES;
        
        [_typeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self).offset(9 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        
        if ([dataDic[@"auditMC"] isEqualToString:@"自由流程"]) {
            
            _auditL.hidden = NO;
            _auditBtn.hidden = NO;
            _roleL.hidden = NO;
            _roleBtn.hidden = NO;
            _personL.hidden = NO;
            _personBtn.hidden = NO;
            
            //            _auditBtn.backgroundColor = CLBackColor;
            //            _auditBtn.userInteractionEnabled = NO;
            
            [_auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self).offset(9 *SIZE);
                make.top.equalTo(self->_typeBtn.mas_bottom).offset(12 *SIZE);
                make.width.mas_equalTo(70 *SIZE);
            }];
            
            [_auditBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self).offset(80 *SIZE);
                make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
                make.width.mas_equalTo(258 *SIZE);
                make.height.mas_equalTo(33 *SIZE);
            }];
            
            [_personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self).offset(80 *SIZE);
                make.top.equalTo(self->_roleBtn.mas_bottom).offset(9 *SIZE);
                make.width.mas_equalTo(258 *SIZE);
                make.height.mas_equalTo(33 *SIZE);
                make.bottom.equalTo(self).offset(-20 *SIZE);
            }];
        }else{
            
            _auditL.hidden = NO;
            _auditBtn.hidden = NO;
            
            _roleL.hidden = YES;
            _roleBtn.hidden = YES;
            _personL.hidden = YES;
            _personBtn.hidden = YES;
            
            [_auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self).offset(9 *SIZE);
                make.top.equalTo(self->_typeBtn.mas_bottom).offset(12 *SIZE);
                make.width.mas_equalTo(70 *SIZE);
            }];
            
            [_auditBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self).offset(80 *SIZE);
                make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
                make.width.mas_equalTo(258 *SIZE);
                make.height.mas_equalTo(33 *SIZE);
                make.bottom.equalTo(self).offset(-10 *SIZE);
            }];
            
            [_personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self).offset(80 *SIZE);
                make.top.equalTo(self->_roleBtn.mas_bottom).offset(9 *SIZE);
                make.width.mas_equalTo(258 *SIZE);
                make.height.mas_equalTo(33 *SIZE);
            }];
        }
        
        
    }else if ([dataDic[@"check_type"] integerValue] == 2){
        
        _auditBtn.backgroundColor = CLWhiteColor;
        _auditBtn.userInteractionEnabled = YES;
        
        [_typeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self).offset(9 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            make.bottom.equalTo(self).offset(-10 *SIZE);
        }];
        
        [_personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_roleBtn.mas_bottom).offset(9 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        _auditL.hidden = YES;
        _auditBtn.hidden = YES;
        _roleL.hidden = YES;
        _roleBtn.hidden = YES;
        _personL.hidden = YES;
        _personBtn.hidden = YES;
    }else if ([dataDic[@"check_type"] integerValue] == 1){
        
        _auditL.hidden = NO;
        _auditBtn.hidden = NO;
        _roleL.hidden = NO;
        _roleBtn.hidden = NO;
        _personL.hidden = NO;
        _personBtn.hidden = NO;
        
        _auditBtn.backgroundColor = CLBackColor;
        _auditBtn.userInteractionEnabled = NO;
        
        [_typeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self).offset(9 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(9 *SIZE);
            make.top.equalTo(self->_typeBtn.mas_bottom).offset(12 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];
        
        [_auditBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_typeBtn.mas_bottom).offset(9 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
        
        [_personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(80 *SIZE);
            make.top.equalTo(self->_roleBtn.mas_bottom).offset(9 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
            make.bottom.equalTo(self).offset(-20 *SIZE);
        }];
    }else{
        
        
    }
}


- (void)initUI{
    
    
    self.backgroundColor = CLWhiteColor;
    
    NSArray *titleArr = @[@"审批流程：",@"流程类型：",@"项目角色：",@"审核人员："];
    for (int i = 0; i < titleArr.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = titleArr[i];
        
        if (i == 0) {
            
//            _originL = label;
//            [self addSubview:_originL];
//
//            _originTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
//            _originTF.userInteractionEnabled = NO;
//            _originTF.backgroundColor = CLBackColor;
//            [self addSubview:_originTF];
//        }else if(i == 1){
//
//            _sinceL = label;
//            [self addSubview:_sinceL];
//
//            _sinceTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
//            _sinceTF.textField.keyboardType = UIKeyboardTypeNumberPad;
//            _sinceTF.textField.delegate = self;
//            [self addSubview:_sinceTF];
//        }else if(i == 2){
            
            _typeL = label;
            [self addSubview:_typeL];
            
            _typeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_typeBtn addTarget:self action:@selector(ActionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_typeBtn];
        }else if(i == 1){
            
            _auditL = label;
            _auditL.hidden = YES;
            [self addSubview:_auditL];
            
            _auditBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_auditBtn addTarget:self action:@selector(ActionAuditBtn:) forControlEvents:UIControlEventTouchUpInside];
            _auditBtn.hidden = YES;
            [self addSubview:_auditBtn];
        }else if(i == 2){
            
            _roleL = label;
            _roleL.hidden = YES;
            [self addSubview:_roleL];
            
            _roleBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_roleBtn addTarget:self action:@selector(ActionRoleBtn:) forControlEvents:UIControlEventTouchUpInside];
            _roleBtn.hidden = YES;
            [self addSubview:_roleBtn];
        }else if(i == 3){
            
            _personL = label;
            _personL.hidden = YES;
            [self addSubview:_personL];
            
            _personBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [_personBtn addTarget:self action:@selector(ActionPersonBtn:) forControlEvents:UIControlEventTouchUpInside];
            _personBtn.hidden = YES;
            [self addSubview:_personBtn];
        }
    }

    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self).offset(9 *SIZE);
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
