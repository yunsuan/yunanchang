//
//  TaskReportVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/9/26.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "TaskReportVC.h"

#import "TaskSellReportCell.h"

@interface TaskReportVC ()<UIScrollViewDelegate>
{
    
    NSDictionary *_data;
}
@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UILabel *label;

@end

@implementation TaskReportVC

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        _data = data;
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{
    
    self.titleLabel.bounds = CGRectMake(0, 0, 220 * SIZE, 44);
    self.titleLabel.text = self.tit;
    
    _scroll = [[UIScrollView alloc] init];
    _scroll.delegate = self;
    _scroll.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_scroll];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _label.textColor = CLTitleLabColor;
    _label.font = [UIFont systemFontOfSize:13 *SIZE];
    _label.numberOfLines = 0;
    _label.text = _data[@"extra_comment"];
    [_scroll addSubview:_label];
    
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_scroll).offset(10 *SIZE);
        make.top.equalTo(self->_scroll).offset(10 *SIZE);
        make.right.equalTo(self->_scroll).offset(-10 *SIZE);
        make.top.equalTo(self->_scroll.mas_bottom).offset(-10 *SIZE);
    }];
}

@end
