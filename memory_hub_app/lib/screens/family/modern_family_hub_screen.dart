import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../design_system/design_tokens.dart';
import '../../widgets/section_header.dart';
import '../../widgets/modern_content_card.dart';
import '../../widgets/horizontal_scroll_section.dart';
import '../../services/family/family_service.dart';
import '../../models/family/family_timeline.dart';
import 'family_albums_screen.dart';
import 'family_calendar_screen.dart';
import 'family_milestones_screen.dart';
import 'family_recipes_screen.dart';
import 'family_timeline_screen.dart';
import 'family_traditions_screen.dart';
import 'genealogy_tree_screen.dart';
import 'health_records_screen.dart';
import 'legacy_letters_screen.dart';
import 'parental_controls_screen.dart';
import 'family_document_vault_screen.dart';

class ModernFamilyHubScreen extends StatefulWidget {
  const ModernFamilyHubScreen({super.key});

  @override
  State<ModernFamilyHubScreen> createState() => _ModernFamilyHubScreenState();
}

class _ModernFamilyHubScreenState extends State<ModernFamilyHubScreen> {
  final FamilyService _familyService = FamilyService();
  bool _isLoading = true;
  Map<String, dynamic> _dashboardData = {};
  List<TimelineEvent> _recentActivities = [];

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    setState(() => _isLoading = true);
    
