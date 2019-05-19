//
//  WorkCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkCell.h"

@implementation WorkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)SetImg:(NSString *)img title:(NSString *)title content:(NSString *)content{
    
    _headImg.image = IMAGE_WITH_NAME(img);
    _titleL.text = title;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLBlackColor;
    _titleL.font = [UIFont systemFontOfSize:16 *SIZE];
//    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_titleL];
    
    _topContentL = [[UILabel alloc]init];
    _topContentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _topContentL.textColor = CL153Color;
    [self.contentView addSubview:_topContentL];
    
    _contentL = [[UILabel alloc]init];
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _contentL.textColor = CL153Color;
    [self.contentView addSubview:_contentL];
    
    _bomContentL = [[UILabel alloc]init];
    _bomContentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _bomContentL.textColor = CL153Color;
    [self.contentView addSubview:_bomContentL];
    
    _rightImg = [[UIImageView alloc] init];
    _rightImg.image = [UIImage imageNamed:@"jiantou black"];
    [self.contentView addSubview:_rightImg];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = CLLineColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.height.mas_equalTo(45 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
        make.width.mas_equalTo(95 *SIZE);
    }];
    
    [_topContentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(self.contentView).offset(38 *SIZE);
        make.width.mas_equalTo(230*SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(self.contentView).offset(52 *SIZE);
        make.width.mas_equalTo(230*SIZE);
    }];
    
    [_bomContentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(self->_topContentL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(230*SIZE);
    }];
    
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
        make.width.mas_equalTo(7 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self->_headImg.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
