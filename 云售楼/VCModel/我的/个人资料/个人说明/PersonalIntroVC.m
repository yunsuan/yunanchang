//
//  PersonalIntroVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "PersonalIntroVC.h"

@interface PersonalIntroVC ()
{
    
    NSString *_intro;
}

@property (nonatomic, strong) UITextView *introTV;

//@property (nonatomic, strong) UIButton *conte;
@end

@implementation PersonalIntroVC

- (instancetype)initWithIntro:(NSString *)intro
{
    self = [super init];
    if (self) {
        
        _intro = intro;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    if (_introTV.text.length && ![self isEmpty:_introTV.text]) {
        
        if (self.personalIntroVCBlock) {
            
            self.personalIntroVCBlock(_introTV.text);
        }
        NSDictionary *dic = @{@"slef_desc":_introTV.text};
        [BaseRequest POST:UserPersonalChangeAgentInfo_URL parameters:dic success:^(id resposeObject) {
            
            //            NSLog(@"%@",resposeObject);
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [UserInfoModel defaultModel].slef_desc = self->_introTV.text;
                [UserModelArchiver archive];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
            //            NSLog(@"%@",error);
        }];
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"个人说明";
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.rightBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _introTV = [[UITextView alloc] initWithFrame:CGRectMake(0, 10 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, 170 *SIZE)];
    _introTV.text = _intro;
    [self.view addSubview:_introTV];
}
@end
