//
//  RoomDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RoomDetailVC.h"

#import "AddOrderVC.h"
#import "AddSignVC.h"

#import "SMScrollView.h"
//#import "KyoCenterLineView.h"
//#import "KyoRowIndexView.h"
#import "SingleHouseCell.h"

#define kRowIndexWith   30
#define kRowIndexSpace  2.0
#define kRowIndexViewDefaultColor   [UIColor clearColor]
#define kCenterLineViewTail 6.0
#define KweixuanColor COLOR(0x14, 0x80, 0x0d, 1)
#define KyidingColor COLOR(0xdf, 0xb0, 0x45, 1)
#define KyishouColor COLOR(0xef, 0x5e, 0x52, 1)

@interface RoomDetailVC ()<SMCinameSeatScrollViewDelegate,UIScrollViewDelegate>

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

@property (nonatomic , strong)UILabel *name;
@property (nonatomic , strong)UIImageView *img;

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

    self.titleLabel.text = @"房源";
//    [self.leftButton setImage:IMAGE_WITH_NAME(@"youjiantou.png") forState:UIControlStateNormal];
    //    [self.view addSubview:self.MycollectionView];
//    [self post];
    
    [self initInterFace];

}




-(void)initInterFace
{
    NSArray *arr = @[@"未售",@"已定",@"已售"];
    
    
    for (NSUInteger i = 0 ; i<3; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(176*SIZE+i*65*SIZE, (CGFloat) (NAVIGATION_BAR_HEIGHT +9*SIZE), 17*SIZE, 17*SIZE)];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 2*SIZE;
        if (i == 0) {
            view.backgroundColor = COLOR(0, 197, 198, 1);//KweixuanColor;
        }
        else if(i == 1)
        {
            view.backgroundColor = KyidingColor;
        }
        else
        {
            view.backgroundColor = KyishouColor;
        }
        [self.view addSubview:view];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(200*SIZE+i*65*SIZE, (CGFloat) NAVIGATION_BAR_HEIGHT, 28*SIZE, 34*SIZE)];
        lab.font = [UIFont systemFontOfSize:13*SIZE];
        lab.text = arr[i];
        lab.textColor = COLOR(115, 115, 115, 1);
        [self.view addSubview:lab];
    }
    [self.view addSubview:self.name];
    [self.view addSubview:self.img];
    _row = _LDinfo.count;
    _column = 0;
    for (int i = 0; i<_row; i++) {
        
        if ([_LDinfo[i][@"houseList"] count]>_column) {
            _column = [_LDinfo[i][@"houseList"] count];
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
            //            if (row * column % 5 == 0) {
            //                [arrayState addObject:@(KyoCinameSeatStateHadBuy)];
            //            } else if (row * column % 5 == 0) {
            //                [arrayState addObject:@(KyoCinameSeatStateUnexist)];
            //            } else {
            //                [arrayState addObject:@(KyoCinameSeatStateNormal)];
            //            }
        }
        self.dictSeatState[@(row)] = arrayState;

    }
    
    self.myScrollView = [[SMScrollView alloc] init];
    _myScrollView.contentSize = CGSizeMake((self.seatLeft + self.column * self.seatSize.width + self.seatRight) * _myScrollView.zoomScale,(self.seatTop + self.row * self.seatSize.height + self.seatBottom) * _myScrollView.zoomScale);
