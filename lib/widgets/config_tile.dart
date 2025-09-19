import 'package:flutter/material.dart';
import 'package:vpn_v2ray_full/models/vpn_config.dart';


class ConfigTile extends StatelessWidget {
  final VpnConfig vpn;
  final VoidCallback? onTap;
  final VoidCallback? onTapDelete;

  const ConfigTile({super.key, required this.vpn, this.onTap,this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          vpn.selected ? Icons.vpn_lock : Icons.vpn_key,
          color: vpn.selected ? Colors.green : Colors.grey,
        ),
        title: Text(vpn.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(vpn.connection != ConfigStatus.unknown ? vpn.connection.toString() : ''),
        trailing: IconButton(onPressed: onTapDelete, icon: Icon(Icons.delete, color: Colors.red,size: 16)),
        onTap: onTap,
      ),
    );
  }
}