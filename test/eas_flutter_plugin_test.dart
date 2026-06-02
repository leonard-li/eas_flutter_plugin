import 'package:flutter_test/flutter_test.dart';
import 'package:eas_flutter_plugin/eas_flutter_plugin.dart';
import 'package:eas_flutter_plugin/eas_flutter_plugin_platform_interface.dart';
import 'package:eas_flutter_plugin/eas_flutter_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEasFlutterPluginPlatform
    with MockPlatformInterfaceMixin
    implements EasFlutterPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final EasFlutterPluginPlatform initialPlatform = EasFlutterPluginPlatform.instance;

  test('$MethodChannelEasFlutterPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEasFlutterPlugin>());
  });

  test('getPlatformVersion', () async {
    EasFlutterPlugin easFlutterPlugin = EasFlutterPlugin();
    MockEasFlutterPluginPlatform fakePlatform = MockEasFlutterPluginPlatform();
    EasFlutterPluginPlatform.instance = fakePlatform;

    expect(await easFlutterPlugin.getPlatformVersion(), '42');
  });
}
