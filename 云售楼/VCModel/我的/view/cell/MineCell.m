//
//  MineCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_titleImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _rightImg = [[UIImageView alloc] init];
    _rightImg.image = IMAGE_WITH_NAME(@"jiantou black");
    [self.contentView addSubview:_rightImg];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CL170Color;
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _contentL.textAlignment = NSTextAlignmentRight;;
    [self.contentView addSubview:_contentL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleImg mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(16 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.height.mas_equalTo(15 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(43 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-17 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
        make.width.mas_equalTo(9 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-33 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(-0 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(-0 *SIZE);
    }];
}

@end
