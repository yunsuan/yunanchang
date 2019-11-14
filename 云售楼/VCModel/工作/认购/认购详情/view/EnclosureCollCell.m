//
//  EnclosureCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/28.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "EnclosureCollCell.h"

@implementation EnclosureCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)initUI{
    
    _bigImg = [[UIImageView alloc] initWithFrame:CGRectMake(5 *SIZE, 3 *SIZE, 100 *SIZE, 83 *SIZE)];
//    _bigImg.image =[UIImage imageNamed:@"add_3"];
    _bigImg.contentMode = UIViewContentModeScaleAspectFill;
    _bigImg.clipsToBounds = YES;
    [self.contentView addSubview:_bigImg];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(5 *SIZE, 90 *SIZE, 100 *SIZE, 30 *SIZE)];
    _titleL.numberOfLines = 2;
    _titleL.adjustsFontSizeToFitWidth = YES;
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
}

@end
