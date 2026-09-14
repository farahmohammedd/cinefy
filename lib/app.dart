import 'package:cinefy_app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:cinefy_app/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routes,
      theme: AppTheme.darkTheme,

      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
    );
  }
}
