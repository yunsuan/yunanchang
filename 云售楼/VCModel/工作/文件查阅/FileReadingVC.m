//
//  FileReadingVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "FileReadingVC.h"

#import <WebKit/WebKit.h>

@interface FileReadingVC ()<WKUIDelegate,WKNavigationDelegate>
{
    
    NSString *_urlString;
}

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation FileReadingVC

- (instancetype)initWithUrlString:(NSString *)urlString
{
    self = [super init];
    if (self) {
        
        _urlString = urlString;
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{
    
    self.titleLabel.text = @"文件查阅";
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) configuration:config];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_urlString]]]];
    
}

@end
