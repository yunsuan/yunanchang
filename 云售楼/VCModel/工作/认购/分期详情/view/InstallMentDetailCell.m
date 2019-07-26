//
//  InstallMentDetailCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/26.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "InstallMentDetailCell.h"

@implementation InstallMentDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _numL.text = [NSString stringWithFormat:@"第%@期",dataDic[@"id"]];
    _moneyL.text = [NSString stringWithFormat:@"%@元",dataDic[@"pay_money"]];
    _timeL.text = [NSString stringWithFormat:@"%@",dataDic[@"pay_time"]];
    _remindTimeL.text = [NSString stringWithFormat:@"%@",dataDic[@"tip_time"]];
}

- (void)initUI{
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = CLContentLabColor;
    _numL.font = [UIFont systemFontOfSize:13 *SIZE];
    _numL.adjustsFontSizeToFitWidth = YES;
    _numL.numberOfLines = 0;
    _numL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_numL];
    
    _moneyL = [[UILabel alloc] init];
    _moneyL.textColor = CLContentLabColor;
    _moneyL.font = [UIFont systemFontOfSize:13 *SIZE];
    _moneyL.adjustsFontSizeToFitWidth = YES;
    _moneyL.numberOfLines = 0;
    _moneyL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_moneyL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _timeL.adjustsFontSizeToFitWidth = YES;
    _timeL.numberOfLines = 0;
    _timeL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_timeL];
    
    _remindTimeL = [[UILabel alloc] init];
    _remindTimeL.textColor = CLContentLabColor;
    _remindTimeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _remindTimeL.adjustsFontSizeToFitWidth = YES;
    _remindTimeL.numberOfLines = 0;
    _remindTimeL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_remindTimeL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(50 *SIZE);
        make.height.mas_greaterThanOrEqualTo(20 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
    }];
    
    [_moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(70 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(100 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(80 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_remindTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(270 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_offset(80 *SIZE);
        make.bottom.equalTo(self->_line.mas_top).offset(-9 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self->_numL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(120 *SIZE * 5);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(1 *SIZE);
    }];
}

@end
