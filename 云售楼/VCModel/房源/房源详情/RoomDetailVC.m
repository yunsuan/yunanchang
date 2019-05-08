//
//  RoomDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RoomDetailVC.h"

#import "SMScrollView.h"
//#import "KyoCenterLineView.h"
//#import "KyoRowIndexView.h"
#import "SingleHouseCell.h"

#define kRowIndexWith   30
#define kRowIndexSpace  2.0
#define kRowIndexViewDefaultColor   [UIColor clearColor]
#define kCenterLineViewTail 6.0
#define KweixuanColor COLOR(220, 220, 220, 1)
#define KyidingColor COLOR(255, 215, 154, 1)
#define KyishouColor COLOR(244, 117, 100, 1)

@interface RoomDetailVC ()<SMCinameSeatScrollViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_headarr;
    NSArray *_titlearr;
    NSArray *_contentarr;
}

@property (nonatomic , strong)NSMutableArray *datasouce;
@property (nonatomic , strong)NSDictionary *fjxx;
@property (nonatomic, assign)  NSUInteger row;
@property (nonatomic, assign)  NSUInteger column;
@property (nonatomic, assign)  CGSize seatSize;
@property (assign, nonatomic)  CGFloat seatTop;
@property (assign, nonatomic)  CGFloat seatLeft;
@property (assign, nonatomic)  CGFloat seatBottom;
@property (assign, nonatomic)  CGFloat seatRight;
@property (strong, nonatomic)  UIImage *imgSeatNormal;
@property (strong, nonatomic)  UIImage *imgSeatHadBuy;
@property (strong, nonatomic)  UIImage *imgSeatSelected;
@property (strong, nonatomic)  UIImage *imgSeatUnexist;
@property (strong, nonatomic)  UIImage *imgSeatLoversLeftNormal;
@property (strong, nonatomic)  UIImage *imgSeatLoversLeftHadBuy;
@property (strong, nonatomic)  UIImage *imgSeatLoversLeftSelected;
@property (strong, nonatomic)  UIImage *imgSeatLoversRightNormal;
@property (strong, nonatomic)  UIImage *imgSeatLoversRightHadBuy;
@property (strong, nonatomic)  UIImage *imgSeatLoversRightSelected;
@property (assign, nonatomic)  BOOL showCenterLine;
@property (assign, nonatomic)  BOOL showRowIndex;
@property (assign, nonatomic)  BOOL rowIndexStick;  /**< 是否让showIndexView粘着左边 */
@property (strong, nonatomic)  UIColor *rowIndexViewColor;
@property (assign, nonatomic)  NSInteger rowIndexType; //座位左边行号提示样式
@property (strong, nonatomic)  NSMutableArray *arrayRowIndex; //座位号左边行号提示（用它则忽略
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) KyoRowIndexView *rowIndexView;
@property (strong, nonatomic) KyoCenterLineView *centerLineView;
@property (strong, nonatomic) NSMutableDictionary *dictSeat;
@property (retain, nonatomic) SMScrollView *myScrollView;
@property (strong, nonatomic) NSMutableDictionary *dictSeatState;
@property ( nonatomic , strong ) UIView *maskView;
@property ( nonatomic , strong ) UIView *maskView1;
@property ( nonatomic , strong ) UIView *tanchuanView;
@property ( nonatomic , strong ) UIView *detailView;
@property ( nonatomic , strong ) UIButton *dropbtn;
@property ( nonatomic , strong ) UITableView *tableview;
@end

@implementation RoomDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(243, 243, 243, 1);
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = _titleinfo;
    [self post];
    
}


-(void)post{
//    [BaseRequest GET:GetUnit_URL parameters:@{
//                                              @"project_id":_project_id,
//                                              @"build_id":_build_id,
//                                              @"unit_id":_unit_id,
//                                              @"type":@"0"
//                                              }
//             success:^(id resposeObject) {
//
//                 if ([resposeObject[@"code"] integerValue]==200) {
//                     _datasouce = resposeObject[@"data"];
//                     [self initInterFace];
//                 }
//
//             }
//             failure:^(NSError *error) {
//
//             }];
}


