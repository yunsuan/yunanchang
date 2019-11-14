//
//  StoreDetailHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "StoreDetailHeader.h"

@implementation StoreDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.storeDetailHeaderTagBlock) {
        
        self.storeDetailHeaderTagBlock(btn.tag);
    }
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.storeDetailHeaderEditBlock) {

        self.storeDetailHeaderEditBlock(btn.tag);
    }
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _nameL.text = [NSString stringWithFormat:@"商家名称：%@",dataDic[@"business_name"]];
    _formatL.text = [NSString stringWithFormat:@"经营业态：%@",dataDic[@"format_name"]];
    _regionL.text = [NSString stringWithFormat:@"所属区域：%@%@%@",dataDic[@"province_name"],dataDic[@"city_name"],dataDic[@"district_name"]];
    _nickL.text = [NSString stringWithFormat:@"商家简称：%@",dataDic[@"business_name_short"]];
    _priceL.text = [NSString stringWithFormat:@"可承受租金：%@元/㎡/月",dataDic[@"lease_money"]];
    _areaL.text = [NSString stringWithFormat:@"可承受面积：%@㎡",dataDic[@"lease_size"]];
    NSString *str = @"";
    for (int i = 0; i < [dataDic[@"resource_name_list"] count]; i++) {
        
        if (i == 0) {
            
            str = [NSString stringWithFormat:@"%@",dataDic[@"resource_name_list"][i][@"resource_name"]];
        }else{
            
            str = [NSString stringWithFormat:@"%@,%@",str,dataDic[@"resource_name_list"][i][@"resource_name"]];
        }
    }
    _brandL.text = [NSString stringWithFormat:@"品牌信息：%@",str];
    _approchL.text = [NSString stringWithFormat:@"认知途径：%@",dataDic[@"source_name"]];
    _statusL.text = [NSString stringWithFormat:@"经营关系：%@",dataDic[@"business_type_name"]];
    _contractL.text = [NSString stringWithFormat:@"联系人：%@",dataDic[@"contact"]];
    NSArray *arr = [dataDic[@"contact_tel"] componentsSeparatedByString:@","];
    if (arr.count == 3) {
        
        _phoneL1.text = [NSString stringWithFormat:@"联系电话：%@",arr[0]];
        _phoneL2.text = [NSString stringWithFormat:@"联系电话：%@",arr[1]];
        _phoneL3.text = [NSString stringWithFormat:@"联系电话：%@",arr[2]];
    }else if(arr.count == 2){
        
        _phoneL1.text = [NSString stringWithFormat:@"联系电话：%@",arr[0]];
        _phoneL2.text = [NSString stringWithFormat:@"联系电话：%@",arr[1]];
        _phoneL3.text = [NSString stringWithFormat:@"联系电话：%@",@""];
    }else if (arr.count == 1){
        
        _phoneL1.text = [NSString stringWithFormat:@"联系电话：%@",arr[0]];
        _phoneL2.text = [NSString stringWithFormat:@"联系电话：%@",@""];
        _phoneL3.text = [NSString stringWithFormat:@"联系电话：%@",@""];
    }else{
        
        _phoneL1.text = [NSString stringWithFormat:@"联系电话：%@",@""];
        _phoneL2.text = [NSString stringWithFormat:@"联系电话：%@",@""];
        _phoneL3.text = [NSString stringWithFormat:@"联系电话：%@",@""];
    }
    
    _addressL.text = [NSString stringWithFormat:@"通讯地址：%@",dataDic[@"address"]];
    _descL.text = [NSString stringWithFormat:@"经营描述：%@",dataDic[@"comment"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = CLBlueBtnColor;
    [self.contentView addSubview:_blueView];
    
    _headImg = [[UIImageView alloc] init];
//    _headImg.layer.cornerRadius = 33.5 *SIZE;
//    _headImg.clipsToBounds = YES;
    _headImg.image = IMAGE_WITH_NAME(@"sjmerchant_1");
    [_blueView addSubview:_headImg];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLWhiteColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                _nameL = label;
                [_blueView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _formatL = label;
                [_blueView addSubview:_formatL];
                break;
            }
            case 2:
            {
                _regionL = label;
                [_blueView addSubview:_regionL];
                break;
            }
            default:
                break;
        }
    }
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:IMAGE_WITH_NAME(@"editor_3") forState:UIControlStateNormal];
    [self.contentView addSubview:_editBtn];
    
    _header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _header.titleL.text = @"基础信息";
    [_header ReMasonryUI];
    [self.contentView addSubview:_header];
    
    for (int i = 0; i < 12; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        if (i == 0) {
            
            _nickL = label;
            [self.contentView addSubview:_nickL];
        }else if (i == 1){
            
            _priceL = label;
            [self.contentView addSubview:_priceL];
        }else if (i == 2){
            
            _areaL = label;
            [self.contentView addSubview:_areaL];
        }else if (i == 3){
            
            _brandL = label;
            [self.contentView addSubview:_brandL];
        }else if (i == 4){
            
            _approchL = label;
            [self.contentView addSubview:_approchL];
        }else if (i == 5){
            
            _statusL = label;
            [self.contentView addSubview:_statusL];
        }else if (i == 6){
            
            _contractL = label;
            [self.contentView addSubview:_contractL];
        }else if (i == 7){
            
            _phoneL1 = label;
            [self.contentView addSubview:_phoneL1];
        }else if (i == 8){
            
            _phoneL2 = label;
            [self.contentView addSubview:_phoneL2];
        }else if (i == 9){
            
            _phoneL3 = label;
            [self.contentView addSubview:_phoneL3];
        }else if (i == 10){
            
            _addressL = label;
            [self.contentView addSubview:_addressL];
        }else if (i == 11){
            
            _descL = label;
            [self.contentView addSubview:_descL];
        }
    }
    
    NSArray *titleArr = @[@"商家需求",@"跟进记录"];
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn setBackgroundColor:CL248Color];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:CL178Color forState:UIControlStateNormal];
        
        if (i == 0) {
            
            _infoBtn = btn;
            [self.contentView addSubview:_infoBtn];
        }else{
            
            _followBtn = btn;
            [self.contentView addSubview:_followBtn];
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_blueView).offset(10 *SIZE);
        make.top.equalTo(self->_blueView).offset(10 *SIZE);
        make.width.height.mas_equalTo(67 *SIZE);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(self.contentView).offset(-18 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.height.mas_equalTo(26 *SIZE);
    }];


    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_blueView).offset(94 *SIZE);
        make.top.equalTo(self->_blueView).offset(9 *SIZE);
        make.right.equalTo(self->_blueView.mas_right).offset(-70 *SIZE);
    }];

    [_formatL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_blueView).offset(94 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self->_blueView.mas_right).offset(-70 *SIZE);
    }];
    
    [_regionL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_blueView).offset(94 *SIZE);
        make.top.equalTo(self->_formatL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self->_blueView.mas_right).offset(-70 *SIZE);
        make.bottom.equalTo(self->_blueView).offset(-19 *SIZE);
    }];
    
    [_header mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_nickL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_header.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_nickL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_brandL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_approchL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_brandL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_approchL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_contractL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_statusL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_phoneL1 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_contractL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    [_phoneL2 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_phoneL1.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_phoneL3 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_phoneL2.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_phoneL3.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_descL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_addressL.mas_bottom).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_descL.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(SCREEN_Width / 2);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(SCREEN_Width / 2);
        make.top.equalTo(self->_descL.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(SCREEN_Width / 2);
        make.height.mas_equalTo(40 *SIZE);
    }];
}

@end
