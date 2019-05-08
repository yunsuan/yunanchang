//
//  BorderTextField.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BorderTextField.h"

@implementation BorderTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3 *SIZE;
    self.layer.borderColor = CLLightGrayColor.CGColor;
    self.layer.borderWidth = SIZE;
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(12 *SIZE, 0, self.bounds.size.width - 12 *SIZE, self.bounds.size.height)];
    _textField.font = FONT(13 *SIZE);
    _textField.textColor = CLContentLabColor;
//    _textField.layer.cornerRadius = 3 *SIZE;
//    _textField.layer.borderColor = CLLightGrayColor.CGColor;
//    _textField.layer.borderWidth = SIZE;
//    _textField.clipsToBounds = YES;
    [self addSubview:_textField];
}

@end
