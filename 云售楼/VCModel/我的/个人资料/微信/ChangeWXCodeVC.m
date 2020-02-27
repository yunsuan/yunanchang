//
//  ChangeWXCodeVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/20.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "ChangeWXCodeVC.h"

@interface ChangeWXCodeVC (){
    
    NSString *_wx;
}
@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UITextField *nameTF;

@end

@implementation ChangeWXCodeVC

- (instancetype)initWithWX:(NSString *)wxCode
{
    self = [super init];
    if (self) {
        
        _wx = wxCode;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    if (_nameTF.text.length && ![self isEmpty:_nameTF.text]) {
        
        if (self.changeWXCodeVCBlock) {
            
            self.changeWXCodeVCBlock(_nameTF.text);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
        [self showContent:@"请输入微信号"];
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"姓名";
    self.navBackgroundView.hidden = NO;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.rightBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.whiteView];
    [self.whiteView addSubview:self.nameTF];
}

- (UITextField *)nameTF{
    
    if (!_nameTF) {
        
        _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 0, 340 *SIZE, 50 *SIZE)];
        _nameTF.font = [UIFont systemFontOfSize:13 *SIZE];
        _nameTF.placeholder = @"请输入微信号";
        _nameTF.text = _wx;
    }
    return _nameTF;
}

- (UIView *)whiteView{
    
    if (!_whiteView) {
        
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 12 *SIZE, SCREEN_Width, 50 *SIZE)];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}

@end
