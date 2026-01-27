import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/inquiry_model.dart';

class InquiryCard extends StatelessWidget {
  final Inquiry inquiry;
  final VoidCallback onTap;

  const InquiryCard({
    super.key,
    required this.inquiry,
    required this.onTap,
  });

  String _getLanguageFlag(String language) {
    switch (language) {
      case 'ja':
        return '🇯🇵';
      case 'en':
        return '🇬🇧';
      case 'zh':
        return '🇨🇳';
      case 'fr':
        return '🇫🇷';
      case 'ko':
        return '🇰🇷';
      default:
        return '🌐';
    }
  }

  String _getStatusText(InquiryStatus status) {
    switch (status) {
      case InquiryStatus.pending:
        return '대기중';
      case InquiryStatus.reviewed:
        return '검토완료';
      case InquiryStatus.sent:
        return '전송완료';
    }
  }

  Color _getStatusColor(InquiryStatus status) {
    switch (status) {
      case InquiryStatus.pending:
        return AppColors.accentYellow;
      case InquiryStatus.reviewed:
        return AppColors.accentOrange;
      case InquiryStatus.sent:
        return AppColors.backgroundGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedTime = DateFormat('MM/dd HH:mm').format(inquiry.receivedAt);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _getLanguageFlag(inquiry.customerLanguage),
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      inquiry.customerName,
                      style: AppTextStyles.headline,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(inquiry.status),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _getStatusText(inquiry.status),
                      style: AppTextStyles.caption.copyWith(
                        color: inquiry.status == InquiryStatus.sent
                            ? AppColors.textGray
                            : AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                inquiry.subject,
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                inquiry.content,
                style: AppTextStyles.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppColors.accentOrange,
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
      ),
    );
  }
}
