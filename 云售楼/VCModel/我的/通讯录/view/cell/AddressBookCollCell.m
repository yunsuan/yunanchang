//
//  AddressBookCollCell.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddressBookCollCell.h"

@implementation AddressBookCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _typeL = [[UILabel alloc] initWithFrame:CGRectMake(0, 14 *SIZE, 165 *SIZE, 11 *SIZE)];
    _typeL.textColor = CLContentLabColor;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _typeL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_typeL];
    
    _dropImg = [[UIImageView alloc] initWithFrame:CGRectMake(95 *SIZE, 19 *SIZE, 7 *SIZE, 7 *SIZE)];
    [self.contentView addSubview:_dropImg];
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        
        
    }else{
        
        
    }
}
@end
