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

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = CLBlueBtnColor;
    [self.contentView addSubview:_blueView];
    
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.cornerRadius = 33.5 *SIZE;
    _headImg.clipsToBounds = YES;
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
                _addressL = label;
                [_blueView addSubview:_addressL];
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
    
//    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_deleteBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_deleteBtn setImage:IMAGE_WITH_NAME(@"delete") forState:UIControlStateNormal];
//    [self.contentView addSubview:_deleteBtn];
    
    NSArray *titleArr = @[@"基本资料",@"品牌信息",@"跟进记录"];
    for (int i = 0; i < 3; i++) {
        
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
        }else if (i == 2){
            
            _brandBtn = btn;
            [self.contentView addSubview:_brandBtn];
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

//
//    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_blueView).offset(94 *SIZE);
//        make.top.equalTo(self->_blueView).offset(9 *SIZE);
//        make.right.equalTo(self->_blueView.mas_right).offset(-70 *SIZE);
//    }];
//
//    [_customSourceL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_blueView).offset(94 *SIZE);
//        make.top.equalTo(self->_propertyL.mas_bottom).offset(8 *SIZE);
//        make.right.equalTo(self->_blueView.mas_right).offset(-70 *SIZE);
//    }];
//
//    [_sourceTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_blueView).offset(94 *SIZE);
//        make.top.equalTo(self->_customSourceL.mas_bottom).offset(8 *SIZE);
//        make.right.equalTo(self->_blueView.mas_right).offset(-70 *SIZE);
//    }];
//
//    [_approachL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_blueView).offset(94 *SIZE);
//        make.top.equalTo(self->_sourceTypeL.mas_bottom).offset(8 *SIZE);
//        make.right.equalTo(self->_blueView.mas_right).offset(-70 *SIZE);
////        make.bottom.equalTo(self->_blueView).offset(-19 *SIZE);
//    }];
//
//    [_belongL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_blueView).offset(94 *SIZE);
//        make.top.equalTo(self->_approachL.mas_bottom).offset(8 *SIZE);
//        make.right.equalTo(self->_blueView.mas_right).offset(-70 *SIZE);
//        make.bottom.equalTo(self->_blueView).offset(-19 *SIZE);
//    }];
//
//    [_groupColl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(0 *SIZE);
//        make.top.equalTo(self->_blueView.mas_bottom).offset(0 *SIZE);
//        make.width.mas_equalTo(300 *SIZE);
//        make.height.mas_equalTo(47 *SIZE);
//    }];
//
//    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.contentView).offset(-13 *SIZE);
//        make.top.equalTo(self->_blueView.mas_bottom).offset(11 *SIZE);
//        make.width.height.mas_equalTo(25 *SIZE);
//    }];
    
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(47 *SIZE);
        make.width.mas_equalTo(125 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_brandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(47 *SIZE);
        make.width.mas_equalTo(125 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(125 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(47 *SIZE);
        make.width.mas_equalTo(125 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
}

@end
