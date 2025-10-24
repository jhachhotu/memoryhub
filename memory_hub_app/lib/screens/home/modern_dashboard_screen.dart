import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../design_system/design_tokens.dart';
import '../../widgets/section_header.dart';
import '../../widgets/modern_content_card.dart';
import '../../widgets/horizontal_scroll_section.dart';
import '../../widgets/modern_button.dart';
import '../memories/memory_create_screen.dart';
import '../memories/memories_list_screen.dart';
import '../collections/collections_screen.dart';
import '../family/modern_family_hub_screen.dart';
import '../vault/vault_list_screen.dart';
import '../analytics/analytics_screen.dart';
import '../notifications/notifications_screen.dart';
import '../../services/dashboard_service.dart';
import '../../services/analytics_service.dart';

class ModernDashboardScreen extends StatefulWidget {
  const ModernDashboardScreen({super.key});

  @override
  State<ModernDashboardScreen> createState() => _ModernDashboardScreenState();
}

class _ModernDashboardScreenState extends State<ModernDashboardScreen> {
  bool _isLoading = true;
  String _error = '';
  Map<String, dynamic> _stats = {};
  List<Map<String, dynamic>> _recentMemories = [];
  List<Map<String, dynamic>> _recentCollections = [];
  
  final DashboardService _dashboardService = DashboardService();
  final AnalyticsService _analyticsService = AnalyticsService();

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });
    
    try {
      final statsData = await _analyticsService.getOverview();
      final activityData = await _dashboardService.getRecentActivity(limit: 10);
      
      setState(() {
        _stats = statsData;
        _recentMemories = activityData
            .where((a) => a['type'] == 'memory' || a['type'] == 'memory_created')
            .take(5)
            .map((m) => m as Map<String, dynamic>)
            .toList();
        _recentCollections = activityData
            .where((a) => a['type'] == 'collection' || a['type'] == 'collection_created')
            .take(5)
            .map((c) => c as Map<String, dynamic>)
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
        _stats = {
          'total_memories': 0,
          'total_files': 0,
          'total_collections': 0,
        };
      });
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadDashboardData,
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildGreetingSection(),
                  const SizedBox(height: 32),
                  if (_isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else ...[
                    _buildFeaturedSection(),
                    const SizedBox(height: 32),
                    _buildRecentMemoriesSection(),
                    const SizedBox(height: 32),
                    _buildQuickActionsSection(),
                    const SizedBox(height: 32),
                    _buildCollectionsSection(),
                    const SizedBox(height: 32),
                    _buildStatsSection(),
                    const SizedBox(height: 32),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MemoryCreateScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: Text(
          'New Memory',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
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
      title: Text(
        'Memory Hub',
        style: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded),
          onPressed: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildGreetingSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getGreeting(),
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? MemoryHubColors.textDarkSecondary
                  : MemoryHubColors.gray600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Welcome back',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? MemoryHubColors.textDarkPrimary
                  : MemoryHubColors.gray900,
              letterSpacing: -1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 320,
        decoration: BoxDecoration(
          borderRadius: MemoryHubBorderRadius.xlRadius,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              MemoryHubColors.purple600,
              MemoryHubColors.indigo600,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -50,
              bottom: -50,
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 200,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: MemoryHubBorderRadius.smRadius,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      'Memories & Collections',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Capture Your\nPrecious Moments',
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
                    'Create, organize, and share your memories with\nfamily and friends',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      ModernPlayButton(
                        label: 'Create Memory',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MemoryCreateScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      ModernActionButton(
                        label: 'Browse',
                        icon: Icons.grid_view_rounded,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MemoriesListScreen(),
                            ),
                          );
                        },
                        isOutlined: true,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentMemoriesSection() {
    if (_recentMemories.isEmpty) {
      return const SizedBox.shrink();
    }

    return HorizontalScrollSection(
      title: 'Recent Memories',
      actionText: 'See all',
      onActionTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MemoriesListScreen(),
          ),
        );
      },
      height: 220,
      children: _recentMemories.map((memory) {
        return ModernContentCard(
          width: 160,
          title: memory['title'] ?? 'Memory',
          subtitle: memory['description'] ?? '',
          tags: memory['tags'] != null
              ? (memory['tags'] as List).map((t) => t.toString()).toList()
              : null,
          onTap: () {
            if (memory['id'] != null) {
              Navigator.pushNamed(
                context,
                '/memories/detail',
                arguments: memory['id'],
              );
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildQuickActionsSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final actions = [
      {
        'icon': Icons.photo_library_rounded,
        'label': 'Memories',
        'color': MemoryHubColors.purple500,
        'route': '/memories',
      },
      {
        'icon': Icons.collections_bookmark_rounded,
        'label': 'Collections',
        'color': MemoryHubColors.indigo500,
        'route': '/collections',
      },
      {
        'icon': Icons.family_restroom_rounded,
        'label': 'Family Hub',
        'color': MemoryHubColors.pink500,
        'route': null,
        'screen': const ModernFamilyHubScreen(),
      },
      {
        'icon': Icons.folder_rounded,
        'label': 'Vault',
        'color': MemoryHubColors.teal500,
        'route': '/vault',
      },
      {
        'icon': Icons.analytics_rounded,
        'label': 'Analytics',
        'color': MemoryHubColors.amber500,
        'route': '/analytics',
      },
      {
        'icon': Icons.search_rounded,
        'label': 'Search',
        'color': MemoryHubColors.cyan500,
        'route': '/search',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Quick Actions',
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
              childAspectRatio: 1,
            ),
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              return GestureDetector(
                onTap: () {
                  if (action['screen'] != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => action['screen'] as Widget,
                      ),
                    );
                  } else if (action['route'] != null) {
                    Navigator.pushNamed(context, action['route'] as String);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? MemoryHubColors.darkSurface
                        : Colors.white,
                    border: Border.all(
                      color: isDark
                          ? MemoryHubColors.darkBorder
                          : MemoryHubColors.gray200,
                    ),
                    borderRadius: MemoryHubBorderRadius.lgRadius,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: (action['color'] as Color).withOpacity(0.1),
                          borderRadius: MemoryHubBorderRadius.mdRadius,
                        ),
                        child: Icon(
                          action['icon'] as IconData,
                          color: action['color'] as Color,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        action['label'] as String,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? MemoryHubColors.textDarkPrimary
                              : MemoryHubColors.gray900,
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

  Widget _buildCollectionsSection() {
    if (_recentCollections.isEmpty) {
      return const SizedBox.shrink();
    }

    return HorizontalScrollSection(
      title: 'Your Collections',
      actionText: 'See all',
      onActionTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CollectionsScreen(),
          ),
        );
      },
      height: 180,
      children: _recentCollections.map((collection) {
        return ModernContentCard(
          width: 140,
          height: 180,
          title: collection['title'] ?? 'Collection',
          subtitle: '${collection['count'] ?? 0} items',
          onTap: () {
            if (collection['id'] != null) {
              Navigator.pushNamed(
                context,
                '/collections/detail',
                arguments: collection['id'],
              );
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildStatsSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final statsList = [
      {
        'icon': Icons.auto_awesome_rounded,
        'label': 'Memories',
        'value': _stats['total_memories'] ?? _stats['memories'] ?? 0,
        'color': MemoryHubColors.purple500,
      },
      {
        'icon': Icons.collections_bookmark_rounded,
        'label': 'Collections',
        'value': _stats['total_collections'] ?? _stats['collections'] ?? 0,
        'color': MemoryHubColors.indigo500,
      },
      {
        'icon': Icons.folder_rounded,
        'label': 'Files',
        'value': _stats['total_files'] ?? _stats['files'] ?? 0,
        'color': MemoryHubColors.teal500,
      },
      {
        'icon': Icons.people_rounded,
        'label': 'Followers',
        'value': _stats['total_followers'] ?? _stats['followers'] ?? 0,
        'color': MemoryHubColors.pink500,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Your Stats',
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
            itemCount: statsList.length,
            itemBuilder: (context, index) {
              final stat = statsList[index];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark
                      ? MemoryHubColors.darkSurface
                      : Colors.white,
                  border: Border.all(
                    color: isDark
                        ? MemoryHubColors.darkBorder
                        : MemoryHubColors.gray200,
                  ),
                  borderRadius: MemoryHubBorderRadius.lgRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: (stat['color'] as Color).withOpacity(0.1),
                            borderRadius: MemoryHubBorderRadius.mdRadius,
                          ),
                          child: Icon(
                            stat['icon'] as IconData,
                            color: stat['color'] as Color,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${stat['value']}',
                          style: GoogleFonts.inter(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? MemoryHubColors.textDarkPrimary
                                : MemoryHubColors.gray900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          stat['label'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: isDark
                                ? MemoryHubColors.textDarkSecondary
                                : MemoryHubColors.gray600,
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
}
