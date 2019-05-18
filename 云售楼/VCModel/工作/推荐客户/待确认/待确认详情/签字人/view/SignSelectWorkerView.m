//
//  SignSelectWorkerView.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SignSelectWorkerView.h"

#import "SignWorkerPickView.h"

@implementation SignSelectWorkerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self removeFromSuperview];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
        SignWorkerPickView *view = [[SignWorkerPickView alloc] initWithFrame:self.bounds WithData:self.dataArr];
        WS(weakSelf);
        view.signWorkerPickViewBlock = ^(NSString * _Nonnull Name, NSString * _Nonnull ID, NSString * _Nonnull tel) {
           
            if (Name) {
                weakSelf.nameL.text = [NSString stringWithFormat:@"%@/%@",Name,tel];
            }
            else
            {
                weakSelf.nameL.text = [NSString stringWithFormat:@"%@/%@",ID,tel];
            }
//            weakSelf.phoneL.text = [NSString stringWithFormat:@"联系电话：%@",tel];
            weakSelf.agentId = [NSString stringWithFormat:@"%@",ID];
        };
        [self addSubview:view];
    }else{
        
        if (_nameL.text.length) {
            
            if (self.signSelectWorkerViewBlock) {
                
                self.signSelectWorkerViewBlock();
                [self removeFromSuperview];
            }
        }else{
            
            
        }
    }
}

- (void)initUI{

    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    alphaView.userInteractionEnabled = YES;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 206 *SIZE, 250 *SIZE, 270 *SIZE)];
    
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_whiteView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24 *SIZE, 250 *SIZE, 13 *SIZE)];
    label.textColor = CLTitleLabColor;
    label.font = [UIFont systemFontOfSize:14 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"指定下一步确认人";
    [_whiteView addSubview:label];
    
    _nameView = [[UIView alloc] initWithFrame:CGRectMake(25 *SIZE, 65 *SIZE, 200 *SIZE, 33 *SIZE)];
    _nameView.backgroundColor = COLOR(238, 238, 238, 1);
    [_whiteView addSubview:_nameView];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(8 *SIZE, 11 *SIZE, 160 *SIZE, 11 *SIZE)];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    //    _nameL.text = @""
    [_nameView addSubview:_nameL];
    
    _dropImg = [[UIImageView alloc] initWithFrame:CGRectMake(185 *SIZE, 15 *SIZE, 8 *SIZE,  8 *SIZE)];
    _dropImg.image = [UIImage imageNamed:@"downarrow1"];
    [_nameView addSubview:_dropImg];
    
    _nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nameBtn.frame = _nameView.bounds;
    _nameBtn.tag = 0;
    [_nameBtn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nameView addSubview:_nameBtn];
    
    _phoneL = [[UILabel alloc] initWithFrame:CGRectMake(32 *SIZE, 112 *SIZE, 250 *SIZE, 11 *SIZE)];
    _phoneL.textColor = CLTitleLabColor;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    _phoneL.text = @"备注:";
    [_whiteView addSubview:_phoneL];
    
    _markTV = [[UITextView alloc] initWithFrame:CGRectMake(25 *SIZE, 140 *SIZE, 200 *SIZE, 50 *SIZE)];
    _markTV.keyboardType = UIKeyboardTypeDefault;
    _markTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _markTV.layer.borderWidth = SIZE;
    _markTV.clipsToBounds = YES;
    _markTV.layer.cornerRadius = 3 *SIZE;
    [_whiteView addSubview:_markTV];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(25 *SIZE, 205 *SIZE, 200 *SIZE, 37 *SIZE);
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    _recommendBtn.tag = 1;
    [_recommendBtn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:CLBlueBtnColor];
    [_whiteView addSubview:_recommendBtn];
}
@end
