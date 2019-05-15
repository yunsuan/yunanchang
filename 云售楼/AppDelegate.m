//
//  AppDelegate.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AppDelegate.h"
#import <WebKit/WebKit.h>

#import "LoginVC.h"
#import "GuideVC.h"

#import "CYLTabBarControllerConfig.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self NetworkingStart];
    [self initUI];
    return YES;
}

- (void)initUI{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goHome) name:@"goHome" object:nil];
    //注册通知，退出登陆时回到首页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(comeBackLoginVC) name:@"goLoginVC" object:nil];
    
    NSString *logIndentifier = [[NSUserDefaults standardUserDefaults] objectForKey:LOGINENTIFIER];
    BOOL flag = [[NSUserDefaults standardUserDefaults] boolForKey:@"Guided"];
    if (flag == YES) {
        
        [self deleteWebCache];
        if ([logIndentifier isEqualToString:@"logInSuccessdentifier"]) {
            CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
            _window.rootViewController = tabBarControllerConfig.tabBarController;
        }else {
            //未登录
            LoginVC *mainLogin_vc = [[LoginVC alloc] init];
            UINavigationController *mainLogin_nav = [[UINavigationController alloc] initWithRootViewController:mainLogin_vc];
            mainLogin_nav.navigationBarHidden = YES;
            _window.rootViewController = mainLogin_nav;
            [_window makeKeyAndVisible];
            
        }
    } else {
        GuideVC *guideVC = [[GuideVC alloc] init];
        UINavigationController *guideNav = [[UINavigationController alloc] initWithRootViewController:guideVC];
        guideNav.navigationBarHidden = YES;
        _window.rootViewController = guideNav;
        [_window makeKeyAndVisible];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Guided"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//网络请求
- (void)NetworkingStart {

    [BaseRequest GET:@"config" parameters:nil success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [UserModel defaultModel].Configdic = resposeObject[@"data"];
            [UserModelArchiver archive];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)goHome{
    
//    NSSet *tags;
//    
//    [JPUSHService setAlias:[NSString stringWithFormat:@"agent_%@",[UserModel defaultModel].agent_id] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//        
//        NSLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, tags , iAlias);;
//    } seq:0];
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
    _window.rootViewController = tabBarControllerConfig.tabBarController;
}


- (void)comeBackLoginVC {
    //未登录
//    NSSet *tags;
    
//    [JPUSHService setAlias:@"exit" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//
//        NSLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, tags , iAlias);
//    } seq:0];
    LoginVC *mainLogin_vc = [[LoginVC alloc] init];
    UINavigationController *mainLogin_nav = [[UINavigationController alloc] initWithRootViewController:mainLogin_vc];
    mainLogin_nav.navigationBarHidden = YES;
    _window.rootViewController = mainLogin_nav;
    [_window makeKeyAndVisible];
    
}

//删除web缓存
- (void)deleteWebCache {
    
    //    if([UIDevice currentDevice])
    if(@available(iOS 9.0, *)) {
        NSSet * websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate * dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore]removeDataOfTypes: websiteDataTypes
                                                  modifiedSince:dateFrom completionHandler:^{
                                                      
                                                  }];
        
    }else{
        
        NSString*libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES)objectAtIndex:0];
        NSString* cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError * errors;
        [[NSFileManager defaultManager]removeItemAtPath:cookiesFolderPath error:&errors];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
