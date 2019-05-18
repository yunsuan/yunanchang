//
//  SignListCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SignListCell.h"

@implementation SignListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];//WithFrame:CGRectMake(57 *SIZE, 23 *SIZE, 250 *SIZE, 12 *SIZE)];
    _titleL.textColor = CLTitleLabColor;
    //    _titleL.numberOfLines = 0;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.numberOfLines = 0;
        if (i == 0) {
            
            _nameL = label;
            [self.contentView addSubview:_nameL];
        }else if (i == 1){
            
            _statusL = label;
//            _statusL.text = @"签字通过";
            [self.contentView addSubview:_statusL];
        }else{
            
            _timeL = label;
            [self.contentView addSubview:_timeL];
        }
    }
    
    _circleImg = [[UIImageView alloc] initWithFrame:CGRectMake(28 *SIZE, 20 *SIZE, 17 *SIZE, 17 *SIZE)];
    _circleImg.image = [UIImage imageNamed:@"progressbar"];
    [self.contentView addSubview:_circleImg];
    
    _upLine = [[UIView alloc] init];//WithFrame:CGRectMake(36 *SIZE, 0, SIZE, 20 *SIZE)];
    _upLine.backgroundColor = COLOR(255, 165, 29, 1);
    [self.contentView addSubview:_upLine];
    
    
    _downLine = [[UIView alloc] init];//WithFrame:CGRectMake(36 *SIZE, 37 *SIZE, SIZE, 43 *SIZE)];
    _downLine.backgroundColor = COLOR(255, 165, 29, 1);
    [self.contentView addSubview:_downLine];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_upLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(36 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.equalTo(@(SIZE));
        make.height.equalTo(@(20 *SIZE));
//        make.bottom.equalTo(self.contentView).offset(-60 *SIZE);
    }];
    
    
    [_downLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(36 *SIZE);
        make.top.equalTo(self.contentView).offset(37 *SIZE);
        make.width.equalTo(@(SIZE));
//        make.height.equalTo(@(43 *SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(57 *SIZE);
        make.top.equalTo(self.contentView).offset(23 *SIZE);
        make.width.equalTo(@(60 *SIZE));
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self.contentView).offset(23 *SIZE);
        make.width.equalTo(@(250 *SIZE));
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(5 *SIZE);
        make.width.equalTo(@(250 *SIZE));
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self->_statusL.mas_bottom).offset(5 *SIZE);
        make.width.equalTo(@(250 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-23 *SIZE);
    }];
}
@end
