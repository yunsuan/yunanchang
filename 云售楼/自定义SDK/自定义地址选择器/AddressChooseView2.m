//
//  AddressChooseView2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddressChooseView2.h"
#import "AddressTableCell.h"

@interface AddressChooseView2()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_dataSource;
}
@property (nonatomic, strong) UITableView *proTable;

@property (nonatomic, strong) UITableView *cityTable;

@property (nonatomic, strong) UITableView *districtTable;

@property(nonatomic, strong) NSArray * provinceArray;

@property(nonatomic, strong) NSMutableArray * cityArray;

@property(nonatomic, strong) NSMutableArray * areaArray;

@property (nonatomic, strong) NSMutableArray *selectPro;

@property (nonatomic, strong) NSMutableArray *selectCity;

@property (nonatomic, strong) NSMutableArray *selectArea;

@property(nonatomic, copy) NSString * provinceStr;

@property(nonatomic, copy) NSString * cityStr;

@property(nonatomic, copy) NSString * areaStr;

@property(nonatomic , copy)NSString *provinceid;

@property(nonatomic , copy)NSString *cityid;

@property(nonatomic , copy)NSString *areaid;

//@property(nonatomic, assign) NSInteger selected;

@end

@implementation AddressChooseView2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initDataSource];
        [self initUI];
    }
    return self;
}

- (void)initDataSource{
    
    _selectPro = [@[] mutableCopy];
    _selectCity = [@[] mutableCopy];
    _selectArea = [@[] mutableCopy];
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
    
    NSError *err;
    _dataSource = [NSJSONSerialization JSONObjectWithData:JSONData
                                                  options:NSJSONReadingMutableContainers
                                                    error:&err];
    [self getprovincearray];
    [self getCityArrayByprovince:0];
    [self getAreaArrayBycity:0];
    self.provinceStr = self.provinceArray[0][@"name"];
    self.provinceid = self.provinceArray[0][@"code"];
    self.cityStr = self.cityArray[0][@"name"];
    self.cityid = self.cityArray[0][@"code"];
    self.areaStr = self.areaArray[0][@"name"];
    self.areaid = self.areaArray[0][@"code"];
    
    NSMutableArray *selectTemp = [NSMutableArray arrayWithArray:self.provinceArray];
    [self.provinceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (idx == 0) {
            
            [selectTemp replaceObjectAtIndex:0 withObject:@(1)];
        }else{
            
            [selectTemp replaceObjectAtIndex:idx withObject:@(0)];
        }
    }];
    _selectPro = selectTemp;
    
    selectTemp = [NSMutableArray arrayWithArray:self.cityArray];
    [self.cityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0) {
            
            [selectTemp replaceObjectAtIndex:0 withObject:@(1)];
        }else{
            
            [selectTemp replaceObjectAtIndex:idx withObject:@(0)];
        }
    }];
    _selectCity = selectTemp;
    
    selectTemp = [NSMutableArray arrayWithArray:self.areaArray];
    [self.areaArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0) {
            
            [selectTemp replaceObjectAtIndex:0 withObject:@(1)];
        }else{
            
            [selectTemp replaceObjectAtIndex:idx withObject:@(0)];
        }
    }];
    _selectArea = selectTemp;
    
}

