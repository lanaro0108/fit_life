import 'package:fit_life/controller/atividades_controller.dart';
import 'package:fit_life/theme/app_theme.dart';
import 'package:fit_life/view/home_page.dart';
import 'package:fit_life/view/splash_page.dart';
import 'package:fit_life/widgets/bnbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Ponto de entrada do aplicativo FitLife
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AtividadesController(),
      child: FitLife(), // 
    ),
  );
}

class FitLife extends StatelessWidget {
  const FitLife({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<AtividadesController>().darkMode;

    return MaterialApp(
      title: 'FitLife',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: SplashPage(),
      routes: {
        '/home': (_) => HomePage(),
        '/app': (_) => AppShell(), // 
      },
    );
  }
}
