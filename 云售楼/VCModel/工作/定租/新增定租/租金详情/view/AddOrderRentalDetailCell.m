//
//  AddOrderRentalDetailCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddOrderRentalDetailCell.h"

@implementation AddOrderRentalDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.addOrderRentalDetailCellBlock) {
        
        self.addOrderRentalDetailCellBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _timeL.text = [NSString stringWithFormat:@"计价起止时间：%@至%@",dataDic[@"stage_start_time"],dataDic[@"stage_end_time"]];
    _rentL.text = [NSString stringWithFormat:@"免租期起止时间：%@",dataDic[@"free_rent"]];
    _originL.text = [NSString stringWithFormat:@"计算金额：%@",dataDic[@"total_rent"]];
    _resultL.text = [NSString stringWithFormat:@"实际金额：%@",dataDic[@"total_rent"]];
    _markL.text = [NSString stringWithFormat:@"备注：%@",dataDic[@"comment"]];
    _payTimeL.text = [NSString stringWithFormat:@"交款时间：%@",dataDic[@"pay_time"]];
    _remindL.text = [NSString stringWithFormat:@"提醒时间：%@",dataDic[@"remind_time"]];
    _unitL.text = [NSString stringWithFormat:@"单价：%@",dataDic[@"unit_rent"]];
}

- (void)initUI{
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.numberOfLines = 0;
        label.font = FONT(13 *SIZE);
        if (i == 0) {
            
            _timeL = label;
            [self.contentView addSubview:_timeL];
        }else if (i == 1){
            
            _rentL = label;
            [self.contentView addSubview:_rentL];
        }else if (i == 2){
            
            _originL = label;
            [self.contentView addSubview:_originL];
        }else if (i == 3){
            
            _resultL = label;
            [self.contentView addSubview:_resultL];
        }else if (i == 4){
            
            _markL = label;
            [self.contentView addSubview:_markL];
        }else if (i == 5){
            
            _payTimeL = label;
            [self.contentView addSubview:_payTimeL];
        }else if (i == 6){
            
            _unitL = label;
            [self.contentView addSubview:_unitL];
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
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_rentL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];

    [_unitL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_rentL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];

    [_originL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(170 *SIZE);
        make.top.equalTo(self->_rentL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_resultL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_unitL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(330 *SIZE);
    }];
    
    [_payTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(170 *SIZE);
        make.top.equalTo(self->_unitL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_remindL mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self->_resultL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
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
