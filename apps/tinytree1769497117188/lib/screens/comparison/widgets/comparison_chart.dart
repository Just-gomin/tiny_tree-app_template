import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ComparisonChart extends StatelessWidget {
  final String title;
  final double myValue;
  final double avgValue;
  final double top10Value;

  const ComparisonChart({
    super.key,
    required this.title,
    required this.myValue,
    required this.avgValue,
    required this.top10Value,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = [myValue, avgValue, top10Value].reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.title),
            const SizedBox(height: 24),
            _buildBar('내 콘텐츠', myValue, AppColors.primaryBlue, maxValue),
            const SizedBox(height: 16),
            _buildBar('카테고리 평균', avgValue, AppColors.textGray, maxValue),
            const SizedBox(height: 16),
            _buildBar('상위 10%', top10Value, AppColors.statusGood, maxValue),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(String label, double value, Color color, double maxValue) {
    final percentage = maxValue > 0 ? (value / maxValue) : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.body),
            Text(
              '${value.toStringAsFixed(1)}%',
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage.toDouble(),
            backgroundColor: AppColors.borderGray,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 12,
          ),
        ),
      ],
    );
  }
}
