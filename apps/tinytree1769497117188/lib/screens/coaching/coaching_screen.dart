import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/mock_data.dart';
import '../../models/coaching_feedback.dart';
import 'widgets/action_item_tile.dart';

class CoachingScreen extends StatefulWidget {
  const CoachingScreen({super.key});

  @override
  State<CoachingScreen> createState() => _CoachingScreenState();
}

class _CoachingScreenState extends State<CoachingScreen> {
  late List<ActionItem> _actions;

  @override
  void initState() {
    super.initState();
    _actions = List.from(MockData.coachingFeedback.actions);
  }

  @override
  Widget build(BuildContext context) {
    final feedback = MockData.coachingFeedback;

    return Scaffold(
      appBar: AppBar(
        title: Text('AI 코칭', style: AppTextStyles.title),
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
      ),
      body: LayoutBuilder(
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
                    Text('진단 결과', style: AppTextStyles.headline),
                    const SizedBox(height: 16),
                    _buildDiagnosisSection(feedback),
                    const SizedBox(height: 24),
                    Text('개선 액션 아이템', style: AppTextStyles.title),
                    const SizedBox(height: 16),
                    _buildActionItems(isDesktop),
                    const SizedBox(height: 24),
                    _buildExpectedImpact(feedback),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDiagnosisSection(CoachingFeedback feedback) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber, color: AppColors.statusWarning),
                const SizedBox(width: 8),
                Text('문제 분석', style: AppTextStyles.title),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              feedback.diagnosis,
              style: AppTextStyles.body,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItems(bool isDesktop) {
    if (isDesktop) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.5,
        ),
        itemCount: _actions.length,
        itemBuilder: (context, index) {
          return ActionItemTile(
            item: _actions[index],
            onChanged: (value) {
              setState(() {
                _actions[index].isCompleted = value ?? false;
              });
            },
          );
        },
      );
    } else {
      return Column(
        children: _actions.map((action) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ActionItemTile(
              item: action,
              onChanged: (value) {
                setState(() {
                  action.isCompleted = value ?? false;
                });
              },
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildExpectedImpact(CoachingFeedback feedback) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.statusGood.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.statusGood),
      ),
      child: Row(
        children: [
          const Icon(Icons.trending_up, color: AppColors.statusGood),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feedback.expectedImpact,
              style: AppTextStyles.body.copyWith(
                color: AppColors.statusGood,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
