//
//  SaleDetailCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/21.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SaleDetailCell.h"

@implementation SaleDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _statisticsL = [[UILabel alloc] init];
    _statisticsL.textColor = CLContentLabColor;
    _statisticsL.font = [UIFont systemFontOfSize:13 *SIZE];
    _statisticsL.adjustsFontSizeToFitWidth = YES;
    _statisticsL.textAlignment = NSTextAlignmentCenter;
    _statisticsL.numberOfLines = 0;
    [self.contentView addSubview:_statisticsL];
    
    _numL1 = [[UILabel alloc] init];
    _numL1.textColor = CLContentLabColor;
    _numL1.font = [UIFont systemFontOfSize:13 *SIZE];
    _numL1.adjustsFontSizeToFitWidth = YES;
    _numL1.textAlignment = NSTextAlignmentCenter;
    _numL1.numberOfLines = 0;
    [self.contentView addSubview:_numL1];
    
    _numL2 = [[UILabel alloc] init];
    _numL2.textColor = CLContentLabColor;
    _numL2.font = [UIFont systemFontOfSize:13 *SIZE];
    _numL2.adjustsFontSizeToFitWidth = YES;
    _numL2.textAlignment = NSTextAlignmentCenter;
    _numL2.numberOfLines = 0;
    [self.contentView addSubview:_numL2];
    
    _numL3 = [[UILabel alloc] init];
    _numL3.textColor = CLContentLabColor;
    _numL3.font = [UIFont systemFontOfSize:13 *SIZE];
    _numL3.adjustsFontSizeToFitWidth = YES;
    _numL3.textAlignment = NSTextAlignmentCenter;
    _numL3.numberOfLines = 0;
    [self.contentView addSubview:_numL3];
    
    for (int i = 0 ; i < 5; i++) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = CLLineColor;
        switch (i) {
            case 0:
            {
                _line1 = line;
                [self.contentView addSubview:_line1];
                break;
            }
            case 1:
            {
                _line2 = line;
                [self.contentView addSubview:_line2];
                break;
            }
            case 2:
            {
                _line3 = line;
                [self.contentView addSubview:_line3];
                break;
            }
            case 3:
            {
                _line4 = line;
                [self.contentView addSubview:_line4];
                break;
            }
            default:
                break;
        }
    }
    
    [_statisticsL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_offset(90 *SIZE);
        make.bottom.equalTo(self->_line4.mas_top).offset(0 *SIZE);
    }];
    
    [_numL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(70 *SIZE);
        make.bottom.equalTo(self->_line4.mas_top).offset(-9 *SIZE);
    }];
    
    [_numL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(190 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(70 *SIZE);
        make.bottom.equalTo(self->_line4.mas_top).offset(-9 *SIZE);
    }];
    
    [_numL3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(280 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(70 *SIZE);
        make.bottom.equalTo(self->_line4.mas_top).offset(-9 *SIZE);
    }];

    
    [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self->_statisticsL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(90 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(270 *SIZE);
        make.width.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
