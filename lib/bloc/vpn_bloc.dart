import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:flutter_v2ray/url/url.dart';
import 'package:vpn_v2ray_full/services/geo_services.dart';
import 'package:vpn_v2ray_full/services/vpn_connect_service.dart';
import '../models/vpn_config.dart';
import '../repository/vpn_repository.dart';
import '../services/vpn_test_service.dart';
import 'vpn_event.dart';
import 'vpn_state.dart';

class VpnBloc extends Bloc<VpnEvent, VpnState> {
  final VpnRepository repository;
  final VpnTestService _vpnTestService = VpnTestService();
  final GeoService _geoServices = GeoService();
  final VpnConnectService _vpnConnectService = VpnConnectService();

  VpnBloc(this.repository) : super(VpnState()) {
    on<AddConfig>((event, emit) {
      final newConfig = VpnConfig(
        id: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        date: DateTime.now(),
        title: event.title,
        selected: false,
        configString: event.configString,
        connection: ConfigStatus.unknown,
      );
      repository.addConfig(newConfig);
      final updatedList = List<VpnConfig>.from(state.configs)
        ..add(newConfig);

      emit(state.copyWith(configs: updatedList));
    });


    on<RemoveConfig>((event, emit) {
      final updatedList = state.configs.where((c) => c.id != event.id).toList();
      emit(state.copyWith(configs: updatedList));
    });


    on<SetSelected>((event, emit) {
      final updatedList = state.configs.map((c) {
        if (c.id == event.id) {
          return VpnConfig(
            id: c.id,
            date: c.date,
            title: c.title,
            selected: true,
            configString: c.configString,
            connection: c.connection,
          );
        } else {
          return VpnConfig(
            id: c.id,
            date: c.date,
            title: c.title,
            selected: false,
            configString: c.configString,
            connection: c.connection,
          );
        }
      }).toList();

      final selected = updatedList.firstWhereOrNull((c) => c.selected);
      emit(state.copyWith(configs: updatedList, selectedConfig: selected));
      repository.saveAllConfigs(updatedList);

    });


    on<ListAll>((event, emit) async {
      final configs = await repository.fetchAllConfigs();
      emit(state.copyWith(configs: configs));
    });
    on<ToggleVpn>((event, emit) async {
      VpnConfig? config = state.selectedConfig;
      if (config == null) {
        config = state.configs.firstWhereOrNull((c) => c.selected);
      }


      if (config == null) return;

      try {
        if (state.connectionStatus == ConfigStatus.ok) {

          await _vpnConnectService.disconnect();
          emit(state.copyWith(connectionStatus: ConfigStatus.unknown));
        } else {

          final status = await _vpnConnectService.connect(config.configString);
          emit(state.copyWith(connectionStatus: status));
        }
      } catch (e) {
        emit(state.copyWith(connectionStatus: ConfigStatus.failed));
      }
    });

    // on<Connected>((event,emit){
    //
    // });
    on<TestAll>((event, emit) async {
      final configs = await repository.fetchAllConfigs();
      final List<VpnConfig> updatedConfigs = [];

      for (var cfg in configs) {
        final status = await _vpnTestService.testVpnLink(cfg.configString);

        final updatedCfg = VpnConfig(
            id: cfg.id,
            date: cfg.date,
            selected: cfg.selected,
            title: cfg.title,
            configString: cfg.configString,
            connection: status,
            lat: cfg.lat,
            region: cfg.region,
            city: cfg.city,
            lon: cfg.lon
        );
        updatedConfigs.add(updatedCfg);
        emit(state.copyWith(configs: List.from(updatedConfigs)));
        repository.saveAllConfigs(updatedConfigs);
      }
    });
    on<LocationAll>((event, emit) async {
      final configs = await repository.fetchAllConfigs();
      final List<VpnConfig> updatedConfigs = [];

      for (var cfg in configs) {
        String configCode = cfg.configString;
        V2RayURL parser = FlutterV2ray.parseFromURL(configCode);

        final location = await _geoServices.getLocation(parser.address);

        final updatedCfg = VpnConfig(
          id: cfg.id,
          date: cfg.date,
          selected: cfg.selected,
          title: cfg.title,
          configString: cfg.configString,
          connection: cfg.connection,
          city: location?['city'],
          region: location?['regionName'],
          lat: location?['lat'],
          lon: location?['lon'],
        );

        updatedConfigs.add(updatedCfg);
        emit(state.copyWith(configs: List.from(updatedConfigs)));
        repository.saveAllConfigs(updatedConfigs);
      }
    });
  }
}
