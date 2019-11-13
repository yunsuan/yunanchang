//
//  AddOrderRentPriceCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/13.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddOrderRentPriceCell.h"

@implementation AddOrderRentPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.addOrderRentPriceCellBlock) {

        self.addOrderRentPriceCellBlock();
    }
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.addOrderRentPriceCellAddBlock) {
        
        self.addOrderRentPriceCellAddBlock();
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
//    _priceL.text = @"实际单价：50元/月/㎡";
    if (dataDic.count) {
        
        _totalL.text = [NSString stringWithFormat:@"%@：%@",self.title,dataDic[@""]];
        _addBtn.hidden = YES;
    }else{
     
        _totalL.text = @" ";
        _addBtn.hidden = NO;
    }
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;

    for (int i = 0; i < 2; i++) {
    
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        
        if (i == 0) {
            
            _priceL = label;
//            [self addSubview:_priceL];
        }else{
            
            _totalL = label;
//            _totalL.hidden = YES;
            _totalL.text = @" ";
            [self.contentView addSubview:_totalL];
        }
    }
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setBackgroundColor:CLOrangeColor];
    [_addBtn setTitle:@"自动生成" forState:UIControlStateNormal];
    [_addBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.titleLabel.font = FONT(13 *SIZE);
    _addBtn.layer.cornerRadius = 15 *SIZE;
    _addBtn.clipsToBounds = YES;
    [self.contentView addSubview:_addBtn];
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:[UIImage imageNamed:@"editor_2"] forState:UIControlStateNormal];
    _editBtn.hidden = YES;
    [self.contentView addSubview:_editBtn];
    
//    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self).offset(12 *SIZE);
//        make.top.equalTo(self).offset(12 *SIZE);
//        make.width.mas_equalTo(300 *SIZE);
//    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_totalL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-12 *SIZE);
    }];
        
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.width.mas_equalTo(30 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
}

@end
