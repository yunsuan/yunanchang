//
//  ResourcesAuditVC.m
//  云售楼
//
//  Created by xiaoq on 2019/10/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ResourcesAuditVC.h"

#import "BaseHeader.h"
#import "SaleDetailCell.h"

@interface ResourcesAuditVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    
    NSInteger _num1;
    double _num2;
    double _num3;
    
    NSString *_project_id;
    
    NSMutableArray *_dataArr;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UITableView *table;

@end

@implementation ResourcesAuditVC

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
    
    _dataArr = [@[] mutableCopy];
    _dataDic = [@{} mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ReportFormZYPDB_URL parameters:@{@"project_id":_project_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            NSDictionary *dic = self->_dataDic[@"no"];
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
               
                [self->_dataArr addObject:[NSString stringWithFormat:@"%@",key]];
            }];
            [self->_dataArr addObject:@"合计"];
            [self->_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
                
        [self showContent:@"网络错误"];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count + 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    if (section == 0) {
        
        header.titleL.text = @"已售资源";
    }else if (section == 1){
        
        header.titleL.text = @"可售资源";
    }else if (section == 2){
        
        header.titleL.text = @"全部资源";
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 40 *SIZE;
    }
    
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SaleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaleDetailCell"];
    if (!cell) {
            
        cell = [[SaleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SaleDetailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.statisticsL mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_offset(50 *SIZE);
    }];
    
    [cell.numL1 mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(60 *SIZE);
        make.width.mas_offset(30 *SIZE);
    }];
    
    [cell.numL2 mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(110 *SIZE);
        make.width.mas_offset(80 *SIZE);
    }];
    
    [cell.numL3 mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(210 *SIZE);
        make.width.mas_offset(140 *SIZE);
    }];
    
    [cell.line1 mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(50 *SIZE);
    }];
    
    [cell.line2 mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(100 *SIZE);
    }];
    
    [cell.line3 mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(200 *SIZE);
    }];
    
    if (indexPath.row == 0) {

        cell.contentView.backgroundColor = CLBackColor;
        cell.statisticsL.textColor = CLTitleLabColor;
        cell.numL1.textColor = CLContentLabColor;
        cell.numL2.textColor = CLContentLabColor;
        cell.numL3.textColor = CLContentLabColor;
        cell.statisticsL.backgroundColor = CLBackColor;

        cell.statisticsL.text = @"类型";
        cell.numL1.text = @"套数";
        cell.numL2.text = @"建面";
        cell.numL3.text = @"金额";
    }else{
          
        cell.contentView.backgroundColor = CLWhiteColor;
        cell.statisticsL.backgroundColor = CLBlueBtnColor;
        cell.statisticsL.textColor = CLWhiteColor;

        cell.statisticsL.text = _dataArr[indexPath.row - 1];
            
        if (_dataDic) {
            
            if (indexPath.section == 0) {
                
                if ([cell.statisticsL.text isEqualToString:@"合计"]) {
                    
                    _num1 = 0;
                    _num2 = 0;
                    _num3 = 0;
                    for (int i = 0; i < _dataArr.count - 1; i++) {
                        
                        _num1 = _num1 + [[_dataDic[@"yes"] objectForKey:_dataArr[i]][@"num"] integerValue];
                        _num2 = _num2 + [[_dataDic[@"yes"] objectForKey:_dataArr[i]][@"size"] doubleValue];
                        _num3 = _num3 + [[_dataDic[@"yes"] objectForKey:_dataArr[i]][@"print"] doubleValue];
                    }
                    cell.numL1.text = [NSString stringWithFormat:@"%ld",_num1];
                    cell.numL2.text = [NSString stringWithFormat:@"%.2f",_num2];
                    cell.numL3.text = [NSString stringWithFormat:@"%.2f",_num3];
                }else{
                 
                    cell.numL1.text = [NSString stringWithFormat:@"%ld",[[_dataDic[@"yes"] objectForKey:cell.statisticsL.text][@"num"] integerValue]];
                    cell.numL2.text = [NSString stringWithFormat:@"%.2f",[[_dataDic[@"yes"] objectForKey:cell.statisticsL.text][@"size"] doubleValue]];
                    cell.numL3.text = [NSString stringWithFormat:@"%.2f",[[_dataDic[@"yes"] objectForKey:cell.statisticsL.text][@"print"] doubleValue]];
                }
            }else if (indexPath.section == 1){
                
                if ([cell.statisticsL.text isEqualToString:@"合计"]) {
                    
                    _num1 = 0;
                    _num2 = 0;
                    _num3 = 0;
                    for (int i = 0; i < _dataArr.count - 1; i++) {
                        
                        _num1 = _num1 + [[_dataDic[@"no"] objectForKey:_dataArr[i]][@"num"] integerValue];
                        _num2 = _num2 + [[_dataDic[@"no"] objectForKey:_dataArr[i]][@"size"] doubleValue];
                        _num3 = _num3 + [[_dataDic[@"no"] objectForKey:_dataArr[i]][@"print"] doubleValue];
                    }
                    cell.numL1.text = [NSString stringWithFormat:@"%ld",_num1];
                    cell.numL2.text = [NSString stringWithFormat:@"%.2f",_num2];
                    cell.numL3.text = [NSString stringWithFormat:@"%.2f",_num3];
                }else{
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%ld",[[_dataDic[@"no"] objectForKey:cell.statisticsL.text][@"num"] integerValue]];
                    cell.numL2.text = [NSString stringWithFormat:@"%.2f",[[_dataDic[@"no"] objectForKey:cell.statisticsL.text][@"size"] doubleValue]];
                    cell.numL3.text = [NSString stringWithFormat:@"%.2f",[[_dataDic[@"no"] objectForKey:cell.statisticsL.text][@"print"] doubleValue]];
                }
            }else{
                
                if ([cell.statisticsL.text isEqualToString:@"合计"]) {
                    
                    _num1 = 0;
                    _num2 = 0;
                    _num3 = 0;
                    for (int i = 0; i < _dataArr.count - 1; i++) {
                        
                        _num1 = _num1 + [[_dataDic[@"no"] objectForKey:_dataArr[i]][@"num"] integerValue] + [[_dataDic[@"yes"] objectForKey:_dataArr[i]][@"num"] integerValue];
                        _num2 = _num2 + [[_dataDic[@"no"] objectForKey:_dataArr[i]][@"size"] doubleValue] + [[_dataDic[@"yes"] objectForKey:_dataArr[i]][@"size"] doubleValue];
                        _num3 = _num3 + [[_dataDic[@"no"] objectForKey:_dataArr[i]][@"print"] doubleValue] + [[_dataDic[@"yes"] objectForKey:_dataArr[i]][@"print"] doubleValue];
                    }
                    cell.numL1.text = [NSString stringWithFormat:@"%ld",_num1];
                    cell.numL2.text = [NSString stringWithFormat:@"%.2f",_num2];
                    cell.numL3.text = [NSString stringWithFormat:@"%.2f",_num3];
                }else{
                    
                    cell.numL1.text = [NSString stringWithFormat:@"%ld",[[_dataDic[@"yes"] objectForKey:cell.statisticsL.text][@"num"] integerValue] + [[_dataDic[@"no"] objectForKey:cell.statisticsL.text][@"num"] integerValue]];
                    cell.numL2.text = [NSString stringWithFormat:@"%.2f",[[_dataDic[@"yes"] objectForKey:cell.statisticsL.text][@"size"] doubleValue] + [[_dataDic[@"no"] objectForKey:cell.statisticsL.text][@"size"] doubleValue]];
                    cell.numL3.text = [NSString stringWithFormat:@"%.2f",[[_dataDic[@"yes"] objectForKey:cell.statisticsL.text][@"print"] doubleValue] + [[_dataDic[@"no"] objectForKey:cell.statisticsL.text][@"print"] doubleValue]];
                }
            }
        }else{
            
            cell.numL1.text = @"0";
            cell.numL2.text = @"0";
            cell.numL3.text = @"0";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"资源盘点表";
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scroll.delegate = self;
    _scroll.bounces = NO;
    [_scroll setContentSize:CGSizeMake(120 *SIZE * 3, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:_scroll];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE * 3, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 40 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = CLBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    [_scroll addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
       
        [self RequestMethod];
    }];
}

@end
