import '../models/vpn_config.dart';
import 'vpn_storage.dart';

class VpnRepository {
  final VpnStorage storage;

  VpnRepository(this.storage);

  Future<List<VpnConfig>> fetchAllConfigs() => storage.readConfigs();

  Future<void> addConfig(VpnConfig config) => storage.saveConfig(config);

  Future<void> removeConfig(String id) => storage.removeConfig(id);
  Future<void> saveAllConfigs(List<VpnConfig> configs) => storage.saveAllConfigs(configs);

}