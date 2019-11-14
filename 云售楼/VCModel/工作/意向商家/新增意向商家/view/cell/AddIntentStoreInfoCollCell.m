//
//  AddIntentStoreInfoCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddIntentStoreInfoCollCell.h"

@implementation AddIntentStoreInfoCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
//    _headImg.image = IMAGE_WITH_NAME(@"sjmerchant_1");
    _titleL.text = [NSString stringWithFormat:@"%@",dataDic[@"business_name"]];
    _customL.text = [NSString stringWithFormat:@"联系人：%@",dataDic[@"contact"]];
//    _numL.text = [NSString stringWithFormat:@"组别人数：%@",dataDic[@"client_num"]];
    if ([dataDic[@"format_name"] length]) {
        
        _ascriptionL.text = [NSString stringWithFormat:@"%@",dataDic[@"format_name"]];
    }else{
        
        _ascriptionL.text = @" ";
    }
    
    _typeL.text = [NSString stringWithFormat:@"可承受租金：%@",dataDic[@"lease_money"]];
//    _typeL.text = [NSString stringWithFormat:@"%@",dataDic[@"resource_name"]];
//    _addressL.text = [NSString stringWithFormat:@"%@%@%@",dataDic[@"province_name"],dataDic[@"city_name"],dataDic[@"district_name"]];
    _addressL.text = [NSString stringWithFormat:@"承租面积：%@",dataDic[@"lease_size"]];
    _timeL.text = dataDic[@"create_time"];
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
//    if (self.storeCellBlock) {
//        
//        self.storeCellBlock(self.tag);
//    }
}

- (void)ActionDeleteBtn:(UIButton *)btn{
    
    if (self.addIntentStoreInfoCollCellDeleteBlock) {
        
        self.addIntentStoreInfoCollCellDeleteBlock(self.tag);
    }
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImg];
    
    for (int i = 0; i < 6; i++) {
        
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
                
                _customL = label;
                _customL.textAlignment = NSTextAlignmentRight;
//                _customL.adjustsFontSizeToFitWidth = YES;
                [self.contentView addSubview:_customL];
                break;
            }
            case 2:
            {
                _timeL = label;
                _timeL.textAlignment = NSTextAlignmentRight;
                _timeL.adjustsFontSizeToFitWidth = YES;
                [self.contentView addSubview:_timeL];
                break;
            }
            case 3:
            {
                
                _addressL = label;
//                _addressL.adjustsFontSizeToFitWidth = YES;
//                _addressL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_addressL];
                break;
            }
            case 4:
            {
                
                _ascriptionL = label;
//                _ascriptionL.textColor = CLWhiteColor;
//                _ascriptionL.textAlignment = NSTextAlignmentCenter;
//                _ascriptionL.backgroundColor = CLBlueBtnColor;
//                _ascriptionL.font = FONT(11 *SIZE);
                [self.contentView addSubview:_ascriptionL];
                break;
            }
            case 5:
            {
                
                _typeL = label;
//                _typeL.textColor = CLWhiteColor;
//                _typeL.textAlignment = NSTextAlignmentCenter;
//                _typeL.backgroundColor = [UIColor darkGrayColor];
//                _typeL.font = FONT(11 *SIZE);
                _typeL.textAlignment = NSTextAlignmentRight;
//                _typeL.adjustsFontSizeToFitWidth = YES;
                [self.contentView addSubview:_typeL];
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
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake(SCREEN_Width - 90 *SIZE, 0, 90 *SIZE, 105 *SIZE);
    [_deleteBtn setBackgroundColor:[UIColor redColor]];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(ActionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
    
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
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-240 *SIZE);
    }];
    
    [_customL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(125 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
//        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.height.mas_equalTo(19 *SIZE);
    }];
    
    [_ascriptionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-240 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(135 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_ascriptionL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-220 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-102 *SIZE);
        make.top.equalTo(self->_ascriptionL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(110 *SIZE);
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
