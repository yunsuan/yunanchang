//
//  SelectCompanyTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SelectCompanyTableCell.h"

@implementation SelectCompanyTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(CompanyModel *)model{
    
//    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,model.logo]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//        if (error) {
//
//            _headImg.image = [UIImage imageNamed:@"default_3"];
//        }
//    }];
    
    _nameL.text = model.company_name;
    _addressL.text = model.absolute_address;
//    _phoneL.text = [NSString stringWithFormat:@"联系方式：%@",model.contact_tel];
//    _contactL.text = [NSString stringWithFormat:@"负责人：%@",model.contact];
//    if (model.absolute_address.length) {
//        
//        [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.equalTo(self.contentView).offset(0 *SIZE);
//            make.top.equalTo(_phoneL.mas_bottom).offset(15 *SIZE);
//            make.width.mas_equalTo(SCREEN_Width);
//            make.height.mas_equalTo(SIZE);
//            make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//        }];
//    }else{
//        
//        [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.equalTo(self.contentView).offset(0 *SIZE);
//            make.top.equalTo(_headImg.mas_bottom).offset(18 *SIZE);
//            make.width.mas_equalTo(SCREEN_Width);
//            make.height.mas_equalTo(SIZE);
//            make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//        }];
//    }
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLContentLabColor;
    _nameL.numberOfLines = 0;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _addressL = [[UILabel alloc] init];
    _addressL.numberOfLines = 0;
    _addressL.textColor = CLContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_addressL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.numberOfLines = 0;
    _codeL.textColor = CLContentLabColor;
    _codeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.numberOfLines = 0;
    _phoneL.textColor = CLContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_phoneL];
    
    _contactL = [[UILabel alloc] init];
    _contactL.textColor = CLContentLabColor;
    _contactL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contactL.numberOfLines = 0;
    _contactL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_contactL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
         make.top.equalTo(self.contentView).offset(17 *SIZE);
         make.width.height.mas_equalTo(67 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(95 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(15 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(95 *SIZE);
        make.top.equalTo(_nameL.mas_bottom).offset(7 *SIZE);
        make.right.equalTo(self.contentView).offset(15 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(95 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(15 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(95 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(180 *SIZE);
    }];
    
    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(100 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
