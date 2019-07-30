//
//  RecommendCheckCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RecommendCheckCell.h"

@implementation RecommendCheckCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    
    _titleL = [[UILabel alloc]initWithFrame:CGRectMake(27*SIZE, 0*SIZE, 300*SIZE, 14 *SIZE)];
    _titleL.font = [UIFont systemFontOfSize:14*SIZE];
    _titleL.textColor = CLOrangeColor;
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.text = @"推荐已成功，已到访为准";
    [self.contentView addSubview:_titleL];
}


@end
