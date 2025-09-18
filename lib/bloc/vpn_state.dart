import 'package:equatable/equatable.dart';

import '../models/vpn_config.dart';

class VpnState extends Equatable {
  final List<VpnConfig> configs;
  final VpnConfig? selectedConfig;
  final ConfigStatus connectionStatus;

  const VpnState({
    this.configs = const [],
    this.selectedConfig,
    this.connectionStatus = ConfigStatus.unknown,
  });

  VpnState copyWith({
    List<VpnConfig>? configs,
    VpnConfig? selectedConfig,
    ConfigStatus? connectionStatus,
  }) {
    return VpnState(
      configs: configs ?? this.configs,
      selectedConfig: selectedConfig ?? this.selectedConfig,
      connectionStatus: connectionStatus ?? this.connectionStatus,
    );
  }

  @override
  List<Object?> get props => [configs, selectedConfig, connectionStatus];
}
