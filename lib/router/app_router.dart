import 'dart:js';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          builder: (context, state) => const SplashScreen()),
      GoRoute(
          path: '/vpn',
          name: 'vpn',
          builder: (context, state) => const SplashScreen()),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text(state.error.toString())),
    ),
  );
}
