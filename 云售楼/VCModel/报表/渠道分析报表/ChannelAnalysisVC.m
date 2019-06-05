//
//  ChannelAnalysisVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelAnalysisVC.h"

#import "ChannelRankListVC.h"

#import "BaseHeader.h"
#import "TitleRightBtnHeader.h"
#import "ChannelAnalysisCell.h"
#import "ChannelMutiChartCell.h"
#import "ChannelSingleChartCell.h"
#import "ChannelMutiLineCell.h"

@interface ChannelAnalysisVC ()<UITableViewDataSource,UITableViewDelegate>///,SingleBarChartViewDelegate>
{
    
    NSString *_status;
    NSString *_project_id;
    
    NSMutableDictionary *_dataDic;
    NSMutableDictionary *_yearDic;
}

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UITableView *table;

@end

@implementation ChannelAnalysisVC

- (instancetype)initWithProjectId:(NSString *)project_id
{
    self = [super init];
    if (self) {
        
        _project_id = project_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _status = @"1";
    _dataDic = [@{} mutableCopy];
    _yearDic = [@{} mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectClientCount_URL parameters:@{@"project_id":_project_id,@"sell_count":_status} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([self->_status isEqualToString:@"1"]) {
                
                self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            }else{
                
                self->_yearDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            }
            [self->_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)valueChanged:(UISegmentedControl *)sender{
    
//    NSLog(@"%@",sender.)
    if (sender.selectedSegmentIndex == 0) {
        
        _status = @"1";
        if (!_dataDic.count) {
            
            [self RequestMethod];
        }
        [_table reloadData];
    }else{
        
        _status = @"0";
        if (!_yearDic.count) {
            
            [self RequestMethod];
        }
        [_table reloadData];
    }
}


//- (void)SingleBarChart:(SingleBarChartView *)chartView didSelectIndex:(NSInteger)index{
//
//    WorkRecommendVC *nextVC = [[WorkRecommendVC alloc] init];
//    [self.navigationController pushViewController:nextVC animated:YES];
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        
        if ([_status isEqualToString:@"1"]) {
            
            return [_dataDic[@"company"] count] > 3? 3:[_dataDic[@"company"] count];
        }else{
        
            return [_yearDic[@"company"] count] > 3? 3:[_yearDic[@"company"] count];
        }
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        
        TitleRightBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleRightBtnHeader"];
        if (!header) {
            
            header = [[TitleRightBtnHeader alloc] initWithReuseIdentifier:@"TitleRightBtnHeader"];
        }
        
        header.titleL.text = @"分销公司排行榜";
        header.addBtn.hidden = YES;
        
        header.titleRightBtnHeaderMoreBlock = ^{
            
            if ([self->_status isEqualToString:@"1"]) {
                
                ChannelRankListVC *nextVC = [[ChannelRankListVC alloc] initWithDataArr:self->_dataDic[@"company"]];
                nextVC.titleStr = @"今日分销公司排行榜";
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                ChannelRankListVC *nextVC = [[ChannelRankListVC alloc] initWithDataArr:self->_yearDic[@"company"]];
                nextVC.titleStr = @"累计分销公司排行榜";
                [self.navigationController pushViewController:nextVC animated:YES];
            }

        };
        
        return header;
    }else{
        
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        
        if (section == 0) {
            
            header.titleL.text = @"客户统计图";
        }else{
            
            if (section == 1) {
                
                 header.titleL.text = @"渠道来源分析图";
            }else{
                
                header.titleL.text = @"年度统计图";
            }
        }
       
        return header;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        
        return UITableViewAutomaticDimension;
    }
    return 240 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        
        ChannelAnalysisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelAnalysisCell"];
        if (!cell) {
            
            cell = [[ChannelAnalysisCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChannelAnalysisCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([_status isEqualToString:@"1"]) {
            
            cell.titleL.text = _dataDic[@"company"][indexPath.row][@"name"];
        }else{

            cell.titleL.text = _yearDic[@"company"][indexPath.row][@"name"];
        }

        return cell;
    }else{
        
        if (indexPath.section == 0) {
            
            ChannelSingleChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelSingleChartCell"];
            if (!cell) {
                
                cell = [[ChannelSingleChartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChannelSingleChartCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
//            cell.singleBarChartView.delegate = self;
            cell.channelSingleChartCellBlock = ^(NSInteger index) {
                
            };
            
            if ([_status isEqualToString:@"1"]) {
                
                if (_dataDic.count) {
                    
                    cell.dataDic =  _dataDic[@"totalCount"];
                }else{
                    
                    cell.dataDic = @{};
                }
                
            }else{
                
                cell.dataDic = @{};
            }
            
            return cell;
        }else if (indexPath.section == 1){
            
            ChannelMutiChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelMutiChartCell"];
            if (!cell) {
                
                cell = [[ChannelMutiChartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChannelMutiChartCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if ([_status isEqualToString:@"1"]) {
                
                cell.dataDic = _dataDic;
            }else{
                
                cell.dataDic = _yearDic;
            }
            
            return cell;
        }else{
            
            ChannelMutiLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelMutiLineCell"];
            if (!cell) {
                
                cell = [[ChannelMutiLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChannelMutiLineCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if ([_status isEqualToString:@"1"]) {
                
                cell.dataDic = _dataDic;
            }else{
                
                cell.dataDic = _yearDic;
            }
            
            return cell;
        }
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"渠道分析表";
    
    _segment = [[UISegmentedControl alloc] initWithItems:[NSMutableArray arrayWithObjects:@"今日统计",@"累计统计", nil]];
    _segment.frame = CGRectMake(80 *SIZE, NAVIGATION_BAR_HEIGHT, 200 *SIZE, 30 *SIZE);
    //添加到视图
    
    //    [_segment setTintColor:CLWhiteColor];
    //    [_segment setEnabled:NO forSegmentAtIndex:0];
    [_segment setWidth:100 *SIZE forSegmentAtIndex:0];
    [_segment addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:_segment];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 30 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 30 *SIZE) style:UITableViewStyleGrouped];
//    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
