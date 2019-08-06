//
//  QueryPhoneVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/8/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "QueryPhoneVC.h"

#import "AddCallTelegramVC.h"
#import "AddVisitCustomVC.h"

@interface QueryPhoneVC ()<UITextFieldDelegate>
{

    NSString *_project_id;
    NSString *_info_id;
}
@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIButton *addTelBtn;

@property (nonatomic, strong) UIButton *addVisitBtn;

@end

@implementation QueryPhoneVC

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(nonnull NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _project_id = projectId;
        _info_id = info_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
//    [self RequestMethod];
}

- (void)initDataSource{
    
//    _page = 1;
//    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id}];
    
    if (![self isEmpty:_searchBar.text]) {
        
        [dic setObject:_searchBar.text forKey:@"tel"];
    }
    [BaseRequest GET:@"saleApp/work/client/getTelInfo" parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"state"] integerValue] == 1) {
                
                _contentL.text = resposeObject[@"data"][@"message"];
                _addVisitBtn.hidden = NO;
                _addTelBtn.hidden = NO;
            }else{
                
                _contentL.text = resposeObject[@"data"][@"message"];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
        
    }];
}

- (void)ActionAddTelBtn:(UIButton *)btn{
    
    AddCallTelegramVC *nextVC = [[AddCallTelegramVC alloc] initWithProjectId:_project_id info_id:_info_id];
    nextVC.addCallTelegramVCBlock = ^{
        
        [self RequestMethod];
//        if (self.callTelegramVCBlock) {
//
//            self.callTelegramVCBlock();
//        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionAddVisitBtn:(UIButton *)btn{
    
    AddVisitCustomVC *nextVC = [[AddVisitCustomVC alloc] initWithProjectId:_project_id info_id:_info_id];
    nextVC.addVisitCustomVCBlock = ^{
        
        [self RequestMethod];
//        if (self.visitCustomVCBlock) {
//
//            self.visitCustomVCBlock();
//        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return [self validateNumber:string];
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.text.length > 11) {
        
        textField.text = [textField.text substringToIndex:11];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([self checkTel:textField.text]) {
        
        [self RequestMethod];
    }else{
        
        [self showContent:@"请输入正确的电话号码"];
    }
    return YES;
}

- (void)initUI{
    
    self.titleLabel.text = @"号码查询判断";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = CLLineColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.delegate = self;
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"输入电话";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    _searchBar.returnKeyType = UIReturnKeySearch;
    [whiteView addSubview:_searchBar];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.textAlignment = NSTextAlignmentCenter;
    _contentL.numberOfLines = 0;
    _contentL.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_contentL];
    
    _addTelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addTelBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_addTelBtn addTarget:self action:@selector(ActionAddTelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addTelBtn setTitle:@"新增来电" forState:UIControlStateNormal];
    [_addTelBtn setBackgroundColor:CLBlueBtnColor];
    _addTelBtn.layer.cornerRadius = 2 *SIZE;
    _addTelBtn.clipsToBounds = YES;
    _addTelBtn.hidden = YES;
    [self.view addSubview:_addTelBtn];
    
    _addVisitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addVisitBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_addVisitBtn addTarget:self action:@selector(ActionAddVisitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addVisitBtn setTitle:@"新增来访" forState:UIControlStateNormal];
    [_addVisitBtn setBackgroundColor:CLBlueBtnColor];
    _addVisitBtn.hidden = YES;
    _addVisitBtn.layer.cornerRadius = 2 *SIZE;
    _addVisitBtn.clipsToBounds = YES;
    [self.view addSubview:_addVisitBtn];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 *SIZE);
        make.top.equalTo(self.view).offset(15 *SIZE + NAVIGATION_BAR_HEIGHT + 40 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
    }];
    
    [_addTelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(130 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addVisitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(130 *SIZE);
        make.top.equalTo(self->_addTelBtn.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
}

@end
