import 'package:flutter_v2ray/flutter_v2ray.dart';
import '../models/vpn_config.dart';

class VpnConnectService {
  final FlutterV2ray _flutterV2ray = FlutterV2ray(onStatusChanged: (V2RayStatus status) {  });
  VpnConfig? _currentConfig;


  Future<ConfigStatus> connect(String link) async {
    try {

      await _flutterV2ray.initializeV2Ray();


      V2RayURL parser = FlutterV2ray.parseFromURL(link);
      final config = parser.getFullConfiguration();

      //
      // final delay = await _flutterV2ray.getServerDelay(config: config);
      // if (delay < 0) {
      //   print('Server not reachable');
      //   return ConfigStatus.failed;
      // }
      // print('Server delay: ${delay}ms');


      final granted = await _flutterV2ray.requestPermission();
      if (!granted) {
        print('Permission denied');
        return ConfigStatus.failed;
      }

      if (await _flutterV2ray.requestPermission()){
        _flutterV2ray.startV2Ray(
          remark: parser.remark,
          // The use of parser.getFullConfiguration() is not mandatory,
          // and you can enter the desired V2Ray configuration in JSON format
          config: parser.getFullConfiguration(),
          blockedApps: null,
          bypassSubnets: null,
          proxyOnly: false,
        );
      };



      return ConfigStatus.ok;
    } catch (e) {
      print('VPN connection error: $e');
      return ConfigStatus.failed;
    }
  }


  Future<void> disconnect() async {
    try {
      await _flutterV2ray.stopV2Ray();
      _currentConfig = null;
    } catch (e) {
      print('VPN disconnect error: $e');
    }
  }


  VpnConfig? get currentConfig => _currentConfig;
}
