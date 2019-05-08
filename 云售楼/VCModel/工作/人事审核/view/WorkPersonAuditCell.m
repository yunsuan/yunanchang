//
//  WorkPersonAuditCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkPersonAuditCell.h"

@implementation WorkPersonAuditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionRefuseBtn:(UIButton *)btn{
    
    
}

- (void)ActionAgreeBtn:(UIButton *)btn{
    
    
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = @"张三";
    _phoneL.text = @"1598232123";
    _roleL.text = @"申请角色：云算公馆-销售秘书";
    _timeL.text = @"2018.9.23";
}

- (void)initUI{
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CL86Color;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        switch (i) {
            case 0:
            {
                label.font = [UIFont boldSystemFontOfSize:15 *SIZE];
                _nameL = label;
                [self.contentView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _phoneL = label;
                [self.contentView addSubview:_phoneL];
                break;
            }
            case 2:
            {
                _roleL = label;
                [self.contentView addSubview:_roleL];
                break;
            }
            case 3:
            {
                _timeL = label;
                _timeL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_timeL];
                break;
            }
            default:
                break;
        }
    }
    
    _genderImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_genderImg];
    
    _refuseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _refuseBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_refuseBtn addTarget:self action:@selector(ActionRefuseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [_refuseBtn setBackgroundColor:CLBlueBtnColor];
    _refuseBtn.layer.cornerRadius = 2 *SIZE;
    _refuseBtn.clipsToBounds = YES;
    [self.contentView addSubview:_refuseBtn];
    
    _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _agreeBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_agreeBtn addTarget:self action:@selector(ActionAgreeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [_agreeBtn setBackgroundColor:CLOrangeColor];
    _agreeBtn.layer.cornerRadius = 2 *SIZE;
    _agreeBtn.clipsToBounds = YES;
    [self.contentView addSubview:_agreeBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(21 *SIZE);
        make.width.mas_greaterThanOrEqualTo(200 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nameL.mas_right).offset(5 *SIZE);
        make.top.equalTo(self.contentView).offset(22 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(11 *SIZE);
        make.width.mas_greaterThanOrEqualTo(200 *SIZE);
    }];
    
    [_roleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_phoneL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(200 *SIZE);
    }];
    
    [_agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-11 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_refuseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-68 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-11 *SIZE);
        make.top.equalTo(self->_agreeBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_roleL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(1 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
