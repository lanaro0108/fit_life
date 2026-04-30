import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_life/controller/atividades_controller.dart';
import 'package:fit_life/view/home_page.dart';
import 'package:fit_life/view/main_app_page.dart';
import 'package:fit_life/view/splash_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const FitLifeApp(),
    ),
  );
}

class FitLifeApp extends StatelessWidget {
  const FitLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<AppState>().isDarkMode
        ? ThemeMode.dark
        : ThemeMode.light;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit Life',
      theme: ThemeData(
        primaryColor: const Color(0xFF00A79D),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00A79D)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1F1F1F)),
      ),
      themeMode: themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
        '/app': (context) => const MainAppPage(),
      },
    );
  }
}
