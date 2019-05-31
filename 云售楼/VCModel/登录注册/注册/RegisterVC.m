//
//  RegisterVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RegisterVC.h"

#import "LoginVC.h"

#import "GetCaptchaView.h"

@interface RegisterVC ()<UITextFieldDelegate>
{
    NSInteger surplusTime;//重新发送短信的倒计时时间
    NSTimer *time;
    NSDateFormatter *_formatter;
}
@property (nonatomic , strong) UITextField *AccountTF;

@property (nonatomic , strong) UITextField *CodeTF;

@property (nonatomic , strong) UITextField *PassWordTF;

//@property (nonatomic , strong) UITextField *recommendTF;

@property (nonatomic , strong) UIButton *GetCodeBtn;

@property (nonatomic , strong) UIButton *RegisterBtn;

//@property (nonatomic , strong) UIButton *ProtocolBtn;

@property (nonatomic , strong) UITextField *SurePassWordTF;

@property (nonatomic, strong)  UILabel *timeLabel;

@property (nonatomic, strong) GetCaptchaView *getCaptchaView;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBackgroundView.backgroundColor = CLBackColor;
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYYMMdd"];
    
    [self InitUI];
}

-(void)InitUI
{
    
    self.navImg.hidden = YES;
    [self.view addSubview:self.RegisterBtn];
    [self.view addSubview:self.AccountTF];
    [self.view addSubview:self.CodeTF];
    [self.view addSubview:self.GetCodeBtn];
    [self.view addSubview:self.SurePassWordTF];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.PassWordTF];
//    [self.view addSubview:self.recommendTF];
    UILabel  *title = [[UILabel alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+53*SIZE, 100*SIZE, 22*SIZE)];
    title.text = @"账号注册";
    title.font = [UIFont systemFontOfSize:21*SIZE];
    title.textColor = CLTitleLabColor;
    [self.view addSubview:title];
    
    for (int i = 0; i < 4; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+154*SIZE+47*SIZE*i, 316*SIZE, 0.5*SIZE)];
        line.backgroundColor = COLOR(180, 180, 180, 1);
        [self.view addSubview:line];
    }
}

-(void)Register
{
    
    if (![self checkTel:_AccountTF.text]) {
        [self showContent:@"请输入正确的电话号码！"];
    }
    if ([_CodeTF.text isEqualToString:@""]) {
        [self showContent:@"请输入验证码！"];
        return;
    }
    if (_PassWordTF.text.length<6) {
        [self showContent:@"密码长度至少为6位"];
        return;
    }
//    if (![self checkPassword:_PassWord.text]) {
//        [self showContent:@"密码格式错误,必须包含数字和字母！"];
//        return;
//    }
    
    if (![_PassWordTF.text isEqualToString:_SurePassWordTF.text]) {
        [self showContent:@"两次输入的密码不相同！"];
        return;
    }
    
    
    NSDictionary *temp = @{
                           @"account":_AccountTF.text,
                           @"password":_PassWordTF.text,
                           @"password_verify":_SurePassWordTF.text,
                           @"captcha":_CodeTF.text
                           };
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:temp];
    [BaseRequest POST:Register_URL parameters:parameter success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            LoginVC *next_vc = [[LoginVC alloc]init];
            [UserModel defaultModel].loginAccount = self->_AccountTF.text;
            [UserModel defaultModel].passWord = self->_PassWordTF.text;
            [UserModelArchiver archive];
            [self.navigationController pushViewController:next_vc animated:YES];
            [self alertControllerWithNsstring:@"系统提示" And:@"恭喜你注册成功，请妥善保管好账号"];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
    }];
    
}

