import 'package:flutter/material.dart';
import 'section_header.dart';

class HorizontalScrollSection extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final List<Widget> children;
  final double itemSpacing;
  final EdgeInsetsGeometry? padding;
  final double height;

  const HorizontalScrollSection({
    super.key,
    required this.title,
    required this.children,
    this.actionText = 'See all',
    this.onActionTap,
    this.itemSpacing = 12,
    this.padding,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionHeader(
          title: title,
          actionText: actionText,
          onActionTap: onActionTap,
          padding: padding,
        ),
        SizedBox(
          height: height,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
            itemCount: children.length,
            separatorBuilder: (context, index) => SizedBox(width: itemSpacing),
            itemBuilder: (context, index) => children[index],
          ),
        ),
      ],
    );
  }
}

class GridScrollSection extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final EdgeInsetsGeometry? padding;

  const GridScrollSection({
    super.key,
    required this.title,
    required this.children,
    this.actionText = 'See all',
    this.onActionTap,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 12,
    this.crossAxisSpacing = 12,
    this.childAspectRatio = 0.7,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionHeader(
          title: title,
          actionText: actionText,
          onActionTap: onActionTap,
          padding: padding,
        ),
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: children.length,
            itemBuilder: (context, index) => children[index],
          ),
        ),
      ],
    );
  }
}
