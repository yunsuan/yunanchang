//
//  NumeralDetailInvalidView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NumeralDetailInvalidView.h"

@implementation NumeralDetailInvalidView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        
    }
    return self;
}

- (void)ActionConfirmBtn:(UIButton *)btn{
 
    if (self.numeralDetailInvalidViewBlock) {
        
        self.numeralDetailInvalidViewBlock();
    }
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 123 *SIZE, 250 *SIZE, 200 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(220 *SIZE, 4 *SIZE, 26 *SIZE, 26 *SIZE);
    [cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setImage:[UIImage imageNamed:@"fork"] forState:UIControlStateNormal];
    [whiteView addSubview:cancelBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(23 *SIZE, 34 *SIZE, 100 *SIZE, 13 *SIZE)];
    label.textColor = CL86Color;
    label.text = @"作废原因";
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    [whiteView addSubview:label];
        
    _reasonTV = [[UITextView alloc] initWithFrame:CGRectMake(23 *SIZE, 60 *SIZE, 204 *SIZE, 77 *SIZE)];
    _reasonTV.contentInset = UIEdgeInsetsMake(5 *SIZE, 5 *SIZE, 5 *SIZE, 5 *SIZE);
    _reasonTV.layer.cornerRadius = 5 *SIZE;
    _reasonTV.layer.borderWidth = SIZE;
    _reasonTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _reasonTV.clipsToBounds = YES;
    [whiteView addSubview:_reasonTV];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(23 *SIZE, 155 *SIZE, 203 *SIZE, 37 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:CLBlueBtnColor];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [whiteView addSubview:_confirmBtn];
}

@end
