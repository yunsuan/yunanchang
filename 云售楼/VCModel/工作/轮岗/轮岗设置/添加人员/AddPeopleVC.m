//
//  AddPeopleVC.m
//  云售楼
//
//  Created by xiaoq on 2019/5/21.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddPeopleVC.h"
#import "AbdicateCell.h"

@interface AddPeopleVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataarr;
}


@property (nonatomic , strong) UITableView *PeopleTable;

@property (nonatomic , strong) UIButton *SureBtn;

@end

@implementation AddPeopleVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self Post];
    
}

-(void)Post{
    [BaseRequest GET:GetPeople_URL
          parameters:@{
                       @"company_id":_company_id
                       }
             success:^(id  _Nonnull resposeObject) {
                 
                 if ([resposeObject[@"code"] integerValue]==200) {
                     _dataarr = [resposeObject[@"data"] mutableCopy];
                     [self ClernSameData];
                     [self.view addSubview:self.PeopleTable];
                     [self.view addSubview:self.SureBtn];
                 }
                 else
                 {
                     [self showContent:resposeObject[@"data"]];
                 }
                 
                 
             }
             failure:^(NSError * _Nonnull error) {
                 
                 [self showContent:@"网络错误"];
             }];
}


- (void)initUI{
    
    self.titleLabel.text = @"选择人员";
    self.leftButton.hidden = NO;
//    [self.view addSubview:self.PeopleTable];
//    [self.view addSubview:self.SureBtn];
    
    
}

-(void)action_sure
{
    if (self.addBtnBlock) {
        
        self.addBtnBlock(_dataarr[ _PeopleTable.indexPathsForSelectedRows[0].row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataarr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.indexPathsForSelectedRows.count>1) {
        [tableView deselectRowAtIndexPath:tableView.indexPathsForSelectedRows[0] animated:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73*SIZE;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AbdicateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AbdicateCell"];
    if (!cell) {
        
        cell = [[AbdicateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AbdicateCell"];
    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameL.text = _dataarr[indexPath.row][@"name"];
    cell.phoneL.text = _dataarr[indexPath.row][@"tel"];
    [cell.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataarr[indexPath.row][@"url"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    return cell;
}




-(UITableView *)PeopleTable
{
    if (!_PeopleTable) {
        _PeopleTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _PeopleTable.delegate = self;
        _PeopleTable.dataSource = self;
        _PeopleTable.backgroundColor = CLWhiteColor;
        _PeopleTable.editing = YES;
        [_PeopleTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _PeopleTable;
}

-(UIButton *)SureBtn
{
    if (!_SureBtn) {
        _SureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _SureBtn.frame = CGRectMake(0, SCREEN_Height-TAB_BAR_HEIGHT, 360*SIZE, TAB_BAR_HEIGHT);
        _SureBtn.backgroundColor = CLBlueBtnColor;
        _SureBtn.titleLabel.font = FONT(15);
        [_SureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_SureBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
        [_SureBtn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SureBtn;
}


-(void)ClernSameData
{
    NSMutableArray *samearr = [@[] mutableCopy];
    for (int i = 0; i<_selectPeople.count; i++) {
        for (int j = 0; j<_dataarr.count; j++) {
            if ([_selectPeople[i][@"agent_id"] isEqual:_dataarr[j][@"agent_id"]]) {
                [samearr addObject:[NSString stringWithFormat:@"%d",j]];
            }
        }
    }
    if (samearr.count>0) {
        for (int i = 0;i<samearr.count ; i++) {
            [_dataarr removeObjectAtIndex:[samearr[i] integerValue]];
        }
    }
}


@end
