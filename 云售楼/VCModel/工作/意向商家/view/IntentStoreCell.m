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
    _registerL.text = [NSString stringWithFormat:@"意向编号：%@",dataDic[@"row_code"]];
    if ([dataDic[@"name"] length]) {
        
        _buildL.text = [NSString stringWithFormat:@"%@",dataDic[@"name"]];
    }else{
        
        _buildL.text = @" ";
    }
    
    _timeL.text = [NSString stringWithFormat:@"%@",[dataDic[@"create_time"] componentsSeparatedByString:@" "][0]];
    if (_registerL.bounds.size.height >= _buildL.bounds.size.height) {
        
        [_timeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(100 *SIZE);
            make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(self.contentView).offset(-170 *SIZE);
        }];
        
        [_payL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView).offset(-12 *SIZE);
            make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
        
        [_auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_payL.mas_left).offset(-5 *SIZE);
            make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
        
        [_statusL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_auditL.mas_left).offset(-5 *SIZE);
            make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
    }else{
        
        [_timeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(100 *SIZE);
            make.top.equalTo(self->_buildL.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(self.contentView).offset(-170 *SIZE);
        }];
        
        [_payL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView).offset(-12 *SIZE);
            make.top.equalTo(self->_buildL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
        
        [_auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_payL.mas_left).offset(-5 *SIZE);
            make.top.equalTo(self->_buildL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
        
        [_statusL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_auditL.mas_left).offset(-5 *SIZE);
            make.top.equalTo(self->_buildL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
    }
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
            _statusL.text = @"意向";
            break;
        }
        case 4:
        {
            _statusL.text = @"转定租";
            break;
        }
        case 5:
        {
            _statusL.text = @"转签租";
            break;
        }
        case 6:
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

- (void)setOrderDic:(NSDictionary *)orderDic{
    
    _headImg.image = IMAGE_WITH_NAME(@"sjmerchant_1");

    _titleL.text = [NSString stringWithFormat:@"%@",orderDic[@"business_name"]];
    _contractL.text = [NSString stringWithFormat:@"联系人：%@",orderDic[@"contact"]];
    _registerL.text = [NSString stringWithFormat:@"定租编号：%@",orderDic[@"sub_code"]];
    if ([orderDic[@"shop_name"] length]) {
        
        _buildL.text = [NSString stringWithFormat:@"%@",orderDic[@"shop_name"]];
    }else{
        
        _buildL.text = @" ";
    }
    
    _timeL.text = [NSString stringWithFormat:@"%@",[orderDic[@"create_time"] componentsSeparatedByString:@" "][0]];
    if (_registerL.bounds.size.height >= _buildL.bounds.size.height) {
        
        [_timeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(100 *SIZE);
            make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(self.contentView).offset(-170 *SIZE);
        }];
        
        [_payL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView).offset(-12 *SIZE);
            make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
        
        [_auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_payL.mas_left).offset(-5 *SIZE);
            make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
        
        [_statusL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_auditL.mas_left).offset(-5 *SIZE);
            make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
    }else{
        
        [_timeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(100 *SIZE);
            make.top.equalTo(self->_buildL.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(self.contentView).offset(-170 *SIZE);
        }];
        
        [_payL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView).offset(-12 *SIZE);
            make.top.equalTo(self->_buildL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
        
        [_auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_payL.mas_left).offset(-5 *SIZE);
            make.top.equalTo(self->_buildL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
        
        [_statusL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_auditL.mas_left).offset(-5 *SIZE);
            make.top.equalTo(self->_buildL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
    }
    switch ([orderDic[@"disabled_state"] integerValue]) {
     
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
            _statusL.text = @"意向";
            break;
        }
        case 4:
        {
            _statusL.text = @"转定租";
            break;
        }
        case 5:
        {
            _statusL.text = @"转签租";
            break;
        }
        case 6:
        {
            _statusL.text = @"退号";
            break;
        }
        default:
            break;
    }
    switch ([orderDic[@"check_state"] integerValue]) {
            
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
    _payL.text = [orderDic[@"receive_state"] integerValue] == 1? @"已收款":@"未收款";
}

- (void)setSignDic:(NSDictionary *)signDic{
    
    _headImg.image = IMAGE_WITH_NAME(@"sjmerchant_1");

    _titleL.text = [NSString stringWithFormat:@"%@",signDic[@"business_name"]];
    _contractL.text = [NSString stringWithFormat:@"联系人：%@",signDic[@"contact"]];
    _registerL.text = [NSString stringWithFormat:@"签租编号：%@",signDic[@"contact_code"]];
    if ([signDic[@"shop_name"] length]) {
        
        _buildL.text = [NSString stringWithFormat:@"%@",signDic[@"shop_name"]];
    }else{
        
        _buildL.text = @" ";
    }
    
    _timeL.text = [NSString stringWithFormat:@"%@",[signDic[@"create_time"] componentsSeparatedByString:@" "][0]];
    if (_registerL.bounds.size.height >= _buildL.bounds.size.height) {
        
        [_timeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(100 *SIZE);
            make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(self.contentView).offset(-170 *SIZE);
        }];
        
        [_payL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView).offset(-12 *SIZE);
            make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
        
        [_auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_payL.mas_left).offset(-5 *SIZE);
            make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
        
        [_statusL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_auditL.mas_left).offset(-5 *SIZE);
            make.top.equalTo(self->_registerL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
    }else{
        
        [_timeL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(100 *SIZE);
            make.top.equalTo(self->_buildL.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(self.contentView).offset(-170 *SIZE);
        }];
        
        [_payL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView).offset(-12 *SIZE);
            make.top.equalTo(self->_buildL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
        
        [_auditL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_payL.mas_left).offset(-5 *SIZE);
            make.top.equalTo(self->_buildL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
        
        [_statusL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_auditL.mas_left).offset(-5 *SIZE);
            make.top.equalTo(self->_buildL.mas_bottom).offset(10 *SIZE);
            make.width.mas_equalTo(40 *SIZE);
        }];
    }
    switch ([signDic[@"disabled_state"] integerValue]) {
     
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
            _statusL.text = @"意向";
            break;
        }
        case 4:
        {
            _statusL.text = @"转定租";
            break;
        }
        case 5:
        {
            _statusL.text = @"转签租";
            break;
        }
        case 6:
        {
            _statusL.text = @"退号";
            break;
        }
        default:
            break;
    }
    switch ([signDic[@"check_state"] integerValue]) {
            
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
    _payL.text = [signDic[@"receive_state"] integerValue] == 1? @"已收款":[signDic[@"receive_state"] integerValue] == 2?@"未收款":@"欠款";
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImg];
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.numberOfLines = 2;
//        label.lineBreakMode = nsline
//        label.adjustsFontSizeToFitWidth = YES;
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
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_buildL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(215 *SIZE);
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
        make.top.equalTo(self->_timeL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}


@end
