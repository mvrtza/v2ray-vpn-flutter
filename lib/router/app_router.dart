import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vpn_v2ray_full/screens/home_screen.dart';
import 'package:vpn_v2ray_full/screens/vpn_screen.dart';

import '../screens/splash_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          name: 'splash',
          builder: (context, state) => const SplashScreen()),
      GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen()),
      GoRoute(
          path: '/vpn',
          name: 'vpn',
          builder: (context, state) => const VpnScreen()),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text(state.error.toString())),
    ),
  );
}
