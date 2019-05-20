//
//  TaskSignAuditCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/19.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "TaskSignAuditCollCell.h"

@implementation TaskSignAuditCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _headLine = [[UIView alloc] initWithFrame:CGRectMake(0, 38 *SIZE, 6 *SIZE, SIZE)];
    _headLine.backgroundColor = CLLineColor;
    [self.contentView addSubview:_headLine];
    
    _tagImg = [[UIImageView alloc] initWithFrame:CGRectMake(18 *SIZE, 5 *SIZE, 35 *SIZE, 17 *SIZE)];
    _tagImg.image = IMAGE_WITH_NAME(@"label");
    [self.contentView addSubview:_tagImg];
    
//    _markL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35 *SIZE, 14 *SIZE)];
//    _markL.textColor = CLWhiteColor;
//    _markL.font = [UIFont systemFontOfSize:7 *SIZE];
//    _markL.textAlignment = NSTextAlignmentCenter;
//    _markL.text = @"查看备注";
//    [_tagImg addSubview:_markL];
    
    _circleImg = [[UIImageView alloc] initWithFrame:CGRectMake(6 *SIZE, 22 *SIZE, 33 *SIZE, 33 *SIZE)];
    _circleImg.image = IMAGE_WITH_NAME(@"blue");
    [self.contentView addSubview:_circleImg];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(4 *SIZE, 12 *SIZE, 26 *SIZE, 10 *SIZE)];
    _nameL.textColor = CLWhiteColor;
    _nameL.font = [UIFont systemFontOfSize:11 *SIZE];
    _nameL.adjustsFontSizeToFitWidth = YES;
    _nameL.textAlignment = NSTextAlignmentCenter;
//    _nameL.text = @"查看备注";
    [_circleImg addSubview:_nameL];
    
    _tailLine = [[UIView alloc] initWithFrame:CGRectMake(39 *SIZE, 38 *SIZE, 28 *SIZE, SIZE)];
    _tailLine.backgroundColor = CLLineColor;
    [self.contentView addSubview:_tailLine];
}

@end