//    
//    NSLog(@"_myScrollView.contentSize = %@",NSStringFromCGRect(_myScrollView.frame));
//    NSLog(@"_myScrollView.zoomScale = %f",_myScrollView.zoomScale);

    if (!self.contentView) {
        self.contentView = [[UIView alloc] init];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    _contentView.frame = CGRectMake(0, 0, _myScrollView.contentSize.width, _myScrollView.contentSize.height);
    
    _contentView.contentMode = UIViewContentModeScaleAspectFill;
    _contentView.clipsToBounds = YES;
    _SMCinameSeatScrollViewDelegate = self;
    
    self.myScrollView = [[SMScrollView alloc] initWithFrame:CGRectMake(0, (CGFloat) (NAVIGATION_BAR_HEIGHT +30*SIZE), 360*SIZE, (CGFloat) (SCREEN_Height -NAVIGATION_BAR_HEIGHT-30*SIZE))];

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

    //    seatImageView.image = [UIImage imageNamed:@"selectSeat"];

    [_contentView addSubview:seatImageView];
    [_contentView bringSubviewToFront:seatImageView];
    
    //画座位行数提示
    if (!self.rowIndexView) {
        self.rowIndexView = [[KyoRowIndexView alloc] init];
        self.rowIndexView.arrayRowIndex = [NSMutableArray array];

        for (NSUInteger i = 0; i<_LDinfo.count; i++) {
            [self.rowIndexView.arrayRowIndex addObject:[NSString stringWithFormat:@"%@",_LDinfo[i][@"floor_name"]]];
        }
        //        [self.rowIndexView dr]

        [self.rowIndexView drawRect:self.rowIndexView.frame];
        self.rowIndexView.backgroundColor = self.rowIndexViewColor ? : kRowIndexViewDefaultColor;
        [_contentView addSubview:self.rowIndexView];
        
        //[_myScrollView addSubview:self.rowIndexView];

    }
    if (self.showRowIndex) {
        [_contentView bringSubviewToFront:self.rowIndexView];
        [_myScrollView bringSubviewToFront:self.rowIndexView];
        self.rowIndexView.row = self.row;
        self.rowIndexView.width = kRowIndexWith;
        
        self.rowIndexView.frame = CGRectMake((CGFloat) ((kRowIndexSpace + (self.rowIndexStick ? _myScrollView.contentOffset.x : 0)) / _myScrollView.zoomScale), self.seatTop, kRowIndexWith, self.row * self.seatSize.height);
        
        NSLog(@"self.rowIndexView.frame = %@",NSStringFromCGRect(self.rowIndexView.frame));
        //        self.rowIndexView.arrayRowIndex = self.arrayRowIndex;

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
            self.centerLineView.frame = CGRectMake((CGFloat) ((self.seatLeft + self.column * self.seatSize.width + self.seatRight) / 2 + kRowIndexSpace * 2), (CGFloat) (self.seatTop - kCenterLineViewTail), 1, (CGFloat) (self.row * self.seatSize.height + kCenterLineViewTail * 2));
        } else {
            self.centerLineView.frame = CGRectMake((self.seatLeft + self.column * self.seatSize.width + self.seatRight) / 2, (CGFloat) (self.seatTop - kCenterLineViewTail), 1, (CGFloat) (self.row * self.seatSize.height + kCenterLineViewTail * 2));
        }
        
        self.centerLineView.hidden = !(self.row > 0 && self.column > 0);

    } else {
        self.centerLineView.hidden = YES;
    }
    
    self.centerLineView.hidden = YES;

}

