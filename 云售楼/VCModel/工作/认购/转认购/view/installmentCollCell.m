//
//  installmentCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "installmentCollCell.h"

@interface installmentCollCell ()<UITextFieldDelegate>

@end

@implementation installmentCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}

- (void)initUI{
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(10 *SIZE, 5 *SIZE, 100 *SIZE, 15 *SIZE);
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setTitle:@"分期付款" forState:UIControlStateNormal];
    [_addBtn setImage:IMAGE_WITH_NAME(@"") forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20 *SIZE, 20 *SIZE + i * 40 *SIZE, 60 *SIZE, 10 *SIZE)];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.textAlignment = NSTextAlignmentRight;
        if (i == 0) {
            
            label.text = @"交款日期：";
            [self.contentView addSubview:label];
            
            _timeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 20 *SIZE, 258 *SIZE, 33 *SIZE)];
            [_timeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_timeBtn];
        }else{
            
            label.text = @"付款金额：";
            [self.contentView addSubview:label];
            
            _payTF = [[BorderTextField alloc] initWithFrame:CGRectMake(80 *SIZE, 50 *SIZE *SIZE, 258 *SIZE, 33 *SIZE)];
            _payTF.textField.delegate = self;
            [self.contentView addSubview:_payTF];
        }
    }
}

@end
