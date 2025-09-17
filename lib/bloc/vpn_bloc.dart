import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/models/vpn_config.dart';
import 'package:vpn/repository/vpn_storage.dart';
import '../repository/vpn_repository.dart';

import 'vpn_event.dart';
import 'vpn_state.dart';

class VpnBloc extends Bloc<VpnEvent, VpnState> {
  final VpnRepository repository;

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

      final updatedList = List<VpnConfig>.from(state.configs)
        ..add(newConfig);
      emit(state.copyWith(configs: updatedList));
    });
    on<RemoveConfig>((event, emit) {
      final updatedList = state.configs.where((c) => c.id != event.id).toList();
      emit(state.copyWith(configs: updatedList));
    });
    on<SetSelected>((event, emit) {
      final selected = state.configs.firstWhereOrNull(
            (c) => c.id == event.id,
      );
      emit(state.copyWith(selectedConfig: selected));
    });
    on<ListAll>((event, emit) async {
      final configs = await repository.fetchAllConfigs();
      emit(state.copyWith(configs: configs));
    });
  }
}