-(void)initheader
{
    [self.view addSubview:self.dropbtn];
    NSArray *arr = @[@"已定",@"已售",@"未售"];
    NSArray *colorarr = @[KyidingColor,KyishouColor,KweixuanColor];
    for (int i = 0 ; i<3; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE+i*66.7*SIZE, 47.7*SIZE+NAVIGATION_BAR_HEIGHT, 50*SIZE, 26.7*SIZE)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = arr[i];
        lab.backgroundColor = colorarr[i];
        lab.layer.masksToBounds = YES;
        lab.layer.cornerRadius = 1.7*SIZE;
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:12*SIZE];
        [self.view addSubview:lab];
    }
}

-(void)initInterFace
{
    [self initheader];
    
    _row = _datasouce.count;
    _column = 0;
    for (int i = 0; i<_row; i++) {
        
        if ([_datasouce[i][@"LIST"] count]>_column) {
            _column = [_datasouce[i][@"LIST"] count];
        }
    }
    
    _seatSize = CGSizeMake(93*SIZE, 34*SIZE);
    _seatTop = 20;
    _seatLeft = 30;
    _seatBottom = 20;
    _seatRight = 20;
    _myScrollView.zoomScale = 1.0;
    
    _imgSeatNormal = [UIImage imageNamed:@""];
    _imgSeatHadBuy = [UIImage imageNamed:@""];
    _imgSeatSelected = [UIImage imageNamed:@""];
    
    _showCenterLine = YES;
    _showRowIndex = YES;
    _rowIndexStick = YES;
    
    self.dictSeatState = [NSMutableDictionary dictionary];
    for (NSInteger row = 0; row < self.row; row++) {
        NSMutableArray *arrayState = [NSMutableArray array];
        for (NSInteger column = 0; column < self.column; column++) {
            
            [arrayState addObject:@(KyoCinameSeatStateNormal)];
 
        }
        [self.dictSeatState setObject:arrayState forKey:@(row)];
    }
    
    self.myScrollView = [[SMScrollView alloc] init];
    _myScrollView.contentSize = CGSizeMake((self.seatLeft + self.column * self.seatSize.width + self.seatRight) * _myScrollView.zoomScale,(self.seatTop + self.row * self.seatSize.height + self.seatBottom) * _myScrollView.zoomScale);
    
    if (!self.contentView) {
        self.contentView = [[UIView alloc] init];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    _contentView.frame = CGRectMake(0, 0, _myScrollView.contentSize.width, _myScrollView.contentSize.height);
    
    _contentView.contentMode = UIViewContentModeScaleAspectFill;
    _contentView.clipsToBounds = YES;
    _SMCinameSeatScrollViewDelegate = self;
    
    self.myScrollView = [[SMScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+81.3*SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-81.3*SIZE)];
    self.myScrollView.maximumZoomScale = 2;
    self.myScrollView.delegate = self;
    self.myScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.myScrollView.contentSize = _contentView.frame.size;
    self.myScrollView.alwaysBounceVertical = YES;
    self.myScrollView.alwaysBounceHorizontal = YES;
    self.myScrollView.stickToBounds = YES;
    [self.myScrollView addViewForZooming:_contentView];
    [self.myScrollView scaleToFit];
    self.myScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myScrollView];
    
    self.myScrollView.contentSize = CGSizeMake((self.seatLeft + self.column * self.seatSize.width + self.seatRight) * _myScrollView.zoomScale,(self.seatTop + self.row * self.seatSize.height + self.seatBottom) * _myScrollView.zoomScale);
    
    //画座位
    [self drawSeat];
    
    UIImageView *seatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 50, 50)];
    seatImageView.image = [UIImage imageNamed:@"selectSeat"];
    [_contentView addSubview:seatImageView];
    [_contentView bringSubviewToFront:seatImageView];
    
    //画座位行数提示
    if (!self.rowIndexView) {
        self.rowIndexView = [[KyoRowIndexView alloc] init];
        self.rowIndexView.arrayRowIndex = [NSMutableArray array];
        for (int i = 0; i<_datasouce.count; i++) {
            [self.rowIndexView.arrayRowIndex addObject:[NSString stringWithFormat:@"F%@",_datasouce[i][@"FLOORNUM"]]];
        }
        [self.rowIndexView drawRect:self.rowIndexView.frame];
        self.rowIndexView.backgroundColor = self.rowIndexViewColor ? : kRowIndexViewDefaultColor;
        [_contentView addSubview:self.rowIndexView];
        
    }
    if (self.showRowIndex) {
        [_contentView bringSubviewToFront:self.rowIndexView];
        [_myScrollView bringSubviewToFront:self.rowIndexView];
        self.rowIndexView.row = self.row;
        self.rowIndexView.width = kRowIndexWith;
        self.rowIndexView.rowIndexViewColor = self.rowIndexViewColor;
        
        self.rowIndexView.frame = CGRectMake((kRowIndexSpace + (self.rowIndexStick ? _myScrollView.contentOffset.x : 0)) / _myScrollView.zoomScale, self.seatTop, kRowIndexWith, self.row * self.seatSize.height);
        
        self.rowIndexView.rowIndexType = self.rowIndexType;
        self.rowIndexView.hidden = NO;
    } else {
        self.rowIndexView.hidden = YES;
    }
    
    //画中线
    if (!self.centerLineView) {
        self.centerLineView = [[KyoCenterLineView alloc] init];
        self.centerLineView.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:self.centerLineView];
    }
    if (self.showCenterLine) {
        [self.contentView bringSubviewToFront:self.centerLineView];
        if (self.showRowIndex) {
            self.centerLineView.frame = CGRectMake((self.seatLeft + self.column * self.seatSize.width + self.seatRight) / 2 + kRowIndexSpace * 2, self.seatTop - kCenterLineViewTail, 1, self.row * self.seatSize.height + kCenterLineViewTail * 2);
        } else {
            self.centerLineView.frame = CGRectMake((self.seatLeft + self.column * self.seatSize.width + self.seatRight) / 2, self.seatTop - kCenterLineViewTail, 1, self.row * self.seatSize.height + kCenterLineViewTail * 2);
        }
        
        if (self.row > 0 && self.column > 0) {
            self.centerLineView.hidden = NO;
        } else {
            self.centerLineView.hidden = YES;
        }
    } else {
        self.centerLineView.hidden = YES;
    }
    
    self.centerLineView.hidden = YES;
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.tanchuanView];
}

