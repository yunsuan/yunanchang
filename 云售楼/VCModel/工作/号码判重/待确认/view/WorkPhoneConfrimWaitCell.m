//
//  WorkPhoneConfrimWaitCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkPhoneConfrimWaitCell.h"

@implementation WorkPhoneConfrimWaitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.workPhoneConfrimWaitCellBlock) {
        
        self.workPhoneConfrimWaitCellBlock();
    }
}

- (void)Action_copy:(UIButton *)btn{
    
    if (self.copyWorkPhoneConfrimWaitCellBlock) {
        
        self.copyWorkPhoneConfrimWaitCellBlock();
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = [NSString stringWithFormat:@"%@",dataDic[@"name"]];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",dataDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",dataDic[@"project_name"]];
    _timeL.text = [NSString stringWithFormat:@"失效时间：%@",dataDic[@"timsLimit"]];
//    _addressL.text = [NSString stringWithFormat:@"项目地址：%@",dataDic[@"absolute_address"]];
    _phoneL.text = [NSString stringWithFormat:@"%@",dataDic[@"tel"]];
}

- (void)setUseDic:(NSMutableDictionary *)useDic{
    
    _nameL.text = [NSString stringWithFormat:@"%@",useDic[@"name"]];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",useDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",useDic[@"project_name"]];
    _timeL.text = [NSString stringWithFormat:@"失效时间：%@",useDic[@"timsLimit"]];
    //    _addressL.text = [NSString stringWithFormat:@"项目地址：%@",dataDic[@"absolute_address"]];
    _phoneL.text = [NSString stringWithFormat:@"%@",useDic[@"tel"]];
}

- (void)setFailDic:(NSMutableDictionary *)failDic{
    
    _resonL.text = @"无效原因：自然失效";
    _nameL.text = [NSString stringWithFormat:@"%@",failDic[@"name"]];
    _codeL.text = [NSString stringWithFormat:@"推荐编号：%@",failDic[@"client_id"]];
    _projectL.text = [NSString stringWithFormat:@"推荐项目：%@",failDic[@"project_name"]];
    _timeL.text = [NSString stringWithFormat:@"失效时间：%@",failDic[@"timsLimit"]];
    //    _addressL.text = [NSString stringWithFormat:@"项目地址：%@",dataDic[@"absolute_address"]];
    _phoneL.text = [NSString stringWithFormat:@"%@",failDic[@"tel"]];
}

- (void)initUI{
    
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLContentLabColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        switch (i) {
            case 0:
            {
                _nameL = label;
                _nameL.textColor = CLTitleLabColor;
                _nameL.font = [UIFont systemFontOfSize:14 *SIZE];
                [self.contentView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _codeL = label;
                _codeL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_codeL];
                break;
            }
            case 2:
            {
                _projectL = label;
                [self.contentView addSubview:_projectL];
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

                _phoneL = label;
                [self.contentView addSubview:_phoneL];
                break;
            }
            case 5:
            {
                
                _resonL = label;
                _resonL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_resonL];
                break;
            }
            default:
                break;
        }
    }
    
    _genderImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_genderImg];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
//    [_confirmBtn setBackgroundColor:COLOR(255, 165, 29, 1)];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    _confirmBtn.layer.borderWidth = SIZE;
    _confirmBtn.layer.borderColor = CLBlueBtnColor.CGColor;
    [_confirmBtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
    [self.contentView addSubview:_confirmBtn];
    
    _copybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _copybtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_copybtn addTarget:self action:@selector(Action_copy:) forControlEvents:UIControlEventTouchUpInside];
    [_copybtn setTitle:@"复制" forState:UIControlStateNormal];
//    [_copybtn setBackgroundColor:CLBlueBtnColor];
    _copybtn.layer.cornerRadius = 2 *SIZE;
    _copybtn.clipsToBounds = YES;
    _copybtn.layer.borderWidth = SIZE;
    _copybtn.layer.borderColor = CLBlueBtnColor.CGColor;
    [_copybtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
    [self.contentView addSubview:_copybtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_greaterThanOrEqualTo(150 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.left.equalTo(self->_nameL.mas_right).offset(5 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_resonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(130 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_phoneL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_projectL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-150 *SIZE);
    }];
    
    [_copybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(233 *SIZE);
        make.top.equalTo(self->_codeL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(290 *SIZE);
        make.top.equalTo(self->_codeL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
