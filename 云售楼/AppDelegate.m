//
//  AppDelegate.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AppDelegate.h"
#import "PowerMannerger.h"
#import <WebKit/WebKit.h>

#import <Bugtags/Bugtags.h>

#import "LoginVC.h"
#import "GuideVC.h"
#import "CodeScanVC.h"

#import "CYLTabBarControllerConfig.h"

#import "UpgradeTipsView.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


static NSString *const kJpushAPPKey = @"920b77f3b949ac810516400e";

@interface AppDelegate ()<JPUSHRegisterDelegate>

@property (nonatomic, strong) UpgradeTipsView *updateView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionPushScan) name:@"scan" object:nil];
    [self NetworkingStart];
    [self configThirdWithOptions:launchOptions];
    [self initUI];
    [self UpdateRequest];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    return YES;
}

- (void)ActionPushScan{
    
    CodeScanVC *vc = [[CodeScanVC alloc] init];
    [[UIApplication sharedApplication].keyWindow.cyl_tabBarController.navigationController presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)UpdateRequest{
    
    [BaseRequest VersionUpdateSuccess:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        NSArray *array = resposeObject[@"results"];
        NSDictionary *dic = array[0];
        NSString *appStoreVersion = dic[@"version"];
        if ([[appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue] > [[YACversion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue]) {
            
            [BaseRequest GET:@"getSaleVersionInfo" parameters:@{} success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                        [self->_updateView removeFromSuperview];
                        
                        self->_updateView = [[UpgradeTipsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                        self->_updateView.contentL.text = dic[@"releaseNotes"];
                        self->_updateView.upgradeTipsViewBlock = ^{
                            
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1371990304?mt=8"]];
                        };
                        if ([resposeObject[@"data"][@"must"] integerValue]) {

                            self->_updateView.cancelBtn.hidden = YES;
                        }
                    
                        
                        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self->_updateView];
                    });
                }
            } failure:^(NSError *error) {
                
            }];
        }

    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}

//配置三方
- (void)configThirdWithOptions:(NSDictionary *)launchOptions{

    [self conifgJpushWithOptions:launchOptions];
    // 首先判断是否支持3DTouch
    if(self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        // 创建3DTouch模型
        UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"scan"];
        // 创建带着有自定义图标item
        UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"share" localizedTitle:@"扫一扫" localizedSubtitle:@"" icon:icon1 userInfo:nil];
        [[UIApplication sharedApplication] setShortcutItems:@[item1]];
    }
}

//配置极光推送
- (void)conifgJpushWithOptions:(NSDictionary *)launchOptions  {
    
    //bugtags
    [Bugtags startWithAppKey:@"52b3a8daea93b51c76430c9d41a09d0a" invocationEvent:BTGInvocationEventNone];// options:<#(BugtagsOptions *)#>
    
    
    //极光配置
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if (@available(iOS 10.0, *)) {
        [JPUSHService registerForRemoteNotificationTypes:(UNNotificationPresentationOptionAlert |UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound) categories:nil];
    } else {
        // Fallback on earlier versions
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
    }
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//        // 可以添加自定义categories
//        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
//        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
//        if (@available(iOS 10.0, *)) {
//            [JPUSHService registerForRemoteNotificationTypes:(UNNotificationPresentationOptionAlert |UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound) categories:nil];
//        } else {
//            // Fallback on earlier versions
//            [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
//        }
//    }else{
//
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
//    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    //    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    [JPUSHService setupWithOption:launchOptions appKey:kJpushAPPKey
                          channel:@"appstore"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            [self SetTagsAndAlias];
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    if (launchOptions) {
        
        NSDictionary *remote = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        if (remote) {
            [self GotoHome];
        }else{
            NSString *loggIndentifier;
            loggIndentifier = [[NSUserDefaults standardUserDefaults] objectForKey:LOGINENTIFIER];
            if ([loggIndentifier isEqualToString:@"logInSuccessdentifier"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessList" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
            }
        }
    }
}

- (void)SetTagsAndAlias{
    NSString *logIndentifier = [[NSUserDefaults standardUserDefaults] objectForKey:LOGINENTIFIER];
    if (logIndentifier) {
        NSSet *tags;
        
        [JPUSHService setAlias:[NSString stringWithFormat:@"saleApp_%@",[UserModel defaultModel].agent_id] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
            NSLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, tags , iAlias);;
        } seq:0];
    }
}

- (void)GotoHome{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessList" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
    [UIApplication sharedApplication].keyWindow.cyl_tabBarController.selectedIndex = 0;
}