- (void)drawSeat{
    if (!self.dictSeat){
        self.dictSeat = [NSMutableDictionary dictionary];
    }
    
    CGFloat x = self.seatLeft + (self.showRowIndex ? kRowIndexSpace * 2 : 0);
    CGFloat y = self.seatTop;
    
    for (NSInteger row = 0; row < self.row; row++) {
        
        NSMutableArray *arraySeat = self.dictSeat[@(row)] ? : [NSMutableArray array];
        
        for (NSInteger column = 0; column < [_datasouce[row][@"LIST"] count]; column++) {
            
            UIButton *btnSeat = nil;
            if (arraySeat.count <= column) {
                btnSeat = [UIButton buttonWithType:UIButtonTypeCustom];
                btnSeat.tag = row;  //tag纪录行数
                [btnSeat setTitle:_datasouce[row][@"LIST"][column][@"FJMC"] forState:UIControlStateNormal];
                btnSeat.titleLabel.font =[UIFont systemFontOfSize:10];
                [btnSeat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 
                if ([_datasouce[row][@"LIST"][column][@"FJZT"] integerValue] ==0 ||[_datasouce[row][@"LIST"][column][@"FJZT"] integerValue] ==1)
                {
                    btnSeat.backgroundColor = KweixuanColor;
                    
                }
                else if ([_datasouce[row][@"LIST"][column][@"FJZT"] integerValue] ==4)
                {
                    btnSeat.backgroundColor = KyishouColor;
                    btnSeat.userInteractionEnabled = NO;
                }
                else
                {
                    btnSeat.backgroundColor = KyidingColor;
                    btnSeat.userInteractionEnabled = NO;
                }
                
                [btnSeat addTarget:self action:@selector(btnSeatTouchIn:) forControlEvents:UIControlEventTouchUpInside];
                [_contentView addSubview:btnSeat];
                [arraySeat addObject:btnSeat];
            } else {
                btnSeat = arraySeat[column];
            }
            
            btnSeat.frame = CGRectMake(x+1, y+0.5, self.seatSize.width-2, self.seatSize.height-1);
            if (self.SMCinameSeatScrollViewDelegate &&
                [self.SMCinameSeatScrollViewDelegate respondsToSelector:@selector(kyoCinameSeatScrollViewSeatStateWithRow:withColumn:)]) {
                KyoCinameSeatState state = [self.SMCinameSeatScrollViewDelegate kyoCinameSeatScrollViewSeatStateWithRow:row withColumn:column];
                [btnSeat setImage:[self getSeatImageWithState:state] forState:UIControlStateNormal];
            } else {
                [btnSeat setImage:self.imgSeatNormal forState:UIControlStateNormal];
            }
            
            x += self.seatSize.width;
        }
        
        y += self.seatSize.height;
        x = self.seatLeft + (self.showRowIndex ? kRowIndexSpace * 2 : 0);
        
        [self.dictSeat setObject:arraySeat forKey:@(row)];
    }
}




- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.myScrollView.viewForZooming;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

#pragma mark --------------------
#pragma mark - KyoCinameSeatScrollViewDelegate

//座位状态
- (KyoCinameSeatState)kyoCinameSeatScrollViewSeatStateWithRow:(NSUInteger)row withColumn:(NSUInteger)column {
    NSMutableArray *arraySeat = self.dictSeatState[@(row)];
    return (KyoCinameSeatState)[arraySeat[column] integerValue];
}

//点击座位
- (void)kyoCinameSeatScrollViewDidTouchInSeatWithRow:(NSUInteger)row withColumn:(NSUInteger)column {
    
    NSMutableArray *arraySeat = self.dictSeatState[@(row)];
    KyoCinameSeatState currentState = (KyoCinameSeatState)[arraySeat[column] integerValue];
    if (currentState == KyoCinameSeatStateNormal) {
        [arraySeat replaceObjectAtIndex:column withObject:@(KyoCinameSeatStateSelected)];
    } else if (currentState == KyoCinameSeatStateSelected) {
        [arraySeat replaceObjectAtIndex:column withObject:@(KyoCinameSeatStateNormal)];
    } else if (currentState == KyoCinameSeatStateHadBuy || currentState == KyoCinameSeatStateUnexist) {
        return;
    }
    _fjxx = _datasouce[row][@"LIST"][column];
    _headarr = @[@"房源",@"价格",[NSString stringWithFormat:@"物业：%@",_fjxx[@"WYMC"]]];
    _titlearr = @[@[@"房号：",@"楼栋：",@"单元：",@"楼层："],@[@"计价规则：",@"单价：",@"总价："],@[@"建筑面积：",@"套内面积：",@"户型信息："]];
    _contentarr = @[@[_fjxx[@"FJMC"],_fjxx[@"LDMC"],_fjxx[@"DYMC"],_fjxx[@"FLOORNUM"]],@[_fjxx[@"JJGZ"],[NSString stringWithFormat:@"%@元/㎡",_fjxx[@"JZDJ"]],[NSString stringWithFormat:@"%@元",_fjxx[@"FJZJ"]]],@[[NSString stringWithFormat:@"%@㎡",_fjxx[@"JZMJ"]],[NSString stringWithFormat:@"%@㎡",_fjxx[@"TNMJ"]],_fjxx[@"HXMC"]]];
    
    [self.view addSubview:self.maskView1];
    [self.view addSubview:self.detailView];
    [_tableview reloadData];
    
}



#pragma mark --------------------
#pragma mark - Methods

//根据座位类型返回实际图片
- (UIImage *)getSeatImageWithState:(KyoCinameSeatState)state {
    if (state == KyoCinameSeatStateHadBuy) {
        return self.imgSeatHadBuy;
    } else if (state == KyoCinameSeatStateNormal) {
        return self.imgSeatNormal;
    } else if (state == KyoCinameSeatStateSelected) {
        return self.imgSeatSelected;
    } else if (state == KyoCinameSeatStateUnexist) {
        return self.imgSeatUnexist;
    } else if (state == KyoCinameSeatStateLoversLeftNormal) {
        return self.imgSeatLoversLeftNormal;
    } else if (state == KyoCinameSeatStateLoversLeftHadBuy) {
        return self.imgSeatLoversLeftHadBuy;
    } else if (state == KyoCinameSeatStateLoversLeftSelected) {
        return self.imgSeatLoversLeftSelected;
    } else if (state == KyoCinameSeatStateLoversRightNormal) {
        return self.imgSeatLoversRightNormal;
    } else if (state == KyoCinameSeatStateLoversRightHadBuy) {
        return self.imgSeatLoversRightHadBuy;
    } else if (state == KyoCinameSeatStateLoversRightSelected) {
        return self.imgSeatLoversRightSelected;
    } else {
        return self.imgSeatNormal;
    }
}


#pragma mark --------------------
#pragma mark - Events
- (void)btnSeatTouchIn:(UIButton *)btn {

    NSArray *arraySeat = self.dictSeat[@(btn.tag)];
    NSUInteger column = [arraySeat indexOfObject:btn];

    [self.SMCinameSeatScrollViewDelegate kyoCinameSeatScrollViewDidTouchInSeatWithRow:btn.tag withColumn:column];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //画座位行数提示
    if (!self.rowIndexView) {
        self.rowIndexView = [[KyoRowIndexView alloc] init];
        self.rowIndexView.backgroundColor = self.rowIndexViewColor ? : kRowIndexViewDefaultColor;
        [_myScrollView addSubview:self.rowIndexView];
    }
    if (self.showRowIndex) {
        [_contentView bringSubviewToFront:self.rowIndexView];
        [_myScrollView bringSubviewToFront:self.rowIndexView];
        self.rowIndexView.row = self.row;
        self.rowIndexView.width = kRowIndexWith;
        self.rowIndexView.rowIndexViewColor = self.rowIndexViewColor;
        
        self.rowIndexView.frame = CGRectMake((kRowIndexSpace + (self.rowIndexStick ? _myScrollView.contentOffset.x : 0)) < 2 ? 2:(kRowIndexSpace + (self.rowIndexStick ? _myScrollView.contentOffset.x : 0)) / _myScrollView.zoomScale, self.seatTop,
                                             kRowIndexWith,
                                             self.row * self.seatSize.height);

        self.rowIndexView.rowIndexType = self.rowIndexType;
        self.rowIndexView.arrayRowIndex = self.arrayRowIndex;
        self.rowIndexView.hidden = NO;
    } else {
        self.rowIndexView.hidden = YES;
    }
}




-(void)action_drop
{
    self.maskView.hidden = NO;
    self.tanchuanView.hidden = NO;
}

-(UIButton *)dropbtn
{
    if (!_dropbtn) {
        _dropbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dropbtn.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, 33.3*SIZE);
        _dropbtn.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xia"]];
        img.frame = CGRectMake(171*SIZE, 10.7*SIZE, 18.7*SIZE, 12*SIZE);
        [_dropbtn addSubview:img];
        [_dropbtn addTarget:self action:@selector(action_drop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dropbtn;
}

-(UIView *)detailView
{
    if (!_detailView) {
        _detailView = [[UIView alloc]initWithFrame:CGRectMake(46.7*SIZE, 96*SIZE, 266.7*SIZE, 477.3*SIZE)];
        _detailView.backgroundColor = [UIColor whiteColor];
        _detailView.layer.masksToBounds = YES;
        _detailView.layer.cornerRadius = 3.3*SIZE;
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 18*SIZE, 266.7*SIZE, 20*SIZE)];
        lab.textColor = CLTitleLabColor;
        lab.text = self.titleStr;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont boldSystemFontOfSize:20*SIZE];
        [_detailView addSubview:lab];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(241*SIZE, 17*SIZE, 16*SIZE, 16*SIZE);
        [btn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(maskViewTap) forControlEvents:UIControlEventTouchUpInside];
        [_detailView addSubview:btn];
        [_detailView addSubview:self.tableview];
    }
    return _detailView;
}



