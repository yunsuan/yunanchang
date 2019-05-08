//
//  ContentBaseCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ContentBaseCell.h"

@implementation ContentBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)initUI{

    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CL95Color;
    _contentL.font = [UIFont systemFontOfSize:14 *SIZE];
    _contentL.numberOfLines = 0;
    [self.contentView addSubview:_contentL];


    _textContent = [[UITextView alloc] init];
    _textContent.font = [UIFont systemFontOfSize:13.3*SIZE];
    _textContent.editable = NO;
    _textContent.scrollEnabled = NO;
    _textContent.hidden = YES;
    _textContent.textContainer.lineFragmentPadding = 0;
    _textContent.textContainerInset = UIEdgeInsetsZero;
    [self.contentView addSubview:_textContent];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = CLLineColor;
    _lineView.hidden = YES;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(16 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.right.equalTo(self.contentView).offset(-16 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-7 *SIZE);
    }];
    
    [_textContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(27*SIZE);
        make.top.equalTo(self.contentView).offset(9*SIZE);
        make.right.equalTo(self.contentView).offset(-27*SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self->_contentL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
