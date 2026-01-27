import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/mock_data.dart';
import '../../models/performance_metrics.dart';
import '../coaching/coaching_screen.dart';
import '../comparison/comparison_screen.dart';
import 'widgets/metric_card.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final _screens = [
    const _DashboardContent(),
    const ComparisonScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Growth Coach', style: AppTextStyles.title),
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: '대시보드',
          ),
          NavigationDestination(
            icon: Icon(Icons.compare_arrows),
            label: '비교',
          ),
        ],
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    final metrics = MockData.performanceMetrics;
    final numberFormat = NumberFormat('#,###');

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 600;
        final maxWidth = isDesktop ? 1000.0 : double.infinity;
        final padding = isDesktop ? 32.0 : 16.0;

        return Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            padding: EdgeInsets.all(padding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('성과 대시보드', style: AppTextStyles.headline),
                  const SizedBox(height: 24),
                  _buildMetricsGrid(metrics, numberFormat, isDesktop),
                  const SizedBox(height: 24),
                  _buildCoachingButton(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMetricsGrid(
    PerformanceMetrics metrics,
    NumberFormat numberFormat,
    bool isDesktop,
  ) {
    final cards = [
      MetricCard(
        title: '노출수',
        value: numberFormat.format(metrics.views),
        status: HealthStatus.good,
        trend: metrics.trend,
      ),
      MetricCard(
        title: '클릭률',
        value: '${metrics.clickRate}%',
        status: metrics.status,
        trend: metrics.trend,
      ),
      MetricCard(
        title: '예약률',
        value: '${metrics.bookingRate}%',
        status: HealthStatus.warning,
        trend: metrics.trend,
      ),
      MetricCard(
        title: '취소율',
        value: '${metrics.cancellationRate}%',
        status: HealthStatus.good,
        trend: PerformanceTrend.stable,
      ),
    ];

    if (isDesktop) {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
        children: cards,
      );
    } else {
      return Column(
        children: cards
            .map((card) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: card,
                ))
            .toList(),
      );
    }
  }

  Widget _buildCoachingButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accentYellow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            '⚠️ 클릭률이 평균 대비 66% 낮습니다',
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CoachingScreen(),
                ),
              );
            },
            child: const Text('AI 코칭 받기'),
          ),
        ],
      ),
    );
  }
}
