import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/mock_data.dart';
import 'widgets/comparison_chart.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final benchmark = MockData.benchmarkData;

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
                  Text('비교 분석', style: AppTextStyles.headline),
                  const SizedBox(height: 8),
                  Text(
                    benchmark.contentTitle,
                    style: AppTextStyles.caption,
                  ),
                  const SizedBox(height: 24),
                  ComparisonChart(
                    title: '클릭률 비교',
                    myValue: benchmark.myClickRate,
                    avgValue: benchmark.avgClickRate,
                    top10Value: benchmark.top10ClickRate,
                  ),
                  const SizedBox(height: 16),
                  ComparisonChart(
                    title: '예약률 비교',
                    myValue: benchmark.myBookingRate,
                    avgValue: benchmark.avgBookingRate,
                    top10Value: benchmark.top10BookingRate,
                  ),
                  const SizedBox(height: 24),
                  _buildInsightsSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInsightsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('인사이트', style: AppTextStyles.title),
            const SizedBox(height: 16),
            _buildInsightItem(
              Icons.thumb_up,
              '강점',
              '취소율이 평균 대비 78% 낮습니다',
              AppColors.statusGood,
            ),
            const SizedBox(height: 12),
            _buildInsightItem(
              Icons.warning_amber,
              '약점',
              '클릭률이 평균 대비 66% 낮습니다',
              AppColors.statusCritical,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightItem(
    IconData icon,
    String label,
    String description,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(description, style: AppTextStyles.caption),
            ],
          ),
        ),
      ],
    );
  }
}
