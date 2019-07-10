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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.addNumeralInfoViewStrBlock) {
        
        self.addNumeralInfoViewStrBlock(textField.text, textField.tag);
    }
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;
    
    NSArray *titleArr = @[@"项目名称：",@"排号类别：",@"排号号码：",@"排号费用："];
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = titleArr[i];
        //        [self addSubview:label];
        
        if (i == 1) {
            
            _typeL = label;
            [self addSubview:_typeL];
            
            _typeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            [self addSubview:_typeBtn];
        }else{
            
            BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            tf.textField.tag = i;
            if (i == 0) {
                
                _nameL = label;
                [self addSubview:_nameL];
                
                _nameTF = tf;
                [self addSubview:_nameTF];
            }else if (i == 2){
                
                _numL = label;
                [self addSubview:_numL];
                
                _numTF = tf;
                [self addSubview:_numTF];
            }else{
                
                _freeL = label;
                [self addSubview:_freeL];
                
                _freeTF = tf;
                [self addSubview:_freeTF];
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
        make.bottom.equalTo(self).offset(-10 *SIZE);
    }];
}

@end
