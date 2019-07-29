//
//  SincerityChangeVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SincerityChangeVC.h"

#import "SincerityChangeView.h"

#import "SinglePickView.h"

#import "DropBtn.h"
#import "BorderTextField.h"

@interface SincerityChangeVC ()<UITextFieldDelegate>
{
    
    NSString *_project_id;
    NSString *_sincerity;
    NSString *_role_id;
    
    NSMutableDictionary *_progressDic;
    
    NSMutableArray *_roleArr;
    NSMutableArray *_rolePersonArr;
    NSMutableArray *_progressArr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) SincerityChangeView *sincerityChangeView;
@end

@implementation SincerityChangeVC

- (instancetype)initWithProject_id:(NSString *)project_id sincerity:(NSString *)sincerity
{
    self = [super init];
    if (self) {
        
        _project_id = project_id;
        _sincerity = sincerity;
        
        _progressDic = [@{} mutableCopy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self PropertyRequestMethod];
}

- (void)initDataSource{
    
    _progressArr = [@[] mutableCopy];
}

- (void)PropertyRequestMethod{
    
    [BaseRequest GET:ProjectProgressGet_URL parameters:@{@"project_id":_project_id,@"config_type":@"2",@"progress_defined_id":@"1"} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_progressArr removeAllObjects];

            for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                
                [self->_progressArr addObject:@{@"param":[NSString stringWithFormat:@"%@",resposeObject[@"data"][i][@"progress_name"]],@"id":resposeObject[@"data"][i][@"progress_id"]}];
            }
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    
    [BaseRequest GET:ProjectRoleListAll_URL parameters:@{@"project_id":_project_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            for (NSDictionary *dic in resposeObject[@"data"]) {
                
                [self->_roleArr addObject:@{@"param":[NSString stringWithFormat:@"%@/%@",dic[@"project_name"],dic[@"role_name"]],@"id":dic[@"role_id"]}];
            }
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id}];
    
    if (_role_id.length) {
        
        [dic setObject:_role_id forKey:@"role_id"];
    }
    
    [BaseRequest GET:ProjectRolePersonList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_rolePersonArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            
            self->_sincerityChangeView.personArr = self->_rolePersonArr;
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}


- (void)initUI{
    
    self.titleLabel.text = @"增加诚意金";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLBackColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    _sincerityChangeView = [[SincerityChangeView alloc] init];
    _sincerityChangeView.dataDic = _progressDic;
    [_scrollView addSubview:_sincerityChangeView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE);
    }];
    
    [_sincerityChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(0);
        make.right.equalTo(self->_scrollView).offset(0);
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
    }];
}



@end
