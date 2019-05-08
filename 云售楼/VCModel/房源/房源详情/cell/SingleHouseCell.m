//
//  SingleHouseCell.m
//  云渠道
//
//  Created by xiaoq on 2018/5/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SingleHouseCell.h"

@implementation SingleHouseCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70*SIZE, 13 *SIZE)];
        _title.textColor = CLContentLabColor;
        _title.font = [UIFont systemFontOfSize:12 *SIZE];
        _title.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_title];
        
        _content =[[UILabel alloc] initWithFrame:CGRectMake(85*SIZE, 0, 170*SIZE, 13 *SIZE)];
        _content.textColor = CLContentLabColor;
        _content.font = [UIFont systemFontOfSize:12 *SIZE];
        _content.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_content];
    }
    return self;
}



-(void)setcelltitle:(NSString *)title content:(NSString *)content
{
    _title.text = title;
    _content.text = content;
}


@end
