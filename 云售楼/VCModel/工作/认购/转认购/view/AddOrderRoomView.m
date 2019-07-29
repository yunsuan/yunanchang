//
//  AddOrderRoomView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddOrderRoomView.h"

@implementation AddOrderRoomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.addOrderRoomViewEditBlock) {
        
        self.addOrderRoomViewEditBlock();
    }
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _roomTF.textField.text = dataDic[@"house_name"];
    _buildTF.textField.text = dataDic[@"build_name"];
    _unitTF.textField.text = dataDic[@"unit_name"];
    if (dataDic[@"floor_num"]) {
        
        _floorTF.textField.text = [NSString stringWithFormat:@"%@",dataDic[@"floor_num"]];
    }else{
        
        _floorTF.textField.text = @"";
    }
    
    if (dataDic[@"total_price"]) {
        
        _priceTF.textField.text = [NSString stringWithFormat:@"%@",dataDic[@"total_price"]];
    }else{
        
        _priceTF.textField.text = @"";
    }

    _ruleTF.textField.text = dataDic[@"price_way_name"];
    
    if (dataDic[@"criterion_unit_price"]) {
        
        _unitPriceTF.textField.text = [NSString stringWithFormat:@"%@",dataDic[@"criterion_unit_price"]];
    }else{
        
        _unitPriceTF.textField.text = @"";
    }
    
    if (dataDic[@"total_price"]) {
        
        _totalTF.textField.text = [NSString stringWithFormat:@"%@",dataDic[@"total_price"]];
    }else{
        
        _totalTF.textField.text = @"";
    }
    _propertyTF.textField.text = dataDic[@"property_type"];
    if (dataDic[@"indoor_size"] && ![dataDic[@"estimated_build_size"] isKindOfClass:[NSNull class]]) {
        
        _areaTF.textField.text = [NSString stringWithFormat:@"%@",dataDic[@"estimated_build_size"]];
    }else{
        
        _areaTF.textField.text = @"";
    }
    
    if (dataDic[@"indoor_size"] && ![dataDic[@"indoor_size"] isKindOfClass:[NSNull class]]) {
        
        _innerTF.textField.text = [NSString stringWithFormat:@"%@",dataDic[@"indoor_size"]];
    }else{
        
        _innerTF.textField.text = @"";
    }
    
    _typeTF.textField.text = dataDic[@"house_type"];
    
}

- (void)initUI{
    
    self.backgroundColor = CLWhiteColor;
    
    NSArray *titleArr = @[@"房间号",@"楼栋",@"单元",@"楼层",@"价格",@"计价规则",@"单价",@"总价",@"物业类型",@"建筑面积",@"套内面积",@"户型"];
    for (int i = 0; i < 12; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        label.text = titleArr[i];
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        tf.userInteractionEnabled = NO;
        tf.backgroundColor = CLBackColor;
        tf.textField.placeholder = @"请选择房间";
        switch (i) {
            case 0:
            {
                _roomL = label;
                [self addSubview:_roomL];
                
                _roomTF = tf;
                [self addSubview:_roomTF];
                break;
            }
            case 1:
            {
                _buildL = label;
                [self addSubview:_buildL];
                
                _buildTF = tf;
                [self addSubview:_buildTF];
                break;
            }
            case 2:
            {
                _unitL = label;
                [self addSubview:_unitL];
                
                _unitTF = tf;
                [self addSubview:_unitTF];
                break;
            }
            case 3:
            {
                _floorL = label;
                [self addSubview:_floorL];
                
                _floorTF = tf;
                _floorTF.unitL.text = @"层";
                [self addSubview:_floorTF];
                break;
            }
            case 4:
            {
                _priceL = label;
                [self addSubview:_priceL];
                
                _priceTF = tf;
                _priceTF.unitL.text = @"元";
                [self addSubview:_priceTF];
                break;
            }
            case 5:
            {
                _ruleL = label;
                [self addSubview:_ruleL];
                
                _ruleTF = tf;
                [self addSubview:_ruleTF];
                break;
            }
            case 6:
            {
                _unitPriceL = label;
                [self addSubview:_unitPriceL];
                
                _unitPriceTF = tf;
                _unitPriceTF.unitL.text = @"元/㎡";
                [self addSubview:_unitPriceTF];
                break;
            }
            case 7:
            {
                _totalL = label;
                [self addSubview:_totalL];
                
                _totalTF = tf;
                _totalTF.unitL.text = @"元";
                [self addSubview:_totalTF];
                break;
            }
            case 8:
            {
                _propertyL = label;
                [self addSubview:_propertyL];
                
                _propertyTF = tf;
                [self addSubview:_propertyTF];
                break;
            }
            case 9:
            {
                _areaL = label;
                [self addSubview:_areaL];
                
                _areaTF = tf;
                _areaTF.unitL.text = @"㎡";
                [self addSubview:_areaTF];
                break;
            }
            case 10:
            {
                _innerL = label;
                [self addSubview:_innerL];
                
                _innerTF = tf;
                _innerTF.unitL.text = @"㎡";
                [self addSubview:_innerTF];
                break;
            }
            case 11:
            {
                _typeL = label;
                [self addSubview:_typeL];
                
                _typeTF = tf;
                [self addSubview:_typeTF];
                break;
            }
            default:
                break;
        }
    }
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:IMAGE_WITH_NAME(@"editor_2") forState:UIControlStateNormal];
    [self addSubview:_editBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self).offset(22 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_roomTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self).offset(17 *SIZE);
        make.width.mas_equalTo(217 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(300 *SIZE);
        make.top.equalTo(self).offset(17 *SIZE);
        make.width.mas_equalTo(33 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_buildL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_roomTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_buildTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_roomTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_unitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_buildTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_unitTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_buildTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_unitTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_floorTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_unitTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_floorTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_floorTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_ruleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_ruleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_unitPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_ruleTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_unitPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_ruleTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_totalL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_unitPriceTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_totalTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_unitPriceTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_totalTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_propertyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_totalTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_propertyTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_propertyTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_innerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_areaTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_innerTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_areaTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(9 *SIZE);
        make.top.equalTo(self->_innerTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_typeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(80 *SIZE);
        make.top.equalTo(self->_innerTF.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self).offset(-20 *SIZE);
    }];
}



@end