- (void)drawSeat{
    if (!self.dictSeat){
        self.dictSeat = [NSMutableDictionary dictionary];
    }
    

    CGFloat x = (CGFloat) (self.seatLeft + (self.showRowIndex ? kRowIndexSpace * 2 : 0));
    CGFloat y = self.seatTop;
    
    for (NSUInteger row = 0; row < self.row; row++) {
        
        NSMutableArray *arraySeat = self.dictSeat[@(row)] ? : [NSMutableArray array];
        
        for (NSUInteger column = 0; column < [_LDinfo[row][@"houseList"] count]; column++) {

            
            UIButton *btnSeat = nil;
            if (arraySeat.count <= column) {
                btnSeat = [UIButton buttonWithType:UIButtonTypeCustom];
                btnSeat.tag = row;  //tag纪录行数
                [btnSeat setTitle:_LDinfo[row][@"houseList"][column][@"house_name"] forState:UIControlStateNormal];
                btnSeat.titleLabel.font =[UIFont systemFontOfSize:10];
                [btnSeat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                //                btnSeat.layer.masksToBounds = YES;
                //                btnSeat.layer.cornerRadius = 2;
//                if ([_LDinfo[row][@"houseList"][column][@"FJZT"] integerValue] ==0 ||[_LDinfo[row][@"houseList"][column][@"FJZT"] integerValue] ==1)
//                {
                if ([_LDinfo[row][@"houseList"][column][@"state"] integerValue]==0||[_LDinfo[row][@"houseList"][column][@"state"] integerValue]==1) {
                    btnSeat.backgroundColor = COLOR(0, 197, 198, 1);//KweixuanColor;
                }
                
//
//                }
                else if ([_LDinfo[row][@"houseList"][column][@"state"] integerValue] ==4)
                {
                    btnSeat.backgroundColor = KyishouColor;
                    btnSeat.userInteractionEnabled = NO;
                }
                else
                {
                    btnSeat.backgroundColor = KyidingColor;
                    btnSeat.userInteractionEnabled = NO;
                }
                
                //                btnSeat.backgroundColor = [UIColor grayColor];

                [btnSeat addTarget:self action:@selector(btnSeatTouchIn:) forControlEvents:UIControlEventTouchUpInside];
                [_contentView addSubview:btnSeat];
                [arraySeat addObject:btnSeat];
            } else {
                btnSeat = arraySeat[column];
            }
            
            btnSeat.frame = CGRectMake(x+1, (CGFloat) (y+0.5), self.seatSize.width-2, self.seatSize.height-1);
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
        x = (CGFloat) (self.seatLeft + (self.showRowIndex ? kRowIndexSpace * 2 : 0));
        
        self.dictSeat[@(row)] = arraySeat;
    }
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.myScrollView.viewForZooming;
}



#pragma mark - KyoCinameSeatScrollViewDelegate

//座位状态
- (KyoCinameSeatState)kyoCinameSeatScrollViewSeatStateWithRow:(NSUInteger)row withColumn:(NSUInteger)column {
    NSMutableArray *arraySeat = self.dictSeatState[@(row)];
    return (KyoCinameSeatState)[arraySeat[column] integerValue];
}

//点击座位
- (void)kyoCinameSeatScrollViewDidTouchInSeatWithRow:(NSUInteger)row withColumn:(NSUInteger)column {
    
}



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

- (void)setNeedsDisplay {
    //[super setNeedsDisplay];
    
    if (self.rowIndexView) {
        [self.rowIndexView setNeedsDisplay];
    }
    
    if (self.centerLineView) {
        [self.centerLineView setNeedsDisplay];
    }
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
        
        self.rowIndexView.frame = CGRectMake((CGFloat) ((kRowIndexSpace + (self.rowIndexStick ? _myScrollView.contentOffset.x : 0)) < 2 ? 2:(kRowIndexSpace + (self.rowIndexStick ? _myScrollView.contentOffset.x : 0)) / _myScrollView.zoomScale), self.seatTop,
                                             kRowIndexWith,
                                             self.row * self.seatSize.height);
        
        NSLog(@"self.rowIndexView.frame = %@",NSStringFromCGRect(self.rowIndexView.frame));
        NSLog(@"self.myScrollView.contentSize = %@",NSStringFromCGSize( _myScrollView.contentSize));
        
        //        self.rowIndexView.arrayRowIndex = self.arrayRowIndex;

        self.rowIndexView.hidden = NO;
    } else {
        self.rowIndexView.hidden = YES;
    }
}


#pragma mark ----------- lazyload -------------

-(UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.frame = CGRectMake(34*SIZE, (CGFloat) NAVIGATION_BAR_HEIGHT, 200*SIZE, 34*SIZE);
        _name.font = [UIFont systemFontOfSize:14*SIZE];
        _name.textColor = COLOR(115, 115, 115, 1);
        _name.text = _LDtitle;
    }
    return _name;
}