- (void)ActionTap{
    if (self.cancelBtnBlock) {
        
        self.cancelBtnBlock();
    }
    
    if (self.superview) {
        [self removeFromSuperview];
    }
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.confirmAreaBlock) {
        
        self.confirmAreaBlock(self.provinceStr, self.cityStr, self.areaStr, self.provinceid, self.cityid, self.areaid);
        [self removeFromSuperview];
    }
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    if (self.cancelBtnBlock) {
        
        self.cancelBtnBlock();
        [self removeFromSuperview];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == _proTable) {
        
        return self.provinceArray.count;
    }else if (tableView == _cityTable){
        
        return _cityArray.count;
    }else{
        
        return _areaArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableCell"];
    if (!cell) {
        
        cell = [[AddressTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == _proTable) {
        
        cell.titleL.text = _provinceArray[indexPath.row][@"name"];
        
        if ([_selectPro[indexPath.row] integerValue]) {
            
            cell.titleL.textColor = CLBlueBtnColor;
        }else{
            
            cell.titleL.textColor = CL86Color;
        }
    }else if (tableView == _cityTable){
        
        cell.titleL.text = _cityArray[indexPath.row][@"name"];
        
        if ([_selectCity[indexPath.row] integerValue]) {
            
            cell.titleL.textColor = CLBlueBtnColor;
        }else{
            
            cell.titleL.textColor = CL86Color;
        }
    }else{
        
        cell.titleL.text = _areaArray[indexPath.row][@"name"];
        
        if ([_selectArea[indexPath.row] integerValue]) {
            
            cell.titleL.textColor = CLBlueBtnColor;
        }else{
            
            cell.titleL.textColor = CL86Color;
        }
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _proTable) {//选择省
//        self.selected = indexPath.row;
        [self getCityArrayByprovince:indexPath.row];
        [self getAreaArrayBycity:0];
        self.provinceStr = self.provinceArray[indexPath.row][@"name"];
        self.provinceid = self.provinceArray[indexPath.row][@"code"];
        
        NSMutableArray *selectTemp = [NSMutableArray arrayWithArray:self.cityArray];
        [self.cityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [selectTemp replaceObjectAtIndex:0 withObject:@(1)];
            }else{
                
                [selectTemp replaceObjectAtIndex:idx withObject:@(0)];
            }
        }];
        _selectCity = selectTemp;
        
        [_cityTable reloadData];
        [_cityTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        
        NSMutableArray *selectTemp1 = [NSMutableArray arrayWithArray:self.areaArray];
        [self.areaArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [selectTemp1 replaceObjectAtIndex:0 withObject:@(1)];
            }else{
                
                [selectTemp1 replaceObjectAtIndex:idx withObject:@(0)];
            }
        }];
        _selectArea = selectTemp1;
        
        [_districtTable reloadData];
        if (_areaArray.count) {
            
            [_districtTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
        
        [tableView reloadData];
        
        self.cityStr = self.cityArray[0][@"name"];
        self.cityid = self.cityArray[0][@"code"];
        if (_areaArray.count) {
            
            self.areaStr = self.areaArray[0][@"name"];
            self.areaid = self.areaArray[0][@"code"];
        }else{
            
            self.areaStr = @"";
            self.areaid = @"";
        }
        
        
        [_selectPro enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == indexPath.row) {
                
                [self->_selectPro replaceObjectAtIndex:idx withObject:@(1)];
            }else{
                
                [self->_selectPro replaceObjectAtIndex:idx withObject:@(0)];
            }
        }];
        [tableView reloadData];
    }else if (tableView == _cityTable){//选择市
        
        [self getAreaArrayBycity:indexPath.row];
        
        [_districtTable reloadData];
        if (_areaArray.count) {
            
            [_districtTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
        
        self.cityStr = self.cityArray[indexPath.row][@"name"];
        self.cityid =  self.cityArray[indexPath.row][@"code"];
        if (_areaArray.count) {
            
            self.areaStr = self.areaArray[0][@"name"];
            self.areaid = self.areaArray[0][@"code"];
        }else{
            
            self.areaStr = @"";
            self.areaid = @"";
        }
//        self.areaStr = self.areaArray[0][@"name"];
//        self.areaid = self.areaArray[0][@"code"];
        
        NSMutableArray *selectTemp = [NSMutableArray arrayWithArray:self.areaArray];
        [self.areaArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [selectTemp replaceObjectAtIndex:0 withObject:@(1)];
            }else{
                
                [selectTemp replaceObjectAtIndex:idx withObject:@(0)];
            }
        }];
        _selectArea = selectTemp;
        [_districtTable reloadData];
        [_districtTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        [_selectCity enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == indexPath.row) {
                
                [self->_selectCity replaceObjectAtIndex:idx withObject:@(1)];
            }else{
                
                [self->_selectCity replaceObjectAtIndex:idx withObject:@(0)];
            }
        }];
        [tableView reloadData];
    }else if (tableView == _districtTable){//选择区
        
        self.areaStr = self.areaArray[indexPath.row][@"name"];
        self.areaid =  self.areaArray[indexPath.row][@"code"];
        
        [_selectArea enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == indexPath.row) {
                
                [self->_selectArea replaceObjectAtIndex:idx withObject:@(1)];
            }else{
                
                [self->_selectArea replaceObjectAtIndex:idx withObject:@(0)];
            }
        }];
        [tableView reloadData];
    }
}


- (void)initUI{
    
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap)];
    [backView addGestureRecognizer:tap];
    [self addSubview:backView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 243 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    
    for (int i = 0; i < 3; i++) {
        
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 0, SCREEN_Width / 3, 160 *SIZE) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.tableFooterView = [[UIView alloc] init];
        switch (i) {
            case 0:
            {
                table.backgroundColor = [UIColor whiteColor];
                _proTable = table;
                [self addSubview:_proTable];
                break;
            }
            case 1:
            {
                table.backgroundColor = CLBackColor;
                _cityTable = table;
                [self addSubview:_cityTable];
                break;
            }
            case 2:
            {
                table.backgroundColor = [UIColor whiteColor];
                _districtTable = table;
                [self addSubview:_districtTable];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(66 *SIZE + i * 125 *SIZE, 188 *SIZE, 100 *SIZE, 33 *SIZE);
        if (i == 0) {
            
            
            [btn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:CL86Color forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
            btn.layer.cornerRadius = 2 *SIZE;
            btn.layer.borderColor = COLOR(170, 170, 170, 1).CGColor;
            btn.clipsToBounds = YES;
            btn.layer.borderWidth = SIZE;
            [whiteView addSubview:btn];
        }else{
            
            [btn setTitle:@"确定" forState:UIControlStateNormal];
            [btn setBackgroundColor:COLOR(130, 200, 255, 1)];
            btn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
            btn.layer.cornerRadius = 2 *SIZE;
            btn.clipsToBounds = YES;
            [btn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
            [whiteView addSubview:btn];
        }
    }
    
}


-(void)getprovincearray
{
    NSDictionary *dic = @{@"city":@[@{@"code":@"000000",
                                      @"district":@[@{@"code":@"0000000",
                                                      @"name":@"不限"
                                                      }],
                                      @"name":@"不限"
                                      }],
                          @"code":@"0000000",
                          @"name":@"不限"};
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:[_dataSource mutableCopy]];
    [tempArr insertObject:dic atIndex:0];
    NSArray *proArr = [[NSArray alloc] initWithArray:tempArr];
    _provinceArray = proArr;
}

-(void)getCityArrayByprovince:(NSInteger)num
{
    _cityArray = [NSMutableArray arrayWithArray:_provinceArray[num][@"city"]];
}


-(void)getAreaArrayBycity:(NSInteger )num
{
    if (![_cityArray[num][@"district"] isKindOfClass:[NSNull class]]) {
        
        _areaArray = [NSMutableArray arrayWithArray:_cityArray[num][@"district"]];
    }else{
        
        _areaArray = [[NSMutableArray alloc] init];
    }
}


@end
