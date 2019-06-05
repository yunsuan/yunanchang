//
//  ChannelRankListCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelRankListCell.h"

@implementation ChannelRankListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

//- (void)SetImg:(NSString *)img title:(NSString *)title content:(NSString *)content{
//
//    _headImg.image = IMAGE_WITH_NAME(img);
//    _titleL.text = title;
//    _contentL.text = content;
//}

- (void)initUI{
    
    _rankL = [[UILabel alloc] init];
    _rankL.textColor = CLBlackColor;
    _rankL.font = [UIFont systemFontOfSize:20 *SIZE];
    _rankL.layer.cornerRadius = 22.5 *SIZE;
    _rankL.clipsToBounds = YES;
    _rankL.layer.borderWidth = SIZE;
    _rankL.layer.borderColor = CLLineColor.CGColor;
    _rankL.textAlignment = NSTextAlignmentCenter;
    //    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_rankL];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLBlackColor;
    _titleL.font = [UIFont systemFontOfSize:16 *SIZE];
    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_titleL];
    

    _contentL = [[UILabel alloc]init];
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _contentL.textColor = CL153Color;
    [self.contentView addSubview:_contentL];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = CLLineColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_rankL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.height.mas_equalTo(45 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
//        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(81 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(230*SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self->_contentL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
