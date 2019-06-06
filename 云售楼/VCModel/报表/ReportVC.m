//
//  ReportVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ReportVC.h"
#import "VisitCustomReportVC.h"
#import "ChannelAnalysisVC.h"

#import "PowerMannerger.h"

#import "WorkCell.h"

#import "CompanyAuthVC.h"

@interface ReportVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation ReportVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    if ([UserModel defaultModel].projectinfo) {
//        
//        _table.hidden = NO;
//    }else{
//        
//        _table.hidden = YES;
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionNSNotificationMethod) name:@"reloadCompanyInfo" object:nil];
    
    _titleArr = @[@"来访客户分析表",@"渠道分析表"];
}

- (void)ActionNSNotificationMethod{
    
    [self.rightBtn setTitle:[UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];
    if ([[UserModel defaultModel].projectinfo count]) {
        
        _table.hidden = NO;
        self.rightBtn.hidden = NO;
        
    }else{
        
        _table.hidden = YES;
        self.rightBtn.hidden = YES;;
    }
}


- (void)ActionGoBtn:(UIButton *)btn{
    
    CompanyAuthVC *nextVC = [[CompanyAuthVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkCell"];
    if (!cell) {
        
        cell = [[WorkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WorkCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleL.text = _titleArr[indexPath.row];
    cell.headImg.image = IMAGE_WITH_NAME(@"laifangfenxi");
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        VisitCustomReportVC *nextVC = [[VisitCustomReportVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        ChannelAnalysisVC *nextVC = [[ChannelAnalysisVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.leftButton.hidden = YES;
    
    self.titleLabel.text = @"报表";
    self.rightBtn.hidden = NO;
    self.rightBtn.center = CGPointMake(SCREEN_Width - 45 * SIZE, STATUS_BAR_HEIGHT + 20);
    self.rightBtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    [self.rightBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:[UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
//    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
//        
////        [self RequestMethod];
//    }];
    
    if ([UserModel defaultModel].projectinfo) {
        
        _table.hidden = NO;
    }else{
        
        _table.hidden = YES;
    }
}

@end
