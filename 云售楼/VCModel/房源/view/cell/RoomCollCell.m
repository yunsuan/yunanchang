//
//  RoomCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RoomCollCell.h"

@implementation RoomCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(18.5 *SIZE, 8 *SIZE, 53 *SIZE, 53 *SIZE)];
    _headImg.backgroundColor = CLBlueBtnColor;
    _headImg.layer.cornerRadius = 3 *SIZE;
    _headImg.clipsToBounds = YES;
    _headImg.image = IMAGE_WITH_NAME(@"room");
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 11 *SIZE + CGRectGetMaxY(_headImg.frame), self.bounds.size.width, 11 *SIZE)];
    _titleL.textColor = CL86Color;
    _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;;
    [self.contentView addSubview:_titleL];
}

@end
