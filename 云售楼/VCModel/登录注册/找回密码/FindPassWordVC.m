//
//  FindPassWordVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "FindPassWordVC.h"

#import "LoginVC.h"

#import "GetCaptchaView.h"

@interface FindPassWordVC ()
{
    NSInteger surplusTime;//重新发送短信的倒计时时间
    NSTimer *time;
    NSDateFormatter *_formatter;
}
@property (nonatomic , strong) UITextField *Account;
@property (nonatomic , strong) UITextField *Code;
@property (nonatomic , strong) UITextField *PassWord;
@property (nonatomic , strong) UIButton *GetCodeBtn;
@property (nonatomic , strong) UIButton *RegisterBtn;
@property (nonatomic , strong) UITextField *SurePassWord;
@property (nonatomic, strong)  UILabel *timeLabel;

@property (nonatomic, strong) GetCaptchaView *getCaptchaView;

@end

@implementation FindPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBackgroundView.hidden = NO;
    self.navBackgroundView.backgroundColor = CLBackColor;
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYYMMdd"];
    [self InitUI];
}

-(void)InitUI
{
    [self.view addSubview:self.RegisterBtn];
    [self.view addSubview:self.Account];
    [self.view addSubview:self.Code];
    [self.view addSubview:self.GetCodeBtn];
    [self.view addSubview:self.SurePassWord];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.PassWord];
    UILabel  *title = [[UILabel alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+53*SIZE, 100*SIZE, 22*SIZE)];
    title.text = @"忘记密码";
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
    if (![self checkTel:_Account.text]) {
        [self showContent:@"请输入正确的电话号码！"];
    }
    if ([_Code.text isEqualToString:@""]) {
        [self showContent:@"请输入验证码！"];
        return;
    }
    if (_PassWord.text.length<6) {
        [self showContent:@"密码长度至少为6位"];
        return;
    }
//    if (![self checkPassword:_PassWord.text]) {
//        [self showContent:@"密码格式错误！"];
//        return;
//    }
    
    if (![_PassWord.text isEqualToString:_SurePassWord.text]) {
        [self showContent:@"两次输入的密码不相同！"];
        return;
    }
    
    
    NSDictionary *temp = @{
                           @"tel":_Account.text,
                           @"password":_PassWord.text,
                           @"password_verify":_SurePassWord.text,
                           @"captcha":_Code.text
                           };
    
    [BaseRequest POST:ForgetPassWord_URL parameters:temp success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            LoginVC *next_vc = [[LoginVC alloc]init];
            [UserModel defaultModel].loginAccount = self->_Account.text;
            [UserModel defaultModel].passWord = self->_PassWord.text;
            [UserModelArchiver archive];
            [self alertControllerWithNsstring:@"系统提示" And:@"修改密码成功，请妥善保管好账号" WithDefaultBlack:^{
                
                [self.navigationController pushViewController:next_vc animated:YES];
            }];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
    }];
    //    LoginVC *next_vc = [[LoginVC alloc]init];
    //    [self.navigationController pushViewController:next_vc animated:YES];
}

-(void)GetCode{
    //获取验证码
    if([self checkTel:_Account.text]) {
        
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
                
                _GetCodeBtn.userInteractionEnabled = NO;
                NSDictionary *parameter = @{
                                            @"tel":_Account.text,
                                            @"token":[self md5:@"yunsuankeji"]
                                            };
                [BaseRequest GET:Captcha_URL parameters:parameter success:^(id resposeObject) {
                    NSLog(@"%@",resposeObject);
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [self showContent:@"验证码有效期为60分钟"];
                        
                        _GetCodeBtn.hidden = YES;
                        _timeLabel.hidden = NO;
                        surplusTime = 60;
                        _timeLabel.text = [NSString stringWithFormat:@"%ldS", (long)surplusTime];
                        //倒计时
                        time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
                        
                    }
                    else{
                        [self showContent:resposeObject[@"msg"]];
                    }
                    _GetCodeBtn.userInteractionEnabled = YES;
                } failure:^(NSError *error) {
                    _GetCodeBtn.userInteractionEnabled = YES;
                    [self showContent:@"网络错误"];
                }];
            };
            [self.view addSubview:_getCaptchaView];
        }else{
            
            _GetCodeBtn.userInteractionEnabled = NO;
            NSDictionary *parameter = @{
                                        @"tel":_Account.text,
                                        @"token":[self md5:@"yunsuankeji"]
                                        };
            [BaseRequest GET:Captcha_URL parameters:parameter success:^(id resposeObject) {
                NSLog(@"%@",resposeObject);
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [self showContent:@"验证码有效期为60分钟"];
                    
                    _GetCodeBtn.hidden = YES;
                    _timeLabel.hidden = NO;
                    surplusTime = 60;
                    _timeLabel.text = [NSString stringWithFormat:@"%ldS", (long)surplusTime];
                    //倒计时
                    time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
                    
                }
                else{
                    [self showContent:resposeObject[@"msg"]];
                }
                _GetCodeBtn.userInteractionEnabled = YES;
            } failure:^(NSError *error) {
                _GetCodeBtn.userInteractionEnabled = YES;
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



-(UITextField *)Account{
    if (!_Account) {
        _Account = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+124*SIZE, 300*SIZE, 30*SIZE)];
        _Account.placeholder = @"请输入手机号码";
        _Account.keyboardType = UIKeyboardTypeNumberPad;
        _Account.font = [UIFont systemFontOfSize:14*SIZE];
        
    }
    return _Account;
}

-(UITextField *)Code{
    if (!_Code) {
        _Code = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+171*SIZE, 200*SIZE, 30*SIZE)];
        _Code.placeholder = @"请输入验证码";
        _Code.keyboardType = UIKeyboardTypeNumberPad;
        _Code.font = [UIFont systemFontOfSize:14*SIZE];
        
    }
    return _Code;
}

-(UITextField *)PassWord
{
    if (!_PassWord) {
        _PassWord = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+218*SIZE, 300*SIZE, 30*SIZE)];
        _PassWord.placeholder = @"请输入密码";
        _PassWord.secureTextEntry = YES;
        _PassWord.font = [UIFont systemFontOfSize:14*SIZE];
        
    }
    return _PassWord;
}

-(UITextField *)SurePassWord
{
    if (!_SurePassWord) {
        _SurePassWord = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+265*SIZE, 300*SIZE, 30*SIZE)];
        _SurePassWord.placeholder = @"再次输入密码";
        _SurePassWord.secureTextEntry = YES;
        _SurePassWord.font = [UIFont systemFontOfSize:14*SIZE];
    }
    return _SurePassWord;
}

-(UIButton *)RegisterBtn
{
    if (!_RegisterBtn) {
        _RegisterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _RegisterBtn.frame = CGRectMake(22*SIZE, 340*SIZE+STATUS_BAR_HEIGHT, 316*SIZE, 41*SIZE);
        _RegisterBtn.layer.masksToBounds = YES;
        _RegisterBtn.layer.cornerRadius = 2*SIZE;
        _RegisterBtn.backgroundColor = CLBlueBtnColor;
        [_RegisterBtn setTitle:@"找回密码" forState:UIControlStateNormal];
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
        _GetCodeBtn.frame =  CGRectMake(236*SIZE, 171*SIZE+STATUS_BAR_HEIGHT, 100*SIZE, 30*SIZE);
        [_GetCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_GetCodeBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
        _GetCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14*SIZE];
        [_GetCodeBtn addTarget:self action:@selector(GetCode) forControlEvents:UIControlEventTouchUpInside];
        _GetCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _GetCodeBtn;
}


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

@end
