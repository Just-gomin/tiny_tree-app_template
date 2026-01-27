import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/inquiry_model.dart';

class ReviewScreen extends StatefulWidget {
  final Inquiry inquiry;
  final Function(Inquiry, String) onApprove;
  final VoidCallback onReject;

  const ReviewScreen({
    super.key,
    required this.inquiry,
    required this.onApprove,
    required this.onReject,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.inquiry.aiResponse ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.backgroundWhite,
        title: Text('AI 응답 검토', style: AppTextStyles.headline.copyWith(color: AppColors.backgroundWhite)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth >= 600;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isWide ? 24 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('원본 문의', style: AppTextStyles.headline),
                            const SizedBox(height: 16),
                            _buildInfoRow('고객명', widget.inquiry.customerName),
                            const SizedBox(height: 8),
                            _buildInfoRow('언어', widget.inquiry.customerLanguage.toUpperCase()),
                            const SizedBox(height: 8),
                            _buildInfoRow('제목', widget.inquiry.subject),
                            const SizedBox(height: 16),
                            Text('내용', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            Text(widget.inquiry.content, style: AppTextStyles.body),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('AI 생성 응답', style: AppTextStyles.headline),
                                const SizedBox(width: 8),
                                Icon(Icons.auto_awesome, size: 20, color: AppColors.accentOrange),
                              ],
                            ),
                            if (widget.inquiry.appliedPolicy != null) ...[
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.accentYellow,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.policy, size: 16, color: AppColors.textDark),
                                    const SizedBox(width: 4),
                                    Text(
                                      '적용된 정책: ${widget.inquiry.appliedPolicy}',
                                      style: AppTextStyles.caption.copyWith(color: AppColors.textDark),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            TextField(
                              controller: _controller,
                              maxLines: 10,
                              style: AppTextStyles.body,
                              decoration: InputDecoration(
                                hintText: 'AI 응답을 수정할 수 있습니다',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: AppColors.backgroundWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              widget.onApprove(widget.inquiry, _controller.text);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryDark,
                              foregroundColor: AppColors.backgroundWhite,
                            ),
                            child: const Text('승인 후 전송'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: widget.onReject,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primaryRed,
                              side: BorderSide(color: AppColors.primaryRed),
                            ),
                            child: const Text('거절'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Text(value, style: AppTextStyles.body),
        ),
      ],
    );
  }
}
