//
//  FeedbackVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "FeedbackVC.h"

@interface FeedbackVC ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self initUI];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length) {
        
        _placeL.hidden = YES;
    }else{
        
        _placeL.hidden = NO;
    }
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    
    if (![self isEmpty:_textView.text]) {
        
        _confirmBtn.userInteractionEnabled = NO;
        [BaseRequest POST:UserPersonalSendAdvice_URL parameters:@{@"content":_textView.text} success:^(id resposeObject) {

//            NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue] == 200) {

                [self showContent:@"反馈成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{
                
                self->_confirmBtn.userInteractionEnabled = YES;
            }
        } failure:^(NSError *error) {

            self->_confirmBtn.userInteractionEnabled = YES;
            [self showContent:@"网络错误"];
        }];
    }else{
        
        [self showContent:@"请输入反馈信息"];
    }
}

- (void)initUI{
    
    self.view.backgroundColor = CLLineColor;
    self.titleLabel.text = @"意见反馈";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 150 *SIZE)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(22 *SIZE, 10 *SIZE, 320 *SIZE, 105 *SIZE)];
    _textView.delegate = self;
    [view addSubview:_textView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 123 *SIZE, 350 *SIZE, 11 *SIZE)];
    label.textColor = CLContentLabColor;
    label.font = [UIFont systemFontOfSize:12 *SIZE];
    label.textAlignment = NSTextAlignmentRight;
    label.text = @"200字以内";
    [view addSubview:label];
    
    _placeL = [[UILabel alloc] initWithFrame:CGRectMake(5 *SIZE, 8 *SIZE, 150 *SIZE, 11 *SIZE)];
    _placeL.textColor = CLContentLabColor;
    _placeL.text = @"请输入意见反馈...";
    _placeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [_textView addSubview:_placeL];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(22 *SIZE, 475 *SIZE + NAVIGATION_BAR_HEIGHT, 314 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:CLBlueBtnColor];
    [self.view addSubview:_confirmBtn];
}

@end
