//
//  VisitCustomReportVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/6/4.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "VisitCustomReportVC.h"

#import "VisitCustomHeader.h"
#import "VisitCustomReportCell.h"

#import "TypeTagCollCell.h"

@interface VisitCustomReportVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSString *_status;
    NSString *_project_id;

    
    NSArray *_titleArr;
}

//@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UITableView *table;

@end

@implementation VisitCustomReportVC

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
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectReportClientType_URL parameters:@{@"project_id":_project_id,@"type":_status} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)valueChanged:(UISegmentedControl *)sender{


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
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 280 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    VisitCustomHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"VisitCustomHeader"];
    if (!header) {
        
        header = [[VisitCustomHeader alloc] initWithReuseIdentifier:@"VisitCustomHeader"];
    }
    
    header.dataDic = @{};
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VisitCustomReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VisitCustomReportCell"];
    if (!cell) {
        
        cell = [[VisitCustomReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VisitCustomReportCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = @{};
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"来访客户分析表";
    
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
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - 40 *SIZE) style:UITableViewStyleGrouped];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}
@end
