//
//  DropBtn.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "DropBtn.h"

@implementation DropBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3 *SIZE;
        self.layer.borderColor = CLLightGrayColor.CGColor;
        self.layer.borderWidth = SIZE;
        [self addSubview:self.content];
        [self addSubview:self.placeL];
        [self addSubview:self.dropimg];
    }
    return self;
}

-(UILabel *)content
{
    if (!_content) {
        
        _content = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 11*SIZE, self.frame.size.width - 24*SIZE, 14*SIZE)];
        _content.font = [UIFont systemFontOfSize:14*SIZE];
        _content.textColor = CLContentLabColor;
    }
    return _content;
}

- (UILabel *)placeL
{
    if (!_placeL) {
        
        _placeL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 11*SIZE, self.frame.size.width-24*SIZE, 14*SIZE)];
        _placeL.font = [UIFont systemFontOfSize:14 *SIZE];
        _placeL.textColor = CLPlaceColor;
    }
    return _placeL;
}

-(UIImageView *)dropimg
{
    if (!_dropimg) {
        
        _dropimg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"downarrow-1"]];
        _dropimg.frame = CGRectMake(self.frame.size.width- 19 *SIZE, 13 *SIZE, 13 *SIZE, 13 *SIZE);
    }
    return _dropimg;
}

@end
