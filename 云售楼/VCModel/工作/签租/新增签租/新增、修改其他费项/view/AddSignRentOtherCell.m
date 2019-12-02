
//
//  AddSignRentOtherCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/22.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddSignRentOtherCell.h"

@implementation AddSignRentOtherCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.addSignRentOtherCellBlock) {
        
        self.addSignRentOtherCellBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = [NSString stringWithFormat:@"费项名称：%@",dataDic[@"name"]];
    _typeL.text = [NSString stringWithFormat:@"费项类别：%@元",dataDic[@"config_name"]];
    _totalL.text = [NSString stringWithFormat:@"费项金额：%@元",dataDic[@"total_cost"]];
    _markL.text = [NSString stringWithFormat:@"备注：%@",dataDic[@"comment"]];
    _payTimeL.text = [NSString stringWithFormat:@"交款时间：%@",dataDic[@"pay_time"]];
    _remindL.text = [NSString stringWithFormat:@"提醒时间：%@",dataDic[@"remind_time"]];
}

- (void)initUI{
    
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.numberOfLines = 0;
        label.font = FONT(13 *SIZE);
        if (i == 0) {
            
            _nameL = label;
            [self.contentView addSubview:_nameL];
        }else if (i == 1){
            
            _typeL = label;
            [self.contentView addSubview:_typeL];
        }else if (i == 2){
            
            _totalL = label;
            [self.contentView addSubview:_totalL];
        }else if (i == 3){
            
            _markL = label;
            [self.contentView addSubview:_markL];
        }else if (i == 4){
            
            _payTimeL = label;
            [self.contentView addSubview:_payTimeL];
        }else{
            
            _remindL = label;
            [self.contentView addSubview:_remindL];
        }
    }
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:[UIImage imageNamed:@"editor_2"] forState:UIControlStateNormal];
    [self.contentView addSubview:_editBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(170 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_totalL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_payTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_totalL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_remindL mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_payTimeL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    //        make.bottom.equalTo(self.contentView).offset(-12 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_remindL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_markL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(1 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-0 *SIZE);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.width.mas_equalTo(30 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
}

@end
