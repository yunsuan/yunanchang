//
//  TitleContentRightBaseCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "TitleContentRightBaseCell.h"

@implementation TitleContentRightBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc]init];
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
//    _contentL.numberOfLines = 0;
    _contentL.textAlignment = NSTextAlignmentRight;
    _contentL.textColor = CL153Color;
    [self.contentView addSubview:_contentL];
    
    _rightImg = [[UIImageView alloc] init];
    _rightImg.image = [UIImage imageNamed:@"rightarrow"];
    [self.contentView addSubview:_rightImg];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = CLLineColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
        make.width.mas_equalTo(95 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-31 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
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
        make.top.equalTo(self->_titleL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
