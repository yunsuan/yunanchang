//
//  CallTelegramCustomDetailIntentHeader.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramCustomDetailIntentHeader.h"

@implementation CallTelegramCustomDetailIntentHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    if (self.callTelegramCustomDetailIntentHeaderEditBlock) {
        
        self.callTelegramCustomDetailIntentHeaderEditBlock(btn.tag);
    }
}

- (void)ActionDeleteBtn:(UIButton *)btn{
    
    if (self.callTelegramCustomDetailIntentHeaderDeleteBlock) {
        
        self.callTelegramCustomDetailIntentHeaderDeleteBlock(btn.tag);
    }
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLBlueTagColor;
    _titleL.font = [UIFont boldSystemFontOfSize:16 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn setImage:IMAGE_WITH_NAME(@"editor_2") forState:UIControlStateNormal];
    [self.contentView addSubview:_editBtn];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn addTarget:self action:@selector(ActionEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteBtn setImage:IMAGE_WITH_NAME(@"delete_2") forState:UIControlStateNormal];
    [self.contentView addSubview:_deleteBtn];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-11 *SIZE);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-18 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_editBtn.mas_left).offset(-20 *SIZE);
        make.top.equalTo(self.contentView).offset(9 *SIZE);
        make.width.height.mas_equalTo(20 *SIZE);
    }];
}

@end
