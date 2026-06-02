
import 'eas_flutter_plugin_platform_interface.dart';

class EasFlutterPlugin {
  Future<String?> getPlatformVersion() {
    return EasFlutterPluginPlatform.instance.getPlatformVersion();
  }
  void enableLog(bool enableLog) {
    if (enableLog) {
      EasFlutterPluginPlatform.instance.enableLog();
    }
  }

  Future<String?> getRegion(String appId) async {
    return EasFlutterPluginPlatform.instance.getRegion(appId);
  }
  Future<bool?> initSdk(String appId) async {
    return EasFlutterPluginPlatform.instance.initSdk(appId);
  }
  void login(String accountId,String appId) {
    return EasFlutterPluginPlatform.instance.login(accountId,appId);
  }
  void track(String eventName,String appId, Map<String, dynamic>? properties)  {
    EasFlutterPluginPlatform.instance.track(eventName,appId,properties);
  }
  void userSet(String appId, Map<String, dynamic> properties) {
    EasFlutterPluginPlatform.instance.userSet(appId,properties);
  }
  void userSetOnce(String appId, Map<String, dynamic> properties) {
    EasFlutterPluginPlatform.instance.userSetOnce(appId,properties);
  }
  void userAdd(String appId, Map<String, num> properties) {
    EasFlutterPluginPlatform.instance.userAdd(appId,properties);
  }
  void userAppend(String appId, Map<String, dynamic> properties) {
    EasFlutterPluginPlatform.instance.userAppend(appId,properties);
  }
  void userUniqAppend(String appId, Map<String, dynamic> properties) {
    EasFlutterPluginPlatform.instance.userUniqAppend(appId,properties);
  }
  void userUnset(String appId, Map<String, dynamic> properties) {
    EasFlutterPluginPlatform.instance.userUnset(appId,properties);
  }
  void flush(String appId) {
    EasFlutterPluginPlatform.instance.flush(appId);
  }

  void setSuperProperties(String appId, Map<String, dynamic> properties) {
    EasFlutterPluginPlatform.instance.setSuperProperties(appId,properties);
  }
  Future<Map<String, dynamic>?> getSuperProperties(String appId) async {
    return EasFlutterPluginPlatform.instance.getSuperProperties(appId);
  }
  void clearSuperProperties(String appId) {
    EasFlutterPluginPlatform.instance.clearSuperProperties(appId);
  }
  void unsetSuperProperty(String appId, String key) {
    EasFlutterPluginPlatform.instance.unsetSuperProperty(appId,key);
  }
  Future<String?> getDataFid(String appId) async {
    return EasFlutterPluginPlatform.instance.getDataFid(appId);
  }
  Future<String?> getDataBid(String appId) async {
    return EasFlutterPluginPlatform.instance.getDataBid(appId);
  }
  Future<String?> getDataGeo(String appId) async {
    return EasFlutterPluginPlatform.instance.getDataGeo(appId);
  }
  Future<int?> getDataActiviteDays(String appId) async {
    return EasFlutterPluginPlatform.instance.getDataActiviteDays(appId);
  }
  Future<String?> getDataFirstStartTime(String appId) async {
    return EasFlutterPluginPlatform.instance.getDataFirstStartTime(appId);
  }
  Future<bool?> exitAcquApp(String appId) async {
    return EasFlutterPluginPlatform.instance.exitAcquApp(appId);
  }
}
