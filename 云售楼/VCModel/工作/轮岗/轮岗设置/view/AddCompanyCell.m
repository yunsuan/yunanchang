//
//  AddCompanyCell.m
//  云售楼
//
//  Created by xiaoq on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddCompanyCell.h"

@implementation AddCompanyCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.colorView];
        [self.contentView addSubview:self.displayLabel];
        [self.contentView addSubview:self.cancelBtn];
        //        self.layer.masksToBounds = YES;
        //        self.layer.cornerRadius = 1.7*SIZE;
        
    }
    return self;
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    if (self.deleteBtnBlock) {
        
        self.deleteBtnBlock((NSUInteger) self.tag);
    }
}

- (UILabel *)displayLabel{
    if (!_displayLabel) {
        _displayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0*SIZE, 17 *SIZE, self.contentView.frame.size.width , 12*SIZE)];
        _displayLabel.textAlignment = NSTextAlignmentCenter;
        _displayLabel.font = [UIFont systemFontOfSize:12*SIZE];
        _displayLabel.textColor = COLOR(115, 115, 115, 1);
    }
    return _displayLabel;
}

- (UIView *)colorView{
    
    if (!_colorView) {
        
        _colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 7 *SIZE, self.bounds.size.width - 4 *SIZE, 30 *SIZE)];
        _colorView.backgroundColor = COLOR(213, 242, 255, 1);
    }
    return _colorView;
}

- (UIButton *)cancelBtn{
    
    if (!_cancelBtn) {
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(self.bounds.size.width - 18 *SIZE, 0, 18 *SIZE, 18 *SIZE);
        [_cancelBtn setImage:[UIImage imageNamed:@"delete_2"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(void)setstylebytype:(NSString *)type andsetlab:(NSString *)str{
    _displayLabel.text = str;
    _colorView.backgroundColor = COLOR(27, 152, 255, 1);
   _displayLabel.textColor = CLWhiteColor;
    
}

@end
