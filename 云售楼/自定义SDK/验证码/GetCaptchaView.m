//
//  GetCaptchaView.m
//  云渠道
//
//  Created by 谷治墙 on 2019/4/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "GetCaptchaView.h"

#import "CaptchaView.h"

@interface GetCaptchaView ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *_input;
    CaptchaView *_captchaView;

}
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation GetCaptchaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

/** 大写字母转换为小写 */
- (NSString *)toLower:(NSString *)str {
    for (int i = 0; i < str.length; i++) {
        if ([str characterAtIndex:i] >= 'A' && [str characterAtIndex:i] <= 'Z') {
            char temp = [str characterAtIndex:i] + 32;
            NSRange range = NSMakeRange(i, 1);
            str = [str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c" , temp]];
        }
    }
    return str;
}

- (void)ActionComfirmBtn:(UIButton *)btn{
    
    //判断输入的是否为验证图片显示的验证码
    if ([[self toLower:_input.text] isEqualToString:[self toLower:_captchaView.changeString]]) {
        //正确弹出警告款提示正确
        if (self.getCaptchaViewBlock) {
            
            self.getCaptchaViewBlock();
            [self removeFromSuperview];
        }
    }
    else
    {
        //验证不匹配，验证码和输入框晃动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [_captchaView.layer addAnimation:anim forKey:nil];
        [_input.layer addAnimation:anim forKey:nil];
    }
}

- (void)initUI{

    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(40 *SIZE, 200 *SIZE, 280 *SIZE, 200 *SIZE)];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 5 *SIZE;
    alertView.clipsToBounds = YES;
    [self addSubview:alertView];
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(20 *SIZE, 10 *SIZE, 240 *SIZE, 20 *SIZE)];
    labe.text = @"请验证图形码";
    labe.font = [UIFont systemFontOfSize:14 *SIZE];
    labe.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:labe];
    
    //显示验证码界面
    _captchaView = [[CaptchaView alloc] initWithFrame:CGRectMake(20 *SIZE, 40 *SIZE, 150 *SIZE, 40 *SIZE)];
    [alertView addSubview:_captchaView];
    
    //提示文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(180 *SIZE, 40 *SIZE, 90 *SIZE, 40 *SIZE)];
    label.text = @"点击图片换验证码";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    label.textColor = [UIColor grayColor];
    [alertView addSubview:label];
    
    //添加输入框
    _input = [[UITextField alloc] initWithFrame:CGRectMake(20 *SIZE, 100 *SIZE, 240 *SIZE, 40 *SIZE)];
    _input.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _input.layer.borderWidth = 1 *SIZE;
    _input.layer.cornerRadius = 5.0 *SIZE;
    _input.font = [UIFont systemFontOfSize:13 *SIZE];
    _input.placeholder = @"请输入验证码!";
    _input.clearButtonMode = UITextFieldViewModeWhileEditing;
    _input.backgroundColor = [UIColor clearColor];
    _input.textAlignment = NSTextAlignmentCenter;
    _input.returnKeyType = UIReturnKeyDone;
    _input.delegate = self;
    [alertView addSubview:_input];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, 160 *SIZE, 140 *SIZE, 40 *SIZE);
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [alertView addSubview:_cancelBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(140 *SIZE, 160 *SIZE, 140 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionComfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"验证" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:_confirmBtn];
    
    UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, 159 *SIZE, 280 *SIZE, SIZE)];
    horizontal.backgroundColor = CLBackColor;
    [alertView addSubview:horizontal];
    
    UIView *vertical = [[UIView alloc] initWithFrame:CGRectMake(140 *SIZE, 160 *SIZE, SIZE, 40 *SIZE)];
    vertical.backgroundColor = CLBackColor;
    [alertView addSubview:vertical];
}


@end
