//
//  AddressBookCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddressBookCell.h"

@implementation AddressBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = dataDic[@"name"];//@"小煤球";
    if ([dataDic[@"sex"] integerValue] == 1) {
        
        _genderImg.image = IMAGE_WITH_NAME(@"man");
    }else if ([dataDic[@"sex"] integerValue] == 2){
        
        _genderImg.image = IMAGE_WITH_NAME(@"girl");
    }else{
        
        _genderImg.image = IMAGE_WITH_NAME(@"");
    }
    _phoneL.text = dataDic[@"tel"];//@"1801010313";
    _departmentL.text = [NSString stringWithFormat:@"%@：%@", dataDic[@"department_name"],dataDic[@"post_name"]];//@"销售部：销售经理";
//    _positionL.text = @"销售经理";
    [_nameL mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self->_nameL.mj_textWith + 5 *SIZE);
    }];
}

- (void)ActionPhone{
    
    if (self.addressBookCellPhoneBlock) {
        
        self.addressBookCellPhoneBlock();
    }
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    _headImg.layer.cornerRadius = 21.5 *SIZE;
    _headImg.backgroundColor = CLBackColor;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = CLTitleLabColor;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_phoneL];
    
    _departmentL = [[UILabel alloc] init];
    _departmentL.textColor = CL102Color;
    _departmentL.textAlignment = NSTextAlignmentRight;
    _departmentL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_departmentL];
    
//    _positionL = [[UILabel alloc] init];
//    _positionL.textColor = CL102Color;
//    _positionL.textAlignment = NSTextAlignmentRight;
//    _positionL.font = [UIFont systemFontOfSize:12 *SIZE];
//    [self.contentView addSubview:_positionL];
    
    _genderImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_genderImg];
    
    _phoneImg = [[UIImageView alloc] init];
    _phoneImg.image = IMAGE_WITH_NAME(@"phone");
    _phoneImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionPhone)];
    [_phoneImg addGestureRecognizer:tap];
    [self.contentView addSubview:_phoneImg];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
        make.height.width.mas_equalTo(43 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(68 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
        make.width.mas_equalTo(self->_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_nameL.mas_right).offset(2 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.height.width.mas_equalTo(12 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(68 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.height.width.mas_equalTo(16 *SIZE);
    }];
    
    [_departmentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(42 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
//    [_positionL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.contentView).offset(-71 *SIZE);
//        make.top.equalTo(self->_departmentL.mas_bottom).offset(15 *SIZE);
//        make.width.mas_equalTo(60 *SIZE);
//    }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(15 *SIZE);
        make.height.mas_equalTo(1 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-0 *SIZE);
    }];
}

@end
