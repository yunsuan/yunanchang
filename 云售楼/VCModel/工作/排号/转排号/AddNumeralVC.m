//
//  AddNumeralVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/2.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddNumeralVC.h"

#import "TitleRightBtnHeader.h"
#import "AddNumeralPersonCell.h"
#import "AddNumeralInfoCell.h"
#import "AddNumeralProcessCell.h"

@interface AddNumeralVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_project_id;
    
    NSArray *_titleArr;
    
    NSMutableArray *_personArr;
    NSMutableArray *_selectArr;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddNumeralVC

- (instancetype)initWithProject_id:(NSString *)project_id personArr:(NSArray *)personArr
{
    self = [super init];
    if (self) {
        
        _project_id = project_id;
        _personArr = [[NSMutableArray alloc] initWithArray:personArr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"权益人信息",@"排号信息",@"流程信息"];
//    _personArr = [@[] mutableCopy];
    _selectArr = [[NSMutableArray alloc] initWithArray:@[@1,@0,@0]];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    NSDictionary *dic = @{@"project_id":_project_id};
    
    [BaseRequest POST:ProjectRowAddRow_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
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
    
    if ([_selectArr[section] integerValue] == 1) {
        
        return 1;
    }else{
        
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TitleRightBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleRightBtnHeader"];
    if (!header) {
        
        header = [[TitleRightBtnHeader alloc] initWithReuseIdentifier:@"TitleRightBtnHeader"];
    }
    
    header.titleL.text = _titleArr[section];
    
    header.addBtn.hidden = YES;
    if ([_selectArr[section] integerValue] == 1) {
        
        [header.moreBtn setTitle:@"收起" forState:UIControlStateNormal];
    }else{
        
        [header.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    }
    
    header.titleRightBtnHeaderMoreBlock = ^{
      
        if ([self->_selectArr[section] integerValue] == 1) {
            
            [self->_selectArr replaceObjectAtIndex:section withObject:@0];
        }else{
            
            [self->_selectArr replaceObjectAtIndex:section withObject:@1];
        }
        [tableView reloadData];
    };
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        AddNumeralPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddNumeralPersonCell"];
        if (!cell) {
            
            cell = [[AddNumeralPersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddNumeralPersonCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataArr = _personArr;
        
        return cell;
    }else{
        
        if (indexPath.section == 1) {
            
            AddNumeralInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddNumeralInfoCell"];
            if (!cell) {
                
                cell = [[AddNumeralInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddNumeralInfoCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else{
            
            AddNumeralProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddNumeralProcessCell"];
            if (!cell) {
                
                cell = [[AddNumeralProcessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddNumeralProcessCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"转排号";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 40 *SIZE;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    [self.view addSubview:_nextBtn];
}

@end
