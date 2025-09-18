import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/vpn_bloc.dart';
import '../bloc/vpn_event.dart';
import '../bloc/vpn_state.dart';
import 'package:go_router/go_router.dart';
import '../widgets/config_tile.dart';

class VpnScreen extends StatelessWidget {
  const VpnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            context.go('/home');
          },
        ),

        centerTitle: true, // متن وسط AppBar

        title: const Text(style: TextStyle(color: Colors.white), "SERVERS"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.vpn_lock, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: TextField(
                    decoration: InputDecoration(hint: Text('نام کانفیگ')),
                  ),
                  content: TextField(
                    decoration: InputDecoration(hint: Text('کد کانفیگ')),
                  ),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      child: const Text("OK"),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<VpnBloc, VpnState>(
        builder: (context, state) {
          final vpnList = state.configs;
          if (vpnList.isEmpty) {
            return const Center(child: Text("هیچ کانفیگی یافت نشد"));
          }
          return ListView.builder(
            itemCount: vpnList.length,
            itemBuilder: (context, index) {
              final vpn = vpnList[index];
              return ConfigTile(
                vpn: vpn,
                onTap: () {
                  context.read<VpnBloc>().add(SetSelected(vpn.id));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Selected: ${vpn.title}")),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