-(UIView *)tanchuanView
{
    if (!_tanchuanView) {
        _tanchuanView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE,123.3*SIZE)];
        _tanchuanView.backgroundColor = COLOR(240, 240, 240, 1);
        _tanchuanView.hidden =YES;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,1, 360*SIZE, 123*SIZE)];
        view.backgroundColor = [UIColor whiteColor];
        NSArray *arr;
        if (_LDdic.count) {
            
            arr =  @[@[[NSString stringWithFormat:@"总户数：%@",_LDdic[@"build_info"][@"total_house_num"]],[NSString stringWithFormat:@"开盘方式：%@",_LDdic[@"build_info"][@"open_way"]]],@[[NSString stringWithFormat:@"楼上层数：%@",_LDdic[@"build_info"][@"upper_floor_num"]],[NSString stringWithFormat:@"楼下层数：%@",_LDdic[@"build_info"][@"down_floor_num"]]],@[[NSString stringWithFormat:@"开盘时间：%@",_LDdic[@"build_info"][@"open_time"]],[NSString stringWithFormat:@"交房时间：%@",_LDdic[@"build_info"][@"handing_room_time"]]]];
        }else{
            
            arr =  @[@[@"总户数：",@"开盘方式："],@[@"楼上层数：",@"楼下层数："],@[@"开盘时间：",@"交房时间："]];
        }
        
        for (int i=0; i<3; i++) {
            for (int j=0; j<2; j++) {
                UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(9.7*SIZE+j*200*SIZE, 13.3*SIZE+i*27.7*SIZE, 180*SIZE, 13*SIZE)];
                lab.text = arr[i][j];
                lab.font = [UIFont systemFontOfSize:12*SIZE];
                lab.textColor = COLOR(51, 51, 51, 1);
                [view addSubview:lab];
            }
        }
        [_tanchuanView addSubview:view];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 90*SIZE, 360*SIZE, 33.3*SIZE);
        btn.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shang"]];
        img.frame = CGRectMake(171*SIZE, 10.7*SIZE, 18.7*SIZE, 12*SIZE);
        [btn addSubview:img];
        [btn addTarget:self action:@selector(maskViewTap) forControlEvents:UIControlEventTouchUpInside];
        [self.tanchuanView addSubview:btn];
    }
    return _tanchuanView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTap)];
        [_maskView addGestureRecognizer:tap];
        _maskView.hidden = YES;
    }
    return _maskView;
}

