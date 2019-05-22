//
//  PushSettingCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "PushSettingCell.h"

@implementation PushSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionSwitch:(UISwitch *)onOff{
    
    if (self.pushSettingCellSwitchBlock) {
        
        self.pushSettingCellSwitchBlock();
    }
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 150 *SIZE, 13 *SIZE)];
    _titleL.textColor = CLContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(290 *SIZE, 6 *SIZE, 40 *SIZE, 40 *SIZE)];
    _headImg.layer.cornerRadius = 20 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    _headImg.hidden = YES;
    
    _contentL = [[UILabel alloc] initWithFrame:CGRectMake(85 *SIZE, 19 *SIZE, 255 *SIZE, 13 *SIZE)];
    _contentL.textColor = CLTitleLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_contentL];
    
    _OnOff = [[UISwitch alloc] initWithFrame:CGRectMake(300 *SIZE, 10 *SIZE, 80 *SIZE, 20 *SIZE)];
    _OnOff.hidden = YES;
    [_OnOff addTarget:self action:@selector(ActionSwitch:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_OnOff];
    
    _rightView = [[UIImageView alloc] initWithFrame:CGRectMake(343 *SIZE, 19 *SIZE, 12 *SIZE, 12 *SIZE)];
    _rightView.image = [UIImage imageNamed:@"rightarrow"];
    [self.contentView addSubview:_rightView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = CLLineColor;
    [self.contentView addSubview:line];
}

@end
