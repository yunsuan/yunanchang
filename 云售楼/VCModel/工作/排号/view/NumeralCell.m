
//
//  NumeralCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/1.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NumeralCell.h"

@implementation NumeralCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _titleL.text = @"一批次";
    _customL.text = @"任志远";
    _numL.text = [NSString stringWithFormat:@"组别人数：%@",@"2"];
    _timeL.text = @"2019-12-2";
    _consultantL.text = [NSString stringWithFormat:@"置业顾问：%@",@"温嘉琪"];
    _statusL.text = @"作废";
    _auditL.text = @"已审核";
    _payL.text = @"已收款";
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImg];
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                
                _titleL = label;
                [self.contentView addSubview:_titleL];
                break;
            }
            case 1:
            {
                
                _customL = label;
                [self.contentView addSubview:_customL];
                break;
            }
            case 2:
            {
                
                _numL = label;
                [self.contentView addSubview:_numL];
                break;
            }
            case 3:
            {
                
                _timeL = label;
                _timeL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_timeL];
                break;
            }
            case 4:
            {
                
                _consultantL = label;
                _consultantL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_consultantL];
                break;
            }
            case 5:
            {
                
                _statusL = label;
                _statusL.textColor = CLWhiteColor;
                _statusL.textAlignment = NSTextAlignmentCenter;
                _statusL.backgroundColor = CLBlueBtnColor;
                _statusL.font = FONT(11 *SIZE);
                [self.contentView addSubview:_statusL];
                break;
            }
            case 6:
            {
                
                _auditL = label;
                _auditL.textColor = CLWhiteColor;
                _auditL.textAlignment = NSTextAlignmentCenter;
                _auditL.backgroundColor = CLLineColor;
                _auditL.font = FONT(11 *SIZE);
                [self.contentView addSubview:_auditL];
                break;
            }
            case 7:
            {
                
                _payL = label;
                _payL.textColor = CLWhiteColor;
                _payL.textAlignment = NSTextAlignmentCenter;
                _payL.backgroundColor = CLOrangeColor;
                _payL.font = FONT(11 *SIZE);
                [self.contentView addSubview:_payL];
                break;
            }
            default:
                break;
        }
    }
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.width.height.mas_equalTo(70 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_customL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-200 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.top.equalTo(self->_customL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_consultantL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(self->_customL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_auditL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_payL.mas_left).offset(-5 *SIZE);
        make.top.equalTo(self->_customL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_auditL.mas_left).offset(-5 *SIZE);
        make.top.equalTo(self->_customL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
