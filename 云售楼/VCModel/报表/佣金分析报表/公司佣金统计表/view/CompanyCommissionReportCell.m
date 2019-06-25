//
//  CompanyCommissionReportCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CompanyCommissionReportCell.h"

@implementation CompanyCommissionReportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = CLContentLabColor;
    _codeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _codeL.adjustsFontSizeToFitWidth = YES;
    _codeL.textAlignment = NSTextAlignmentCenter;
    _codeL.numberOfLines = 0;
    [self.contentView addSubview:_codeL];
    
    _roomL = [[UILabel alloc] init];
    _roomL.textColor = CLContentLabColor;
    _roomL.font = [UIFont systemFontOfSize:13 *SIZE];
    _roomL.adjustsFontSizeToFitWidth = YES;
    _roomL.textAlignment = NSTextAlignmentCenter;
    _roomL.numberOfLines = 0;
    [self.contentView addSubview:_roomL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLContentLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    _nameL.adjustsFontSizeToFitWidth = YES;
    _nameL.textAlignment = NSTextAlignmentCenter;
    _nameL.numberOfLines = 0;
    [self.contentView addSubview:_nameL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = CLContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
    _phoneL.adjustsFontSizeToFitWidth = YES;
    _phoneL.textAlignment = NSTextAlignmentCenter;
    _phoneL.numberOfLines = 0;
    [self.contentView addSubview:_phoneL];
    
    _moneyL = [[UILabel alloc] init];
    _moneyL.textColor = CLContentLabColor;
    _moneyL.font = [UIFont systemFontOfSize:13 *SIZE];
    _moneyL.adjustsFontSizeToFitWidth = YES;
    _moneyL.textAlignment = NSTextAlignmentCenter;
    _moneyL.numberOfLines = 0;
    [self.contentView addSubview:_moneyL];
    
//    _numL = [[UILabel alloc] init];
//    _numL.textColor = CLContentLabColor;
//    _numL.font = [UIFont systemFontOfSize:13 *SIZE];
//    _numL.adjustsFontSizeToFitWidth = YES;
//    _numL.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:_numL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLContentLabColor;
    _typeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _typeL.adjustsFontSizeToFitWidth = YES;
    _typeL.textAlignment = NSTextAlignmentCenter;
    _typeL.numberOfLines = 0;
    [self.contentView addSubview:_typeL];
    
    _ruleL = [[UILabel alloc] init];
    _ruleL.textColor = CLContentLabColor;
    _ruleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _ruleL.adjustsFontSizeToFitWidth = YES;
    _ruleL.textAlignment = NSTextAlignmentCenter;
    _ruleL.numberOfLines = 0;
    [self.contentView addSubview:_ruleL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _timeL.adjustsFontSizeToFitWidth = YES;
    _timeL.textAlignment = NSTextAlignmentCenter;
    _timeL.numberOfLines = 0;
    [self.contentView addSubview:_timeL];
    
    for (int i = 0 ; i < 8; i++) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = CLLineColor;
        switch (i) {
            case 0:
            {
                _line = line;
                [self.contentView addSubview:_line];
                break;
            }
            case 1:
            {
                _line1 = line;
                [self.contentView addSubview:_line1];
                break;
            }
            case 2:
            {
                _line2 = line;
                [self.contentView addSubview:_line2];
                break;
            }
            case 3:
            {
                _line3 = line;
                [self.contentView addSubview:_line3];
                break;
            }
            case 4:
            {
                _line4 = line;
                [self.contentView addSubview:_line4];
                break;
            }
            case 5:
            {
                _line5 = line;
                [self.contentView addSubview:_line5];
                break;
            }
            case 6:
            {
                _line6 = line;
                [self.contentView addSubview:_line6];
                break;
            }
            case 7:
            {
                _line7 = line;
                [self.contentView addSubview:_line7];
                break;
            }
            default:
                break;
        }
    }
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(100 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(130 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(100 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(100 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(370 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(100 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
    }];
    
//    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(490 *SIZE);
//        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.width.mas_offset(100 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
//    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(490 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(100 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
    }];
    
    [_moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(610 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(100 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
    }];
    
    [_ruleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(730 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(100 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(850 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(100 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self->_codeL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE * 5);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(1 *SIZE);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(240 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(360 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(480 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(600 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_line6 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(720 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_line7 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(840 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
