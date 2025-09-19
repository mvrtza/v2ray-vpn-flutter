import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vpn_v2ray_full/bloc/vpn_event.dart';
import 'package:vpn_v2ray_full/models/vpn_config.dart';
import 'package:vpn_v2ray_full/utils/constants.dart';
import 'package:vpn_v2ray_full/widgets/rotating_earth.dart';

import '../bloc/vpn_bloc.dart';
import '../bloc/vpn_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(kAppName),
        actions: [
          IconButton(
            icon: const Icon(Icons.vpn_lock),
            onPressed: () {
              context.go('/vpn');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          RotatingEarth(),
          Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(
                  0x27B8BCFF)),
              width: double.infinity,
              child: BlocBuilder<VpnBloc, VpnState>(
                builder: (context, state) {
                  final selected = state.selectedConfig;
                  final connectionStatus =
                  state.connectionStatus == ConfigStatus.ok ? 'وصل' : 'متصل نیست';
                  final country = selected?.region ?? '---';

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<VpnBloc>().add(ToggleVpn());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.connectionStatus == ConfigStatus.ok
                              ? Colors.red
                              : Colors.green,
                        ),
                        child: Text(
                          state.connectionStatus == ConfigStatus.ok ? 'قطع' : 'اتصال',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  connectionStatus,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  ':وضعیت اتصال',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  country,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  ':کشور',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

        ],
      ),
    );
  }
}