    try {
      final results = await Future.wait([
        _familyService.getFamilyDashboard(),
        _familyService.getTimelineEvents(),
      ]);

      setState(() {
        _dashboardData = results[0] as Map<String, dynamic>;
        _recentActivities = (results[1] as List<TimelineEvent>).take(10).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  int _getStat(String key) {
    try {
      final stats = _dashboardData['stats'] as Map<String, dynamic>?;
      return (stats?[key] as num?)?.toInt() ?? 0;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadDashboard,
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildHeroSection(),
                  const SizedBox(height: 32),
                  if (_isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(48),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else ...[
                    _buildFamilyMembersSection(),
                    const SizedBox(height: 32),
                    _buildFeaturesGrid(),
                    const SizedBox(height: 32),
                    _buildStatsSection(),
                    const SizedBox(height: 32),
                    _buildRecentActivitySection(),
                    const SizedBox(height: 32),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MemoryHubColors.purple600,
                  MemoryHubColors.pink500,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.family_restroom_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Family Hub',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: MemoryHubColors.textDarkPrimary,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ParentalControlsScreen(),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          borderRadius: MemoryHubBorderRadius.xlRadius,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              MemoryHubColors.purple700,
              MemoryHubColors.pink500,
              MemoryHubColors.cyan500,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: MemoryHubBorderRadius.fullRadius,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              child: Text(
                '12 Features',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Your Complete\nFamily Suite',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.2,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Albums, Calendar, Recipes, Genealogy, Health Records,\nand more - all in one place',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.white.withOpacity(0.95),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilyMembersSection() {
    final members = [
      {'name': 'John', 'avatar': null, 'role': 'Parent'},
      {'name': 'Sarah', 'avatar': null, 'role': 'Parent'},
      {'name': 'Emma', 'avatar': null, 'role': 'Child'},
      {'name': 'Noah', 'avatar': null, 'role': 'Child'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Family Members',
          actionText: 'Manage',
          onActionTap: () {},
        ),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: members.length + 1,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              if (index == members.length) {
                return _buildAddMemberCard();
              }
              
              final member = members[index];
              return CircularContentCard(
                size: 70,
                label: member['name'] as String,
                onTap: () {},
                badge: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: MemoryHubColors.accentGreen,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MemoryHubColors.darkBackground,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddMemberCard() {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: MemoryHubColors.darkBorder,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.add_rounded,
                color: MemoryHubColors.textDarkSecondary,
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: MemoryHubColors.textDarkPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesGrid() {
    final features = [
      {
        'icon': Icons.photo_library_rounded,
        'label': 'Albums',
        'color': MemoryHubColors.purple500,
        'screen': const FamilyAlbumsScreen(),
      },
      {
        'icon': Icons.calendar_month_rounded,
        'label': 'Calendar',
        'color': MemoryHubColors.cyan500,
        'screen': const FamilyCalendarScreen(),
      },
      {
        'icon': Icons.stars_rounded,
        'label': 'Milestones',
        'color': MemoryHubColors.amber500,
        'screen': const FamilyMilestonesScreen(),
      },
      {
        'icon': Icons.restaurant_rounded,
        'label': 'Recipes',
        'color': MemoryHubColors.red500,
        'screen': const FamilyRecipesScreen(),
      },
      {
        'icon': Icons.timeline_rounded,
        'label': 'Timeline',
        'color': MemoryHubColors.indigo500,
        'screen': const FamilyTimelineScreen(),
      },
      {
        'icon': Icons.celebration_rounded,
        'label': 'Traditions',
        'color': MemoryHubColors.pink500,
        'screen': const FamilyTraditionsScreen(),
      },
      {
        'icon': Icons.account_tree_rounded,
        'label': 'Genealogy',
        'color': MemoryHubColors.teal500,
        'screen': const GenealogyTreeScreen(),
      },
      {
        'icon': Icons.favorite_rounded,
        'label': 'Health',
        'color': MemoryHubColors.red400,
        'screen': const HealthRecordsScreen(),
      },
      {
        'icon': Icons.mail_rounded,
        'label': 'Letters',
        'color': MemoryHubColors.purple400,
        'screen': const LegacyLettersScreen(),
      },
      {
        'icon': Icons.folder_special_rounded,
        'label': 'Vault',
        'color': MemoryHubColors.green500,
        'screen': const FamilyDocumentVaultScreen(),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'All Features',
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.95,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => feature['screen'] as Widget,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: MemoryHubColors.darkSurface,
                    border: Border.all(
                      color: MemoryHubColors.darkBorder,
                    ),
                    borderRadius: MemoryHubBorderRadius.lgRadius,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: (feature['color'] as Color).withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          feature['icon'] as IconData,
                          color: feature['color'] as Color,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        feature['label'] as String,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: MemoryHubColors.textDarkPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    final stats = [
      {
        'icon': Icons.photo_library_rounded,
        'label': 'Albums',
        'value': _getStat('albums'),
        'color': MemoryHubColors.purple500,
      },
      {
        'icon': Icons.event_rounded,
        'label': 'Events',
        'value': _getStat('upcoming_events'),
        'color': MemoryHubColors.cyan500,
      },
      {
        'icon': Icons.stars_rounded,
        'label': 'Milestones',
        'value': _getStat('milestones'),
        'color': MemoryHubColors.amber500,
      },
      {
        'icon': Icons.restaurant_rounded,
        'label': 'Recipes',
        'value': _getStat('recipes'),
        'color': MemoryHubColors.red500,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Family Stats',
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: stats.length,
            itemBuilder: (context, index) {
              final stat = stats[index];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: MemoryHubColors.darkSurface,
                  border: Border.all(
                    color: MemoryHubColors.darkBorder,
                  ),
                  borderRadius: MemoryHubBorderRadius.lgRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (stat['color'] as Color).withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        stat['icon'] as IconData,
                        color: stat['color'] as Color,
                        size: 24,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${stat['value']}',
                          style: GoogleFonts.inter(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: MemoryHubColors.textDarkPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          stat['label'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: MemoryHubColors.textDarkSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivitySection() {
    if (_recentActivities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Recent Activity',
          actionText: 'View All',
          onActionTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FamilyTimelineScreen(),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _recentActivities.take(5).length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final activity = _recentActivities[index];
              return _buildActivityCard(activity);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActivityCard(TimelineEvent activity) {
    final icons = {
      'album': Icons.photo_library_rounded,
      'event': Icons.event_rounded,
      'milestone': Icons.stars_rounded,
      'recipe': Icons.restaurant_rounded,
    };

    final colors = {
      'album': MemoryHubColors.purple500,
      'event': MemoryHubColors.cyan500,
      'milestone': MemoryHubColors.amber500,
      'recipe': MemoryHubColors.red500,
    };

    final icon = icons[activity.eventType] ?? Icons.circle_rounded;
    final color = colors[activity.eventType] ?? MemoryHubColors.indigo500;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MemoryHubColors.darkSurface,
        border: Border.all(
          color: MemoryHubColors.darkBorder,
        ),
        borderRadius: MemoryHubBorderRadius.lgRadius,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: MemoryHubColors.textDarkPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  activity.description ?? 'No description',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: MemoryHubColors.textDarkSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            _formatTime(activity.createdAt),
            style: GoogleFonts.inter(
              fontSize: 12,
              color: MemoryHubColors.textDarkTertiary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '${(difference.inDays / 7).floor()}w';
    }
  }
}
