import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/performance_metrics.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final HealthStatus status;
  final PerformanceTrend trend;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.status,
    required this.trend,
  });

  Color _getStatusColor() {
    switch (status) {
      case HealthStatus.good:
        return AppColors.statusGood;
      case HealthStatus.warning:
        return AppColors.statusWarning;
      case HealthStatus.critical:
        return AppColors.statusCritical;
    }
  }

  IconData _getTrendIcon() {
    switch (trend) {
      case PerformanceTrend.up:
        return Icons.trending_up;
      case PerformanceTrend.stable:
        return Icons.trending_flat;
      case PerformanceTrend.down:
        return Icons.trending_down;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.caption),
                Icon(_getTrendIcon(), color: statusColor, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: AppTextStyles.metric.copyWith(color: statusColor),
            ),
          ],
        ),
      ),
    );
  }
}
