//
//  VisitCustomVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "VisitCustomVC.h"

#import "VisitCustomDetailVC.h"
#import "AddVisitCustomVC.h"
#import "FollowRecordVC.h"
#import "ChannelCustomListVC.h"


#import "CallTelegramCell.h"
#import "VisitCustomCell.h"


@interface VisitCustomVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    NSInteger _page;
    
    NSString *_projectId;
    NSString *_info_id;
    
    NSMutableDictionary *_visitDic;
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UITextField *searchBar;

@end

@implementation VisitCustomVC

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

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"reloadCall" object:nil];
    _page = 1;
    _dataArr = [@[] mutableCopy];
    _visitDic = [@{} mutableCopy];
}

- (void)RequestMethod{
    
    [_visitDic removeAllObjects];
    [BaseRequest GET:ProjectDutyVisitLog_URL parameters:@{@"project_id":_projectId} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_visitDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            
        }else{
            
            
        }
        [self->_table reloadData];
    } failure:^(NSError * _Nonnull error) {
        
        [self->_table reloadData];
        NSLog(@"%@",error);
    }];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"type":@"2",@"project_id":_projectId}];
    self->_table.mj_footer.state = MJRefreshStateIdle;
    if (![self isEmpty:_searchBar.text]) {
        
        [dic setObject:_searchBar.text forKey:@"search"];
    }
    [BaseRequest GET:WorkClientAutoList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        [self->_dataArr removeAllObjects];
        [self->_table reloadData];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
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
        
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestAddMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"type":@"2",@"project_id":_projectId,@"page":@(_page)}];
    if (![self isEmpty:_searchBar.text]) {
        
        [dic setObject:_searchBar.text forKey:@"search"];
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
    
    AddVisitCustomVC *nextVC = [[AddVisitCustomVC alloc] initWithProjectId:_projectId info_id:_info_id];
    nextVC.addVisitCustomVCBlock = ^{
        
        [self RequestMethod];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self RequestMethod];
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_visitDic.count) {
        
        return _dataArr.count + 1;
    }
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
    
    if (_visitDic.count) {
        
        if (indexPath.section == 0) {
            
            VisitCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VisitCustomCell"];
            if (!cell) {
                
                cell = [[VisitCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VisitCustomCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _visitDic;
            
            
            cell.visitCustomCellBlock = ^{
                
                UIAlertController *source = [UIAlertController alertControllerWithTitle:@"客户来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction *channel = [UIAlertAction actionWithTitle:@"渠道客户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    ChannelCustomListVC *nextVC = [[ChannelCustomListVC alloc] initWithProjectId:self->_projectId info_id:self->_info_id];
                    nextVC.channelCustomListVCBlock = ^(NSDictionary * _Nonnull dic) {
                        
                        FollowRecordVC *vc = [[FollowRecordVC alloc] initWithGroupId:dic[@"group_id"]];
                        vc.followDic = [@{} mutableCopy];
                        vc.status = @"direct";
                        vc.info_id = self->_info_id;
                        vc.visit_id = self->_visitDic[@"visit_id"];
                        vc.allDic = [NSMutableDictionary dictionaryWithDictionary:@{@"project_id":self->_projectId}];
                        vc.followRecordVCBlock = ^{
                            
                            [self RequestMethod];
                        };
                        [self.navigationController pushViewController:vc animated:YES];

                    };
                    [self.navigationController pushViewController:nextVC animated:YES];
                }];
                
                UIAlertAction *visit = [UIAlertAction actionWithTitle:@"自然来访" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    AddVisitCustomVC *nextVC = [[AddVisitCustomVC alloc] initWithProjectId:self->_projectId info_id:self->_info_id];
                    nextVC.visit_id = self->_visitDic[@"visit_id"];
                    nextVC.addVisitCustomVCBlock = ^{
                      
                        [self RequestMethod];
                    };
                    [self.navigationController pushViewController:nextVC animated:YES];
                }];
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [source addAction:channel];
                [source addAction:visit];
                [source addAction:cancel];
                
                [self.navigationController presentViewController:source animated:YES completion:^{
                    
                }];
            };
            
            return cell;
        }else{
            
            CallTelegramCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCell"];
            if (!cell) {
                
                cell = [[CallTelegramCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataDic = _dataArr[indexPath.section - 1];;
            
            return cell;
        }
    }else{
        
        CallTelegramCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCell"];
        if (!cell) {
            
            cell = [[CallTelegramCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _dataArr[indexPath.section];;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VisitCustomDetailVC *nextVC = [[VisitCustomDetailVC alloc] initWithGroupId:[NSString stringWithFormat:@"%@",_dataArr[indexPath.section][@"group_id"]]];
    nextVC.project_id = [NSString stringWithFormat:@"%@",_projectId];
    nextVC.info_id = [NSString stringWithFormat:@"%@",_info_id];
    nextVC.name = @"";//_dataArr[indexPath.row][@"agent_name"];
    if ([_dataArr[indexPath.row][@"advicer_id"] integerValue] == [[UserModel defaultModel].agent_id integerValue]) {
        
        nextVC.powerDic = self.powerDic;
    }else{
        
        nextVC.powerDic = @{};
    }
    nextVC.visitCustomDetailModifyBlock = ^{
      
        [self RequestMethod];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)initUI{
    
    self.titleLabel.text = @"来访";
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
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 340 *SIZE, 33 *SIZE)];
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
