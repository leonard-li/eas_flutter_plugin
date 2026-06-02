import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'eas_flutter_plugin_method_channel.dart';

abstract class EasFlutterPluginPlatform extends PlatformInterface {
  /// Constructs a EasFlutterPluginPlatform.
  EasFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static EasFlutterPluginPlatform _instance = MethodChannelEasFlutterPlugin();

  /// The default instance of [EasFlutterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelEasFlutterPlugin].
  static EasFlutterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EasFlutterPluginPlatform] when
  /// they register themselves.
  static set instance(EasFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<String?> getRegion(String appId) async {
    throw UnimplementedError('getRegion() has not been implemented.');
  }
  void enableLog() {
    throw UnimplementedError('enableLog() has not been implemented.');
  }
  Future<bool?> initSdk(String appId) async {
    throw UnimplementedError('initSdk() has not been implemented.');
  }
  void login(String accountId,String appId) {
    throw UnimplementedError('login() has not been implemented.');
  }
  void track(String eventName,String appId, Map<String, dynamic>? properties)  {
    throw UnimplementedError('track() has not been implemented.');
  }
  void userSet(String appId,Map<String, dynamic> properties) {
    throw UnimplementedError('userSet() has not been implemented.');
  }
  void userSetOnce(String appId,Map<String, dynamic> properties) {
    throw UnimplementedError('userSetOnce() has not been implemented.');
  }
  void userAdd(String appId,Map<String, num> properties) {
    throw UnimplementedError('userAdd() has not been implemented.');
  }
  void userAppend(String appId,Map<String, dynamic> properties) {
    throw UnimplementedError('userAppend() has not been implemented.');
  }
  void userUniqAppend(String appId,Map<String, dynamic> properties) {
    throw UnimplementedError('userUniqAppend() has not been implemented.');
  }
  void userUnset(String appId,Map<String, dynamic> properties) {
    throw UnimplementedError('userUnset() has not been implemented.');
  }
  void flush(String appId) {
    throw UnimplementedError('flush() has not been implemented.');
  }

  void setSuperProperties(String appId,Map<String, dynamic> properties) {
    throw UnimplementedError('setSuperProperties() has not been implemented.');
  }
  Future<Map<String, dynamic>?> getSuperProperties(String appId) async {
    throw UnimplementedError('getSuperProperties() has not been implemented.');
  }
  void clearSuperProperties(String appId) {
    throw UnimplementedError('clearSuperProperties() has not been implemented.');
  }
  void unsetSuperProperty(String appId,String property) {
    throw UnimplementedError('unsetSuperProperty() has not been implemented.');
  }
  Future<String?> getDataFid(String appId) async {
    throw UnimplementedError('getDistinctId() has not been implemented.');
  }
  Future<String?> getDataBid(String appId) async {
    throw UnimplementedError('getDistinctId() has not been implemented.');
  }
  Future<String?> getDataGeo(String appId) async {
    throw UnimplementedError('getDistinctId() has not been implemented.');
  }
  Future<int?> getDataActiviteDays(String appId) async {
    throw UnimplementedError('getDistinctId() has not been implemented.');
  }
  Future<String?> getDataFirstStartTime(String appId) async {
    throw UnimplementedError('getDistinctId() has not been implemented.');
  }
  Future<bool?> exitAcquApp(String appId) async {
    throw UnimplementedError('exitAcquApp() has not been implemented.');
  }
}
