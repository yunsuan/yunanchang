//
//  CommissReportCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CommissReportCell.h"

@implementation CommissReportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _companyL = [[UILabel alloc] init];
    _companyL.textColor = CLContentLabColor;
    _companyL.font = [UIFont systemFontOfSize:13 *SIZE];
    _companyL.adjustsFontSizeToFitWidth = YES;
    _companyL.numberOfLines = 0;
    _companyL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_companyL];
    
//    _contactL = [[UILabel alloc] init];
//    _contactL.textColor = CLContentLabColor;
//    _contactL.font = [UIFont systemFontOfSize:13 *SIZE];
//    _contactL.adjustsFontSizeToFitWidth = YES;
//    _contactL.numberOfLines = 0;
//    _contactL.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:_contactL];
//
//    _phoneL = [[UILabel alloc] init];
//    _phoneL.textColor = CLContentLabColor;
//    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
//    _phoneL.adjustsFontSizeToFitWidth = YES;
//    _phoneL.numberOfLines = 0;
//    _phoneL.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:_phoneL];
    
    _moneyL = [[UILabel alloc] init];
    _moneyL.textColor = CLContentLabColor;
    _moneyL.font = [UIFont systemFontOfSize:13 *SIZE];
    _moneyL.adjustsFontSizeToFitWidth = YES;
    _moneyL.numberOfLines = 0;
    _moneyL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_moneyL];
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = CLContentLabColor;
    _numL.font = [UIFont systemFontOfSize:13 *SIZE];
    _numL.adjustsFontSizeToFitWidth = YES;
    _numL.numberOfLines = 0;
    _numL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_numL];
    
    for (int i = 0 ; i < 5; i++) {
        
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
//                _line3 = line;
//                [self.contentView addSubview:_line3];
                break;
            }
            case 4:
            {
//                _line4 = line;
//                [self.contentView addSubview:_line4];
                break;
            }
            default:
                break;
        }
    }
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(140 *SIZE);
        make.height.mas_greaterThanOrEqualTo(20 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
    }];
    
//    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(170 *SIZE);
//        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.width.mas_offset(100 *SIZE);
//        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
////        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
//    }];
//
//    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(290 *SIZE);
//        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.width.mas_offset(100 *SIZE);
//        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
////        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
//    }];
    
    [_moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(170 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(100 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(290 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(60 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self->_companyL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE * 5);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(1 *SIZE);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(160 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(280 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
//    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.contentView).offset(0);
//        make.left.equalTo(self.contentView).offset(400 *SIZE);
//        make.width.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//    }];
//
//    [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.contentView).offset(0);
//        make.left.equalTo(self.contentView).offset(520 *SIZE);
//        make.width.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//    }];
}
@end
