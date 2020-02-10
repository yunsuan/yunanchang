//
//  LoginVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LoginVC.h"
#import "PowerMannerger.h"

#import "RegisterVC.h"
#import "FindPassWordVC.h"
#import "CompanyApplyVC.h"

@interface LoginVC ()

@property (nonatomic, strong) UITextField *AccountTF;

@property (nonatomic, strong) UITextField *PassWordTF;

@property (nonatomic, strong) UIButton *RegisterBtn;

@property (nonatomic, strong) UIButton *QuickLoginBtn;

@property (nonatomic, strong) UIButton *LoginBtn;

@property (nonatomic, strong) UIImageView *protocolImg;

@property (nonatomic, strong) UILabel *protocolLabel;

@property (nonatomic, strong) UIButton *ProtocolBtn;

@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) UIButton *FindPassWordBtn;

@property (nonatomic, strong) UIImageView *Headerimg;

@property (nonatomic, strong) UIButton *settingbtn;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

-(void)action_sever
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"服务器选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cs = [UIAlertAction actionWithTitle:@"测试服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"ServerControl.plist"];
        NSArray *dataarr  = @[@"http://120.27.21.136:2798/"];
        [dataarr writeToFile:filePath atomically:YES];
        
        
    }];
    
    
//    UIAlertAction *ys = [UIAlertAction actionWithTitle:@"演示服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"ServerControl.plist"];
//        NSArray *dataarr  = @[@"http://47.106.39.169:2797/"];
//        [dataarr writeToFile:filePath atomically:YES];
//    }];
    
    UIAlertAction *zs = [UIAlertAction actionWithTitle:@"正式服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"ServerControl.plist"];
        NSArray *dataarr  = @[@"http://47.107.246.94/"];
        [dataarr writeToFile:filePath atomically:YES];
    }];
    
//    UIAlertAction *new  = [UIAlertAction actionWithTitle:@"新服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"ServerControl.plist"];
//        NSArray *dataarr  = @[@"http://47.107.246.94/"];
//        [dataarr writeToFile:filePath atomically:YES];
//    }];
    
    [alert addAction:cs];
//    [alert addAction:ys];
    [alert addAction:zs];
//    [alert addAction:new];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _AccountTF) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
    if (textField == _PassWordTF) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
}

- (void)ActionLoginBtn:(UIButton *)btn{
    
//    if (!_ProtocolBtn.selected) {
//
//        [self alertControllerWithNsstring:@"温馨提示" And:@"请同意《置业家使用条例》"];
//        return;
//    }
    if ([self isEmpty:_AccountTF.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入账号"];
        return;
    }
    
    if ([self isEmpty:_PassWordTF.text]) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入密码"];
        return;
    }
    
    NSDictionary *dic = @{@"account":_AccountTF.text,
                          @"password":_PassWordTF.text};
    [BaseRequest POST:Login_URL parameters:dic success:^(id  _Nonnull resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {

            [UserModel defaultModel].loginAccount = self->_AccountTF.text;
            [UserModel defaultModel].passWord = self->_PassWordTF.text;
            [UserModel defaultModel].agent_id = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"agent_id"]];
            [UserModel defaultModel].user_state = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"user_state"]];
            [UserModel defaultModel].token = [NSString stringWithFormat:@"%@",resposeObject[@"data"][@"token"]];
            [UserModel defaultModel].agent_company_info_id = resposeObject[@"data"][@"company_info"][@"agent_company_info_id"];
            [UserModel defaultModel].company_id = resposeObject[@"data"][@"company_info"][@"company_id"];
            [UserModel defaultModel].company_name = resposeObject[@"data"][@"company_info"][@"company_name"];
            [UserModel defaultModel].company_state = resposeObject[@"data"][@"company_info"][@"company_state"];
            [UserModel defaultModel].ex_state = resposeObject[@"data"][@"company_info"][@"ex_state"];
            [UserModel defaultModel].project_list = resposeObject[@"data"][@"company_info"][@"project_list"];
            if ([resposeObject[@"data"][@"company_info"][@"project_list"] count]) {
                
                [UserModel defaultModel].projectinfo = resposeObject[@"data"][@"company_info"][@"project_list"][0];
            }
            else{
                [UserModel defaultModel].projectinfo = nil;
            }
            
            [UserModelArchiver archive];
            [[NSUserDefaults standardUserDefaults]setValue:LOGINSUCCESS forKey:LOGINENTIFIER];
            [self InfoRequest];
            if ([UserModel defaultModel].projectinfo) {
    
                [PowerMannerger RequestPowerByprojectID:[UserModel defaultModel].projectinfo[@"project_id"] success:^(NSString * _Nonnull result) {
                    NSLog(@"%@",result);
                } failure:^(NSString * _Nonnull error) {
                    NSLog(@"%@",error);
                }];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"goHome" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
//                CompanyApplyVC *nextVC = [[CompanyApplyVC alloc] init];
//                nextVC.status = @"login";
//                [self.navigationController pushViewController:nextVC animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"goHome" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {

        [self showContent:@"登录失败，请稍后再试"];
    }];
}

