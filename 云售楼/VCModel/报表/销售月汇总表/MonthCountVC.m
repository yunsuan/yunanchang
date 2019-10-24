//
//  MonthCountVC.m
//  云售楼
//
//  Created by xiaoq on 2019/10/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "MonthCountVC.h"

#import "TitleRightBtnHeader.h"
#import "MonthCountHeader.h"
#import "MonthCountCell.h"

#import "SinglePickView.h"

@interface MonthCountVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_project_id;
    
    NSString *_clientStatus;
    NSInteger _index;
    
    NSMutableArray *_dataArr;
    NSMutableArray *_clientArr;
}
@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UITableView *table;

@end

@implementation MonthCountVC

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

    _index = 0;
    _clientStatus = @"全部";
    _dataArr = [@[] mutableCopy];
    _clientArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id,@"type":@"1"}];
    if (![_clientStatus isEqualToString:@"全部"]) {
        
        [dic setValue:_clientStatus forKey:@"level"];
    }
    [dic setValue:@(_index + 1) forKey:@"type"];
    
    [BaseRequest GET:ReportSaleMonthCount_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
                
            [self->_dataArr removeAllObjects];
            for (int i = 0; i < [resposeObject[@"data"][@"contract"] count]; i++) {
                
                [self->_dataArr addObject:[NSString stringWithFormat:@"%@",resposeObject[@"data"][@"contract"][i][@"count"]]];
            }
            
            for (int i = 0; i < [resposeObject[@"data"][@"client"] count]; i++) {
                
                [self->_clientArr addObject:[NSString stringWithFormat:@"%@",resposeObject[@"data"][@"client"][i][@"count"]]];
            }
            
            [self->_table reloadData];
        }else{
                
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
                    
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        TitleRightBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleRightBtnHeader"];
        if (!header) {
            
            header = [[TitleRightBtnHeader alloc] initWithReuseIdentifier:@"TitleRightBtnHeader"];
        }
        
        header.titleL.text = @"客户统计";
        header.addBtn.hidden = YES;
        [header.moreBtn setTitle:_clientStatus forState:UIControlStateNormal];
        header.titleRightBtnHeaderMoreBlock = ^{
          
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[@{@"param":@"全部",@"id":@"全部"},@{@"param":@"A",@"id":@"A"},@{@"param":@"B",@"id":@"B"},@{@"param":@"C",@"id":@"C"},@{@"param":@"D",@"id":@"D"}]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                [header.moreBtn setTitle:MC forState:UIControlStateNormal];
                [self RequestMethod];
            };
            [self.view addSubview:view];
        };
        
        return header;
    }else{
        
        MonthCountHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MonthCountHeader"];
        if (!header) {
            
            header = [[MonthCountHeader alloc] initWithReuseIdentifier:@"MonthCountHeader"];
        }
        header.titleL.text = @"销售统计";
        
        header.index = _index;
        header.monthCountHeaderBlock = ^(NSInteger index) {
          
            self->_index = index;
            [self RequestMethod];
        };
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MonthCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MonthCountCell"];
    if (!cell) {
        
        cell = [[MonthCountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        
        cell.dataArr = _clientArr;
    }else{
        
        cell.dataArr = _dataArr;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

- (void)initUI{
    
    self.titleLabel.text = @"销售月汇总表";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 40 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = CLBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
//    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
//       
//        [self RequestMethod];
//    }];
}
@end
