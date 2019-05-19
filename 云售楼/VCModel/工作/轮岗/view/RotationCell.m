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
    
//    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 23 *SIZE, 47 *SIZE, 47 *SIZE)];
//    _headImg.backgroundColor = CLBlueBtnColor;
//    _headImg.layer.cornerRadius = 23.5 *SIZE;
//    _headImg.clipsToBounds = YES;
//    _headImg.image = IMAGE_WITH_NAME(@"room");
//    [self.contentView addSubview:_headImg];
    _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headBtn.frame = CGRectMake(10*SIZE, 23*SIZE, 48*SIZE, 48*SIZE);
    [_headBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
    _headBtn.titleLabel.font = FONT(12);
    _headBtn.layer.masksToBounds =YES;
    _headBtn.layer.cornerRadius = 24*SIZE;
    [self.contentView addSubview:_headBtn];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 76*SIZE, 67*SIZE, 11 *SIZE)];
    _titleL.textColor = CL86Color;
    _titleL.font = [UIFont systemFontOfSize:10 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;;
    [self.contentView addSubview:_titleL];
}

-(void)ConfigCellByType:(KRotationState)type Title:(NSString *)title
{
    if (type == A_TYPE) {
        
        _headBtn.backgroundColor = COLOR(232, 78, 78, 1);
        [_headBtn setTitle:@"A位" forState:UIControlStateNormal];
    }else if (type == B_TYPE)
    {
        _headBtn.backgroundColor = COLOR(244, 173, 68, 1);
        [_headBtn setTitle:@"B位" forState:UIControlStateNormal];
    }else if (type == WAIT_TYPE)
    {
        _headBtn.backgroundColor = COLOR(114, 182, 238, 1);
        [_headBtn setTitle:@"等待" forState:UIControlStateNormal];
    }
    else if (type == REST_TYPE)
    {
        _headBtn.backgroundColor = COLOR(200, 200, 200, 1);
        [_headBtn setTitle:@"休" forState:UIControlStateNormal];
    }
    
    _titleL.text = title;
}

@end