-(UIImageView *)img
{
    if (!_img ) {
        _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fangwu"]];
        _img.frame = CGRectMake(15*SIZE, (CGFloat) (NAVIGATION_BAR_HEIGHT +10*SIZE), 15*SIZE, 13*SIZE);
    }
    return _img;
}

-(UIView *)tanchuanView
{
    if (!_tanchuanView) {
        _tanchuanView = [[UIView alloc]initWithFrame:CGRectMake(46*SIZE, 102*SIZE, 268*SIZE, SCREEN_Height-102*SIZE-30*SIZE)];
        _tanchuanView.backgroundColor = [UIColor whiteColor];
        _tanchuanView.layer.masksToBounds = YES;
        _tanchuanView.layer.cornerRadius = 3*SIZE;
        [self initTanchuanView];
        [self initFJXQ];
    }
    return _tanchuanView;
}

-(void)initTanchuanView{
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"houseback"]];
    img.frame = CGRectMake(0, 0, 268*SIZE, 89*SIZE);
    [_tanchuanView addSubview:img];
    UILabel *titel = [[UILabel alloc]initWithFrame:CGRectMake(0, 39*SIZE, 268*SIZE, 16*SIZE)];
    titel.font = FONT(15);
    titel.text = [UserModel defaultModel].projectinfo[@"project_name"];
    titel.textColor = CLTitleLabColor;
    titel.textAlignment = NSTextAlignmentCenter;
    [_tanchuanView addSubview:titel];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(242*SIZE, 11*SIZE, 16*SIZE, 16*SIZE);
    [btn setImage:[UIImage imageNamed:@"fork"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(maskViewTap) forControlEvents:UIControlEventTouchUpInside];
    [_tanchuanView addSubview:btn];
    
    
}

