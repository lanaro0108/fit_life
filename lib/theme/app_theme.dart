import 'package:flutter/material.dart';

/// Paleta e temas do aplicativo FitTrack
class AppTheme {
  // ── Cores principais ──────────────────────────────────────────
  static  Color primaryGreen = Color(0xFF00C896);
  static Color accentOrange = Color(0xFFFF6B35);
  static Color darkBg = Color(0xFF0D1117);
  static Color darkCard = Color(0xFF161B22);
  static Color darkSurface = Color(0xFF21262D);
  static Color lightBg = Color(0xFFF0F4F8);
  static Color lightCard = Color(0xFFFFFFFF);

  // ── Tema Escuro ───────────────────────────────────────────────
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkBg,
        colorScheme: ColorScheme.dark(
          primary: primaryGreen,
          secondary: accentOrange,
          surface: darkCard,
          background: darkBg,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: darkCard,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        cardTheme: CardThemeData(
          color: darkCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white.withOpacity(0.06)),
          ),
        ),
        drawerTheme: DrawerThemeData(backgroundColor: darkCard),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: darkCard,
          selectedItemColor: primaryGreen,
          unselectedItemColor: Colors.white38,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: primaryGreen,
          unselectedLabelColor: Colors.white38,
          indicatorColor: primaryGreen,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
              fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white),
          headlineMedium: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
          titleLarge: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.white54),
        ),
      );

  // ── Tema Claro ────────────────────────────────────────────────
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightBg,
        colorScheme: ColorScheme.light(
          primary: primaryGreen,
          secondary: accentOrange,
          surface: lightCard,
          background: lightBg,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: lightCard,
          foregroundColor: Color(0xFF1A1A2E),
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
            letterSpacing: 0.5,
          ),
        ),
        cardTheme: CardThemeData(
          color: lightCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.black.withOpacity(0.06)),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: lightCard,
          selectedItemColor: primaryGreen,
          unselectedItemColor: Colors.black38,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: primaryGreen,
          unselectedLabelColor: Colors.black38,
          indicatorColor: primaryGreen,
        ),
      );
}
