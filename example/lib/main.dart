import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:eas_flutter_plugin/eas_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _easFlutterPlugin = EasFlutterPlugin();
  String eas_appId = "xrjzfcemhhvbksuirqpizvmq";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _easFlutterPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

@override
  Widget build(BuildContext context) {
    List<Widget> buttons = [
      Container(
        child: Text('Running on: $_platformVersion\n'),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '初始化',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () => initEasSdk())),
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '登录',
                      style: TextStyle(fontSize: 10),
                    ),
                    onPressed: () => login())),
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      'Enven打点',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () => trackTestEvent())),
          ],
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      'USER_SETONCE',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () => userSetOnce())),
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      'USER_SET',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () => userSet())),
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      'USER_ADD',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () => userAdd())),
          ],
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      'FLUSH',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () => flush())),
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '设置公共属性',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () => setSuperProperties())),
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '获取公共属性',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () => getSuperProperties())),
          ],
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '去除公共属性',
                      style: TextStyle(fontSize: 10),
                    ),
                    onPressed: () => clearOneProperties())),
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '清除所有公共属性',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () => clearAllSuperProperties())),
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '获取国家编码',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () => getRegion())),
          ],
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '获取缓存的Fid',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () => getDataFid())),
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '获取缓存的Bid',
                      style: TextStyle(fontSize: 10),
                    ),
                    onPressed: () => getDataBid())),
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '获取缓存的活跃天数',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () => getDataActiviteDays())),
          ],
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '获取缓存的首次启动时间',
                      style: TextStyle(fontSize: 10),
                    ),
                    onPressed: () => getDataFirstStartTime())),
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '获取缓存的GEO',
                      style: TextStyle(fontSize: 10),
                    ),
                    onPressed: () => getDataGeo())),
            Expanded(
                child: OutlinedButton(
                    child: const Text(
                      '退出接口',
                      style: TextStyle(fontSize: 10),
                    ),
                    onPressed: () => exitAcquApp())),
          ],
        ),
      ),
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('单实例测试'),
        ),
        body: Container(
            child: CustomScrollView(shrinkWrap: true, slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(2.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    buttons,
                  ),
                ),
              ),
            ])),
      ),
    );
  }


  /// 初始化
  void initEasSdk() {
    _easFlutterPlugin.initSdk(eas_appId);
  }

  ///登录
  void login() {
    String accountId = "testid111";

    _easFlutterPlugin.login(accountId,eas_appId);
  }

  void trackTestEvent() {
    var properties = {
      'PROP_INT': 5678,
      'PROP_DOUBLE': 12.3,
      'PROP_LIST': ['apple', 'ball', 1234],
      'PROP_BOOL': false,
      'PROP_STRING': 'flutter test',
    };
    _easFlutterPlugin.track("event_id_123",eas_appId, properties);
  }


  void userSet() {
    _easFlutterPlugin.userSet(eas_appId,{'user_name': 'TA'});
  }

  void userSetOnce() {
    _easFlutterPlugin.userSetOnce(eas_appId,{'first_payment_time': '2018-01-01 01:23:45.678'});
  }

  void userAdd() {
    _easFlutterPlugin.userAdd(eas_appId,{'total_revenue': 30});
  }

  void setSuperProperties() {
    _easFlutterPlugin.setSuperProperties(eas_appId,{'vip_level': 21, "super_level": 991});
  }


  void clearOneProperties() {
    _easFlutterPlugin.unsetSuperProperty(eas_appId,"vip_level");
  }

  void clearAllSuperProperties() {
    _easFlutterPlugin.clearSuperProperties(eas_appId);
  }

  void getSuperProperties() async {
    var map = await _easFlutterPlugin.getSuperProperties(eas_appId);
    print("EAS getSuperProperties: $map");
  }


  void getRegion() async {
    String? reg = await _easFlutterPlugin.getRegion(eas_appId);
    print("EAS getRegion: $reg");
  }


  void getDeviceId() async {
  }

  void getDataFirstStartTime() async {
    String? time = await _easFlutterPlugin.getDataFirstStartTime(eas_appId);
    print("EAS getDataFirstStartTime: $time");
  }

  void getDataActiviteDays() async {
    int? deviceId = await _easFlutterPlugin.getDataActiviteDays(eas_appId);
     print("EAS getDataActiviteDays: $deviceId");
  }

  void getDataGeo() async {
     String? deviceId = await _easFlutterPlugin.getDataGeo(eas_appId);
     print("EAS getDataGeo: $deviceId");
  }

  void getDataBid() async {
     String? deviceId = await _easFlutterPlugin.getDataBid(eas_appId);
     print("EAS getDataBid: $deviceId");
  }
  void getDataFid() async {
     String? deviceId = await _easFlutterPlugin.getDataFid(eas_appId);
     print("EAS getDataFid: $deviceId");
  }

  void flush() {
    _easFlutterPlugin.flush(eas_appId);
  }

  void exitAcquApp() {
    bool isexit = _easFlutterPlugin.exitAcquApp(eas_appId) as bool;
    print("EAS exitAcquApp: $isexit");
  }

}
