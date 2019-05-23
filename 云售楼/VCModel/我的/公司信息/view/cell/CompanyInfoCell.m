//
//  CompanyInfoCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CompanyInfoCell.h"

@implementation CompanyInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.companyInfoCellBlock) {
        
        self.companyInfoCellBlock(self.tag);
    }
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if ([dataDic[@"state"] integerValue] == 1) {
        
        _companyL.text = [NSString stringWithFormat:@"当前公司：%@",dataDic[@"company_name"]];
    }else{
        
        _companyL.text = [NSString stringWithFormat:@"%@",dataDic[@"company_name"]];
    }
    
    _departL.text = [NSString stringWithFormat:@"部门：%@",dataDic[@"department_name"]];
    _positionL.text = [NSString stringWithFormat:@"岗位：%@",dataDic[@"post_name"]];
    _roleL.text = [NSString stringWithFormat:@"项目角色：%@",dataDic[@"role_name"]];
    _timeL.text = [NSString stringWithFormat:@"入职时间：%@",dataDic[@"create_time"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLBackColor;
    
    _upLine = [[UIView alloc] init];
    _upLine.backgroundColor = CLBlueBtnColor;
    [self.contentView addSubview:_upLine];
    
    _circleImg = [[UIImageView alloc] init];
    _circleImg.image = IMAGE_WITH_NAME(@"round");
    [self.contentView addSubview:_circleImg];
    
    _downLine = [[UIView alloc] init];
    _downLine.backgroundColor = CLBlueBtnColor;
    [self.contentView addSubview:_downLine];
    
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = CLWhiteColor;
    _backView.layer.cornerRadius = 3 *SIZE;
    [self.contentView addSubview:_backView];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setTitle:@"增加角色" forState:UIControlStateNormal];
    _addBtn.layer.cornerRadius = 2 *SIZE;
    _addBtn.layer.borderColor = CLWhiteColor.CGColor;
    _addBtn.layer.borderWidth = SIZE;
    _addBtn.clipsToBounds = YES;
    [self.contentView addSubview:_addBtn];
    
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:IMAGE_WITH_NAME(@"editor_3") forState:UIControlStateNormal];
//    [self.contentView addSubview:_editBtn];
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CL86Color;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        
        switch (i) {
            case 0:
            {
                _companyL = label;
                _companyL.font = [UIFont boldSystemFontOfSize:13 *SIZE];
                _companyL.textColor = CLTitleLabColor;
                [_backView addSubview:_companyL];
                break;
            }
            case 1:{
                
                _departL = label;
                [_backView addSubview:_departL];
                break;
            }
            case 2:{
                
                _positionL = label;
                [_backView addSubview:_positionL];
                break;
            }
            case 3:{
                
                _roleL = label;
                [_backView addSubview:_roleL];
                break;
            }
            case 4:{
                
                _timeL = label;
                [_backView addSubview:_timeL];
                break;
            }
            default:
                break;
        }
    }
    
    [_upLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(18 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(1 *SIZE);
        make.height.mas_equalTo(7 *SIZE);
    }];
    
    [_circleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(17 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_downLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(18 *SIZE);
        make.top.equalTo(self.contentView).offset(24 *SIZE);
        make.width.mas_equalTo(1 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(33 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(317 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-7 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(12 *SIZE);
        make.top.equalTo(self->_backView).offset(19 *SIZE);
        make.width.mas_equalTo(230 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_backView).offset(-11 *SIZE);
        make.top.equalTo(self->_backView).offset(13 *SIZE);
        make.width.mas_equalTo(57 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_departL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(12 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(265 *SIZE);
    }];
    
    [_positionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(12 *SIZE);
        make.top.equalTo(self->_departL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(265 *SIZE);
    }];
    
    [_roleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(12 *SIZE);
        make.top.equalTo(self->_positionL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(265 *SIZE);
    }];
    
//    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.right.equalTo(self->_backView).offset(-11 *SIZE);
//        make.top.equalTo(self->_positionL.mas_bottom).offset(10 *SIZE);
//        make.width.mas_equalTo(16 *SIZE);
//        make.height.mas_equalTo(16 *SIZE);
//    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(12 *SIZE);
        make.top.equalTo(self->_roleL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(265 *SIZE);
        make.bottom.equalTo(self->_backView).offset(-18 *SIZE);
    }];
}
@end