- (void)goHome{
    
    NSSet *tags;
    
    [JPUSHService setAlias:[NSString stringWithFormat:@"saleApp_%@",[UserModel defaultModel].agent_id] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
        NSLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, tags , iAlias);;
    } seq:0];
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
    _window.rootViewController = tabBarControllerConfig.tabBarController;
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
            if ([[UserModel defaultModel].projectinfo count]) {
            
                [PowerMannerger RequestPowerByprojectID:[UserModel defaultModel].projectinfo[@"project_id"] success:^(NSString * _Nonnull result) {
                    if ([result isEqualToString:@"获取权限成功"]) {
                        NSLog(@"成功获取权限");
                    }
                } failure:^(NSString * _Nonnull error) {
                    NSLog(@"获取权限失败");
                }];
            }else{
                
                
            }
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
    
    [BaseRequest GET:@"config" parameters:@{} success:^(id resposeObject) {
       
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [UserModel defaultModel].Configdic = resposeObject[@"data"];
            [UserModelArchiver archive];
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)comeBackLoginVC {
    //未登录
    NSSet *tags;
    
    [JPUSHService setAlias:@"exit" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {

        NSLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, tags , iAlias);
    } seq:0];
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

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    NSLog(@"name:%@\ntype:%@", shortcutItem.localizedTitle, shortcutItem.type);
    // 1.获得shortcutItem的type type就是初始化shortcutItem的时候传入的唯一标识符
//    NSString *type = shortcutItem.type;
//
//    //2.可以通过type来判断点击的是哪一个快捷按钮 并进行每个按钮相应的点击事件
//    [application.keyWindow.rootViewController.navigationController pushViewController:[[CodeScanVC alloc] init] animated:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"scan" object:nil];
    
    
    CodeScanVC *vc = [[CodeScanVC alloc] init];
    [((CYLTabBarController *)(self.window.rootViewController)).selectedViewController pushViewController:vc animated:YES];
}


#pragma mark ---  Jpush  ---

//极光方法

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}


//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

//实现注册APNs失败接口
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    
//    NSDictionary * userInfo = notification.request.content.userInfo;
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = notification.request.content.userInfo;
//    UNNotificationRequest *request = notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
    NSLog(@"22222222%@",userInfo);
    
    if ([userInfo[@"aps"][@"alert"] isKindOfClass:[NSString class]]) {
        
        if ([userInfo[@"aps"][@"alert"] isEqualToString:@"您在云案场的公司认证申请未通过"]) {
            
            [UserModel defaultModel].project_list = @[];
            [UserModel defaultModel].projectinfo = @{};
            [UserModelArchiver archive];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCompanyInfo" object:nil];
        }else if ([userInfo[@"aps"][@"alert"] isEqualToString:@"您在云案场的公司认证申请已通过"]){
            
            [BaseRequest GET:@"saleApp/work/project/list" parameters:@{} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [UserModel defaultModel].project_list = resposeObject[@"data"];
                    if ([resposeObject[@"data"] count]) {
                        
                        [UserModel defaultModel].projectinfo = resposeObject[@"data"][0];
                        [PowerMannerger RequestPowerByprojectID:[UserModel defaultModel].projectinfo[@"project_id"] success:^(NSString * _Nonnull result) {
                            if ([result isEqualToString:@"获取权限成功"]) {
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCompanyInfo" object:nil];
                            }
                        } failure:^(NSString * _Nonnull error) {
                            
                        }];
                        [UserModelArchiver archive];
                    }
                }else{
                    
                    [MBProgressHUD showError:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [MBProgressHUD showError:@"获取项目失败"];
            }];
        }
    }
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{userInfo：%@\n}",userInfo);
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}


- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
    NSLog(@"1111111%@",userInfo);
    
    if ([userInfo[@"aps"][@"alert"] isKindOfClass:[NSString class]]) {
        
        if ([userInfo[@"aps"][@"alert"] isEqualToString:@"您在云案场的公司认证申请未通过"]) {
            
            [UserModel defaultModel].project_list = @[];
            [UserModel defaultModel].projectinfo = @{};
            [UserModelArchiver archive];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCompanyInfo" object:nil];
        }else if ([userInfo[@"aps"][@"alert"] isEqualToString:@"您在云案场的公司认证申请已通过"]){
            
            [BaseRequest GET:@"saleApp/work/project/list" parameters:@{} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [UserModel defaultModel].project_list = resposeObject[@"data"];
                    if ([resposeObject[@"data"] count]) {
                        
                        [UserModel defaultModel].projectinfo = resposeObject[@"data"][0];
                        [PowerMannerger RequestPowerByprojectID:[UserModel defaultModel].projectinfo[@"project_id"] success:^(NSString * _Nonnull result) {
                            if ([result isEqualToString:@"获取权限成功"]) {
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCompanyInfo" object:nil];
                            }
                        } failure:^(NSString * _Nonnull error) {
                            
                        }];
                        [UserModelArchiver archive];
                    }
                }else{
                    
                    [MBProgressHUD showError:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [MBProgressHUD showError:@"获取项目失败"];
            }];
        }
    }
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        [self GotoHome];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{userInfo：%@\n}",userInfo);
    }
    
    //    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:[badge integerValue]];
    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    //    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    completionHandler(UIBackgroundFetchResultNewData);
    
