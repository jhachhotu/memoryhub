import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_system/design_tokens.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: MemoryHubColors.indigo500,
      brightness: Brightness.light,
      primary: MemoryHubColors.indigo500,
      secondary: MemoryHubColors.pink500,
      tertiary: MemoryHubColors.purple500,
      error: MemoryHubColors.red500,
      surface: Colors.white,
      surfaceContainerHighest: MemoryHubColors.gray50,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: MemoryHubColors.gray50,
      
      textTheme: _buildTextTheme(Brightness.light),
      
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: MemoryHubElevation.none,
        scrolledUnderElevation: MemoryHubElevation.none,
        backgroundColor: Colors.transparent,
        foregroundColor: MemoryHubColors.gray900,
        titleTextStyle: GoogleFonts.inter(
          fontSize: MemoryHubTypography.h3,
          fontWeight: MemoryHubTypography.bold,
          color: MemoryHubColors.gray900,
        ),
        iconTheme: const IconThemeData(
          color: MemoryHubColors.gray900,
          size: 24,
        ),
      ),
      
      cardTheme: CardThemeData(
        elevation: MemoryHubElevation.sm,
        shadowColor: MemoryHubColors.gray900.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: MemoryHubBorderRadius.xlRadius,
        ),
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: MemoryHubElevation.none,
          padding: const EdgeInsets.symmetric(
            vertical: MemoryHubSpacing.lg,
            horizontal: MemoryHubSpacing.xxl,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: MemoryHubBorderRadius.lgRadius,
          ),
          backgroundColor: MemoryHubColors.indigo500,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.inter(
            fontSize: MemoryHubTypography.bodyLarge,
            fontWeight: MemoryHubTypography.semiBold,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: MemoryHubSpacing.lg,
            horizontal: MemoryHubSpacing.xxl,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: MemoryHubBorderRadius.lgRadius,
          ),
          side: const BorderSide(
            color: MemoryHubColors.indigo500,
            width: 2,
          ),
          foregroundColor: MemoryHubColors.indigo500,
          textStyle: GoogleFonts.inter(
            fontSize: MemoryHubTypography.bodyLarge,
            fontWeight: MemoryHubTypography.semiBold,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: MemoryHubSpacing.md,
            horizontal: MemoryHubSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: MemoryHubBorderRadius.mdRadius,
          ),
          foregroundColor: MemoryHubColors.indigo500,
          textStyle: GoogleFonts.inter(
            fontSize: MemoryHubTypography.bodyMedium,
            fontWeight: MemoryHubTypography.semiBold,
          ),
        ),
      ),
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: MemoryHubColors.pink500,
        foregroundColor: Colors.white,
        elevation: MemoryHubElevation.md,
        shape: RoundedRectangleBorder(
          borderRadius: MemoryHubBorderRadius.lgRadius,
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: MemoryHubBorderRadius.lgRadius,
          borderSide: const BorderSide(color: MemoryHubColors.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: MemoryHubBorderRadius.lgRadius,
          borderSide: const BorderSide(color: MemoryHubColors.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: MemoryHubBorderRadius.lgRadius,
          borderSide: const BorderSide(
            width: 2,
            color: MemoryHubColors.indigo500,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: MemoryHubBorderRadius.lgRadius,
          borderSide: const BorderSide(color: MemoryHubColors.red500),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: MemoryHubBorderRadius.lgRadius,
          borderSide: const BorderSide(
            width: 2,
            color: MemoryHubColors.red500,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: MemoryHubSpacing.xl,
          vertical: MemoryHubSpacing.lg,
        ),
        hintStyle: GoogleFonts.inter(
          color: MemoryHubColors.gray400,
          fontSize: MemoryHubTypography.bodyMedium,
        ),
      ),
      
      chipTheme: ChipThemeData(
        backgroundColor: MemoryHubColors.gray100,
        labelStyle: GoogleFonts.inter(
          fontSize: MemoryHubTypography.bodySmall,
          fontWeight: MemoryHubTypography.medium,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: MemoryHubSpacing.md,
          vertical: MemoryHubSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: MemoryHubBorderRadius.mdRadius,
        ),
      ),
      
      dividerTheme: const DividerThemeData(
        color: MemoryHubColors.gray100,
        thickness: 1,
        space: 1,
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: MemoryHubColors.indigo500,
        unselectedItemColor: MemoryHubColors.gray400,
        type: BottomNavigationBarType.fixed,
        elevation: MemoryHubElevation.lg,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: MemoryHubTypography.caption,
          fontWeight: MemoryHubTypography.semiBold,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: MemoryHubTypography.caption,
          fontWeight: MemoryHubTypography.medium,
        ),
      ),
      
      snackBarTheme: SnackBarThemeData(
        backgroundColor: MemoryHubColors.gray800,
        contentTextStyle: GoogleFonts.inter(
          color: Colors.white,
          fontSize: MemoryHubTypography.bodyMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: MemoryHubBorderRadius.mdRadius,
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        elevation: MemoryHubElevation.xxl,
        shape: RoundedRectangleBorder(
          borderRadius: MemoryHubBorderRadius.xxlRadius,
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: MemoryHubTypography.h3,
          fontWeight: MemoryHubTypography.bold,
          color: MemoryHubColors.gray900,
        ),
      ),
      
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: MemoryHubColors.indigo500,
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: MemoryHubColors.accentGreen,
      brightness: Brightness.dark,
      primary: MemoryHubColors.accentGreen,
      secondary: MemoryHubColors.accentPurpleLight,
      tertiary: MemoryHubColors.accentPinkLight,
      error: MemoryHubColors.red400,
      surface: MemoryHubColors.darkSurface,
      surfaceContainerHighest: MemoryHubColors.darkSurfaceElevated,
      outline: MemoryHubColors.darkBorder,
      shadow: Colors.black,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: MemoryHubColors.darkBackground,
      
      textTheme: _buildTextTheme(Brightness.dark),
      
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: MemoryHubElevation.none,
        scrolledUnderElevation: MemoryHubElevation.none,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.inter(
          fontSize: MemoryHubTypography.h3,
          fontWeight: MemoryHubTypography.bold,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 24,
        ),
      ),
      
      cardTheme: CardThemeData(
        elevation: MemoryHubElevation.none,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: MemoryHubBorderRadius.lgRadius,
          side: BorderSide(
            color: MemoryHubColors.darkBorder,
            width: 1,
          ),
        ),
        color: MemoryHubColors.darkSurface,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: MemoryHubElevation.none,
          padding: const EdgeInsets.symmetric(
            vertical: MemoryHubSpacing.lg,
            horizontal: MemoryHubSpacing.xxl,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: MemoryHubBorderRadius.mdRadius,
          ),
          backgroundColor: MemoryHubColors.accentGreen,
          foregroundColor: Colors.black,
          textStyle: GoogleFonts.inter(
            fontSize: MemoryHubTypography.bodyLarge,
            fontWeight: MemoryHubTypography.semiBold,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: MemoryHubSpacing.lg,
            horizontal: MemoryHubSpacing.xxl,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: MemoryHubBorderRadius.mdRadius,
          ),
          side: const BorderSide(
            color: MemoryHubColors.darkBorder,
            width: 1,
          ),
          foregroundColor: MemoryHubColors.textDarkPrimary,
          textStyle: GoogleFonts.inter(
            fontSize: MemoryHubTypography.bodyLarge,
            fontWeight: MemoryHubTypography.semiBold,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: MemoryHubSpacing.md,
            horizontal: MemoryHubSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: MemoryHubBorderRadius.smRadius,
          ),
          foregroundColor: MemoryHubColors.accentGreen,
          textStyle: GoogleFonts.inter(
            fontSize: MemoryHubTypography.bodyMedium,
            fontWeight: MemoryHubTypography.semiBold,
          ),
        ),
      ),
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: MemoryHubColors.accentGreen,
        foregroundColor: Colors.black,
        elevation: MemoryHubElevation.none,
        shape: RoundedRectangleBorder(
          borderRadius: MemoryHubBorderRadius.lgRadius,
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: MemoryHubColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: MemoryHubBorderRadius.mdRadius,
          borderSide: const BorderSide(color: MemoryHubColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: MemoryHubBorderRadius.mdRadius,
          borderSide: const BorderSide(color: MemoryHubColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: MemoryHubBorderRadius.mdRadius,
          borderSide: const BorderSide(
            width: 2,
            color: MemoryHubColors.accentGreen,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: MemoryHubBorderRadius.mdRadius,
          borderSide: const BorderSide(color: MemoryHubColors.red400),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: MemoryHubBorderRadius.mdRadius,
          borderSide: const BorderSide(
            width: 2,
            color: MemoryHubColors.red400,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: MemoryHubSpacing.lg,
          vertical: MemoryHubSpacing.lg,
        ),
        hintStyle: GoogleFonts.inter(
          color: MemoryHubColors.textDarkTertiary,
          fontSize: MemoryHubTypography.bodyMedium,
        ),
      ),
      
      chipTheme: ChipThemeData(
        backgroundColor: MemoryHubColors.darkSurfaceElevated,
        labelStyle: GoogleFonts.inter(
          fontSize: MemoryHubTypography.bodySmall,
          fontWeight: MemoryHubTypography.medium,
          color: MemoryHubColors.textDarkPrimary,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: MemoryHubSpacing.md,
          vertical: MemoryHubSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: MemoryHubBorderRadius.smRadius,
          side: BorderSide(color: MemoryHubColors.darkBorder),
        ),
      ),
      
      dividerTheme: const DividerThemeData(
        color: MemoryHubColors.darkDivider,
        thickness: 1,
        space: 1,
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: MemoryHubColors.darkSurface,
        selectedItemColor: MemoryHubColors.accentGreen,
        unselectedItemColor: MemoryHubColors.textDarkTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: MemoryHubElevation.none,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: MemoryHubTypography.caption,
          fontWeight: MemoryHubTypography.semiBold,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: MemoryHubTypography.caption,
          fontWeight: MemoryHubTypography.medium,
        ),
      ),
      
      snackBarTheme: SnackBarThemeData(
        backgroundColor: MemoryHubColors.darkSurfaceElevated,
        contentTextStyle: GoogleFonts.inter(
          color: MemoryHubColors.textDarkPrimary,
          fontSize: MemoryHubTypography.bodyMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: MemoryHubBorderRadius.mdRadius,
          side: BorderSide(color: MemoryHubColors.darkBorder),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      dialogTheme: DialogThemeData(
        backgroundColor: MemoryHubColors.darkSurface,
        elevation: MemoryHubElevation.none,
        shape: RoundedRectangleBorder(
          borderRadius: MemoryHubBorderRadius.xlRadius,
          side: const BorderSide(color: MemoryHubColors.darkBorder),
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: MemoryHubTypography.h3,
          fontWeight: MemoryHubTypography.bold,
          color: MemoryHubColors.textDarkPrimary,
        ),
      ),
      
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: MemoryHubColors.accentGreen,
        linearTrackColor: MemoryHubColors.darkSurfaceElevated,
        circularTrackColor: MemoryHubColors.darkSurfaceElevated,
      ),
    );
  }

  static TextTheme _buildTextTheme(Brightness brightness) {
    final baseColor = brightness == Brightness.light
        ? MemoryHubColors.gray900
        : Colors.white;
    
    final secondaryColor = brightness == Brightness.light
        ? MemoryHubColors.gray600
        : MemoryHubColors.gray300;

    return TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: MemoryHubTypography.display1,
        fontWeight: MemoryHubTypography.bold,
        color: baseColor,
        height: 1.2,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: MemoryHubTypography.display2,
        fontWeight: MemoryHubTypography.bold,
        color: baseColor,
        height: 1.2,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: MemoryHubTypography.h1,
        fontWeight: MemoryHubTypography.bold,
        color: baseColor,
        height: 1.2,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: MemoryHubTypography.h1,
        fontWeight: MemoryHubTypography.bold,
        color: baseColor,
        height: 1.3,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: MemoryHubTypography.h2,
        fontWeight: MemoryHubTypography.bold,
        color: baseColor,
        height: 1.3,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: MemoryHubTypography.h3,
        fontWeight: MemoryHubTypography.semiBold,
        color: baseColor,
        height: 1.3,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: MemoryHubTypography.h3,
        fontWeight: MemoryHubTypography.semiBold,
        color: baseColor,
        height: 1.4,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: MemoryHubTypography.h4,
        fontWeight: MemoryHubTypography.semiBold,
        color: baseColor,
        height: 1.4,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: MemoryHubTypography.h5,
        fontWeight: MemoryHubTypography.medium,
        color: baseColor,
        height: 1.4,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: MemoryHubTypography.bodyLarge,
        fontWeight: MemoryHubTypography.regular,
        color: baseColor,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: MemoryHubTypography.bodyMedium,
        fontWeight: MemoryHubTypography.regular,
        color: baseColor,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: MemoryHubTypography.bodySmall,
        fontWeight: MemoryHubTypography.regular,
        color: secondaryColor,
        height: 1.5,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: MemoryHubTypography.bodyMedium,
        fontWeight: MemoryHubTypography.semiBold,
        color: baseColor,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: MemoryHubTypography.bodySmall,
        fontWeight: MemoryHubTypography.medium,
        color: baseColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: MemoryHubTypography.caption,
        fontWeight: MemoryHubTypography.medium,
        color: secondaryColor,
      ),
    );
  }
}
