#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <YFCore/YFCore.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // ***********
    // 这部分代码仅供测试使用
    YFConstants.shareInstance.isTestDevice = YES;
    
    [YFDebugHelper sharedInstance].logPath = [YFLogManager sharedManager].logFilePath;
    [YFDebugHelper setupLogDebug:YES];
    [YFDebugHelper setupViewDubug:YES];
    [[YFHttpServerLogger shared] startServer:YES];
    // ***********
    
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
