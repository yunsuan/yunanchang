//
//  ChangePassWordVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ChangePassWordVC.h"

@interface ChangePassWordVC ()<UITextFieldDelegate>

@property (nonatomic , strong) UITextField *Account;
@property (nonatomic , strong) UITextField *PassWord;
@property (nonatomic , strong) UIButton *RegisterBtn;
//@property (nonatomic , strong) UIButton *ProtocolBtn;
@property (nonatomic , strong) UITextField *SurePassWord;


@end

@implementation ChangePassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navBackgroundView.hidden = NO;
    self.line.hidden = YES;
//    self.navBackgroundView.backgroundColor = CLLineColor;
    [self InitUI];
    
}

-(void)InitUI
{
    
    self.navBackgroundView.backgroundColor = CLBackColor;
    
    [self.view addSubview:self.RegisterBtn];
    [self.view addSubview:self.Account];
    [self.view addSubview:self.SurePassWord];
    [self.view addSubview:self.PassWord];
    [self.view addSubview:self.leftButton];
    
    UILabel  *title = [[UILabel alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+53*SIZE, 100*SIZE, 22*SIZE)];
    title.text = @"修改密码";
    title.font = [UIFont systemFontOfSize:21*SIZE];
    title.textColor = CLTitleLabColor;
    [self.view addSubview:title];
    
    for (int i = 0; i < 3; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+154*SIZE+47*SIZE*i, 316*SIZE, 0.5*SIZE)];
        line.backgroundColor = COLOR(180, 180, 180, 1);
        [self.view addSubview:line];
    }
}

-(void)Register
{
    
    if (_PassWord.text.length<6) {
        [self showContent:@"密码长度至少为6位"];
        return;
    }

    if (![_PassWord.text isEqualToString:_SurePassWord.text]) {
        [self showContent:@"两次输入的密码不相同！"];
        return;
    }
    
    NSDictionary *parameter = @{
                                @"old_password":_Account.text,
                                @"password":_PassWord.text,
                                @"password_verify":_SurePassWord.text
                                };
    
    [BaseRequest POST:UserPersonalChangePassword_URL parameters:parameter success:^(id resposeObject) {
        //        NSLog(@"%@",resposeObject);

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [UserModel defaultModel].passWord = self->_PassWord.text;
            [UserModelArchiver archive];

            [self alertControllerWithNsstring:@"系统提示" And:[NSString stringWithFormat:@"修改密码成功，你的新密码为：%@，请妥善保管",self->_PassWord.text] WithDefaultBlack:^{
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else{
            
            [self showContent:resposeObject[@"msg"]];
        }

    } failure:^(NSError *error) {
        [self showContent:@"网络错误"];
    }];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.Account) {
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 18) {
            return NO;
        }
    }else if (textField == self.PassWord || textField == self.SurePassWord){
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 18) {
            return NO;
        }
    }
    return YES;
}

-(UITextField *)Account{
    if (!_Account) {
        _Account = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+119*SIZE, 300*SIZE, 30*SIZE)];
        _Account.placeholder = @"请输入原始密码";
        _Account.keyboardType = UIKeyboardTypeDefault;
        _Account.delegate = self;
        _Account.font = [UIFont systemFontOfSize:14*SIZE];
        
    }
    return _Account;
}



-(UITextField *)PassWord
{
    if (!_PassWord) {
        _PassWord = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+166*SIZE, 300*SIZE, 30*SIZE)];
        _PassWord.placeholder = @"请输入新密码";
        _PassWord.secureTextEntry = YES;
        _PassWord.keyboardType = UIKeyboardTypeDefault;
        _PassWord.font = [UIFont systemFontOfSize:14*SIZE];
        
    }
    return _PassWord;
}

-(UITextField *)SurePassWord
{
    if (!_SurePassWord) {
        _SurePassWord = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, STATUS_BAR_HEIGHT+213*SIZE, 300*SIZE, 30*SIZE)];
        _SurePassWord.placeholder = @"再次输入新密码";
        _SurePassWord.secureTextEntry = YES;
        _SurePassWord.keyboardType = UIKeyboardTypeDefault;
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
        _RegisterBtn.backgroundColor = CLBlueBtnColor;;
        [_RegisterBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        [_RegisterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _RegisterBtn.titleLabel.font = [UIFont systemFontOfSize:16*SIZE];
        [_RegisterBtn addTarget:self action:@selector(Register) forControlEvents:UIControlEventTouchUpInside];
    }
    return _RegisterBtn;
}



@end
