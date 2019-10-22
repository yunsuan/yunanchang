//
//  ReceiptCountVC.m
//  云售楼
//
//  Created by xiaoq on 2019/10/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ReceiptCountVC.h"

#import "ReceiptCountChartHeader.h"
#import "ReceiptCountChartCell.h"
#import "BaseHeader.h"
#import "TitleContentBaseCell.h"

#import "TypeTagCollCell.h"

@interface ReceiptCountVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSInteger _percent;
    
    NSString *_status;
    NSString *_project_id;
    
    NSArray *_titleArr;
    NSArray *_typeArr;
    
    NSMutableDictionary *_dataDic;
    NSMutableDictionary *_yearDic;
    
    NSMutableArray *_dataArr;
}

//@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UITableView *table;
@end

@implementation ReceiptCountVC

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
    _typeArr = @[@"现金",@"POS",@"银行",@"其他",@"换票"];
    
    _dataDic = [@{} mutableCopy];
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ReportFormSKTJB_URL parameters:@{@"project_id":_project_id,@"type":_status} success:^(id  _Nonnull resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {

            self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            double cashA = [self->_dataDic[@"earnestMoney"][@"cash"] doubleValue] + [self->_dataDic[@"frontMoney"][@"cash"] doubleValue] + [self->_dataDic[@"roomMoney"][@"cash"] doubleValue] + [self->_dataDic[@"roomMoneyMortgage"][@"cash"] doubleValue] + [self->_dataDic[@"generationCharge"][@"cash"] doubleValue];
            double posA = [self->_dataDic[@"earnestMoney"][@"pos"] doubleValue] + [self->_dataDic[@"frontMoney"][@"pos"] doubleValue] + [self->_dataDic[@"roomMoney"][@"pos"] doubleValue] + [self->_dataDic[@"roomMoneyMortgage"][@"pos"] doubleValue] + [self->_dataDic[@"generationCharge"][@"pos"] doubleValue];
            double carryA = [self->_dataDic[@"earnestMoney"][@"carryOver"] doubleValue] + [self->_dataDic[@"frontMoney"][@"carryOver"] doubleValue] + [self->_dataDic[@"roomMoney"][@"carryOver"] doubleValue] + [self->_dataDic[@"roomMoneyMortgage"][@"carryOver"] doubleValue] + [self->_dataDic[@"generationCharge"][@"carryOver"] doubleValue];
            double otherA = [self->_dataDic[@"earnestMoney"][@"other"] doubleValue] + [self->_dataDic[@"frontMoney"][@"other"] doubleValue] + [self->_dataDic[@"roomMoney"][@"other"] doubleValue] + [self->_dataDic[@"roomMoneyMortgage"][@"other"] doubleValue] + [self->_dataDic[@"generationCharge"][@"other"] doubleValue];
            double changeA = [self->_dataDic[@"earnestMoney"][@"change"] doubleValue] + [self->_dataDic[@"frontMoney"][@"change"] doubleValue] + [self->_dataDic[@"roomMoney"][@"change"] doubleValue] + [self->_dataDic[@"roomMoneyMortgage"][@"change"] doubleValue] + [self->_dataDic[@"generationCharge"][@"change"] doubleValue];
            [self->_dataArr addObject:[NSString stringWithFormat:@"%.2f",cashA]];
            [self->_dataArr addObject:[NSString stringWithFormat:@"%.2f",changeA]];
            [self->_dataArr addObject:[NSString stringWithFormat:@"%.2f",carryA]];
            [self->_dataArr addObject:[NSString stringWithFormat:@"%.2f",otherA]];
            [self->_dataArr addObject:[NSString stringWithFormat:@"%.2f",changeA]];
            [self->_table reloadData];
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
    _status = [NSString stringWithFormat:@"%ld",indexPath.item + 1];
    if (!_yearDic.count) {
        
        [self  RequestMethod];
    }
    if (!_dataDic.count) {
        
        [self  RequestMethod];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 5;
    }else{
        
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 280 *SIZE;
    }else{
        
        return UITableViewAutomaticDimension;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        ReceiptCountChartHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ReceiptCountChartHeader"];
        if (!header) {
            
            header = [[ReceiptCountChartHeader alloc] initWithReuseIdentifier:@"ReceiptCountChartHeader"];
        }
        
        if (_dataDic.count) {
            
            header.dataDic = _dataDic;
        }
        return header;
    }else{
        
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        
        header.titleL.textColor = CLBlueBtnColor;
        if (section == 1) {
            
            header.titleL.text = @"诚意金 : 0";
            if (_dataDic.count) {
                
                header.titleL.text = [NSString stringWithFormat:@"诚意金 ：%.2f",[self->_dataDic[@"earnestMoney"][@"cash"] doubleValue] + [self->_dataDic[@"earnestMoney"][@"pos"] doubleValue] + [self->_dataDic[@"earnestMoney"][@"carryOver"] doubleValue] + [self->_dataDic[@"earnestMoney"][@"other"] doubleValue] + [self->_dataDic[@"earnestMoney"][@"change"] doubleValue]];
            }
        }else if (section == 2){
            
            header.titleL.text = @"定金 : 0";
            if (_dataDic.count) {
                
                header.titleL.text = [NSString stringWithFormat:@"定金 ：%.2f",[self->_dataDic[@"frontMoney"][@"cash"] doubleValue] + [self->_dataDic[@"frontMoney"][@"pos"] doubleValue] + [self->_dataDic[@"frontMoney"][@"carryOver"] doubleValue] + [self->_dataDic[@"frontMoney"][@"other"] doubleValue] + [self->_dataDic[@"frontMoney"][@"change"] doubleValue]];
            }
        }else if (section == 3){
            
            header.titleL.text = @"购房款 : 0";
            if (_dataDic.count) {
                
                header.titleL.text = [NSString stringWithFormat:@"购房款 ：%.2f",[self->_dataDic[@"roomMoney"][@"cash"] doubleValue] + [self->_dataDic[@"roomMoney"][@"pos"] doubleValue] + [self->_dataDic[@"roomMoney"][@"carryOver"] doubleValue] + [self->_dataDic[@"roomMoney"][@"other"] doubleValue] + [self->_dataDic[@"roomMoney"][@"change"] doubleValue]];
            }
        }else if (section == 4){
            
            header.titleL.text = @"房款按揭款 : 0";
            if (_dataDic.count) {
                
                header.titleL.text = [NSString stringWithFormat:@"房款按揭款 ：%.2f",[self->_dataDic[@"roomMoneyMortgage"][@"cash"] doubleValue] + [self->_dataDic[@"roomMoneyMortgage"][@"pos"] doubleValue] + [self->_dataDic[@"roomMoneyMortgage"][@"carryOver"] doubleValue] + [self->_dataDic[@"roomMoneyMortgage"][@"other"] doubleValue] + [self->_dataDic[@"roomMoneyMortgage"][@"change"] doubleValue]];
            }
        }else if (section == 5){
            
            header.titleL.text = @"代收费 : 0";
            if (_dataDic.count) {
                
                header.titleL.text = [NSString stringWithFormat:@"代收费 ：%.2f",[self->_dataDic[@"generationCharge"][@"cash"] doubleValue] + [self->_dataDic[@"generationCharge"][@"pos"] doubleValue] + [self->_dataDic[@"generationCharge"][@"carryOver"] doubleValue] + [self->_dataDic[@"generationCharge"][@"other"] doubleValue] + [self->_dataDic[@"generationCharge"][@"change"] doubleValue]];
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

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 40 *SIZE;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        ReceiptCountChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiptCountChartCell"];
        if (!cell) {
            
            cell = [[ReceiptCountChartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReceiptCountChartCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.colorView.backgroundColor = CLArr[indexPath.row % CLArr.count];
        
        cell.titleL.text = _typeArr[indexPath.row];
        if (_dataArr.count) {

            cell.percentL.text = _dataArr[indexPath.row];
        }else{
            
            cell.percentL.text = @"0.00";
        }
        
//        NSMutableArray *percentArr = [@[] mutableCopy];
//        if (indexPath.row == 0) {
//
//            cell.titleL.text = @"自然来访";
//            cell.numL.text = [NSString stringWithFormat:@"%@",_dataDic[@"basic"][@"auto_visit"]];
//            if ([cell.numL.text integerValue] == 0) {
//
//                cell.percentL.text = @"占比：0%";
//            }else{
//
//                cell.percentL.text = [NSString stringWithFormat:@"占比：%.2f%@",[_dataDic[@"basic"][@"auto_visit"] floatValue] / ([_dataDic[@"basic"][@"auto_visit"] floatValue] + [_dataDic[@"basic"][@"company"] floatValue] + [_dataDic[@"basic"][@"person"] floatValue]) * 100,@"%"];
//            }
//        }else if (indexPath.row == 1){
//
//            cell.titleL.text = @"渠道分销";
//            cell.numL.text = [NSString stringWithFormat:@"%@",_dataDic[@"basic"][@"company"]];
//            if ([cell.numL.text integerValue] == 0) {
//
//                cell.percentL.text = @"占比：0%";
//            }else{
//
//                cell.percentL.text = [NSString stringWithFormat:@"占比：%.2f%@",[_dataDic[@"basic"][@"company"] floatValue] / ([_dataDic[@"basic"][@"auto_visit"] floatValue] + [_dataDic[@"basic"][@"company"] floatValue] + [_dataDic[@"basic"][@"person"] floatValue]) * 100,@"%"];
//            }
//        }else{
//
//            cell.titleL.text = @"全民营销";
//            cell.numL.text = [NSString stringWithFormat:@"%@",_dataDic[@"basic"][@"person"]];
//            if ([cell.numL.text integerValue] == 0) {
//
//                cell.percentL.text = @"占比：0%";
//            }else{
//
//                cell.percentL.text = [NSString stringWithFormat:@"占比：%.2f%@",[_dataDic[@"basic"][@"person"] floatValue] / ([_dataDic[@"basic"][@"auto_visit"] floatValue] + [_dataDic[@"basic"][@"company"] floatValue] + [_dataDic[@"basic"][@"person"] floatValue]) * 100,@"%"];
//            }
//        }
        return cell;
    }else{
    
        TitleContentBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleContentBaseCell"];
        if (!cell) {
            
            cell = [[TitleContentBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleContentBaseCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lineView.hidden = YES;
        cell.titleL.textColor = CLTitleLabColor;
        
        if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                cell.titleL.text = @"现金：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"earnestMoney"][@"cash"] doubleValue]];
            }else if (indexPath.row == 1){
                
                cell.titleL.text = @"POS：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"earnestMoney"][@"pos"] doubleValue]];
            }else if (indexPath.row == 2){
                
                cell.titleL.text = @"银行：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"earnestMoney"][@"carryOver"] doubleValue]];
            }else if (indexPath.row == 3){
                
                cell.titleL.text = @"其他：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"earnestMoney"][@"other"] doubleValue]];
            }else{
                
                cell.titleL.text = @"换票：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"earnestMoney"][@"change"] doubleValue]];
            }
        }else if (indexPath.section == 2){
            
            if (indexPath.row == 0) {
                
                cell.titleL.text = @"现金：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"frontMoney"][@"cash"] doubleValue]];
            }else if (indexPath.row == 1){
                
                cell.titleL.text = @"POS：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"frontMoney"][@"pos"] doubleValue]];
            }else if (indexPath.row == 2){
                
                cell.titleL.text = @"银行：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"frontMoney"][@"carryOver"] doubleValue]];
            }else if (indexPath.row == 3){
                
                cell.titleL.text = @"其他：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"frontMoney"][@"other"] doubleValue]];
            }else{
                
                cell.titleL.text = @"换票：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"frontMoney"][@"change"] doubleValue]];
            }
        }else if (indexPath.section == 3){
            
            if (indexPath.row == 0) {
                
                cell.titleL.text = @"现金：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"roomMoney"][@"cash"] doubleValue]];
            }else if (indexPath.row == 1){
                
                cell.titleL.text = @"POS：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"roomMoney"][@"pos"] doubleValue]];
            }else if (indexPath.row == 2){
                
                cell.titleL.text = @"银行：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"roomMoney"][@"carryOver"] doubleValue]];
            }else if (indexPath.row == 3){
                
                cell.titleL.text = @"其他：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"roomMoney"][@"other"] doubleValue]];
            }else{
                
                cell.titleL.text = @"换票：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"roomMoney"][@"change"] doubleValue]];
            }
        }else if (indexPath.section == 4){
            
            if (indexPath.row == 0) {
                
                cell.titleL.text = @"现金：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"roomMoneyMortgage"][@"cash"] doubleValue]];
            }else if (indexPath.row == 1){
                
                cell.titleL.text = @"POS：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"roomMoneyMortgage"][@"pos"] doubleValue]];
            }else if (indexPath.row == 2){
                
                cell.titleL.text = @"银行：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"roomMoneyMortgage"][@"carryOver"] doubleValue]];
            }else if (indexPath.row == 3){
                
                cell.titleL.text = @"其他：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"roomMoneyMortgage"][@"other"] doubleValue]];
            }else{
                
                cell.titleL.text = @"换票：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"roomMoneyMortgage"][@"change"] doubleValue]];
            }
        }else if (indexPath.section == 5){
            
            if (indexPath.row == 0) {
                
                cell.titleL.text = @"现金：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"generationCharge"][@"cash"] doubleValue]];
            }else if (indexPath.row == 1){
                
                cell.titleL.text = @"POS：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"generationCharge"][@"pos"] doubleValue]];
            }else if (indexPath.row == 2){
                
                cell.titleL.text = @"银行：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"generationCharge"][@"carryOver"] doubleValue]];
            }else if (indexPath.row == 3){
                
                cell.titleL.text = @"其他：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"generationCharge"][@"other"] doubleValue]];
            }else{
                
                cell.titleL.text = @"换票：";
                cell.contentL.text = [NSString stringWithFormat:@"%.2f",[self->_dataDic[@"generationCharge"][@"change"] doubleValue]];
            }
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
            
//            if ([[PowerModel defaultModel].ReportListPower[1] integerValue]) {
//
//                ChannelAnalysisVC *nextVC = [[ChannelAnalysisVC alloc] initWithProjectId:_project_id];
//                if ([_status isEqualToString:@"1"]) {
//
//                    nextVC.status = @"1";
//                }else{
//
//                    nextVC.status = @"0";
//                }
//                [self.navigationController pushViewController:nextVC animated:YES];
//            }
        }else if (indexPath.row == 0){
            
//            AutoVisitReportVC *nextVC = [[AutoVisitReportVC alloc] initWithProjectId:_project_id];
//            if ([_status isEqualToString:@"1"]) {
//
//                nextVC.status = @"1";
//            }else{
//
//                nextVC.status = @"2";
//            }
//            nextVC.titleStr = @"自然来访";
//            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            
        }
    }else{
        
//        PropertyVisitReportVC *nextVC = [[PropertyVisitReportVC alloc] initWithProjectId:_project_id configId:[NSString stringWithFormat:@"%@",_dataDic[@"property"][indexPath.row][@"config_id"]]];
//        if ([_status isEqualToString:@"1"]) {
//
//            nextVC.status = @"1";
//        }else{
//
//            nextVC.status = @"2";
//        }
//        nextVC.titleStr = _dataDic[@"property"][indexPath.row][@"config_name"];
//        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"收款统计表";
    
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
