import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_system/design_tokens.dart';

class ModernContentCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final Widget? image;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool isCircular;
  final List<String>? tags;
  final Widget? badge;

  const ModernContentCard({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.image,
    this.onTap,
    this.width,
    this.height = 200,
    this.isCircular = false,
    this.tags,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: isCircular
              ? MemoryHubBorderRadius.fullRadius
              : MemoryHubBorderRadius.lgRadius,
          border: Border.all(
            color: isDark ? MemoryHubColors.darkBorder : MemoryHubColors.gray200,
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildImage(context),
            _buildGradientOverlay(),
            _buildContent(context),
            if (badge != null)
              Positioned(
                top: 12,
                right: 12,
                child: badge!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (image != null) {
      return image!;
    }

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder(context);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder(context);
        },
      );
    }

    return _buildPlaceholder(context);
  }

  Widget _buildPlaceholder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark
          ? MemoryHubColors.darkSurfaceElevated
          : MemoryHubColors.gray100,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: isDark
              ? MemoryHubColors.textDarkTertiary
              : MemoryHubColors.gray400,
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.6),
          ],
          stops: const [0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Positioned(
      left: 12,
      right: 12,
      bottom: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (tags != null && tags!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: tags!.take(2).map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: MemoryHubBorderRadius.smRadius,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      tag,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                subtitle!,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.white.withOpacity(0.9),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

class CircularContentCard extends StatelessWidget {
  final String label;
  final String? imageUrl;
  final Widget? image;
  final VoidCallback? onTap;
  final double size;
  final Widget? badge;

  const CircularContentCard({
    super.key,
    required this.label,
    this.imageUrl,
    this.image,
    this.onTap,
    this.size = 80,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark
                          ? MemoryHubColors.darkBorder
                          : MemoryHubColors.gray200,
                      width: 2,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: image ??
                      (imageUrl != null && imageUrl!.isNotEmpty
                          ? Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildPlaceholder(context);
                              },
                            )
                          : _buildPlaceholder(context)),
                ),
                if (badge != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: badge!,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? MemoryHubColors.textDarkPrimary
                    : MemoryHubColors.gray900,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark
          ? MemoryHubColors.darkSurfaceElevated
          : MemoryHubColors.gray100,
      child: Center(
        child: Icon(
          Icons.person,
          size: size * 0.4,
          color: isDark
              ? MemoryHubColors.textDarkTertiary
              : MemoryHubColors.gray400,
        ),
      ),
    );
  }
}
