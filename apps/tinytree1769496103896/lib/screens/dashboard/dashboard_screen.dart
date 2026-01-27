import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/inquiry_model.dart';
import 'widgets/inquiry_card.dart';

class DashboardScreen extends StatelessWidget {
  final List<Inquiry> inquiries;
  final Function(Inquiry) onInquiryTap;

  const DashboardScreen({
    super.key,
    required this.inquiries,
    required this.onInquiryTap,
  });

  @override
  Widget build(BuildContext context) {
    final int pendingCount = inquiries.where((i) => i.status == InquiryStatus.pending).length;

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.backgroundWhite,
        title: Text('대시보드', style: AppTextStyles.headline.copyWith(color: AppColors.backgroundWhite)),
        actions: [
          if (pendingCount > 0)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryRed,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '$pendingCount개 대기중',
                style: AppTextStyles.caption.copyWith(color: AppColors.backgroundWhite),
              ),
            ),
        ],
      ),
      body: inquiries.isEmpty
          ? Center(
              child: Text(
                '문의가 없습니다',
                style: AppTextStyles.body,
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                final bool isWide = constraints.maxWidth >= 600;
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: isWide ? 24 : 0,
                      ),
                      itemCount: inquiries.length,
                      itemBuilder: (context, index) {
                        final Inquiry inquiry = inquiries[index];
                        return InquiryCard(
                          inquiry: inquiry,
                          onTap: () => onInquiryTap(inquiry),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
