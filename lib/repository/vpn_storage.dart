import '../models/vpn_config.dart';

abstract class VpnStorage {
  Future<List<VpnConfig>> readConfigs();
  Future<void> saveConfig(VpnConfig config);
  Future<void> removeConfig(String id);
}