import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_system/design_tokens.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
    this.trailing,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 20, right: 20, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? MemoryHubColors.textDarkPrimary
                    : MemoryHubColors.gray900,
                letterSpacing: -0.5,
              ),
            ),
          ),
          if (trailing != null)
            trailing!
          else if (actionText != null && onActionTap != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText!,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? MemoryHubColors.accentGreen
                      : MemoryHubColors.indigo500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
