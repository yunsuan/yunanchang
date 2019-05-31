//
//  MineHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "MineHeader.h"

@implementation MineHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionImg{
    
    if (self.mineHeaderImgBlock) {
        
        self.mineHeaderImgBlock();
    }
}

- (void)ActionName{
    
    if (self.mineHeaderNameBlock) {
        
        self.mineHeaderNameBlock();
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    [_headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"head_img"]]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            self->_headerImg.image = IMAGE_WITH_NAME(@"def_head");
        }
    }];
    _nameL.text = dataDic[@"name"];
    if ([dataDic[@"sex"] integerValue] == 1) {
        
        _genderImg.image = IMAGE_WITH_NAME(@"man");
    }else if ([dataDic[@"sex"] integerValue] == 2){
        
        _genderImg.image = IMAGE_WITH_NAME(@"girl");
    }else{
        
        _genderImg.image = IMAGE_WITH_NAME(@"");
    }
    
    _codeL.text = dataDic[@"account"];
    
    [_nameL mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self->_nameL.mj_textWith + 5 *SIZE);
    }];
}


- (void)initUI{
    
    self.contentView.backgroundColor = CLBackColor;
    
    _backImg = [[UIImageView alloc] init];
    _backImg.backgroundColor = CLWhiteColor;
//    _backImg.image = [UIImage imageNamed:@"background"];
    _backImg.layer.shadowColor = CLLineColor.CGColor;
    _backImg.layer.shadowOffset = CGSizeMake(0, 4 *SIZE);
    _backImg.layer.shadowOpacity = 1;
    [self.contentView addSubview:_backImg];

    _headerImg = [[UIImageView alloc] init];
    _headerImg.contentMode = UIViewContentModeScaleAspectFill;
    _headerImg.clipsToBounds = YES;
    _headerImg.layer.cornerRadius = 30 *SIZE;
    _headerImg.userInteractionEnabled = YES;
//    _headerImg.backgroundColor = CLLineColor;
    UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionImg)];
    [_headerImg addGestureRecognizer:imgTap];
    [self.contentView addSubview:_headerImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    _nameL.userInteractionEnabled = YES;
//    _nameL.text = @"小煤球";
    UITapGestureRecognizer *nameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionName)];
    [_nameL addGestureRecognizer:nameTap];
    [self.contentView addSubview:_nameL];

    _genderImg = [[UIImageView alloc] init];
    _genderImg.image = [UIImage imageNamed:@"man"];
    [self.contentView addSubview:_genderImg];
    
//    _nameLine = [[UIView alloc] init];
//    _nameLine.backgroundColor = CLWhiteColor;
//    [self.contentView addSubview:_nameLine];
    
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = CL86Color;
//    _codeL.text = @"123123";
    _codeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_codeL];
    
    
    _rightImg = [[UIImageView alloc] init];
    _rightImg.image = [UIImage imageNamed:@"jiantouwhite"];
    [self.contentView addSubview:_rightImg];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_backImg mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(133 *SIZE + STATUS_BAR_HEIGHT - 20);
        make.bottom.equalTo(self.contentView).offset(-4 *SIZE);
    }];
    
    [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(14 *SIZE);
        make.top.equalTo(self.contentView).offset(42 *SIZE + STATUS_BAR_HEIGHT - 20);
        make.width.height.mas_equalTo(60 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(91 *SIZE);
        make.top.equalTo(self.contentView).offset(55 *SIZE + STATUS_BAR_HEIGHT - 20);
        make.width.mas_equalTo(self->_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nameL.mas_right).offset(2 *SIZE);
        make.top.equalTo(self.contentView).offset(57 *SIZE + STATUS_BAR_HEIGHT - 20);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
//    [_nameLine mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(109 *SIZE);
//        make.top.equalTo(self->_nameL.mas_bottom).offset(6 *SIZE);
//        make.width.mas_equalTo(self->_nameL.mj_textWith + 19 *SIZE);
//        make.height.mas_equalTo(1);
//    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(91 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-17 *SIZE);
        make.top.equalTo(self.contentView).offset(74 *SIZE + STATUS_BAR_HEIGHT);
        make.height.mas_equalTo(20 *SIZE);
        make.width.mas_equalTo(9 *SIZE);
    }];
}

@end
