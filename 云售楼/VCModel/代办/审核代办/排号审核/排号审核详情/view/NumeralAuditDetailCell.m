//
//  NumeralAuditDetailCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NumeralAuditDetailCell.h"

@implementation NumeralAuditDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = @"客户姓名：张女士";
    _roomL.text = @"";
    _priceL.text = @"诚意金：5000";
    _numL.text = @"排号批次：一批次/住宅/1120";
}

- (void)setOrdDic:(NSMutableDictionary *)ordDic{
    
    _nameL.text = @"客户姓名：张女士";
    _roomL.text = @"房号：4-203";
    _priceL.text = @"诚意金：5000";
    _numL.text = @"排号批次：一批次/住宅/1120";
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImg];
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CL86Color;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        if (i == 0) {
            
            _nameL = label;
            [self.contentView addSubview:_nameL];
        }else if (i == 1){
            
            _roomL = label;
            [self.contentView addSubview:_roomL];
        }else if (i == 2){
            
            _priceL = label;
            [self.contentView addSubview:_priceL];
        }else{
            
            _numL = label;
            [self.contentView addSubview:_numL];
        }
    }
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.height.width.mas_equalTo(67 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(91 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(238 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-19 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(91 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-19 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(91 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-19 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-15 *SIZE);
    }];
}
@end
