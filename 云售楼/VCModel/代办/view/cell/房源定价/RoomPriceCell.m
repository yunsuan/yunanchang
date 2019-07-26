//
//  RoomPriceCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/26.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RoomPriceCell.h"

@implementation RoomPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAuditBtn:(UIButton *)btn{
    
    if (self.roomPriceCellAuditBlock) {
        
        self.roomPriceCellAuditBlock(self.tag);
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if ([dataDic[@"is_read"] integerValue] == 0) {
        
        _readImg.image = IMAGE_WITH_NAME(@"SMS");
    }else{
        
        _readImg.image = IMAGE_WITH_NAME(@"");
    }
    _titleL.text = @"房源定价";
    _nameL.text = [NSString stringWithFormat:@"操作人：%@",dataDic[@"operator"]];
    _projectL.text =  [NSString stringWithFormat:@"项目名称：%@",dataDic[@"project_name"]];
    _infoL.text = [NSString stringWithFormat:@"房源信息：%@",dataDic[@"houseInfo"]];
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
    
    for (int i = 0; i < 3; i++) {
        
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
                _infoL = label;
                [_whiteView addSubview:_infoL];
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
    
    [_infoL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(8 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(8 *SIZE);
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
