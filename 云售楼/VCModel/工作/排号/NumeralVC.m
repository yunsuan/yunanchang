//
//  NumeralVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/1.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NumeralVC.h"

#import "NumeralDetailVC.h"

#import "NumeralCell.h"

#import "GZQFilterView2.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

@interface NumeralVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSInteger _page;
    
    NSString *_project_id;
    NSString *_info_id;
    
    NSMutableDictionary *_requestDic;
    
    NSMutableArray *_dataArr;
    
    NSMutableArray *_levelArr;
    
    NSDateFormatter *_dateformatter;
}
@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) GZQFilterView2 *filterView;

@end

@implementation NumeralVC

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(nonnull NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _project_id = projectId;
        _info_id = info_id;
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
    
    _page = 1;
    _dataArr = [@[] mutableCopy];
    
    _levelArr = [@[] mutableCopy];
    
    _dateformatter = [[NSDateFormatter alloc] init];
    [_dateformatter setDateFormat:@"YYYY-MM-dd"];
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id,@"page":@(_page)}];
    
    if (![self isEmpty:_searchBar.text]) {
        
        [dic setObject:_searchBar.text forKey:@"search"];
    }
    if (_requestDic.count) {
        
        [_requestDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([key isEqualToString:@"receive_name"]) {
                
            }else{
                
                [dic setValue:obj forKey:key];
            }
        }];
    }
    _table.mj_footer.state = MJRefreshStateIdle;
    [BaseRequest GET:ProjectRowGetProjectRowList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_dataArr removeAllObjects];
            [self->_table reloadData];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self->_table.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self->_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
        
    }];
}

- (void)RequestAddMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id,@"page":@(_page)}];
    
    if (![self isEmpty:_searchBar.text]) {
        
        [dic setObject:_searchBar.text forKey:@"search"];
    }
//    _table.mj_footer.state = MJRefreshStateIdle;
    if (_requestDic.count) {
        
        [_requestDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([key isEqualToString:@"receive_name"]) {
                
            }else{
                
                [dic setValue:obj forKey:key];
            }
        }];
    }
    [BaseRequest GET:ProjectRowGetProjectRowList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self->_table.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self->_table.mj_footer endRefreshing];
            self->_page -= 1;
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        self->_page -= 1;
        [self->_table.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (int i = 0; i < data.count; i++) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [dic setObject:@"" forKey:key];
            }else{
                
                [dic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }];
        
        [_dataArr addObject:dic];
    }
    [_table reloadData];
}

- (void)ActionSearchBtn:(UIButton *)btn{
    
    if ([_requestDic[@"start_time"] length]) {
        
        _filterView.followBeginBtn.content.text = [_requestDic[@"start_time"] componentsSeparatedByString:@" "][0];
    }
    if ([_requestDic[@"end_time"] length]) {
        
        _filterView.followEndBtn.content.text = [_requestDic[@"end_time"] componentsSeparatedByString:@" "][0];
    }
    if ([_requestDic[@"receive_name"] length]) {
        
        _filterView.levelBtn.content.text = _requestDic[@"receive_name"];
        _filterView.levelBtn->str = _requestDic[@"receive_state"];
    }
    [self.view addSubview:_filterView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self RequestMethod];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NumeralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NumeralCell"];
    if (!cell) {
        
        cell = [[NumeralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NumeralCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NumeralDetailVC *nextVC = [[NumeralDetailVC alloc] initWithRowId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"row_id"]] project_id:_project_id info_id:_info_id];
    nextVC.need_check = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row][@"need_check"]];
    nextVC.projectName = self.projectName;
    nextVC.numeralDetailVCBlock = ^{
        
        [self RequestMethod];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"排号";
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 300 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = CLLineColor;
    _searchBar.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 11 *SIZE, 0)];
    //设置显示模式为永远显示(默认不显示)
    _searchBar.delegate = self;
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"输入电话/姓名";
    _searchBar.font = [UIFont systemFontOfSize:12 *SIZE];
    _searchBar.layer.cornerRadius = 2 *SIZE;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame = CGRectMake(315 *SIZE, 0, 40 *SIZE, 40 *SIZE);
    [_searchBtn setTitle:@"更多" forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = FONT(13 *SIZE);
    [_searchBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(ActionSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:_searchBtn];
    
    SS(strongSelf);
    _filterView = [[GZQFilterView2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _filterView.GzqFilterView2ConfirmBlock = ^(NSDictionary * _Nonnull dic) {
      
        self->_requestDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
        [strongSelf RequestMethod];
    };
    _filterView.GzqFilterView2TagBlock = ^(NSInteger idx) {
      
        if (idx == 0) {
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
            view.dateblock = ^(NSDate *date) {
                
                strongSelf->_filterView.followBeginBtn.content.text = [strongSelf->_dateformatter stringFromDate:date];
                strongSelf->_filterView.followBeginBtn.placeL.text = @"";
                
                if ([[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followBeginBtn.content.text] compare:[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followEndBtn.content.text]] == NSOrderedDescending) {
                    
                    NSLog(@"1 > 2");
                    [strongSelf showContent:@"开始时间不能大于结束时间"];
                    strongSelf->_filterView.followBeginBtn.content.text = @"";
                    strongSelf->_filterView.followBeginBtn.placeL.text = @"请选择登记开始时间：";
                }else if ([[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followBeginBtn.content.text] compare:[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followEndBtn.content.text]] == NSOrderedAscending){
                    
                    NSLog(@"2 > 1");
                }else{
                    
                    NSLog(@"2 = 1");
                }
            };
            [strongSelf.view addSubview:view];
        }else if (idx == 1){
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
            view.dateblock = ^(NSDate *date) {
                
                strongSelf->_filterView.followEndBtn.content.text = [strongSelf->_dateformatter stringFromDate:date];
                strongSelf->_filterView.followEndBtn.placeL.text = @"";
                if ([[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followBeginBtn.content.text] compare:[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followEndBtn.content.text]] == NSOrderedAscending) {
                    
                    NSLog(@"1 > 2");
                }else if ([[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followBeginBtn.content.text] compare:[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followEndBtn.content.text]] == NSOrderedDescending){
                    
                    [strongSelf showContent:@"登记结束时间不能小于开始时间"];
                    strongSelf->_filterView.followEndBtn.content.text = @"";
                    strongSelf->_filterView.followEndBtn.placeL.text = @"请选择登记结束时间：";
                }else{
                    
                    
                }
            };
            [strongSelf.view addSubview:view];
        }else if (idx == 2){
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:@[@{@"param":@"待付款",@"id":@"2"},@{@"param":@"已付款",@"id":@"1"}]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                strongSelf->_filterView.levelBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                strongSelf->_filterView.levelBtn->str = [NSString stringWithFormat:@"%@",ID];
                strongSelf->_filterView.levelBtn.placeL.text = @"";
            };
            [strongSelf.view addSubview:view];
        }
    };
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        self->_page = 1;
        [self RequestMethod];
    }];
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
       
        self->_page += 1;
        [self RequestAddMethod];
    }];
}

@end