- (void)InfoRequest{
    
    [BaseRequest GET:UserPersonalGetAgentInfo_URL parameters:@{} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                [self SetData:resposeObject[@"data"]];
            }else{
                
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data];
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSNull class]]) {
            
            [tempDic setObject:@"" forKey:key];
        }
    }];
    [UserInfoModel defaultModel].absolute_address = tempDic[@"absolute_address"];
    [UserInfoModel defaultModel].account = tempDic[@"account"];
    [UserInfoModel defaultModel].birth = tempDic[@"birth"];
    [UserInfoModel defaultModel].city = tempDic[@"city"];
    [UserInfoModel defaultModel].district = tempDic[@"district"];
    [UserInfoModel defaultModel].head_img = tempDic[@"head_img"];
    [UserInfoModel defaultModel].name = tempDic[@"name"];
    [UserInfoModel defaultModel].province = tempDic[@"province"];
    [UserInfoModel defaultModel].sex = [NSString stringWithFormat:@"%@",tempDic[@"sex"]];
    [UserInfoModel defaultModel].tel = tempDic[@"tel"];
//    [UserInfoModel defaultModel].slef_desc = tempDic[@"slef_desc"];
    [UserInfoModel defaultModel].self_desc = [NSString stringWithFormat:@"%@",tempDic[@"self_desc"]];
    [UserInfoModel defaultModel].slef_desc = [NSString stringWithFormat:@"%@",tempDic[@"slef_desc"]];
    [UserInfoModel defaultModel].wx_code = [NSString stringWithFormat:@"%@",tempDic[@"wx_code"]];
    [UserModelArchiver infoArchive];
}

- (void)ActionProtocolBtn:(UIButton *)btn{
    
    _ProtocolBtn.selected = !_ProtocolBtn.selected;
    if (_ProtocolBtn.selected) {
        
        _protocolImg.image = IMAGE_WITH_NAME(@"choose");
    }else{
        
        _protocolImg.image = IMAGE_WITH_NAME(@"unselected");
    }
}

