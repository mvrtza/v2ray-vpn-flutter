import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:vpn/models/vpn_config.dart';

abstract class VpnEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListAll extends VpnEvent {

}
class SetSelected extends VpnEvent {
  final String id;
  SetSelected(this.id);

  @override
  List<Object?> get props => [id];
}
class RemoveConfig extends VpnEvent {
  final String id;
  RemoveConfig(this.id);

  @override
  List<Object?> get props => [id];
}
class AddConfig extends VpnEvent {
  final String title;
  final String configString;
  AddConfig(this.title,this.configString);
  @override
  List<Object?> get props => [title,configString];

}
class GetConnectionStatus extends VpnEvent {

}
class ToggleVpn extends VpnEvent {

}
