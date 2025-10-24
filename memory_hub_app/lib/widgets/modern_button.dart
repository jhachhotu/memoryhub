import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_system/design_tokens.dart';

class ModernPlayButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double size;

  const ModernPlayButton({
    super.key,
    required this.label,
    required this.onTap,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: MemoryHubColors.accentGreen,
          borderRadius: MemoryHubBorderRadius.mdRadius,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.play_arrow_rounded,
              color: Colors.black,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModernActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isOutlined;

  const ModernActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = backgroundColor ??
        (isDark ? MemoryHubColors.darkSurface : Colors.white);
    final fgColor = foregroundColor ??
        (isDark
            ? MemoryHubColors.textDarkPrimary
            : MemoryHubColors.gray900);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : bgColor,
          border: Border.all(
            color: isDark
                ? MemoryHubColors.darkBorder
                : MemoryHubColors.gray200,
            width: 1,
          ),
          borderRadius: MemoryHubBorderRadius.mdRadius,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: fgColor, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: fgColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
