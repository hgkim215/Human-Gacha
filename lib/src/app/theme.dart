import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 등급별 색상
class GradeColors {
  const GradeColors._();

  static const n = Color(0xFF9E9E9E);
  static const r = Color(0xFF66BB6A);
  static const sr = Color(0xFF42A5F5);
  static const ssr = Color(0xFFAB47BC);
  static const ur = Color(0xFFFF7043);
  static const legend = Color(0xFFFFD700);

  static const gradientSr = LinearGradient(
    colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientSsr = LinearGradient(
    colors: [Color(0xFF6A1B9A), Color(0xFFCE93D8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientLegend = LinearGradient(
    colors: [Color(0xFFFF8F00), Color(0xFFFFD700), Color(0xFFFFF9C4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// 앱 전체 다크 테마
ThemeData buildAppTheme() {
  const background = Color(0xFF0D0D14);
  const surface = Color(0xFF1A1A2E);
  const surfaceVariant = Color(0xFF16213E);
  const onBackground = Color(0xFFF0F0F8);
  const primary = Color(0xFF7B61FF);
  const primaryVariant = Color(0xFF9D8BFF);

  final base = ThemeData.dark();

  return base.copyWith(
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: primaryVariant,
      surface: surface,
      onSurface: onBackground,
      error: Color(0xFFFF6B6B),
    ),
    textTheme: GoogleFonts.notoSansKrTextTheme(base.textTheme).copyWith(
      displayLarge: GoogleFonts.notoSansKr(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: onBackground,
      ),
      displayMedium: GoogleFonts.notoSansKr(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: onBackground,
      ),
      titleLarge: GoogleFonts.notoSansKr(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: onBackground,
      ),
      titleMedium: GoogleFonts.notoSansKr(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: onBackground,
      ),
      bodyLarge: GoogleFonts.notoSansKr(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: onBackground,
      ),
      bodyMedium: GoogleFonts.notoSansKr(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFFB0B0C8),
      ),
      labelLarge: GoogleFonts.notoSansKr(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: onBackground,
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceVariant,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: GoogleFonts.notoSansKr(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryVariant,
        side: const BorderSide(color: primary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        textStyle: GoogleFonts.notoSansKr(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceVariant,
      selectedColor: primary.withOpacity(0.3),
      side: const BorderSide(color: Color(0xFF3A3A5C), width: 1),
      labelStyle: GoogleFonts.notoSansKr(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: onBackground,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      titleTextStyle: GoogleFonts.notoSansKr(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: onBackground,
      ),
      iconTheme: const IconThemeData(color: onBackground),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: primary,
      unselectedLabelColor: const Color(0xFF6B6B8A),
      indicatorColor: primary,
      labelStyle: GoogleFonts.notoSansKr(fontWeight: FontWeight.w700),
      unselectedLabelStyle: GoogleFonts.notoSansKr(fontWeight: FontWeight.w500),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surface,
      selectedItemColor: primary,
      unselectedItemColor: Color(0xFF6B6B8A),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF2A2A45),
      thickness: 1,
    ),
  );
}
