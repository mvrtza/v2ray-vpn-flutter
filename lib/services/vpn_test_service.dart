import 'package:flutter_v2ray/flutter_v2ray.dart';
import '../models/vpn_config.dart';

class VpnTestService {
  final FlutterV2ray _flutterV2ray = FlutterV2ray(onStatusChanged: (V2RayStatus status) {  });

  Future<ConfigStatus> testVpnLink(String link) async {
    try {

      V2RayURL parser = FlutterV2ray.parseFromURL(link);
      final config = parser.getFullConfiguration();


      final delay = await _flutterV2ray.getServerDelay(config: config);

      if (delay >= 0) {
        print('Server reachable, delay: ${delay}ms');
        return ConfigStatus.ok;
      } else {
        print('Server failed');
        return ConfigStatus.failed;
      }
    } catch (e) {
      print('VPN test error: $e');
      return ConfigStatus.failed;
    }
  }


  Future<Map<String, ConfigStatus>> testMultipleLinks(List<String> links) async {
    final results = <String, ConfigStatus>{};
    for (final link in links) {
      final status = await testVpnLink(link);
      results[link] = status;
    }
    return results;
  }
}
