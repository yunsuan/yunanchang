//
//  DealCustomerReportVC.m
//  云售楼
//
//  Created by xiaoq on 2019/10/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "DealCustomerReportVC.h"
#import "TypeTagCollCell.h"

@interface DealCustomerReportVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSInteger _percent;
    
    NSString *_status;
    NSString *_project_id;
    
    NSArray *_titleArr;
    
    NSMutableDictionary *_dataDic;
    NSMutableDictionary *_yearDic;
    
    NSMutableArray *_dataArr;
}

//@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UITableView *table;

@end

@implementation DealCustomerReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
    
}


- (void)initDataSource{
    
   
}

- (void)RequestMethod{
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 40 *SIZE;
    }
    
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    if (indexPath.row == 0) {
//
//        cell.contentView.backgroundColor = CLBlueBtnColor;
//        cell.companyL.textColor = CLWhiteColor;
//        cell.contactL.textColor = CLWhiteColor;
//        cell.phoneL.textColor = CLWhiteColor;
//        cell.moneyL.textColor = CLWhiteColor;
//        cell.numL.textColor = CLWhiteColor;
//
//        cell.line1.hidden = YES;
//        cell.line2.hidden = YES;
//        cell.line3.hidden = YES;
//        cell.line4.hidden = YES;
//
//
//        cell.companyL.text = @"乙方公司";
//        cell.contactL.text = @"乙方负责人";
//        cell.phoneL.text = @"乙方联系电话";
//        cell.moneyL.text = @"累计金额（￥）";
//        cell.numL.text = @"累计笔数";
//    }else{
//
//        cell.contentView.backgroundColor = CLWhiteColor;
//        cell.companyL.textColor = CL86Color;
//        cell.contactL.textColor = CL86Color;
//        cell.phoneL.textColor = CL86Color;
//        cell.moneyL.textColor = CLBlueBtnColor;
//        cell.numL.textColor = CL86Color;
//
//        cell.line1.hidden = NO;
//        cell.line2.hidden = NO;
//        cell.line3.hidden = NO;
//        cell.line4.hidden = NO;
//
//        cell.companyL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"sell_company_name"]];
//        cell.contactL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"sell_docker"]];
//        cell.phoneL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"sell_docker_tel"]];
//        cell.moneyL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"broker_num"]];
//        cell.numL.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row - 1][@"count"]];
//    }
//
    return cell;
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
    
    self.titleLabel.text = @"成交客户分析表";
    
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
