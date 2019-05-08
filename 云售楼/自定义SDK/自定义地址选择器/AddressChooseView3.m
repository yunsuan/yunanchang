//
//  AddressChooseView3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/5/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AddressChooseView3.h"
#define PICKERHEIGHT 216
#define BGHEIGHT     256

#define KEY_WINDOW_HEIGHT [UIApplication sharedApplication].keyWindow.frame.size.height

@interface AddressChooseView3()<UIPickerViewDelegate,UIPickerViewDataSource>

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

@property(nonatomic, strong) UIButton * cancleBtn;

@property(nonatomic, strong) UIButton * sureBtn;

/**
 记录市选中的位置
 */
@property(nonatomic, assign) NSInteger selected;

@property (nonatomic, strong) NSArray *proArr;;

@property(nonatomic, strong) NSArray * cityArray;

@property(nonatomic, strong) NSArray * areaArray;

@property(nonatomic, strong) NSArray * dataSource;

@property(nonatomic, copy) NSString * cityStr;

@property(nonatomic, copy) NSString * areaStr;

@property(nonatomic , copy)NSString *cityid;

@property(nonatomic , copy)NSString *areaid;



@end

@implementation AddressChooseView3

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
    _proArr = [NSJSONSerialization JSONObjectWithData:JSONData
                                              options:NSJSONReadingMutableContainers
                                                error:&err];
//    if ([UserModel defaultModel].cityArr.count) {
//        
//        _cityArray = [UserModel defaultModel].cityArr;
//        [self getAreaArrayBycity:_cityArray[0][@"city_code"] name:_cityArray[0][@"city_name"]];
//        self.cityStr = self.cityArray[0][@"city_name"];
//        self.cityid = self.cityArray[0][@"city_code"];
//        self.areaStr = self.areaArray[0][@"name"];
//        self.areaid = self.areaArray[0][@"code"];
//    }else{
//        
//        [BaseRequest GET:OpenCity_URL parameters:nil success:^(id resposeObject) {
//            
//            if ([resposeObject[@"code"] integerValue] == 200) {
//                
//                _cityArray = resposeObject[@"data"];
//                
//                if (_cityArray.count) {
//                    
//                    [self getAreaArrayBycity:_cityArray[0][@"city_code"] name:self.cityArray[0][@"city_name"]];
//                    self.cityStr = self.cityArray[0][@"city_name"];
//                    self.cityid = self.cityArray[0][@"city_code"];
//                    self.areaStr = self.areaArray[0][@"name"];
//                    self.areaid = self.areaArray[0][@"code"];
//                }
//                
//            }
//            [_pickerView reloadAllComponents];
//        } failure:^(NSError *error) {
//            
//            
//        }];
//    }
}

-(void)getAreaArrayBycity:(NSString *)code name:(NSString *)name
{
    
    if ([code hasPrefix:@"90"]) {
        NSString *areacode  = [code substringToIndex:4];
        areacode = [NSString stringWithFormat:@"%@01",areacode];
        
        self.areaArray = @[@{ @"code":areacode,
                              @"name": name}];
    }
    else{
        
        NSMutableArray * tempArr;
        for (NSDictionary *proDic in _proArr) {
            
            for (NSDictionary *cityDic in proDic[@"city"]) {
                
                if ([cityDic[@"code"] integerValue] == [code integerValue]) {
                    
                    tempArr = [NSMutableArray arrayWithArray:cityDic[@"district"]];
                    self.areaArray = tempArr;
                    break;
                }
                
            }
        }
        
    }
    
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
        return self.cityArray.count;
    }else
    {
        return self.areaArray.count;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        
        label.text = self.cityArray[row][@"city_name"];
    }else{
        
        label.text = self.areaArray[row][@"name"];
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {//选择市
        self.selected = row;
        
        self.cityStr = self.cityArray[row][@"city_name"];
        self.cityid = self.cityArray[row][@"city_code"];
        
        //        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        
        [self getAreaArrayBycity:self.cityArray[row][@"city_code"] name:self.cityArray[row][@"city_name"]];
        self.areaStr = self.areaArray[0][@"name"];
        self.areaid = self.areaArray[0][@"code"];
        [self.pickerView reloadComponent:1];
        
    }else{
        
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
    return 2;
}


#pragma mark -- Button
- (void)cancleBtnClick
{
    [self hidePickerView];
}

- (void)sureBtnClick
{
    [self hidePickerView];
    if (self.addressChooseView3ConfirmBlock != nil) {
        
        self.addressChooseView3ConfirmBlock(self.cityStr, self.areaStr, self.cityid, self.areaid);
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickerView];
    }
}

@end
