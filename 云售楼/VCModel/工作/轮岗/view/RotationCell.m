//
//  RotationCell.m
//  云售楼
//
//  Created by xiaoq on 2019/5/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RotationCell.h"

@implementation RotationCell

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
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 23 *SIZE, 47 *SIZE, 47 *SIZE)];
    _headImg.backgroundColor = CLBlueBtnColor;
    _headImg.layer.cornerRadius = 23.5 *SIZE;
    _headImg.clipsToBounds = YES;
    _headImg.image = IMAGE_WITH_NAME(@"room");
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 76*SIZE, self.bounds.size.width, 11 *SIZE)];
    _titleL.textColor = CL86Color;
    _titleL.font = [UIFont systemFontOfSize:10 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;;
    [self.contentView addSubview:_titleL];
}

@end
