import '../../models/inquiry_model.dart';

class MockData {
  MockData._();

  static List<Inquiry> getInquiries() {
    final DateTime now = DateTime.now();
    return [
      Inquiry(
        id: '1',
        customerName: 'Yuki Tanaka',
        customerLanguage: 'ja',
        subject: '予約変更のお願い',
        content: '予約を3月15日から3月20日に変更できますか？時間帯は午後2時希望です。',
        receivedAt: now.subtract(const Duration(hours: 2)),
        status: InquiryStatus.pending,
        aiResponse: '''田中様、お問い合わせありがとうございます。

3月20日午後2時への変更が可能です。変更手数料は無料です。
ご予約の変更を確定してよろしいでしょうか？

よろしくお願いいたします。''',
        appliedPolicy: '7日前予約変更無料',
      ),
      Inquiry(
        id: '2',
        customerName: 'John Smith',
        customerLanguage: 'en',
        subject: 'Cancellation Request',
        content: 'I need to cancel my reservation for March 10th. What is your cancellation policy?',
        receivedAt: now.subtract(const Duration(hours: 5)),
        status: InquiryStatus.pending,
        aiResponse: '''Dear John,

Thank you for contacting us.

Our cancellation policy allows free cancellation up to 3 days before check-in. Since your reservation is for March 10th, you can cancel without any charges.

Would you like to proceed with the cancellation?

Best regards''',
        appliedPolicy: '3 days free cancellation',
      ),
      Inquiry(
        id: '3',
        customerName: 'Wei Chen',
        customerLanguage: 'zh',
        subject: '设施咨询',
        content: '请问有免费的停车位吗？另外附近有便利店吗？',
        receivedAt: now.subtract(const Duration(hours: 8)),
        status: InquiryStatus.pending,
        aiResponse: '''陈先生您好，

感谢您的咨询。

我们提供免费停车位，先到先得。
从我们这里步行2分钟就有一家24小时营业的便利店（FamilyMart）。

还有其他需要帮助的吗？

祝您旅途愉快''',
        appliedPolicy: null,
      ),
      Inquiry(
        id: '4',
        customerName: 'Marie Dubois',
        customerLanguage: 'fr',
        subject: 'Check-in Time',
        content: 'Bonjour, je vais arriver tard vers 22h. Est-ce possible?',
        receivedAt: now.subtract(const Duration(hours: 12)),
        status: InquiryStatus.pending,
        aiResponse: '''Bonjour Marie,

Merci pour votre message.

Oui, l'arrivée à 22h est possible. Nous proposons un check-in automatique 24h/24.
Je vous enverrai les instructions détaillées la veille de votre arrivée.

Bon voyage!''',
        appliedPolicy: 'Late check-in available',
      ),
      Inquiry(
        id: '5',
        customerName: 'Kim Min-soo',
        customerLanguage: 'ko',
        subject: '추가 인원 문의',
        content: '2명 예약했는데 1명 더 추가 가능한가요? 추가 요금은 얼마인가요?',
        receivedAt: now.subtract(const Duration(hours: 24)),
        status: InquiryStatus.pending,
        aiResponse: '''안녕하세요 김민수님,

문의 주셔서 감사합니다.

1명 추가 가능하며, 추가 요금은 1박당 3,000엔입니다.
최대 3명까지 숙박 가능합니다.

예약을 변경해 드릴까요?

감사합니다.''',
        appliedPolicy: 'Extra guest: 3,000 yen/night',
      ),
    ];
  }
}
