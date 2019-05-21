//
//  AddCompanyVC.m
//  云售楼
//
//  Created by xiaoq on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddCompanyVC.h"
#import "CompanyChooseCell.h"

@interface AddCompanyVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataarr;
}

@property (nonatomic , strong) UITableView *CompanyTable;

@property (nonatomic , strong) UIButton *SureBtn;


@end



@implementation AddCompanyVC




- (void)viewDidLoad {
    [super viewDidLoad];
    [self Post];
    [self initUI];
    
}

-(void)Post{
    [BaseRequest GET:GetCompany_URL
           parameters:@{
                        @"project_id":[UserModel defaultModel].projectinfo[@"project_id"]
                                                  }
              success:^(id  _Nonnull resposeObject) {
                  
                  if ([resposeObject[@"code"] integerValue]==200) {
                      _dataarr = [resposeObject[@"data"] mutableCopy];
                      [self ClernSameData];
                      [self.view addSubview:self.CompanyTable];
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
    
    self.titleLabel.text = @"选择公司";
    self.leftButton.hidden = NO;

    
    
    
}

-(void)action_sure
{
    
    
    if (self.addBtnBlock) {
        
        self.addBtnBlock([_dataarr[ _CompanyTable.indexPathsForSelectedRows[0].row] mutableCopy]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.indexPathsForSelectedRows.count>1) {
        [tableView deselectRowAtIndexPath:tableView.indexPathsForSelectedRows[0] animated:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataarr.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73*SIZE;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 CompanyChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyChooseCell"];
    if (!cell) {
        
        cell = [[CompanyChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CompanyChooseCell"];
    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataarr[indexPath.row][@"logo"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            image = [UIImage imageNamed:@"company"];
        }
    }];
    cell.companyL.text = _dataarr[indexPath.row][@"company_name"];
    cell.nameL.text = _dataarr[indexPath.row][@"contact"];
    cell.phoneL.text = _dataarr[indexPath.row][@"contact_tel"];
    
    return cell;
}




-(UITableView *)CompanyTable
{
    if (!_CompanyTable) {
        _CompanyTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _CompanyTable.delegate = self;
        _CompanyTable.dataSource = self;
        _CompanyTable.backgroundColor = CLWhiteColor;
        _CompanyTable.editing = YES;
        [_CompanyTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _CompanyTable;
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
    for (int i = 0; i<_selectCompany.count; i++) {
        for (int j = 0; j<_dataarr.count; j++) {
            if ([_selectCompany[i][@"company_id"] isEqual:_dataarr[j][@"company_id"]]) {
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
