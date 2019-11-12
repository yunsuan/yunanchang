//
//  IntentStoreCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "IntentStoreCell.h"

@implementation IntentStoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.intentStoreCellBlock) {
        
        self.intentStoreCellBlock(self.tag);
    }
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _headImg.image = IMAGE_WITH_NAME(@"sjmerchant_1");

    _titleL.text = [NSString stringWithFormat:@"%@",dataDic[@"business_name"]];
    _contractL.text = [NSString stringWithFormat:@"联系人：%@",dataDic[@"contact"]];
    _registerL.text = [NSString stringWithFormat:@"登记号：%@",dataDic[@"row_code"]];
    _buildL.text = [NSString stringWithFormat:@"%@",dataDic[@"name"]];
    _timeL.text = [NSString stringWithFormat:@"%@",dataDic[@"sign_time"]];
    switch ([dataDic[@"disabled_state"] integerValue]) {
     
        case 0:
        {
            _statusL.text = @"有效";
            break;
        }
        case 1:
        {
            _statusL.text = @"变更";
            break;
        }
        case 2:
        {
            _statusL.text = @"作废";
            break;
        }
        case 3:
        {
            _statusL.text = @"定单";
            break;
        }
        case 4:
        {
            _statusL.text = @"转签约";
            break;
        }
        case 5:
        {
            _statusL.text = @"退号";
            break;
        }
        default:
            break;
    }
    switch ([dataDic[@"check_state"] integerValue]) {
            
        case 0:
        {
            _auditL.text = @"不通过";
            break;
        }
        case 1:
        {
            _auditL.text = @"已审核";
            break;
        }
        case 2:
        {
            _auditL.text = @"未审核";
            break;
        }
        case 3:
        {
            _auditL.text = @"审核中";
            break;
        }
        default:
            _auditL.text = @"未审核";
            break;
    }
    _payL.text = [dataDic[@"receive_state"] integerValue] == 1? @"已收款":@"未收款";
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
//                _titleL.numberOfLines = 0;
                [self.contentView addSubview:_titleL];
                break;
            }
            case 1:
            {
                
                _contractL = label;
                _contractL.textAlignment = NSTextAlignmentRight;
//                _customL.adjustsFontSizeToFitWidth = YES;
                [self.contentView addSubview:_contractL];
                break;
            }
            case 2:
            {
                _registerL = label;
                [self.contentView addSubview:_registerL];
                break;
            }
            case 3:
            {
                
                _timeL = label;
                [self.contentView addSubview:_timeL];
                break;
            }
            case 4:
            {
                
                _buildL = label;
                _buildL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_buildL];
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
                _auditL.backgroundColor = [UIColor darkGrayColor];
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
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
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
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_contractL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(215 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        //        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-30 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.height.mas_equalTo(19 *SIZE);
    }];
    
    [_registerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-170 *SIZE);
    }];
    
    [_buildL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(150 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(100 *SIZE);
        make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-170 *SIZE);
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_auditL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_payL.mas_left).offset(-5 *SIZE);
        make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_auditL.mas_left).offset(-5 *SIZE);
        make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
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
