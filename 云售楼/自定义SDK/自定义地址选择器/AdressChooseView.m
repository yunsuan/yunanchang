//
//  AdressChooseView.m
//  云渠道
//
//  Created by xiaoq on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AdressChooseView.h"
#define PICKERHEIGHT 216
#define BGHEIGHT     256

@interface AdressChooseView ()<UIPickerViewDelegate,UIPickerViewDataSource>

/**
 pickerView
 */
@property(nonatomic, strong) UIPickerView * pickerView;
/**
 bgView
 */
@property(nonatomic, strong) UIView * bgView;

/**
 toolBar
 */
@property(nonatomic, strong) UIView * toolBar;

/**
 取消按钮
 */
@property(nonatomic, strong) UIButton * cancleBtn;

/**
 确定按钮
 */
@property(nonatomic, strong) UIButton * sureBtn;


/**
 省
 */
@property(nonatomic, strong) NSArray * provinceArray;



/**
 市
 */
@property(nonatomic, strong) NSArray * cityArray;



/**
 区
 */
@property(nonatomic, strong) NSArray * areaArray;

/**
 所有数据
 */
@property(nonatomic, strong) NSArray * dataSource;

/**
 记录省选中的位置
 */
@property(nonatomic, assign) NSInteger selected;

/**
 选中的省
 */
@property(nonatomic, copy) NSString * provinceStr;

/**
 选中的市
 */
@property(nonatomic, copy) NSString * cityStr;

/**
 选中的区
 */
@property(nonatomic, copy) NSString * areaStr;


@property(nonatomic , copy)NSString *provinceid;

@property(nonatomic , copy)NSString *cityid;

@property(nonatomic , copy)NSString *areaid;
@end

@implementation AdressChooseView

#pragma mark -- lazy

- (UIButton *)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(10, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancleBtn setTitleColor:COLOR(18, 183, 245, 1) forState:UIControlStateNormal];
        _cancleBtn.backgroundColor = [UIColor clearColor];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(self.frame.size.width - 60, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:COLOR(18, 183, 245, 1) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _sureBtn.backgroundColor = [UIColor clearColor];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIView *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BGHEIGHT - PICKERHEIGHT)];
        _toolBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _toolBar;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, BGHEIGHT)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, BGHEIGHT - PICKERHEIGHT, self.frame.size.width, PICKERHEIGHT)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}




- (NSArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSArray array];
    }
    return _provinceArray;
}


- (NSArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSArray array];
    }
    return _cityArray;
}


- (NSArray *)areaArray
{
    if (!_areaArray) {
        _areaArray = [NSArray array];
    }
    return _areaArray;
}
#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame withdata:(NSArray *)data
{
    if (self = [super initWithFrame:frame]) {
        self.selected = 0;
        [self loadDatas];
        [self initSuViews];
       
      
    }
    return self;
}


#pragma mark -- 从plist里面读数据
- (void)loadDatas
{
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
    
    if ([self.areaArray isKindOfClass:[NSNull class]]) {
        self.areaStr = self.cityStr;
        self.areaid = self.cityid;
    }else{
    self.areaStr = self.areaArray[0][@"name"];
    self.areaid = self.areaArray[0][@"code"];
    }
}

-(void)getprovincearray
{
    _provinceArray = _dataSource;
}

-(void)getCityArrayByprovince:(NSInteger)num
{
    _cityArray = _provinceArray[num][@"city"];
}


-(void)getAreaArrayBycity:(NSInteger )num
{
    _areaArray = _cityArray[num][@"district"];
}





#pragma mark -- loadSubViews
- (void)initSuViews
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolBar];
    [self.bgView addSubview:self.pickerView];
    [self.toolBar addSubview:self.cancleBtn];
    [self.toolBar addSubview:self.sureBtn];
    [self showPickerView];
}

#pragma mark -- showPickerView
- (void)showPickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self->_bgView.frame = CGRectMake(0, self.frame.size.height - BGHEIGHT, self.frame.size.width, BGHEIGHT);
    }];
}


- (void)hidePickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        self->_bgView.frame = CGRectMake(0, self.frame.size.height , self.frame.size.width, BGHEIGHT);
        
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -- UIPickerView
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceArray.count;
    }else if (component == 1){
        return self.cityArray.count;
    }else if (component == 2){
        if (![self.areaArray isKindOfClass:[NSNull class]]) {
            return self.areaArray.count;
        }
        else
        {
            return 0;
        }
        
        
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text = self.provinceArray[row][@"name"];
    }else if (component == 1){
        label.text = self.cityArray[row][@"name"];
    }else if (component == 2){
        label.text = self.areaArray[row][@"name"];
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {//选择省
        self.selected = row;
        [self getCityArrayByprovince:row];
        [self getAreaArrayBycity:0];
        self.provinceStr = self.provinceArray[row][@"name"];
        self.provinceid = self.provinceArray[row][@"code"];
        
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        

        self.cityStr = self.cityArray[0][@"name"];
        self.cityid = self.cityArray[0][@"code"];
        
        if ([self.areaArray isKindOfClass:[NSNull class]]) {
            self.areaStr = self.cityStr;
            self.areaid = self.cityid;
        }else{
            self.areaStr = self.areaArray[0][@"name"];
            self.areaid = self.areaArray[0][@"code"];
        }

        
    }else if (component == 1){//选择市
        [self getAreaArrayBycity:row];
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        self.cityStr = self.cityArray[row][@"name"];
        self.cityid =  self.cityArray[row][@"code"];
        if ([self.areaArray isKindOfClass:[NSNull class]]) {
        self.areaStr = self.cityStr;
        self.areaid = self.cityid;
        }
        else{
            self.areaStr = self.areaArray[0][@"name"];
            self.areaid = self.areaArray[0][@"code"];
        }
        
    }else if (component == 2){//选择区
        self.areaStr = self.areaArray[row][@"name"];
        self.areaid =  self.areaArray[row][@"code"];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


#pragma mark -- Button
- (void)cancleBtnClick
{
    [self hidePickerView];
}

- (void)sureBtnClick
{
    [self hidePickerView];
    if (self.selectedBlock != nil) {
        self.selectedBlock(self.provinceStr,self.cityStr,self.areaStr,self.provinceid,self.cityid,self.areaid);
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickerView];
    }
}



@end