//    [self GotoHome];
    if (application.applicationState == UIApplicationStateActive) {
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessList" object:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
        
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"%@",userInfo);
    application.applicationIconBadgeNumber += 1;
    
    
    
    if (application.applicationState == UIApplicationStateActive) {
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessList" object:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    [self UpdateRequest];
//    [BaseRequest VersionUpdateSuccess:^(id  _Nonnull resposeObject) {
//        
//        NSArray *array = resposeObject[@"results"];
//        NSDictionary *dic = array[0];
//        NSString *appStoreVersion = dic[@"version"];
//        if ([[appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue] > [[YACversion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue]) {
//            
//            [BaseRequest GET:@"getSaleVersionInfo" parameters:@{} success:^(id resposeObject) {
//                
//                if ([resposeObject[@"code"] integerValue] == 200) {
//                    
//                    
//                    self->_updateView = [[UpgradeTipsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//                    self->_updateView.contentL.text = dic[@"releaseNotes"];
//                    self->_updateView.upgradeTipsViewBlock = ^{
//                        
//                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1371990304?mt=8"]];
//                    };
//                    if ([resposeObject[@"data"][@"must"] integerValue]) {
//
//                        self->_updateView.cancelBtn.hidden = YES;
//                    }
//                    
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        
//                        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self->_updateView];
//                    });
//                }
//            } failure:^(NSError *error) {
//                
//            }];
//        }
//    } failure:^(NSError * _Nonnull error) {
//        
//        
//    }];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [self UpdateRequest];
//    [BaseRequest VersionUpdateSuccess:^(id  _Nonnull resposeObject) {
//
//        NSArray *array = resposeObject[@"results"];
//        NSDictionary *dic = array[0];
//        NSString *appStoreVersion = dic[@"version"];
//        if ([[appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue] > [[YACversion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue]) {
//
//            [BaseRequest GET:@"getSaleVersionInfo" parameters:@{} success:^(id resposeObject) {
//
//                if ([resposeObject[@"code"] integerValue] == 200) {
//
//                    self->_updateView = [[UpgradeTipsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//                    self->_updateView.contentL.text = dic[@"releaseNotes"];
//                    self->_updateView.upgradeTipsViewBlock = ^{
//
//                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1371990304?mt=8"]];
//                    };
//                    if ([resposeObject[@"data"][@"must"] integerValue]) {
//
//                        self->_updateView.cancelBtn.hidden = YES;
//                    }
//
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self->_updateView];
//                    });
//                }
//            } failure:^(NSError *error) {
//
//            }];
//        }
//    } failure:^(NSError * _Nonnull error) {
//
//
//    }];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self UpdateRequest];
//    [BaseRequest VersionUpdateSuccess:^(id  _Nonnull resposeObject) {
//
//        NSArray *array = resposeObject[@"results"];
//        NSDictionary *dic = array[0];
//        NSString *appStoreVersion = dic[@"version"];
//        if ([[appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue] > [[YACversion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue]) {
//
//            [BaseRequest GET:@"getSaleVersionInfo" parameters:@{} success:^(id resposeObject) {
//
//                if ([resposeObject[@"code"] integerValue] == 200) {
//
//
//                    self->_updateView = [[UpgradeTipsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//                    self->_updateView.contentL.text = dic[@"releaseNotes"];
//                    self->_updateView.upgradeTipsViewBlock = ^{
//
//                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1371990304?mt=8"]];
//                    };
//                    if ([resposeObject[@"data"][@"must"] integerValue]) {
//
//                        self->_updateView.cancelBtn.hidden = YES;
//                    }
//
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self->_updateView];
//                    });
//                }
//            } failure:^(NSError *error) {
//
//            }];
//        }
//    } failure:^(NSError * _Nonnull error) {
//
//
//    }];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
    
    NSLog(@"内存警告了!!!!!!!!!!!!!");
}



@end
