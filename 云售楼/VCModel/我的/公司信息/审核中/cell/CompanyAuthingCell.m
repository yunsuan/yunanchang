//
//  CompanyAuthingCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CompanyAuthingCell.h"

@implementation CompanyAuthingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = CLWhiteColor;
    _backView.layer.cornerRadius = 3 *SIZE;
    [self.contentView addSubview:_backView];
    
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CL86Color;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        
        switch (i) {
            case 0:
            {
                _companyL = label;
                _companyL.font = [UIFont boldSystemFontOfSize:13 *SIZE];
                _companyL.textColor = CLTitleLabColor;
                [_backView addSubview:_companyL];
                break;
            }
            case 1:{
                
                _statusL = label;
                _statusL.textColor = CLOrangeColor;
                _statusL.textAlignment = NSTextAlignmentRight;
                [_backView addSubview:_statusL];
                break;
            }
            case 2:{
                
                _departL = label;
                [_backView addSubview:_departL];
                break;
            }
            case 3:{
                
                _positionL = label;
                [_backView addSubview:_positionL];
                break;
            }
            case 4:{
                
                _roleL = label;
                [_backView addSubview:_roleL];
                break;
            }
            case 5:{
                
                _timeL = label;
                [_backView addSubview:_timeL];
                break;
            }
            default:
                break;
        }
    }
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-7 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(10 *SIZE);
        make.top.equalTo(self->_backView).offset(19 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_backView).offset(-19 *SIZE);
        make.top.equalTo(self->_backView).offset(19 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_departL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(10 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
    }];
    
    [_positionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(10 *SIZE);
        make.top.equalTo(self->_departL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
    }];
    
    [_roleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(10 *SIZE);
        make.top.equalTo(self->_positionL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(10 *SIZE);
        make.top.equalTo(self->_roleL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.bottom.equalTo(self->_backView).offset(-18 *SIZE);
    }];
}

@end
