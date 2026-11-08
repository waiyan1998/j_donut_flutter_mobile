import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/presentation/screens/auth_screen.dart';

class JDonutsApp extends StatelessWidget {
  const JDonutsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "J'Donuts",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AuthScreen(),
    );
  }
}
