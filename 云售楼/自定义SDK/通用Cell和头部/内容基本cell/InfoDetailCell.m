//
//  InfoDetailCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "InfoDetailCell.h"

@implementation InfoDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.infoDetailCellBlock) {
        
        self.infoDetailCellBlock();
    }
}

-(void)initUI
{
    _contentlab = [[UILabel alloc]init];
    _contentlab.font = [UIFont systemFontOfSize:13.3*SIZE];
    _contentlab.numberOfLines = 0;
    _contentlab.lineBreakMode = NSLineBreakByCharWrapping;
    //    [_contentlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _contentlab.textColor = CLContentLabColor;
    [self.contentView addSubview:_contentlab];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"查看确认流程" forState:UIControlStateNormal];
    _moreBtn.backgroundColor = CLBlueBtnColor;
    _moreBtn.layer.cornerRadius = 2 *SIZE;
    _moreBtn.clipsToBounds = YES;
    [self.contentView addSubview:_moreBtn];
    
    [_contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28.3*SIZE);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(300 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-15*SIZE);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(260 *SIZE);
        make.top.equalTo(self.contentView).offset(2 *SIZE);
        make.width.mas_equalTo(90 *SIZE);
        make.height.mas_equalTo(26 *SIZE);
    }];
}

-(void)SetCellContentbystring:(NSString *)str
{
    _contentlab.text = str;
    if ([str containsString:@"确认状态"]) {
        
        _moreBtn.hidden = NO;
        [_contentlab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(28.3*SIZE);
            make.top.equalTo(self.contentView);
            make.width.mas_equalTo(250*SIZE);
            make.bottom.equalTo(self.contentView).offset(-15*SIZE);
        }];
    }else{
        
        _moreBtn.hidden = YES;
        [_contentlab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(28.3*SIZE);
            make.top.equalTo(self.contentView);
            make.width.mas_equalTo(300 *SIZE);
            make.bottom.equalTo(self.contentView).offset(-15*SIZE);
        }];
    }
}

-(CGFloat)calculateTextHeight
{
    return self.contentlab.frame.size.height +15*SIZE;
}

@end
