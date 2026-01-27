enum InquiryStatus { pending, reviewed, sent }

class Inquiry {
  final String id;
  final String customerName;
  final String customerLanguage;
  final String subject;
  final String content;
  final DateTime receivedAt;
  final InquiryStatus status;
  final String? aiResponse;
  final String? appliedPolicy;
  final DateTime? respondedAt;

  Inquiry({
    required this.id,
    required this.customerName,
    required this.customerLanguage,
    required this.subject,
    required this.content,
    required this.receivedAt,
    required this.status,
    this.aiResponse,
    this.appliedPolicy,
    this.respondedAt,
  });

  Inquiry copyWith({
    String? id,
    String? customerName,
    String? customerLanguage,
    String? subject,
    String? content,
    DateTime? receivedAt,
    InquiryStatus? status,
    String? aiResponse,
    String? appliedPolicy,
    DateTime? respondedAt,
  }) {
    return Inquiry(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerLanguage: customerLanguage ?? this.customerLanguage,
      subject: subject ?? this.subject,
      content: content ?? this.content,
      receivedAt: receivedAt ?? this.receivedAt,
      status: status ?? this.status,
      aiResponse: aiResponse ?? this.aiResponse,
      appliedPolicy: appliedPolicy ?? this.appliedPolicy,
      respondedAt: respondedAt ?? this.respondedAt,
    );
  }
}
