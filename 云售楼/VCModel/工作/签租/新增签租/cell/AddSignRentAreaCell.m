//
//  AddSignRentAreaCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/13.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddSignRentAreaCell.h"

@interface AddSignRentAreaCell ()<UITextFieldDelegate>

@end

@implementation AddSignRentAreaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.addSignRentAreaCellStrBlock) {

        self.addSignRentAreaCellStrBlock(textField.text);
    }
}

- (void)textFieldDidChange:(UITextField *)textField{
    
//    if (self.addSignRentAreaCellStrBlock) {
//
//        self.addSignRentAreaCellStrBlock(textField.text);
//    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if (dataDic[@"rentSize"]) {
        
        _rentAreaL.text = [NSString stringWithFormat:@"租赁面积：%@㎡",dataDic[@"rentSize"]];
    }else{
        
        _rentAreaL.text = @"租赁面积：0㎡";
    }
    
    _chargeAreaTF.textField.text = dataDic[@"differ_size"];
    if (dataDic[@"realSize"]) {
        
        _realAreaL.text = [NSString stringWithFormat:@"实际面积：%@㎡",dataDic[@"realSize"]];
    }else{
        
        _realAreaL.text = @"实际面积：0㎡";
    }
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
                [self.contentView addSubview:_rentAreaL];
                
                break;
            }
            
            case 1:
            {
                _chargeAreaL = label;
                [self addSubview:_chargeAreaL];
                
                _chargeAreaTF = tf;
                [_chargeAreaTF.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                [self.contentView addSubview:_chargeAreaTF];
                break;
            }
            
            case 2:
            {
                
                _realAreaL = label;
                [self.contentView addSubview:_realAreaL];

                break;
            }
            default:
                break;
        }
    }
    
    [_rentAreaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_chargeAreaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_rentAreaL.mas_bottom).offset(23 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_chargeAreaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_rentAreaL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_realAreaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_chargeAreaTF.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
}

@end