- (UIView *)maskView1 {
    if (!_maskView1) {
        _maskView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        _maskView1.backgroundColor = [UIColor blackColor];
        _maskView1.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTap)];
        [_maskView1 addGestureRecognizer:tap];
    }
    return _maskView1;
}


- (void)maskViewTap {
    self.tanchuanView.hidden = YES;
    self.maskView.hidden = YES;
    [self.detailView removeFromSuperview];
    _detailView = nil;
    [self.maskView1 removeFromSuperview];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titlearr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = _titlearr[section];
    return arr.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 266.7*SIZE, 40*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];

    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0*SIZE , 13.7*SIZE, 6.7*SIZE, 13.3*SIZE)];
    header.backgroundColor = CLBlueBtnColor;
    [backview addSubview:header];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(27.3*SIZE, 13.7*SIZE, 300*SIZE, 16*SIZE)];
    title.font = [UIFont systemFontOfSize:15.3*SIZE];
    title.textColor = CLTitleLabColor;
    title.text = _headarr[section];
    [backview addSubview:title];
    return backview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40*SIZE;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 26.3 *SIZE;
}

-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 50.3*SIZE, 266.7*SIZE,427.3*SIZE) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = @"SingleHouseCell";
    SingleHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[SingleHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setcelltitle:_titlearr[indexPath.section][indexPath.row] content:_contentarr[indexPath.section][indexPath.row]];
    
    return cell;
}

@end
