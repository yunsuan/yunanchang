//
//  ChangeFileNameView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChangeFileNameView.h"

@interface ChangeFileNameView ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    
    UITextField *_input;

    NSString *_name;
}
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIButton *cancelBtn;

@end
@implementation ChangeFileNameView

- (instancetype)initWithFrame:(CGRect)frame name:(nonnull NSString *)name
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _name = name;
        [self initUI];
    }
    return self;
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (void)ActionComfirmBtn:(UIButton *)btn{
    
    if (self.changeFileNameViewBlock) {
        
        self.changeFileNameViewBlock(_input.text);
    }
    [self removeFromSuperview];
}

- (void)initUI{

    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(40 *SIZE, 200 *SIZE, 280 *SIZE, 160 *SIZE)];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 5 *SIZE;
    alertView.clipsToBounds = YES;
    [self addSubview:alertView];
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(20 *SIZE, 10 *SIZE, 240 *SIZE, 20 *SIZE)];
    labe.text = @"请输入文件名称";
    labe.font = [UIFont systemFontOfSize:14 *SIZE];
    labe.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:labe];

    
    //添加输入框
    _input = [[UITextField alloc] initWithFrame:CGRectMake(20 *SIZE, 60 *SIZE, 240 *SIZE, 40 *SIZE)];
    _input.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _input.layer.borderWidth = 1 *SIZE;
    _input.layer.cornerRadius = 5.0 *SIZE;
    _input.font = [UIFont systemFontOfSize:13 *SIZE];
    _input.text = _name;
    _input.placeholder = @"请输入文件名称!";
    _input.clearButtonMode = UITextFieldViewModeWhileEditing;
    _input.backgroundColor = [UIColor clearColor];
    _input.textAlignment = NSTextAlignmentCenter;
    _input.returnKeyType = UIReturnKeyDone;
    _input.delegate = self;
    [alertView addSubview:_input];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, 120 *SIZE, 140 *SIZE, 40 *SIZE);
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:_cancelBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(140 *SIZE, 120 *SIZE, 140 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionComfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [alertView addSubview:_confirmBtn];
    
    UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, 119 *SIZE, 280 *SIZE, SIZE)];
    horizontal.backgroundColor = CLBackColor;
    [alertView addSubview:horizontal];
    
    UIView *vertical = [[UIView alloc] initWithFrame:CGRectMake(140 *SIZE, 120 *SIZE, SIZE, 40 *SIZE)];
    vertical.backgroundColor = CLBackColor;
    [alertView addSubview:vertical];
}


@end