-(void)GetCode{
    //获取验证码
    
    if([self checkTel:_AccountTF.text]) {
        
        if ([[UserModel defaultModel].time isEqualToString:[_formatter stringFromDate:[NSDate date]]]) {
            
            if (![UserModel defaultModel].registerUp) {
                
                [UserModel defaultModel].registerUp = 1;
                [UserModelArchiver archive];
            }else{
                
                [UserModel defaultModel].registerUp += 1;
                [UserModelArchiver archive];
            }
        }else{
            
            [UserModel defaultModel].time = [_formatter stringFromDate:[NSDate date]];
            [UserModel defaultModel].registerUp = 1;
            [UserModelArchiver archive];
        }
        if ([UserModel defaultModel].registerUp > 5) {
            
            _GetCodeBtn.userInteractionEnabled = YES;
            _getCaptchaView = [[GetCaptchaView alloc] initWithFrame:self.view.bounds];
            _getCaptchaView.getCaptchaViewBlock = ^{
                
                self->_GetCodeBtn.userInteractionEnabled = NO;
                NSDictionary *parameter = @{
                                            @"tel":self->_AccountTF.text,
                                            @"token":[self md5:@"yunsuankeji"]
                                            };
                [BaseRequest GET:Captcha_URL parameters:parameter success:^(id resposeObject) {
                    NSLog(@"%@",resposeObject);
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [self showContent:@"验证码有效期为60分钟"];
                        
                        self->_GetCodeBtn.hidden = YES;
                        self->_timeLabel.hidden = NO;
                        self->surplusTime = 60;
                        self->_timeLabel.text = [NSString stringWithFormat:@"%ldS", (long)self->surplusTime];
                        //倒计时
                        self->time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
                        
                    }
                    else{
                        [self showContent:resposeObject[@"msg"]];
                    }
                    self->_GetCodeBtn.userInteractionEnabled = YES;
                } failure:^(NSError *error) {
                    self->_GetCodeBtn.userInteractionEnabled = YES;
                    [self showContent:@"网络错误"];
                }];
            };
            [self.view addSubview:_getCaptchaView];
        }else{
            
            _GetCodeBtn.userInteractionEnabled = NO;
            NSDictionary *parameter = @{
                                        @"tel":_AccountTF.text,
                                        @"token":[self md5:@"yunsuankeji"]
                                        };
            [BaseRequest GET:Captcha_URL parameters:parameter success:^(id resposeObject) {
                NSLog(@"%@",resposeObject);
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [self showContent:@"验证码有效期为60分钟"];
                    
                    self->_GetCodeBtn.hidden = YES;
                    self->_timeLabel.hidden = NO;
                    self->surplusTime = 60;
                    self->_timeLabel.text = [NSString stringWithFormat:@"%ldS", (long)self->surplusTime];
                    //倒计时
                    self->time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
                    
                }
                else{
                    [self showContent:resposeObject[@"msg"]];
                }
                self->_GetCodeBtn.userInteractionEnabled = YES;
            } failure:^(NSError *error) {
                self->_GetCodeBtn.userInteractionEnabled = YES;
                [self showContent:@"网络错误"];
            }];
        }
    }
    else
    {
        
        _GetCodeBtn.userInteractionEnabled = YES;
        [self showContent:@"请输入正确的电话号码"];
    }
}

- (void)updateTime {
    surplusTime--;
    _timeLabel.text = [NSString stringWithFormat:@"%ldS", (long)surplusTime];
    if (surplusTime == 0) {
        [time invalidate];
        time = nil;
        _timeLabel.hidden = YES;
        _GetCodeBtn.hidden = NO;
    }
}





//-(void)Protocol
//{
//
//}



-(UITextField *)AccountTF{
    if (!_AccountTF) {
        _AccountTF = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+124*SIZE, 314*SIZE, 15*SIZE)];
        _AccountTF.placeholder = @"请输入手机号码";
        _AccountTF.keyboardType = UIKeyboardTypeNumberPad;
        _AccountTF.font = [UIFont systemFontOfSize:14*SIZE];
        [_AccountTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _AccountTF;
}

-(UITextField *)CodeTF{
    if (!_CodeTF) {
        _CodeTF = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+171*SIZE, 200*SIZE, 15*SIZE)];
        _CodeTF.placeholder = @"请输入验证码";
        _CodeTF.keyboardType = UIKeyboardTypeNumberPad;
        _CodeTF.font = [UIFont systemFontOfSize:14*SIZE];
        [_CodeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _CodeTF;
}

