import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'eas_flutter_plugin_platform_interface.dart';

/// An implementation of [EasFlutterPluginPlatform] that uses method channels.
class MethodChannelEasFlutterPlugin extends EasFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('eas_flutter_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void enableLog() {
    methodChannel.invokeMethod('enableLog');
  }

  @override
  Future<bool?> initSdk(String appId) async {
    return await methodChannel
        .invokeMethod<bool>('initSdk', <String, dynamic>{'appId': appId});
  }

  @override
  void login(String accountId, String appId) {
    methodChannel.invokeMethod<void>(
        'login', <String, dynamic>{'accountId': accountId, 'appId': appId});
  }

  @override
  void clearSuperProperties(String appId) {
    methodChannel.invokeMethod(
        'clearSuperProperties', <String, dynamic>{'appId': appId});
  }

  @override
  Future<bool?> exitAcquApp(String appId) async {
    return await methodChannel
        .invokeMethod<bool>('exitAcquApp', <String, dynamic>{'appId': appId});
  }

  @override
  void flush(String appId) {
    methodChannel.invokeMethod('flush', <String, dynamic>{'appId': appId});
  }

  @override
  void track(String eventName, String appId, Map<String, dynamic>? properties) {
    Map<String, dynamic> params = {
      'eventName': eventName,
      'appId': appId,
      'properties': properties,
    };
    methodChannel.invokeMethod<void>('track', params);
  }

  @override
  Future<int?> getDataActiviteDays(String appId) async {
    return await methodChannel.invokeMethod<int>(
        'getDataActiviteDays', <String, dynamic>{'appId': appId});
  }

  @override
  Future<String?> getDataBid(String appId) async {
    return await methodChannel
        .invokeMethod<String>('getDataBid', <String, dynamic>{'appId': appId});
  }

  @override
  Future<String?> getDataFid(String appId) async {
    return await methodChannel
        .invokeMethod<String>('getDataFid', <String, dynamic>{'appId': appId});
  }

  @override
  Future<String?> getDataFirstStartTime(String appId) async {
    return await methodChannel.invokeMethod<String>(
        'getDataFirstStartTime', <String, dynamic>{'appId': appId});
  }

  @override
  Future<String?> getDataGeo(String appId) async {
    return await methodChannel
        .invokeMethod<String>('getDataGeo', <String, dynamic>{'appId': appId});
  }

  @override
  Future<String?> getRegion(String appId) async {
    return await methodChannel
        .invokeMethod<String>('getRegion', <String, dynamic>{'appId': appId});
  }

  @override
  Future<Map<String, dynamic>?> getSuperProperties(String appId) async {
    return await methodChannel.invokeMapMethod<String, dynamic>(
        'getSuperProperties', <String, dynamic>{'appId': appId});
  }

  @override
  void setSuperProperties(String appId, Map<String, dynamic> properties) {
    methodChannel.invokeMethod<void>('setSuperProperties',
        <String, dynamic>{'properties': properties, 'appId': appId});
  }

  @override
  void unsetSuperProperty(String appId, String property) {
    methodChannel.invokeMethod('unsetSuperProperty',
        <String, dynamic>{'property': property, 'appId': appId});
  }

  @override
  void userAdd(String appId, Map<String, num> properties) {
    methodChannel.invokeMethod<void>(
        'userAdd', <String, dynamic>{'properties': properties, 'appId': appId});
  }

  @override
  void userSet(String appId, Map<String, dynamic> properties) {
    methodChannel.invokeMethod<void>(
        'userSet', <String, dynamic>{'properties': properties, 'appId': appId});
  }

  @override
  void userSetOnce(String appId, Map<String, dynamic> properties) {
    methodChannel.invokeMethod<void>('userSetOnce',
        <String, dynamic>{'properties': properties, 'appId': appId});
  }

  @override
  void userAppend(String appId, Map<String, dynamic> properties) {
    methodChannel.invokeMethod<void>('userAppend',
        <String, dynamic>{'properties': properties, 'appId': appId});
  }
  @override
  void userUniqAppend(String appId, Map<String, dynamic> properties) {
    methodChannel.invokeMethod<void>('userUniqAppend',
        <String, dynamic>{'properties': properties, 'appId': appId});
  }
  @override
  void userUnset(String appId, Map<String, dynamic> properties) {
    methodChannel.invokeMethod<void>('userUnset',
        <String, dynamic>{'properties': properties, 'appId': appId});
  }

  // Formats all DateTime value in properties.
  void _searchDate(String appId, Map<String, dynamic> properties) {
    // ignore: unnecessary_null_comparison
    if (properties == null) return;

    properties.updateAll((String k, dynamic v) {
      if (v is DateTime) {
        return _formatDateString(v);
      } else if (v is List) {
        return v.map((e) => e is DateTime ? _formatDateString(e) : e).toList();
      } else {
        return v;
      }
    });
  }

  String _formatDateString(DateTime dateTime) {
    final sb = StringBuffer();

    sb.write(_digits(dateTime.year, 4));
    sb.write('-');
    sb.write(_digits(dateTime.month, 2));
    sb.write('-');
    sb.write(_digits(dateTime.day, 2));
    sb.write(' ');
    sb.write(_digits(dateTime.hour, 2));
    sb.write(':');
    sb.write(_digits(dateTime.minute, 2));
    sb.write(':');
    sb.write(_digits(dateTime.second, 2));
    sb.write('.');
    sb.write(_digits(dateTime.millisecond, 3));

    return sb.toString();
  }

  String _digits(int value, int length) {
    String ret = '$value';
    if (ret.length < length) {
      ret = '0' * (length - ret.length) + ret;
    }
    return ret;
  }
}
