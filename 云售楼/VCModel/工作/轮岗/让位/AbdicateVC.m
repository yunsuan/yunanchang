//
//  AbdicateVC.m
//  云售楼
//
//  Created by xiaoq on 2019/5/19.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AbdicateVC.h"
#import "AbdicateCell.h"
#import "AbdicateHeaderView.h"

@interface AbdicateVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_reserve_agent;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic , strong) UITableView *AbdicateTable;

@property (nonatomic , strong) UIButton *SureBtn;

@end

@implementation AbdicateVC

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        _dataDic = [[NSMutableDictionary alloc] initWithDictionary:data];
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:_dataDic[@"person"]];
        for (int i = 0; i < tempArr.count; i++) {
            
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:tempArr[i]];
            NSMutableArray *listArr = [[NSMutableArray alloc] initWithArray:tempDic[@"list"]];
            [listArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                if ([obj[@"duty_agent_id"] isEqualToString:self->_dataDic[@"duty"][@"duty_agent_id"]]) {
                    
                    [listArr removeObjectAtIndex:idx];
                    *stop = YES;
                }
            }];
            if (listArr.count) {
                
                [tempDic setObject:listArr forKey:@"list"];
                [tempArr replaceObjectAtIndex:i withObject:tempDic];
            }else{
            
                [tempArr removeObjectAtIndex:i];
            }
        }
        [_dataDic setObject:tempArr forKey:@"person"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

- (void)initUI{
    
    self.titleLabel.text = @"选择让位人员";
    
    self.leftButton.hidden = NO;
    [self.view addSubview:self.AbdicateTable];
    [self.view addSubview:self.SureBtn];

}

-(void)action_sure
{
    if (_reserve_agent.length) {
        
        [BaseRequest POST:DutyAgentUpdate_URL parameters:@{@"duty_agent_id":_dataDic[@"duty"][@"duty_agent_id"],@"reserve_agent":_reserve_agent} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }else{
        
        [self alertControllerWithNsstring:@"让位错误" And:@"请选择让位人员"];
    }
    NSLog(@"%@",_AbdicateTable.indexPathsForSelectedRows);
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_dataDic[@"person"] count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _reserve_agent = [NSString stringWithFormat:@"%@",_dataDic[@"person"][indexPath.section][@"list"][indexPath.row][@"agent_id"]];
    if (tableView.indexPathsForSelectedRows.count>1) {
        [tableView deselectRowAtIndexPath:tableView.indexPathsForSelectedRows[0] animated:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataDic[@"person"][section][@"list"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    

    return 37*SIZE;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73*SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    AbdicateHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AbdicateHeaderView"];
    if (!header) {
        header = [[AbdicateHeaderView alloc]initWithReuseIdentifier: @"AbdicateHeaderView"];
    }

    header.companyL.text = _dataDic[@"person"][section][@"company_name"];
    return header;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AbdicateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AbdicateCell"];
    if (!cell) {
        
        cell = [[AbdicateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AbdicateCell"];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameL.text = _dataDic[@"person"][indexPath.section][@"list"][indexPath.row][@"name"];
    cell.phoneL.text = _dataDic[@"person"][indexPath.section][@"list"][indexPath.row][@"tel"];
    
    return cell;
}




-(UITableView *)AbdicateTable
{
    if (!_AbdicateTable) {
        _AbdicateTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _AbdicateTable.delegate = self;
        _AbdicateTable.dataSource = self;
        _AbdicateTable.backgroundColor = CLWhiteColor;
        _AbdicateTable.editing = YES;
        [_AbdicateTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _AbdicateTable;
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

@end
