//
//  GuideVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "GuideVC.h"

@interface GuideVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIButton *inBtn;

@end

@implementation GuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 设置页码
    _pageControl.currentPage = page;
    
    if (page == 2) {
        
        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            _inBtn.hidden = NO;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        
        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self->_inBtn.hidden = YES;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)ActionInBtn:(UIButton *)btn{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
}


- (void)initUI{
    
    self.navBackgroundView.hidden = YES;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator= NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [_scrollView setContentSize:CGSizeMake(SCREEN_Width * 3, SCREEN_Height)];
    [self.view addSubview:_scrollView];
    
    NSArray *imgArr = @[@"yindaoye1",@"yindaoye2",@"yindaoye3"];
    for (int i = 0; i < 3; i++) {
        
        UIImageView *guideImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width * i, 0, SCREEN_Width, SCREEN_Height)];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:imgArr[i] ofType:@"jpg"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        guideImg.image = image;
        guideImg.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:guideImg];
    }
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(140 *SIZE, SCREEN_Height - 24 *SIZE - TAB_BAR_MORE, 80 *SIZE, 10 *SIZE);//指定位置大小
    _pageControl.numberOfPages = 3;//指定页面个数
    _pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
    //添加委托方法，当点击小白点就执行此方法
    
    _pageControl.pageIndicatorTintColor = COLOR(220, 220, 220, 1);// 设置非选中页的圆点颜色
    
    _pageControl.currentPageIndicatorTintColor = CLBlueBtnColor; // 设置选中页的圆点颜色
    [self.view addSubview:_pageControl];
    
    _inBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _inBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, 120 *SIZE, 33 *SIZE);
    _inBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    _inBtn.layer.cornerRadius = 5 *SIZE;
    _inBtn.clipsToBounds = YES;
    [_inBtn addTarget:self action:@selector(ActionInBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_inBtn setTitle:@"开启渠道" forState:UIControlStateNormal];
    [_inBtn setBackgroundColor:CLBlueBtnColor];
    _inBtn.hidden = YES;
    [_inBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_inBtn];
}

@end
