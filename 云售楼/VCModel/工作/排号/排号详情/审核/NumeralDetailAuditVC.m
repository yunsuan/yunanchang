//
//  NumeralDetailAuditVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/2.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NumeralDetailAuditVC.h"

#import "TitleContentRightBaseCell.h"
#import "NumeralDetailAuditAdviseCell.h"
#import "TitleBaseHeader.h"

@interface NumeralDetailAuditVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *agreeBtn;

@property (nonatomic, strong) UIButton *disagreeBtn;
@end

@implementation NumeralDetailAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionAuditBtn:(UIButton *)btn{
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section != 1) {
        
        return 1;
    }else{
        
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section != 1) {
        
        return 0;
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TitleBaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleBaseHeader"];
    if (!header) {
        
        header = [[TitleBaseHeader alloc] initWithReuseIdentifier:@"TitleBaseHeader"];
    }
    
//    header.lineView.hidden = YES;
    header.titleL.text = @"序号";
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section < 2) {
        
        TitleContentRightBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleContentRightBaseCell"];
        if (!cell) {
            
            cell = [[TitleContentRightBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleContentRightBaseCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleL.text = @"123123";
        cell.titleL.textColor = CLTitleLabColor;
        cell.contentL.textAlignment = NSTextAlignmentLeft;
        cell.contentL.text = @"1231231231";
        cell.lineView.hidden = YES;
        cell.rightImg.hidden = YES;
        
        return cell;
    }else{
        
        NumeralDetailAuditAdviseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NumeralDetailAuditAdviseCell"];
        if (!cell) {
            
            cell = [[NumeralDetailAuditAdviseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NumeralDetailAuditAdviseCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}


- (void)initUI{
    
    self.titleLabel.text = @"排号详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE) style:UITableViewStylePlain];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
    
    _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _agreeBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 240 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _agreeBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_agreeBtn addTarget:self action:@selector(ActionAuditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [_agreeBtn setBackgroundColor:CLBlueBtnColor];
    [self.view addSubview:_agreeBtn];
    
    _disagreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _disagreeBtn.frame = CGRectMake(240 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 120 *SIZE, 47 *SIZE + TAB_BAR_MORE);
    _disagreeBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_disagreeBtn addTarget:self action:@selector(ActionAuditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_disagreeBtn setTitle:@"不同意" forState:UIControlStateNormal];
    [_disagreeBtn setBackgroundColor:CLLineColor];
    [self.view addSubview:_disagreeBtn];
}

@end
