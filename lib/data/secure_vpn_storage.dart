import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vpn/repository/vpn_storage.dart';
import 'package:vpn/utils/constants.dart';

import '../models/vpn_config.dart';

class SecureVpnStorage extends VpnStorage{
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Future<List<VpnConfig>> readConfigs() async {
    final raw = await storage.read(key: kVpnStorageKey);
    if (raw == null) return [];
    final List<dynamic> jsonList = jsonDecode(raw);
    return jsonList.map((e) => VpnConfig.fromJson(e)).toList();
  }

  @override
  Future<void> saveConfig(VpnConfig config) async {
    final configs = await readConfigs();
    configs.add(config);
    await storage.write(key: kVpnStorageKey, value: jsonEncode(configs));
  }

  @override
  Future<void> removeConfig(String id) async {
    final configs = await readConfigs();
    configs.removeWhere((c) => c.id == id);
    await storage.write(key: kVpnStorageKey, value: jsonEncode(configs));
  }
}