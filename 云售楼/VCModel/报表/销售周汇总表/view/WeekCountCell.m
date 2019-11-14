//
//  WeekCountCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/21.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WeekCountCell.h"

@implementation WeekCountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _periodL = [[UILabel alloc] init];
    _periodL.textColor = CLContentLabColor;
    _periodL.font = [UIFont systemFontOfSize:13 *SIZE];
    _periodL.adjustsFontSizeToFitWidth = YES;
    _periodL.textAlignment = NSTextAlignmentCenter;
    _periodL.numberOfLines = 0;
    [self.contentView addSubview:_periodL];
    
    _callL = [[UILabel alloc] init];
    _callL.textColor = CLContentLabColor;
    _callL.font = [UIFont systemFontOfSize:13 *SIZE];
    _callL.adjustsFontSizeToFitWidth = YES;
    _callL.textAlignment = NSTextAlignmentCenter;
    _callL.numberOfLines = 0;
    [self.contentView addSubview:_callL];
    
    _visiitL = [[UILabel alloc] init];
    _visiitL.textColor = CLContentLabColor;
    _visiitL.font = [UIFont systemFontOfSize:13 *SIZE];
    _visiitL.adjustsFontSizeToFitWidth = YES;
    _visiitL.textAlignment = NSTextAlignmentCenter;
    _visiitL.numberOfLines = 0;
    [self.contentView addSubview:_visiitL];
    
    _numeralL = [[UILabel alloc] init];
    _numeralL.textColor = CLContentLabColor;
    _numeralL.font = [UIFont systemFontOfSize:13 *SIZE];
    _numeralL.adjustsFontSizeToFitWidth = YES;
    _numeralL.textAlignment = NSTextAlignmentCenter;
    _numeralL.numberOfLines = 0;
    [self.contentView addSubview:_numeralL];
    
    _orderL = [[UILabel alloc] init];
    _orderL.textColor = CLContentLabColor;
    _orderL.font = [UIFont systemFontOfSize:13 *SIZE];
    _orderL.adjustsFontSizeToFitWidth = YES;
    _orderL.textAlignment = NSTextAlignmentCenter;
    _orderL.numberOfLines = 0;
    [self.contentView addSubview:_orderL];

    _contactL = [[UILabel alloc] init];
    _contactL.textColor = CLContentLabColor;
    _contactL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contactL.adjustsFontSizeToFitWidth = YES;
    _contactL.textAlignment = NSTextAlignmentCenter;
    _contactL.numberOfLines = 0;
    [self.contentView addSubview:_contactL];
    
    _numeralMoneyL = [[UILabel alloc] init];
    _numeralMoneyL.textColor = CLContentLabColor;
    _numeralMoneyL.font = [UIFont systemFontOfSize:13 *SIZE];
    _numeralMoneyL.adjustsFontSizeToFitWidth = YES;
    _numeralMoneyL.textAlignment = NSTextAlignmentCenter;
    _numeralMoneyL.numberOfLines = 0;
    [self.contentView addSubview:_numeralMoneyL];
    
    _orderMoneyL = [[UILabel alloc] init];
    _orderMoneyL.textColor = CLContentLabColor;
    _orderMoneyL.font = [UIFont systemFontOfSize:13 *SIZE];
    _orderMoneyL.adjustsFontSizeToFitWidth = YES;
    _orderMoneyL.textAlignment = NSTextAlignmentCenter;
    _orderMoneyL.numberOfLines = 0;
    [self.contentView addSubview:_orderMoneyL];
    
    _contractMoneyL = [[UILabel alloc] init];
    _contractMoneyL.textColor = CLContentLabColor;
    _contractMoneyL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contractMoneyL.adjustsFontSizeToFitWidth = YES;
    _contractMoneyL.textAlignment = NSTextAlignmentCenter;
    _contractMoneyL.numberOfLines = 0;
    [self.contentView addSubview:_contractMoneyL];
    
    for (int i = 0 ; i < 9; i++) {
        
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
            case 8:
            {
                _line8 = line;
                [self.contentView addSubview:_line8];
                break;
            }
            default:
                break;
        }
    }
    
//    [_periodL mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView).offset(10 *SIZE);
//        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.width.mas_offset(80 *SIZE);
//        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
//    }];
//    
//    [_callL mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView).offset(110 *SIZE);
//        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.width.mas_offset(80 *SIZE);
//        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
//    }];
//    
//    [_visiitL mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView).offset(210 *SIZE);
//        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.width.mas_offset(100 *SIZE);
//        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
//    }];
//    
//    [_numeralL mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView).offset(330 *SIZE);
//        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.width.mas_offset(100 *SIZE);
//        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
//    }];
//    
////    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
////
////        make.left.equalTo(self.contentView).offset(490 *SIZE);
////        make.top.equalTo(self.contentView).offset(10 *SIZE);
////        make.width.mas_offset(100 *SIZE);
////        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
////    }];
//    
//    [_orderL mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView).offset(450 *SIZE);
//        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.width.mas_offset(100 *SIZE);
//        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
//    }];
//    
//    [_moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView).offset(570 *SIZE);
//        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.width.mas_offset(100 *SIZE);
//        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
//    }];
//    
//    [_ruleL mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView).offset(690 *SIZE);
//        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.width.mas_offset(100 *SIZE);
//        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
//    }];
//    
//    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView).offset(810 *SIZE);
//        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.width.mas_offset(100 *SIZE);
//        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
//    }];
//    
//    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView).offset(0);
//        make.top.equalTo(self->_codeL.mas_bottom).offset(9 *SIZE);
//        make.width.mas_equalTo(120 *SIZE * 5);
//        make.height.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(1 *SIZE);
//    }];
//    
//    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.contentView).offset(0);
//        make.left.equalTo(self.contentView).offset(100 *SIZE);
//        make.width.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//    }];
//    
//    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.contentView).offset(0);
//        make.left.equalTo(self.contentView).offset(200 *SIZE);
//        make.width.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//    }];
//    
//    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.contentView).offset(0);
//        make.left.equalTo(self.contentView).offset(320 *SIZE);
//        make.width.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//    }];
//    
//    [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.contentView).offset(0);
//        make.left.equalTo(self.contentView).offset(440 *SIZE);
//        make.width.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//    }];
//    
//    [_line5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.contentView).offset(0);
//        make.left.equalTo(self.contentView).offset(560 *SIZE);
//        make.width.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//    }];
//    
//    [_line6 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.contentView).offset(0);
//        make.left.equalTo(self.contentView).offset(680 *SIZE);
//        make.width.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//    }];
//    
//    [_line7 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.contentView).offset(0);
//        make.left.equalTo(self.contentView).offset(800 *SIZE);
//        make.width.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//    }];
}

@end
