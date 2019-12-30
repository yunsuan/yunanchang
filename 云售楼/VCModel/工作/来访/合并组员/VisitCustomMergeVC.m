//
//  VisitCustomMergeVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/8/28.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "VisitCustomMergeVC.h"

#import "VisitCustomDetailVC.h"

#import "BorderTextField.h"

@interface VisitCustomMergeVC ()
{
    
    NSString *_mainS;
    NSString *_minorS;
    
    NSDictionary *_dic;
    
    NSDateFormatter *_formatter;
}
@property (nonatomic, strong) BorderTextField *main;

@property (nonatomic, strong) BorderTextField *minor;

@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation VisitCustomMergeVC

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        _dic = dic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    [BaseRequest POST:ClientMergeGroup_URL parameters:@{@"main_group_id":_mainS,@"subsidiary_group_id":_minorS} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.visitCustomMergeVCBlock) {
                
                self.visitCustomMergeVCBlock();
            }
            for (UIViewController *vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:[VisitCustomDetailVC class]]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)initUI{
    
    self.titleLabel.text = @"合并组员";
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, NAVIGATION_BAR_HEIGHT + 18 *SIZE + 43 *SIZE * i, 70 *SIZE, 14 *SIZE)];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = @"接纳组";
        if (i == 1) {
            
            label.text = @"被接纳组";
        }
        [self.view addSubview:label];
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(80 *SIZE, NAVIGATION_BAR_HEIGHT + 10 *SIZE + 43 *SIZE * i, 258 *SIZE, 33 *SIZE)];
        tf.userInteractionEnabled = NO;
        if (i == 0) {
            
            _main = tf;
            [self.view addSubview:_main];
        }else{
            
            _minor = tf;
            [self.view addSubview:_minor];
        }
    }
    NSComparisonResult result = [[_formatter dateFromString:_dic[@"main_create_time"]] compare:[_formatter dateFromString:_dic[@"subsidiary_create_time"]]];
    if (result == NSOrderedDescending) {
        
        _main.textField.text = _dic[@"subsidiary_name"];
        _minor.textField.text = _dic[@"main_name"];
        
        _mainS = [NSString stringWithFormat:@"%@",_dic[@"subsidiary_group_id"]];
        _minorS = [NSString stringWithFormat:@"%@",_dic[@"main_group_id"]];
    }else{
        
        _main.textField.text = _dic[@"main_name"];
        _minor.textField.text = _dic[@"subsidiary_name"];
        
        _mainS = [NSString stringWithFormat:@"%@",_dic[@"main_group_id"]];
        _minorS = [NSString stringWithFormat:@"%@",_dic[@"subsidiary_group_id"]];
    }
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"合并" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueBtnColor];
    [self.view addSubview:_nextBtn];
    
}

@end
