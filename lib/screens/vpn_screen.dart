import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/vpn_bloc.dart';
import '../bloc/vpn_event.dart';
import '../bloc/vpn_state.dart';
import 'package:go_router/go_router.dart';
import '../widgets/config_tile.dart';

class VpnScreen extends StatefulWidget {
  const VpnScreen({super.key});

  @override
  State<VpnScreen> createState() => _VpnScreenState();

}


class _VpnScreenState extends State<VpnScreen> {
  @override
  void initState() {
    super.initState();


    Future.microtask(() {
      context.read<VpnBloc>().add(ListAll());
    });
  }
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _configController = TextEditingController();

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
                    controller: _nameController,
                    decoration: InputDecoration(hint: Text('نام کانفیگ')),
                  ),
                  content: TextField(
                    controller: _configController,
                    decoration: InputDecoration(hint: Text('کد کانفیگ')),
                  ),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                      context.read<VpnBloc>().add(AddConfig(_nameController.text.trim(), _configController.text));
                        Navigator.pop(context);
                      },
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
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'testify') {
                context.read<VpnBloc>().add(TestAll());
              } else if (value == 'location') {
                context.read<VpnBloc>().add(LocationAll());
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'testify',
                  child: Text('تست تمام کانفیگ ها'),
                ),
                const PopupMenuItem(
                  value: 'location',
                  child: Text('مشخص کردن لوکیشن کانفیگ ها'),
                ),
              ];
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
                    SnackBar(content: Text(" انتخاب شد: ${vpn.title}")),
                  );
                },
                onTapDelete: () {
                  context.read<VpnBloc>().add(RemoveConfig(vpn.id));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(" حذف شد: ${vpn.title}")),
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
