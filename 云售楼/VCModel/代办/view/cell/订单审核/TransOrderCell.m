//
//  TransOrderCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "TransOrderCell.h"

@implementation TransOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAuditBtn:(UIButton *)btn{
    
    if (self.transOrderCellAuditBlock) {
        
        self.transOrderCellAuditBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if ([dataDic[@"is_read"] integerValue] == 0) {
        
        _readImg.image = IMAGE_WITH_NAME(@"SMS");
    }else{
        
        _readImg.image = IMAGE_WITH_NAME(@"");
    }
    _titleL.text = @"定单审核";
    _nameL.text = [NSString stringWithFormat:@"客户姓名：%@",dataDic[@"client_name"]];
    _projectL.text =  [NSString stringWithFormat:@"项目名称：%@",dataDic[@"project_name"]];
//    _batchL.text = [NSString stringWithFormat:@"排号批次：%@",dataDic[@"batchInfo"]];
    _roomL.text = [NSString stringWithFormat:@"房间号码：%@",dataDic[@"houseInfo"]];
    _desipotL.text = [NSString stringWithFormat:@"诚意金：%@",dataDic[@"down_pay"]];
    _allPriceL.text = [NSString stringWithFormat:@"公示总价：%@",dataDic[@"sub_total_price"]];
    _donePriceL.text = [NSString stringWithFormat:@"成交总价：%@",dataDic[@"total_price"]];
    _payWayL.text = [NSString stringWithFormat:@"付款方式：%@",dataDic[@"pay_way"]];
    _consultantL.text = [NSString stringWithFormat:@"职业顾问：%@",dataDic[@"sign_agent_name"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLLineColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    _headImg = [[UIImageView alloc] init];
    _headImg.image = IMAGE_WITH_NAME(@"laidian");
    [_whiteView addSubview:_headImg];
    
    _readImg = [[UIImageView alloc] init];
    _readImg.image = IMAGE_WITH_NAME(@"SMS");
    [_whiteView addSubview:_readImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [_whiteView addSubview:_titleL];
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        
        switch (i) {
            case 0:
            {
                _projectL = label;
                [_whiteView addSubview:_projectL];
                break;
            }
            case 1:
            {
                _nameL = label;
                [_whiteView addSubview:_nameL];
                break;
            }
            case 2:
            {
                _roomL = label;
                [_whiteView addSubview:_roomL];
                break;
            }
            case 3:
            {
                _desipotL = label;
                [_whiteView addSubview:_desipotL];
                break;
            }
            case 4:
            {
                _allPriceL = label;
                [_whiteView addSubview:_allPriceL];
                break;
            }
            case 5:
            {
                _donePriceL = label;
                [_whiteView addSubview:_donePriceL];
                break;
            }
            case 6:
            {
                _payWayL = label;
                [_whiteView addSubview:_payWayL];
                break;
            }
            case 7:
            {
                _consultantL = label;
                [_whiteView addSubview:_consultantL];
                break;
            }
            default:
                break;
        }
    }
    
    
    _auditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _auditBtn.layer.cornerRadius = 2 *SIZE;
    _auditBtn.layer.borderWidth = SIZE;
    _auditBtn.layer.borderColor = CLBlueBtnColor.CGColor;
    _auditBtn.clipsToBounds = YES;
    _auditBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_auditBtn addTarget:self action:@selector(ActionAuditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_auditBtn setTitle:@"审核" forState:UIControlStateNormal];
    [_auditBtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
    [_whiteView addSubview:_auditBtn];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(3 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(354 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(5 *SIZE);
        make.top.equalTo(self->_whiteView).offset(11 *SIZE);
        make.width.height.mas_equalTo(51 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(63 *SIZE);
        make.top.equalTo(self->_whiteView).offset(30 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_readImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView.mas_right).offset(-7 *SIZE);
        make.top.equalTo(self->_whiteView).offset(31 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(7 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_projectL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
//    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
//        make.top.equalTo(self->_batchL.mas_bottom).offset(8 *SIZE);
//        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
//    }];
    
    [_desipotL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_roomL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_allPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_desipotL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_donePriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_allPriceL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_donePriceL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_consultantL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_payWayL.mas_bottom).offset(8 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
        make.bottom.equalTo(self->_whiteView).offset(-18 *SIZE);
    }];
    
    [_auditBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_whiteView.mas_right).offset(-8 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-15 *SIZE);
        make.width.mas_equalTo(73 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
}

@end