-(void)initFJXQ
{
    //
    UIView *blueview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 98*SIZE, 7*SIZE, 13*SIZE)];
    blueview1.backgroundColor = CLBlueBtnColor;
    [_tanchuanView addSubview:blueview1];
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(16*SIZE, 96*SIZE, 200*SIZE, 16*SIZE)];
    lab1.font = FONT(13);
    lab1.text = [NSString stringWithFormat:@"房号:%@",_fjxx[@"house_name"]];
    lab1.textColor = CLTitleLabColor;
    [_tanchuanView addSubview:lab1];
    
    
    UIView *lane1 = [[UIView alloc]initWithFrame:CGRectMake(0, 124*SIZE, 268*SIZE, 0.5*SIZE)];
    lane1.backgroundColor = CLLineColor;
    [_tanchuanView addSubview:lane1];
    
    //
    UIView *blueview2 = [[UIView alloc]initWithFrame:CGRectMake(0, 139*SIZE, 7*SIZE, 13*SIZE)];
    blueview2.backgroundColor = CLBlueBtnColor;
    [_tanchuanView addSubview:blueview2];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(16*SIZE, 139*SIZE, 200*SIZE, 16*SIZE)];
    lab2.font = FONT(13);
    lab2.text = @"价格";
    lab2.textColor = CLTitleLabColor;
    [_tanchuanView addSubview:lab2];
    
    UILabel *contentlab1 = [[UILabel alloc]initWithFrame:CGRectMake(16*SIZE, 171*SIZE, 200*SIZE, 16*SIZE)];
    contentlab1.font = FONT(12);
    contentlab1.text = [NSString stringWithFormat:@"计价规则:  %@",_fjxx[@"price_way"]];
    contentlab1.textColor = CLContentLabColor;
    [_tanchuanView addSubview:contentlab1];
    
    UILabel *contentlab2 = [[UILabel alloc]initWithFrame:CGRectMake(16*SIZE, 198*SIZE, 200*SIZE, 16*SIZE)];
    contentlab2.font = FONT(12);
    contentlab2.text = [NSString stringWithFormat:@"单价:  %@",_fjxx[@"criterion_unit_price"]];
    contentlab2.textColor = CLContentLabColor;
    [_tanchuanView addSubview:contentlab2];
    
    UILabel *contentlab3 = [[UILabel alloc]initWithFrame:CGRectMake(16*SIZE, 224*SIZE, 200*SIZE, 16*SIZE)];
    contentlab3.font = FONT(12);
    contentlab3.text = [NSString stringWithFormat:@"总价:  %@",_fjxx[@"total_price"]];
    contentlab3.textColor = CLContentLabColor;
    [_tanchuanView addSubview:contentlab3];
    
    UIView *lane2 = [[UIView alloc]initWithFrame:CGRectMake(0, 260*SIZE, 268*SIZE, 0.5*SIZE)];
    lane2.backgroundColor = CLLineColor;
    [_tanchuanView addSubview:lane2];
    
    //
    UIView *blueview3 = [[UIView alloc]initWithFrame:CGRectMake(0, 276*SIZE, 7*SIZE, 13*SIZE)];
    blueview3.backgroundColor = CLBlueBtnColor;
    [_tanchuanView addSubview:blueview3];
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(16*SIZE, 276*SIZE, 200*SIZE, 16*SIZE)];
    lab3.font = FONT(13);
    lab3.text = [NSString stringWithFormat:@"物业:%@",_fjxx[@"property_type"]];
    lab3.textColor = CLTitleLabColor;
    [_tanchuanView addSubview:lab3];
    NSArray *detail = _fjxx[@"propertyDetail"];
    for (int i= 0; i<detail.count; i++) {
        UILabel *contentlab = [[UILabel alloc]initWithFrame:CGRectMake(16*SIZE, 309*SIZE+27*SIZE*i, 200*SIZE, 16*SIZE)];
        contentlab.font = FONT(12);
        contentlab.text = detail[i];
        contentlab.textColor = CLContentLabColor;
        [_tanchuanView addSubview:contentlab];
    }

    _tanchuanView.frame = CGRectMake(46*SIZE, 102*SIZE, 268*SIZE,360*SIZE+27*SIZE*detail.count);
    UIButton *watchbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    watchbtn.frame = CGRectMake(0*SIZE, _tanchuanView.frame.size.height-40*SIZE, 268*SIZE, 40*SIZE);
    [watchbtn setTitle:@"查看户型图" forState:UIControlStateNormal];
    [watchbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    watchbtn.titleLabel.font = FONT(13);
    watchbtn.backgroundColor = CLBlueBtnColor;
    [watchbtn addTarget:self action:@selector(action_huxing) forControlEvents:UIControlEventTouchUpInside];
    [_tanchuanView addSubview:watchbtn];
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTap)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}


#pragma mark - Events
- (void)btnSeatTouchIn:(UIButton *)btn {
    NSArray *arraySeat = self.dictSeat[@(btn.tag)];
    NSUInteger columns = [arraySeat indexOfObject:btn];
    [BaseRequest GET:ProjectHouseGetDetailInfo_URL parameters:@{@"house_id":_LDinfo[btn.tag][@"houseList"][columns][@"house_id"]} success:^(id  _Nonnull resposeObject) {
        if ([resposeObject[@"code"] integerValue] == 200) {
            NSLog(@"%@",resposeObject);
            self->_fjxx = resposeObject[@"data"];
            if (self.status.length) {
                
                self.roomDetailVCBlock(self->_fjxx);
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[AddOrderVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                    if ([vc isKindOfClass:[AddSignVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }else{
                
                [self.view addSubview:self.maskView];
                [self.view addSubview:self.tanchuanView];
            }
        }
        else{
            
        }
    } failure:^(NSError * _Nonnull error) {
        [self showContent:@"网络错误"];
    }];
}




- (void)maskViewTap {
    [self.tanchuanView removeFromSuperview];
//    [self.guanbi removeFromSuperview];
    self.tanchuanView = nil;
    [self.maskView removeFromSuperview];
    _fjxx = nil;
}


- (void)action_back {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)action_huxing
{
    
}

@end