-(UITextField *)PassWordTF
{
    if (!_PassWordTF) {
        _PassWordTF = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+218*SIZE, 314*SIZE, 15*SIZE)];
        _PassWordTF.placeholder = @"请输入密码";
        _PassWordTF.font = [UIFont systemFontOfSize:14*SIZE];
        [_PassWordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _PassWordTF.secureTextEntry = YES;
        
    }
    return _PassWordTF;
}

-(UITextField *)SurePassWordTF
{
    if (!_SurePassWordTF) {
        _SurePassWordTF = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+265*SIZE, 314*SIZE, 15*SIZE)];
        _SurePassWordTF.placeholder = @"再次输入密码";
        _SurePassWordTF.font = [UIFont systemFontOfSize:14*SIZE];
        [_SurePassWordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _SurePassWordTF.secureTextEntry = YES;
    }
    return _SurePassWordTF;
}

//-(UITextField *)recommendTF
//{
//    if (!_recommendTF) {
//        _recommendTF = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+312*SIZE, 314*SIZE, 20*SIZE)];
//        _recommendTF.placeholder = @"推荐人号码(选填)";
//        _recommendTF.font = [UIFont systemFontOfSize:14*SIZE];
//        [_recommendTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    }
//    return _recommendTF;
//}

-(UIButton *)RegisterBtn
{
    if (!_RegisterBtn) {
        _RegisterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _RegisterBtn.frame = CGRectMake(22*SIZE, 377*SIZE+STATUS_BAR_HEIGHT, 316*SIZE, 41*SIZE);
        _RegisterBtn.layer.masksToBounds = YES;
        _RegisterBtn.layer.cornerRadius = 20 *SIZE;
        _RegisterBtn.backgroundColor = CLLoginBtnColor;
        [_RegisterBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_RegisterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _RegisterBtn.titleLabel.font = [UIFont systemFontOfSize:16*SIZE];
        [_RegisterBtn addTarget:self action:@selector(Register) forControlEvents:UIControlEventTouchUpInside];
    }
    return _RegisterBtn;
}

-(UIButton *)GetCodeBtn
{
    if (!_GetCodeBtn) {
        _GetCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _GetCodeBtn.frame =  CGRectMake(236*SIZE, 171*SIZE+STATUS_BAR_HEIGHT, 100*SIZE, 15*SIZE);
        [_GetCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_GetCodeBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
        _GetCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14*SIZE];
        [_GetCodeBtn addTarget:self action:@selector(GetCode) forControlEvents:UIControlEventTouchUpInside];
        _GetCodeBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    }
    return _GetCodeBtn;
}


//-(UIButton *)ProtocolBtn
//{
//    if (!_ProtocolBtn) {
//        _ProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _ProtocolBtn.frame =  CGRectMake(0, SCREEN_Height-TAB_BAR_MORE-13*SIZE-19*SIZE, 360*SIZE, 13*SIZE);
//        [_ProtocolBtn setTitle:@"注册/登录即代表同意《易家用户使用协议》" forState: UIControlStateNormal];
//        [_ProtocolBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
//        _ProtocolBtn.titleLabel.font = [UIFont systemFontOfSize:12*SIZE];
//        [_ProtocolBtn addTarget:self action:@selector(Protocol) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _ProtocolBtn;
//}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(247*SIZE, 172*SIZE+STATUS_BAR_HEIGHT, 100*SIZE, 15*SIZE)];
        _timeLabel.textColor = CLContentLabColor;
        _timeLabel.font = [UIFont systemFontOfSize:14 * SIZE];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.hidden = YES;
        
    }
    return _timeLabel;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _AccountTF) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == _CodeTF) {
        if (textField.text.length > 4) {
            textField.text = [textField.text substringToIndex:4];
        }
    }
    if (textField == _PassWordTF) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
    if (textField == _SurePassWordTF) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
//    if (textField == _recommendTF) {
//        
//        if (textField.text.length > 11) {
//            
//            textField.text = [textField.text substringToIndex:11];
//        }
//    }
}

@end
