//
//  ChannelAnalysisVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ChannelAnalysisVC.h"
#import "ChannelCustomVC.h"
#import "ChannelRankListVC.h"

#import "BaseHeader.h"
#import "TitleRightBtnHeader.h"
#import "ChannelAnalysisCell.h"
#import "ChannelMutiChartCell.h"
#import "ChannelSingleChartCell.h"
#import "ChannelMutiLineCell.h"
#import "TypeTagCollCell.h"

#import "DateChooseView.h"
#import "SinglePickView.h"

@interface ChannelAnalysisVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>///,SingleBarChartViewDelegate>
{
    
//    NSString *_status;
    NSString *_project_id;
    NSString *_year;
    
    NSArray *_titleArr;
    
    
    NSMutableDictionary *_dataDic;
    NSMutableDictionary *_monthDic;
    NSMutableDictionary *_yearDic;
    
    NSMutableArray *_yearArr;
//    NSMutableArray *_monthArr;
    
    NSDateFormatter *_formatter;
    NSDateFormatter *_yearMatter;
}

//@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

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
    
//    _status = @"1";
    if ([_status isEqualToString:@"1"]) {
        
        _status = @"1";
    }else if([_status isEqualToString:@"2"]){
     
        _status = @"2";
    }else{
        
        _status = @"0";
    }
    _titleArr = @[@"今日统计",@"本月统计",@"累计统计"];
    _dataDic = [@{} mutableCopy];
    _monthDic = [@{} mutableCopy];
    _yearDic = [@{} mutableCopy];
    
    
    _yearArr = [@[] mutableCopy];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    
    _yearMatter = [[NSDateFormatter alloc] init];
    [_yearMatter setDateFormat:@"yyyy"];
    
    _year = [_yearMatter stringFromDate:[NSDate date]];
    for (int i = 0; i < 10; i++) {
        
        [_yearArr addObject:@{@"param":[NSString stringWithFormat:@"%ld",[_year integerValue] - i],@"id":[NSString stringWithFormat:@"%ld",[_year integerValue] - i]}];
    }
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectClientCount_URL parameters:@{@"project_id":_project_id,@"sell_count":_status,@"year":_year} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([self->_status isEqualToString:@"1"]) {
                
                self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            }else if([self->_status isEqualToString:@"2"]) {
                
                self->_monthDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
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

//- (void)valueChanged:(UISegmentedControl *)sender{
//
////    NSLog(@"%@",sender.)
//    if (sender.selectedSegmentIndex == 0) {
//
//        _status = @"1";
//        if (!_dataDic.count) {
//
//            [self RequestMethod];
//        }
//        [_table reloadData];
//    }else{
//
//        _status = @"0";
//        if (!_yearDic.count) {
//
//            [self RequestMethod];
//        }
//        [_table reloadData];
//    }
//}


//- (void)SingleBarChart:(SingleBarChartView *)chartView didSelectIndex:(NSInteger)index{
//
//    WorkRecommendVC *nextVC = [[WorkRecommendVC alloc] init];
//    [self.navigationController pushViewController:nextVC animated:YES];
//}

#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TypeTagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeTagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TypeTagCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 3, 40 *SIZE)];
        cell.titleL.frame = CGRectMake(0, 14 *SIZE, SCREEN_Width / 3, 11 *SIZE);
        cell.line.frame = CGRectMake(45 *SIZE, 38 *SIZE, 30 *SIZE, 2 *SIZE);
    }
    
    cell.titleL.frame = CGRectMake(0, 14 *SIZE, SCREEN_Width / 3, 11 *SIZE);
    cell.line.frame = CGRectMake(45 *SIZE, 38 *SIZE, 30 *SIZE, 2 *SIZE);
    cell.titleL.text = _titleArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    [_scrollView setContentOffset:CGPointMake(SCREEN_Width * indexPath.item, 0) animated:NO];
    if (indexPath.item == 0) {
        
        _status = @"1";
        if (!_dataDic.count) {
            
            [self RequestMethod];
        }
        [_table reloadData];
    }else if(indexPath.item == 1){
     
        _status = @"2";
        if (!_monthDic.count) {
            
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        
        if ([_status isEqualToString:@"1"]) {
            
            return [_dataDic[@"company"] count] > 3? 3:[_dataDic[@"company"] count];
        }else if([_status isEqualToString:@"2"]){
            
            return [_monthDic[@"company"] count] > 3? 3:[_monthDic[@"company"] count];
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
    
    if (section == 2 || section == 3) {
        
        TitleRightBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleRightBtnHeader"];
        if (!header) {
            
            header = [[TitleRightBtnHeader alloc] initWithReuseIdentifier:@"TitleRightBtnHeader"];
        }
        if (section == 2) {
            
            header.titleL.text = @"分销公司排行榜";
            header.addBtn.hidden = YES;
            
            header.titleRightBtnHeaderMoreBlock = ^{
                
                if ([self->_status isEqualToString:@"1"]) {
                    
                    ChannelRankListVC *nextVC = [[ChannelRankListVC alloc] initWithDataArr:self->_dataDic[@"company"]];
                    nextVC.titleStr = @"今日分销公司排行榜";
                    [self.navigationController pushViewController:nextVC animated:YES];
                }else if ([self->_status isEqualToString:@"2"]) {
                    
                    ChannelRankListVC *nextVC = [[ChannelRankListVC alloc] initWithDataArr:self->_dataDic[@"company"]];
                    nextVC.titleStr = @"本月分销公司排行榜";
                    [self.navigationController pushViewController:nextVC animated:YES];
                }else{
                    
                    ChannelRankListVC *nextVC = [[ChannelRankListVC alloc] initWithDataArr:self->_yearDic[@"company"]];
                    nextVC.titleStr = @"累计分销公司排行榜";
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            };
        }else{
            
            header.titleL.text = @"年度趋势图";
            header.addBtn.hidden = YES;
            
            [header.moreBtn setTitle:[NSString stringWithFormat:@"%@年 >",_year] forState:UIControlStateNormal];
            header.moreBtn.titleLabel.font = FONT(13 *SIZE);
            
            header.titleRightBtnHeaderMoreBlock = ^{
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:self->_yearArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    self->_year = MC;
                    [tableView reloadData];
                    [self RequestMethod];
                };
                [self.view addSubview:view];
//                DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.frame];
//
//                view.dateblock = ^(NSDate *date) {
//
//                    self->_year = [_yearMatter stringFromDate:date];
//                    [tableView reloadData];
//                    [self RequestMethod];
//                };
//                [self.view addSubview:view];
            };
        }
        
        return header;
    }else{
        
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        
        if (section == 0) {
            
            header.titleL.text = @"客户统计图";
        }else{
            
//            if (section == 1) {
            
                 header.titleL.text = @"渠道来源分析图";
//            }else{
//
//                header.titleL.text = @"年度趋势图";
//            }
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
        }else if ([_status isEqualToString:@"2"]) {
            
            cell.titleL.text = _monthDic[@"company"][indexPath.row][@"name"];
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
                
                ChannelCustomVC *nextVC = [[ChannelCustomVC alloc] init];
                nextVC.index = index;
                nextVC.project_id = self->_project_id;
                if ([self->_status isEqualToString:@"1"]) {
                    
                    nextVC.date = [self->_formatter stringFromDate:[NSDate date]];
                }else if ([self->_status isEqualToString:@"2"]){
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy-MM-01"];
                    nextVC.date = [formatter stringFromDate:[NSDate date]];
                }
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            
            if ([_status isEqualToString:@"1"]) {
                
                if (_dataDic.count) {
                    
                    cell.dataDic =  _dataDic[@"currentDayCount"];
                }else{
                    
                    cell.dataDic = @{};
                }
                
            }else if ([_status isEqualToString:@"2"]) {
                
                if (_monthDic.count) {
                    
                    cell.dataDic =  _monthDic[@"currentMonthCount"];
                }else{
                    
                    cell.dataDic = @{};
                }
                
            }else{
                
                if (_yearDic.count) {
                    
                    cell.dataDic = _yearDic[@"totalCount"];
                }else{
                    
                    cell.dataDic = @{};
                }
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
            }else if ([_status isEqualToString:@"2"]) {
                
                cell.dataDic = _monthDic;
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
            }else if ([_status isEqualToString:@"2"]) {
                
                cell.dataDic = _monthDic;
            }else{
                
                cell.dataDic = _yearDic;
            }
            
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
//        ChannelCustomVC *nextVC = [[ChannelCustomVC alloc] init];
//        nextVC.index = 0;
//        nextVC.project_id = self->_project_id;
//        if ([self->_status isEqualToString:@"1"]) {
//            
//            nextVC.date = [self->_formatter stringFromDate:[NSDate date]];
//        }
//        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"渠道分析表";
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 3, 40 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT , SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = [UIColor whiteColor];
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    _segmentColl.showsHorizontalScrollIndicator = NO;
    _segmentColl.bounces = NO;
    [_segmentColl registerClass:[TypeTagCollCell class] forCellWithReuseIdentifier:@"TypeTagCollCell"];
    [self.view addSubview:_segmentColl];
    
    if ([_status isEqualToString:@"0"]) {
        
        [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }else if ([_status isEqualToString:@"2"]) {
        
        [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }else{
        
        [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 41 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 41 *SIZE) style:UITableViewStyleGrouped];
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
