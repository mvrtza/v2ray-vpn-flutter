import 'package:flutter/material.dart';
import 'package:vpn/router/app_router.dart';
import 'package:vpn/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: kAppName,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
