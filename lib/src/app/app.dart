import 'package:flutter/material.dart';
import 'router.dart';
import 'theme.dart';

class HumanGachaApp extends StatelessWidget {
  const HumanGachaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '인간 가챠',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: appRouter,
    );
  }
}
