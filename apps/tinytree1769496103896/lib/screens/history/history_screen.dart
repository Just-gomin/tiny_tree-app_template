import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/inquiry_model.dart';

class HistoryScreen extends StatelessWidget {
  final List<Inquiry> inquiries;

  const HistoryScreen({
    super.key,
    required this.inquiries,
  });

  @override
  Widget build(BuildContext context) {
    final List<Inquiry> completedInquiries = inquiries
        .where((i) => i.status == InquiryStatus.sent)
        .toList()
      ..sort((a, b) => (b.respondedAt ?? b.receivedAt).compareTo(a.respondedAt ?? a.receivedAt));

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.backgroundWhite,
        title: Text('응답 히스토리', style: AppTextStyles.headline.copyWith(color: AppColors.backgroundWhite)),
      ),
      body: completedInquiries.isEmpty
          ? Center(
              child: Text(
                '완료된 문의가 없습니다',
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
                      padding: EdgeInsets.all(isWide ? 24 : 16),
                      itemCount: completedInquiries.length,
                      itemBuilder: (context, index) {
                        final Inquiry inquiry = completedInquiries[index];
                        return _HistoryCard(inquiry: inquiry);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _HistoryCard extends StatefulWidget {
  final Inquiry inquiry;

  const _HistoryCard({required this.inquiry});

  @override
  State<_HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<_HistoryCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final String formattedTime = DateFormat('yyyy/MM/dd HH:mm').format(
      widget.inquiry.respondedAt ?? widget.inquiry.receivedAt,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.inquiry.customerName,
                          style: AppTextStyles.headline,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.inquiry.subject,
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: AppColors.primaryDark,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              formattedTime,
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.textGray,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '원본 문의',
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundGray,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.inquiry.content,
                      style: AppTextStyles.body,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '전송된 응답',
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.accentYellow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.inquiry.aiResponse ?? '',
                      style: AppTextStyles.body,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
