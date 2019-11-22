//
//  CallTelegramVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramVC.h"

#import "CallTelegramCustomDetailVC.h"
#import "AddCallTelegramVC.h"

#import "GZQFilterView.h"

#import "CallTelegramCell.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

@interface CallTelegramVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    NSMutableArray *_dataArr;
    
    NSMutableArray *_levelArr;
    
    NSString *_projectId;
    NSString *_info_id;
    NSInteger _page;
    NSMutableDictionary *_requestDic;
    
    NSDateFormatter *_dateformatter;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UITextField *searchBar;

@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) GZQFilterView *filterView;

@end

@implementation CallTelegramVC

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _projectId = projectId;
        _info_id = info_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    if ([self.powerDic[@"detail"] boolValue]) {
        
        [self RequestMethod];
    }
}

- (void)levelRequest{
    
    [BaseRequest GET:WorkClientAutoBasicConfig_URL parameters:@{@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [self->_levelArr removeAllObjects];
                    for (int i = 0; i < [resposeObject[@"data"][1] count]; i++) {
                        
                        [self->_levelArr addObject:@{@"param":resposeObject[@"data"][1][i][@"config_name"],@"id":resposeObject[@"data"][1][i][@"config_id"]}];
                    }
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_levelArr];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        
                        self->_filterView.levelBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                        self->_filterView.levelBtn->str = [NSString stringWithFormat:@"%@",ID];
                        self->_filterView.levelBtn.placeL.text = @"";
                    };
                    [self.view addSubview:view];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [self showContent:@"网络错误"];
            }];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"reloadCall" object:nil];
    _page = 1;
    _dataArr = [@[] mutableCopy];
    
    _levelArr = [@[] mutableCopy];
    
    _dateformatter = [[NSDateFormatter alloc] init];
    [_dateformatter setDateFormat:@"YYYY-MM-dd"];
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"type":@"1",@"project_id":_projectId}];
    self->_table.mj_footer.state = MJRefreshStateIdle;
    if (![self isEmpty:_searchBar.text]) {
        
        [dic setObject:_searchBar.text forKey:@"search"];
    }
    if (_requestDic.count) {
        
        [_requestDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([key isEqualToString:@"level_name"]) {
                
            }else{
                
                [dic setValue:obj forKey:key];
            }
        }];
    }
    [BaseRequest GET:WorkClientAutoList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        [self->_dataArr removeAllObjects];
        [self->_table reloadData];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self.titleLabel.text = [NSString stringWithFormat:@"来电(共%@条)",resposeObject[@"data"][@"total"]];
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self->_dataArr removeAllObjects];
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self->_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"type":@"1",@"project_id":_projectId,@"page":@(_page)}];
    if (![self isEmpty:_searchBar.text]) {
        
        [dic setObject:_searchBar.text forKey:@"search"];
    }
    if (_requestDic.count) {
        
        [_requestDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([key isEqualToString:@"level_name"]) {
                
            }else{
                
                [dic setValue:obj forKey:key];
            }
        }];
    }
    [BaseRequest GET:WorkClientAutoList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"][@"data"] count]) {
                
                [self->_table.mj_footer endRefreshing];
                [self SetData:resposeObject[@"data"][@"data"]];
            }else{
                
                self->_table.mj_footer.state = MJRefreshStateNoMoreData;
            }
            
        }else{
            
            [self->_table.mj_footer endRefreshing];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self->_table.mj_footer endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for (NSDictionary *dic in data) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [tempDic setObject:@"" forKey:key];
            }
        }];
        
        [_dataArr addObject:tempDic];
    }
    
    [_table reloadData];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    AddCallTelegramVC *nextVC = [[AddCallTelegramVC alloc] initWithProjectId:_projectId info_id:_info_id];
    nextVC.addCallTelegramVCBlock = ^{
      
        [self RequestMethod];
        if (self.callTelegramVCBlock) {
            
            self.callTelegramVCBlock();
        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionSearchBtn:(UIButton *)btn{
    
    if ([_requestDic[@"start_time"] length]) {
        
        _filterView.regiterBeginBtn.content.text = [_requestDic[@"start_time"] componentsSeparatedByString:@" "][0];
    }
    if ([_requestDic[@"end_time"] length]) {
        
        _filterView.regiterEndBtn.content.text = [_requestDic[@"end_time"] componentsSeparatedByString:@" "][0];
    }
    if ([_requestDic[@"level_name"] length]) {
        
        _filterView.levelBtn.content.text = _requestDic[@"level_name"];
        _filterView.levelBtn->str = _requestDic[@"level"];
    }
    if ([_requestDic[@"follow_time_start"] length]) {
        
        _filterView.followBeginBtn.content.text = [_requestDic[@"follow_time_start"] componentsSeparatedByString:@" "][0];
    }
    if ([_requestDic[@"follow_time_end"] length]) {
        
        _filterView.followEndBtn.content.text = [_requestDic[@"follow_time_end"] componentsSeparatedByString:@" "][0];
    }
    [self.view addSubview:_filterView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self RequestMethod];
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;//_dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CallTelegramCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCell"];
    if (!cell) {
        
        cell = [[CallTelegramCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.section];;
    
    if ([_dataArr[indexPath.section][@"sex"] integerValue] == 1) {
        
        cell.headImg.image = IMAGE_WITH_NAME(@"nantouxiang");
    }else{
        
        cell.headImg.image = IMAGE_WITH_NAME(@"nvtouxiang");
    }
    cell.callTelegramCellBlock = ^{
        
        NSString *phone = [self->_dataArr[indexPath.section][@"tel"] componentsSeparatedByString:@","][0];
        if (phone.length) {
            
            //获取目标号码字符串,转换成URL
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
            //调用系统方法拨号
            [[UIApplication sharedApplication] openURL:url];
        }else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CallTelegramCustomDetailVC *nextVC = [[CallTelegramCustomDetailVC alloc] initWithGroupId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.section][@"group_id"]]];
    nextVC.project_id = _projectId;
    nextVC.info_id = _info_id;
    nextVC.name = @"";//_dataArr[indexPath.row][@"agent_name"];
    if ([_dataArr[indexPath.row][@"advicer_id"] integerValue] == [[UserModel defaultModel].agent_id integerValue]) {
        
        nextVC.powerDic = self.powerDic;
    }else{
        
        nextVC.powerDic = @{};
    }
    
    nextVC.callTelegramCustomDetailModifyBlock = ^{
      
//        [self RequestMethod];
    };
    
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"来电";
    if ([self.powerDic[@"add"] boolValue]) {
        
        self.rightBtn.hidden = NO;
    }else{
        
        self.rightBtn.hidden = YES;
    }
    [self.rightBtn setImage:IMAGE_WITH_NAME(@"add_3") forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.line.hidden = YES;
    
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
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame = CGRectMake(315 *SIZE, 0, 40 *SIZE, 40 *SIZE);
    [_searchBtn setTitle:@"更多" forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = FONT(13 *SIZE);
    [_searchBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(ActionSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:_searchBtn];
    
    SS(strongSelf);
    _filterView = [[GZQFilterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _filterView.GzqFilterViewConfirmBlock = ^(NSDictionary * _Nonnull dic) {
      
        self->_requestDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
        [strongSelf RequestMethod];
    };
    _filterView.GzqFilterViewTagBlock = ^(NSInteger idx) {
      
        if (idx == 0) {
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
            view.dateblock = ^(NSDate *date) {
                
                strongSelf->_filterView.regiterBeginBtn.content.text = [strongSelf->_dateformatter stringFromDate:date];
                strongSelf->_filterView.regiterBeginBtn.placeL.text = @"";
                
                if ([[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.regiterBeginBtn.content.text] compare:[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.regiterEndBtn.content.text]] == NSOrderedDescending) {
                    
                    NSLog(@"1 > 2");
                    [strongSelf showContent:@"登记开始时间不能大于结束时间"];
                    strongSelf->_filterView.regiterBeginBtn.content.text = @"";
                    strongSelf->_filterView.regiterBeginBtn.placeL.text = @"请选择登记开始时间：";
                }else if ([[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.regiterBeginBtn.content.text] compare:[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.regiterEndBtn.content.text]] == NSOrderedAscending){
                    
                    NSLog(@"2 > 1");
                }else{
                    
                    NSLog(@"2 = 1");
                }
            };
            [strongSelf.view addSubview:view];
        }else if (idx == 1){
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
            view.dateblock = ^(NSDate *date) {
                
                strongSelf->_filterView.regiterEndBtn.content.text = [strongSelf->_dateformatter stringFromDate:date];
                strongSelf->_filterView.regiterEndBtn.placeL.text = @"";
                if ([[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.regiterBeginBtn.content.text] compare:[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.regiterEndBtn.content.text]] == NSOrderedAscending) {
                    
                    NSLog(@"1 > 2");
                }else if ([[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.regiterBeginBtn.content.text] compare:[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.regiterEndBtn.content.text]] == NSOrderedDescending){
                    
                    [strongSelf showContent:@"登记结束时间不能小于开始时间"];
                    strongSelf->_filterView.regiterEndBtn.content.text = @"";
                    strongSelf->_filterView.regiterEndBtn.placeL.text = @"请选择登记结束时间：";
                }else{
                    
                    
                }
            };
            [strongSelf.view addSubview:view];
        }else if (idx == 2){
            
            if ([strongSelf->_levelArr count]) {
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_levelArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    strongSelf->_filterView.levelBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                    strongSelf->_filterView.levelBtn->str = [NSString stringWithFormat:@"%@",ID];
                    strongSelf->_filterView.levelBtn.placeL.text = @"";
                };
                [strongSelf.view addSubview:view];
            }else{
                
                [strongSelf levelRequest];
            }
        }else if (idx == 3){
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
            view.dateblock = ^(NSDate *date) {
                
                strongSelf->_filterView.followBeginBtn.content.text = [strongSelf->_dateformatter stringFromDate:date];
                strongSelf->_filterView.followBeginBtn.placeL.text = @"";
                if ([[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followBeginBtn.content.text] compare:[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followEndBtn.content.text]]  == NSOrderedDescending) {
                    
                    NSLog(@"1 > 2");
                    [strongSelf showContent:@"跟进开始时间不能大于结束时间"];
                    strongSelf->_filterView.followBeginBtn.content.text = @"";
                    strongSelf->_filterView.followBeginBtn.placeL.text = @"请选择最后跟进时间（开始）：";
                }else if ([[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followBeginBtn.content.text] compare:[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followEndBtn.content.text]]  == NSOrderedAscending){
                    
                }else{
                    
                    NSLog(@"2 > 1");
                }
            };
            [strongSelf.view addSubview:view];
        }else{
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
            view.dateblock = ^(NSDate *date) {
                
                strongSelf->_filterView.followEndBtn.content.text = [strongSelf->_dateformatter stringFromDate:date];
                strongSelf->_filterView.followEndBtn.placeL.text = @"";
                if ([[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followBeginBtn.content.text] compare:[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followEndBtn.content.text]] == NSOrderedAscending) {
                    
                    NSLog(@"1 > 2");
                }else if ([[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followBeginBtn.content.text] compare:[strongSelf->_dateformatter dateFromString:strongSelf->_filterView.followEndBtn.content.text]] == NSOrderedDescending){
                    
                    [strongSelf showContent:@"跟进结束时间不能小于开始时间"];
                    strongSelf->_filterView.followEndBtn.content.text = @"";
                    strongSelf->_filterView.followEndBtn.placeL.text = @"请选择最后跟进时间（结束）：";
                }else{
                    
                    
                }
            };
            [strongSelf.view addSubview:view];
        }
    };
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    //    rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.image = [UIImage imageNamed:@"search"];
    _searchBar.rightView = rightImg;
    _searchBar.rightViewMode = UITextFieldViewModeUnlessEditing;
    _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchBar.delegate = self;
    [whiteView addSubview:_searchBar];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE) style:UITableViewStyleGrouped];
    _table.backgroundColor = CL240Color;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
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
