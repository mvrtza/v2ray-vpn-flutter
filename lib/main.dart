import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_v2ray_full/router/app_router.dart';
import 'package:vpn_v2ray_full/utils/constants.dart';
import 'bloc/vpn_bloc.dart';
import 'bloc/vpn_event.dart';
import 'data/secure_vpn_storage.dart';
import 'repository/vpn_repository.dart';
import 'repository/vpn_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final repository = VpnRepository(SecureVpnStorage());

    return BlocProvider(
      create: (_) => VpnBloc(repository)..add(ListAll()),
      child: MaterialApp.router(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.teal,
        ),
        themeMode: ThemeMode.dark,
        title: kAppName,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
