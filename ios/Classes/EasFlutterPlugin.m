#import "EasFlutterPlugin.h"
#import <Flutter/Flutter.h>
#import <YFData/YFData.h>
#import <YFCore/YFCore.h>

@implementation EasFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"eas_flutter_plugin"
            binaryMessenger:[registrar messenger]];
  EasFlutterPlugin* instance = [[EasFlutterPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSDictionary* arguments = (NSDictionary *)call.arguments;
    
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }
    else if ([@"initSdk" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [YFDataHelper startWithAppId:[arguments objectForKey:@"appId"] completion:^(NSError * _Nullable error) {}];
        } else {
            [YFDataHelper start:^(NSError * _Nullable error) {}];
        }
        result(nil);
    }
    else if ([@"login" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] loginAccount:[arguments objectForKey:@"accountId"]
                                                                                   withNetworkName:[arguments objectForKey:@"networkName"]
                                                                                        completion:^(NSError * _Nullable error, NSString * _Nullable fid) {
                if (error) {
                    result(nil);
                } else {
                    result(fid);
                }
            }];
        } else {
            [YFDataHelper.sharedInstance loginAccount:[arguments objectForKey:@"accountId"]
                                      withNetworkName:[arguments objectForKey:@"networkName"]
                                           completion:^(NSError * _Nullable error, NSString * _Nullable fid) {
                if (error) {
                    result(nil);
                } else {
                    result(fid);
                }
            }];
        }
    }
    else if ([@"userAdd" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] user_add:[arguments objectForKey:@"properties"]];
        } else {
            [YFDataHelper.sharedInstance user_add:[arguments objectForKey:@"properties"]];
        }
        result(nil);
    }
    else if ([@"userSet" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] user_set:[arguments objectForKey:@"properties"]];
        } else {
            [YFDataHelper.sharedInstance user_set:[arguments objectForKey:@"properties"]];
        }
        result(nil);
    }
    else if ([@"userSetOnce" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] user_setonce:[arguments objectForKey:@"properties"]];
        } else {
            [YFDataHelper.sharedInstance user_setonce:[arguments objectForKey:@"properties"]];
        }
        result(nil);
    }
    else if ([@"userAppend" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] user_append:[arguments objectForKey:@"properties"]];
        } else {
            [YFDataHelper.sharedInstance user_append:[arguments objectForKey:@"properties"]];
        }
        result(nil);
    }
    else if ([@"userUniqAppend" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] user_uniq_append:[arguments objectForKey:@"properties"]];
        } else {
            [YFDataHelper.sharedInstance user_uniq_append:[arguments objectForKey:@"properties"]];
        }
        result(nil);
    }
    else if ([@"userUnset" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] user_unset:[arguments objectForKey:@"properties"]];
        } else {
            [YFDataHelper.sharedInstance user_unset:[arguments objectForKey:@"properties"]];
        }
        result(nil);
    }
    else if ([@"track" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] track:[arguments objectForKey:@"eventName"]
                                                                             withProperties:[arguments objectForKey:@"properties"]];
        } else {
            [YFDataHelper.sharedInstance track:[arguments objectForKey:@"eventName"] 
                                withProperties:[arguments objectForKey:@"properties"]];
        }
        result(nil);
    }
    else if ([@"sdkVersion" isEqualToString:call.method]) {
        NSString *version = [YFDataHelper getSDKVersion];
        result(version);
    }
    else if ([@"setSuperProperties" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] setSuperPros:[arguments objectForKey:@"properties"]];
        } else {
            [YFDataHelper.sharedInstance setSuperPros:[arguments objectForKey:@"properties"]];
        }
        result(nil);
    }
    else if ([@"getSuperProperties" isEqualToString:call.method]) {
        NSDictionary *superPros = [NSDictionary dictionary];
        if ([arguments objectForKey:@"appId"]) {
            superPros = [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] getSuperPros];
        } else {
            superPros = [YFDataHelper.sharedInstance getSuperPros];
        }
        result(superPros);
    }
    else if ([@"unsetSuperProperty" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] removeSuperPros:[arguments objectForKey:@"key"]];
        } else {
            [YFDataHelper.sharedInstance removeSuperPros:[arguments objectForKey:@"key"]];
        }
        result(nil);
    }
    else if ([@"clearSuperProperties" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] clearSuperPros];
        } else {
            [YFDataHelper.sharedInstance clearSuperPros];
        }
        result(nil);
    }
    else if ([@"flush" isEqualToString:call.method]) {
        if ([arguments objectForKey:@"appId"]) {
            [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] flush];
        } else {
            [YFDataHelper.sharedInstance flush];
        }
        result(nil);
    }
    else if ([@"enableLog" isEqualToString:call.method]) {
        if ([arguments.allKeys containsString:@"enable"]) {
            YFConstants.shareInstance.isTestDevice = [[arguments objectForKey:@"enable"] boolValue];
        } else {
            YFConstants.shareInstance.isTestDevice = YES;
        }
        result(nil);
    }
    else if ([@"getDataFid" isEqualToString:call.method]) {
        result(YFDataHelper.sharedInstance.fid);
    }
    else if ([@"getDataGeo" isEqualToString:call.method]) {
        result(YFDataCommon.common.yfInfoReg);
    }
    else if ([@"getDataBid" isEqualToString:call.method]) {
        NSString *bid = nil;
        if ([arguments objectForKey:@"appId"]) {
            bid = [[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] performSelector:@selector(yfInfoBId)];
        } else {
            bid = [YFDataHelper.sharedInstance performSelector:@selector(yfInfoBId)];
        }
        result(bid);
    }
    else if ([@"getDataActiviteDays" isEqualToString:call.method]) {
        result(@(YFDataCommon.common.yfInfoActiviteDays));
    }
    else if ([@"getDataFirstStartTime" isEqualToString:call.method]) {
        NSTimeInterval firstStartTime = 0;
        if ([arguments objectForKey:@"appId"]) {
            firstStartTime = [[[YFDataHelper sharedInstanceWithAppId:[arguments objectForKey:@"appId"]] performSelector:@selector(yfInfoFirstStartTime)] doubleValue];
        } else {
            firstStartTime = [[YFDataHelper.sharedInstance performSelector:@selector(yfInfoFirstStartTime)] doubleValue];
        }
        
        result(@(firstStartTime).stringValue);
    }
    else if ([@"getRegion" isEqualToString:call.method]) {
        [YFGeoManager.sharedManager fetchGeoInfoCompleted:^(NSError * _Nullable error) {
            if (error) {
                result(nil);
            } else {
                result(YFGeoManager.sharedManager.geoInfo.countyCode);
            }
        }];
    }
    else if ([@"exitAcquApp" isEqualToString:call.method]) {
        result(nil);
    }
    
    
    
    else {
        result(FlutterMethodNotImplemented);
    }
}

@end