- (void)ActionRegisterBtn:(UIButton *)btn{
    
    RegisterVC *nextVC = [[RegisterVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionFindPassBtn:(UIButton *)btn{
    
    FindPassWordVC *nextVC = [[FindPassWordVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.view.backgroundColor = CLWhiteColor;
//    self.line.hidden = YES;
    self.navBackgroundView.hidden = YES;
    
    [self.view addSubview:self.settingbtn];
    
    _Headerimg = [[UIImageView alloc]initWithFrame:CGRectMake(130*SIZE, 39 *SIZE + NAVIGATION_BAR_HEIGHT, 100*SIZE, 100*SIZE)];
    _Headerimg.image = [UIImage imageNamed:@"logo_anchang"];
    [self.view addSubview:_Headerimg];
    
    _AccountTF = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, 219*SIZE, 314*SIZE, 30*SIZE)];
    _AccountTF.placeholder = @"请输入帐号";
    _AccountTF.keyboardType = UIKeyboardTypeNumberPad;
    _AccountTF.font = [UIFont systemFontOfSize:14*SIZE];
    [_AccountTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _AccountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_AccountTF];
    _AccountTF.text = [UserModel defaultModel].loginAccount;
    
    _PassWordTF = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, 266*SIZE, 314*SIZE, 30*SIZE)];
    _PassWordTF.placeholder = @"请输入密码";
    _PassWordTF.font = [UIFont systemFontOfSize:14*SIZE];
    [_PassWordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _PassWordTF.secureTextEntry = YES;
    [self.view addSubview:_PassWordTF];
    _PassWordTF.text = [UserModel defaultModel].passWord;
    
    for (int i = 0; i < 2; i++) {
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(22*SIZE, 249*SIZE+47*SIZE*i, 316*SIZE, 0.5*SIZE)];
        line.backgroundColor = COLOR(130, 130, 130, 1);
        [self.view addSubview:line];
        
    }
    
//    _protocolImg = [[UIImageView alloc] initWithFrame:CGRectMake(22 *SIZE, 264 *SIZE + NAVIGATION_BAR_HEIGHT, 13 *SIZE, 13 *SIZE)];
//    _protocolImg.image = IMAGE_WITH_NAME(@"unselected");
////    [self.view addSubview:_protocolImg];
//    
//    _protocolLabel = [[UILabel alloc] initWithFrame:CGRectMake(43 *SIZE, 264 *SIZE + NAVIGATION_BAR_HEIGHT, 300 *SIZE, 12 *SIZE)];
//    _protocolLabel.textColor = CLContentLabColor;
//    _protocolLabel.font = [UIFont systemFontOfSize:12 *SIZE];
//    _protocolLabel.text = @"我已阅读并同意《置业家使用条例》";
//    [self.view addSubview:_protocolLabel];
    
    _ProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _ProtocolBtn.frame =  CGRectMake(20*SIZE, 259 *SIZE + NAVIGATION_BAR_HEIGHT, 300 *SIZE, 23 *SIZE);
    [_ProtocolBtn addTarget:self action:@selector(ActionProtocolBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_ProtocolBtn];
//    if ([UserModel defaultModel].phone.length) {
//        
//        [self ActionProtocolBtn:_ProtocolBtn];
//    }
    
    _LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _LoginBtn.frame = CGRectMake(22*SIZE, 310 *SIZE + NAVIGATION_BAR_HEIGHT, 331*SIZE, 41*SIZE);
    _LoginBtn.layer.masksToBounds = YES;
    _LoginBtn.layer.cornerRadius = 20 *SIZE;
    _LoginBtn.backgroundColor = CLLoginBtnColor;
    [_LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _LoginBtn.titleLabel.font = [UIFont systemFontOfSize:16*SIZE];
    [_LoginBtn addTarget:self action:@selector(ActionLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_LoginBtn];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.frame = CGRectMake(17 *SIZE, 10 *SIZE + CGRectGetMaxY(_LoginBtn.frame), 65*SIZE, 25*SIZE);
    [_registerBtn setTitle:@"马上注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    _registerBtn.titleLabel.font = [UIFont systemFontOfSize:14*SIZE];
    [_registerBtn addTarget:self action:@selector(ActionRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
    _FindPassWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _FindPassWordBtn.frame =  CGRectMake(279 *SIZE, 10 *SIZE + CGRectGetMaxY(_LoginBtn.frame), 65*SIZE, 25*SIZE);
    [_FindPassWordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_FindPassWordBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    _FindPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:14*SIZE];
    [_FindPassWordBtn addTarget:self action:@selector(ActionFindPassBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_FindPassWordBtn];
}

-(UIButton *)settingbtn
{
    if (!_settingbtn) {
        _settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingbtn.center = CGPointMake(SCREEN_Width - 25 * SIZE, STATUS_BAR_HEIGHT+20);
        _settingbtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
        [_settingbtn addTarget:self action:@selector(action_sever) forControlEvents:UIControlEventTouchUpInside];
        [_settingbtn setImage:[UIImage imageNamed:@"housing_selected"] forState:UIControlStateNormal];
    }
    return _settingbtn;
}


@end
