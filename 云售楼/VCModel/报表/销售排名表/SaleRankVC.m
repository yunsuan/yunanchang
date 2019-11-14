//
//  SaleRankVC.m
//  云售楼
//
//  Created by xiaoq on 2019/10/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "SaleRankVC.h"

#import "SaleRankVisitCell.h"
#import "SaleRankContractCell.h"
#import "SaleRankOrderCell.h"
#import "SaleRankTelCell.h"

#import "BaseHeader.h"
#import "TypeTagCollCell.h"

@interface SaleRankVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSInteger _percent;
    
    NSString *_status;
    NSString *_project_id;
    
    NSArray *_titleArr;
    
    NSMutableDictionary *_dataDic;
    NSMutableDictionary *_yearDic;
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UITableView *table;

@end

@implementation SaleRankVC

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
   
   _titleArr = @[@"今日统计",@"累计统计"];
   
   _dataDic = [@{} mutableCopy];
   _dataArr = [@[] mutableCopy];
}


- (void)RequestMethod{
    
    [BaseRequest GET:ReportSaleSort_URL parameters:@{@"project_id":_project_id,@"type":_status} success:^(id  _Nonnull resposeObject) {
        
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

#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TypeTagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeTagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TypeTagCollCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 2, 40 *SIZE)];
        cell.titleL.frame = CGRectMake(0, 14 *SIZE, SCREEN_Width / 2, 11 *SIZE);
        cell.line.frame = CGRectMake(75 *SIZE, 38 *SIZE, 30 *SIZE, 2 *SIZE);
    }
    
    cell.titleL.frame = CGRectMake(0, 14 *SIZE, SCREEN_Width / 2, 11 *SIZE);
    cell.line.frame = CGRectMake(75 *SIZE, 38 *SIZE, 30 *SIZE, 2 *SIZE);
    cell.titleL.text = _titleArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    [_scrollView setContentOffset:CGPointMake(SCREEN_Width * indexPath.item, 0) animated:NO];
    _status = [NSString stringWithFormat:@"%ld",indexPath.item + 1];
    if (!_yearDic.count) {

        [self  RequestMethod];
    }
    if (!_dataDic.count) {

        [self  RequestMethod];
    }
    [_table reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 240 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
                
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    if (section == 0) {
        
        header.titleL.text = @"按来电统计";
    }else if (section == 1){
        
        header.titleL.text = @"按来访统计";
    }else if (section == 2) {
                
        header.titleL.text = @"按认购统计";
    }else{
                     
        header.titleL.text = @"按合同统计";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        SaleRankTelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaleRankTelCell"];
                if (!cell) {
                            
                    cell = [[SaleRankTelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SaleRankTelCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
            //            cell.singleBarChartView.delegate = self;

                        
                if ([_status isEqualToString:@"1"]) {

                    if (_dataDic.count) {

                        cell.dataDic = _dataDic;
                    }else{

                        cell.dataDic = @{};
                    }
                }else{

                    if (_yearDic.count) {

                        cell.dataDic = _yearDic;
                    }else{

                        cell.dataDic = @{};
                    }
                }
                        
                return cell;
    }else if (indexPath.section == 1) {
        
        SaleRankVisitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaleRankVisitCell"];
                if (!cell) {
                            
                    cell = [[SaleRankVisitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SaleRankVisitCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
            //            cell.singleBarChartView.delegate = self;

                        
                if ([_status isEqualToString:@"1"]) {

                    if (_dataDic.count) {

                        cell.dataDic = _dataDic;
                    }else{

                        cell.dataDic = @{};
                    }
                }else{

                    if (_yearDic.count) {

                        cell.dataDic = _yearDic;
                    }else{

                        cell.dataDic = @{};
                    }
                }
                        
                return cell;
    }else if (indexPath.section == 2) {
                
        SaleRankOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaleRankOrderCell"];
        if (!cell) {
                    
            cell = [[SaleRankOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SaleRankOrderCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
    //            cell.singleBarChartView.delegate = self;
        cell.saleRankOrderCellBlock = ^(NSInteger index) {
                    
//            ChannelCustomVC *nextVC = [[ChannelCustomVC alloc] init];
//            nextVC.index = index;
//            nextVC.project_id = self->_project_id;
//            if ([self->_status isEqualToString:@"1"]) {
//
//                nextVC.date = [self->_formatter stringFromDate:[NSDate date]];
//            }else if ([self->_status isEqualToString:@"2"]){
//
//                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                [formatter setDateFormat:@"YYYY-MM-01"];
//                nextVC.date = [formatter stringFromDate:[NSDate date]];
//            }
//            [self.navigationController pushViewController:nextVC animated:YES];
        };
                
        if ([_status isEqualToString:@"1"]) {

            if (_dataDic.count) {

                cell.dataDic = _dataDic;
            }else{

                cell.dataDic = @{};
            }
        }else{

            if (_yearDic.count) {

                cell.dataDic = _yearDic;
            }else{

                cell.dataDic = @{};
            }
        }
                
        return cell;
    }else{
        
        SaleRankContractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaleRankContractCell"];
            if (!cell) {
                        
                cell = [[SaleRankContractCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SaleRankContractCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
        //            cell.singleBarChartView.delegate = self;
            cell.saleRankContractCellBlock = ^(NSInteger index) {
                        
//                ChannelCustomVC *nextVC = [[ChannelCustomVC alloc] init];
//                nextVC.index = index;
//                nextVC.project_id = self->_project_id;
//                if ([self->_status isEqualToString:@"1"]) {
//
//                    nextVC.date = [self->_formatter stringFromDate:[NSDate date]];
//                }else if ([self->_status isEqualToString:@"2"]){
//
//                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                    [formatter setDateFormat:@"YYYY-MM-01"];
//                    nextVC.date = [formatter stringFromDate:[NSDate date]];
//                }
//                [self.navigationController pushViewController:nextVC animated:YES];
            };
                    
            if ([_status isEqualToString:@"1"]) {

                if (_dataDic.count) {

                    cell.dataDic =  _dataDic;
                }else{

                    cell.dataDic = @{};
                }
            }else{

                if (_yearDic.count) {

                    cell.dataDic = _yearDic;
                }else{

                    cell.dataDic = @{};
                }
            }
                    
            return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row == 0) {
//
//    }else{
//
//        CompanyCommissionReportVC *nextVC = [[CompanyCommissionReportVC alloc] initWithRuleId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"rule_id"]] project_id:_project_id];
//        nextVC.money = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"broker_num"]];;
//        nextVC.num = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"count"]];
//        [self.navigationController pushViewController:nextVC animated:YES];
//    }
}



- (void)initUI{
    
    self.titleLabel.text = @"销售排名表";
    
//    _segment = [[UISegmentedControl alloc] initWithItems:[NSMutableArray arrayWithObjects:@"今日统计",@"累计统计", nil]];
//    _segment.frame = CGRectMake(80 *SIZE, NAVIGATION_BAR_HEIGHT, 200 *SIZE, 30 *SIZE);
//    //添加到视图
//
////    [_segment setTintColor:CLWhiteColor];
////    [_segment setEnabled:NO forSegmentAtIndex:0];
//    [_segment setWidth:100 *SIZE forSegmentAtIndex:0];
//    [_segment addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
//    [self.view addSubview:_segment];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(SCREEN_Width / 2, 40 *SIZE);
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
    
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 41 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 41 *SIZE) style:UITableViewStyleGrouped];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}
@end
