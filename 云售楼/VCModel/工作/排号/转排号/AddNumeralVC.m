//
//  AddNumeralVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/2.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddNumeralVC.h"

#import "TitleRightBtnHeader.h"
//#import "AddNumeralPersonCell.h"
//#import "AddNumeralInfoCell.h"
//#import "AddNumeralProcessCell.h"
//#import "ba"
#import "AddNumeralPersonView.h"

#import "SinglePickView.h"
#import "DateChooseView.h"
#import "AdressChooseView.h"

@interface AddNumeralVC ()<UIScrollViewDelegate>
{
    
    NSInteger _num;
    
    NSString *_project_id;
    NSString *_info_id;
    
    NSArray *_titleArr;
    
    NSMutableDictionary *_infoDic;
    
    NSMutableArray *_certArr;
    NSMutableArray *_personArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_typeArr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) AddNumeralPersonView *addNumeralPersonView;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddNumeralVC

- (instancetype)initWithProject_id:(NSString *)project_id personArr:(NSArray *)personArr info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _project_id = project_id;
        _personArr = [[NSMutableArray alloc] initWithArray:personArr];
        _info_id = info_id;
        _infoDic = [@{} mutableCopy];
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
    
    _titleArr = @[@"权益人信息",@"排号信息",@"流程信息"];
    _certArr = [@[] mutableCopy];
    _selectArr = [[NSMutableArray alloc] initWithArray:@[@1,@0,@0]];
}

- (void)PropertyRequestMethod{
    
    [BaseRequest GET:WorkClientAutoBasicConfig_URL parameters:@{@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            for (int i = 0; i < [resposeObject[@"data"][2] count]; i++) {
                
                NSDictionary *dic = @{@"id":resposeObject[@"data"][2][i][@"config_id"],
                                      @"param":resposeObject[@"data"][2][i][@"config_name"]};
                [self->_certArr addObject:dic];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
    
    [BaseRequest GET:ProjectRowGetRowList_URL parameters:@{@"project_id":_project_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_typeArr = [[NSMutableArray alloc] initWithArray:resposeObject[@"data"]];
//            [self->_table reloadData];
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    NSDictionary *dic = @{@"project_id":_project_id};
    
    [BaseRequest POST:ProjectRowAddRow_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}


- (void)initUI{
    
    self.titleLabel.text = @"转排号";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE)];
    _scrollView.backgroundColor = CLBackColor;
    [self.view addSubview:_scrollView];
    
    TitleRightBtnHeader *header = [[TitleRightBtnHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    header.titleL.text = @"权益人信息";
    [_scrollView addSubview:header];
    
    _addNumeralPersonView = [[AddNumeralPersonView alloc] init];
    [_scrollView addSubview:_addNumeralPersonView];
    
    [_addNumeralPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_scrollView).offset(40 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(_scrollView).offset(0);
        make.bottom.equalTo(_scrollView.mas_bottom).offset(0);
    }];

    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    [self.view addSubview:_nextBtn];
}

@end
