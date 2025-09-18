import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vpn_v2ray_full/utils/constants.dart';

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
    );
  }
}
