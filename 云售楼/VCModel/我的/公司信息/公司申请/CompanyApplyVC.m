//
//  CompanyApplyVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CompanyApplyVC.h"

#import "CompanyAuthVC.h"

@interface CompanyApplyVC()



@end

@implementation CompanyApplyVC

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionMaskBtn:(UIButton *)btn{
    
    if ([self.status isEqualToString:@"login"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"goHome" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
//        if ([self.status isEqualToString:@"reApply"]) {
//            
//            if (self.companyApplyVCBlock) {
//                
//                self.companyApplyVCBlock();
//            }
//        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)ActionGoBtn:(UIButton *)btn{
    
    CompanyAuthVC *nextVC = [[CompanyAuthVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"公司申请";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(3 *SIZE, 7 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width - 6 *SIZE, 167 *SIZE)];
    whiteView.backgroundColor = CLWhiteColor;
    whiteView.layer.cornerRadius = 7 *SIZE;
    whiteView.clipsToBounds = YES;
    [self.view addSubview:whiteView];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(151 *SIZE, 36 *SIZE, 57 *SIZE, 57 *SIZE)];
    img.image = IMAGE_WITH_NAME(@"company");
    [whiteView addSubview:img];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 110 *SIZE, SCREEN_Width - 6 *SIZE, 13 *SIZE)];
    label.textColor = CL86Color;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"您目前没有进行公司认证，请先认证公司！";
    [whiteView addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(97 *SIZE, 31 *SIZE + CGRectGetMaxY(whiteView.frame), 167 *SIZE, 40 *SIZE);
    btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [btn addTarget:self action:@selector(ActionGoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"去认证" forState:UIControlStateNormal];
    [btn setBackgroundColor:CLBlueBtnColor];
    btn.layer.cornerRadius = 3 *SIZE;
    btn.clipsToBounds = YES;
    [self.view addSubview:btn];
}
@end
