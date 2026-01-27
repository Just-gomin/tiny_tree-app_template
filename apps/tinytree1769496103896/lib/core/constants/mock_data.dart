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
        subjectKo: '예약 변경 요청',
        content: '予約を3月15日から3月20日に変更できますか？時間帯は午後2時希望です。',
        contentKo: '3월 15일 예약을 3월 20일로 변경할 수 있나요? 시간은 오후 2시를 희망합니다.',
        receivedAt: now.subtract(const Duration(hours: 2)),
        status: InquiryStatus.pending,
        aiResponse: '''田中様、お問い合わせありがとうございます。

3月20日午後2時への変更が可能です。変更手数料は無料です。
ご予約の変更を確定してよろしいでしょうか？

よろしくお願いいたします。''',
        appliedPolicy: '7日前予約変更無料',
        responseVariants: [
          // Variant 1: Standard
          '''田中様、お問い合わせありがとうございます。

3月20日午後2時への変更が可能です。変更手数料は無料です。
ご予約の変更を確定してよろしいでしょうか？

よろしくお願いいたします。''',
          // Variant 2: Friendly
          '''田中様、いつもご利用ありがとうございます。

3月20日午後2時への変更が可能です。7日前の変更のため、変更手数料は無料となります。
特別なリクエストがございましたら、お気軽にお申し付けください。

ご予約の変更を確定してよろしいでしょうか？

心よりお待ちしております。''',
          // Variant 3: With discount
          '''田中様、お問い合わせありがとうございます。

3月20日午後2時への変更を承りました。変更手数料は無料です。
なお、チェックイン当日は特別割引クーポン（10% OFF）をご用意しております。

ご予約の変更を確定してよろしいでしょうか？

よろしくお願いいたします。'''
        ],
      ),
      Inquiry(
        id: '2',
        customerName: 'John Smith',
        customerLanguage: 'en',
        subject: 'Cancellation Request',
        subjectKo: '예약 취소 요청',
        content: 'I need to cancel my reservation for March 10th. What is your cancellation policy?',
        contentKo: '3월 10일 예약을 취소해야 합니다. 취소 정책이 어떻게 되나요?',
        receivedAt: now.subtract(const Duration(hours: 5)),
        status: InquiryStatus.pending,
        aiResponse: '''Dear John,

Thank you for contacting us.

Our cancellation policy allows free cancellation up to 3 days before check-in. Since your reservation is for March 10th, you can cancel without any charges.

Would you like to proceed with the cancellation?

Best regards''',
        appliedPolicy: '3 days free cancellation',
        responseVariants: [
          // Variant 1: Standard
          '''Dear John,

Thank you for contacting us.

Our cancellation policy allows free cancellation up to 3 days before check-in. Since your reservation is for March 10th, you can cancel without any charges.

Would you like to proceed with the cancellation?

Best regards''',
          // Variant 2: Friendly
          '''Dear John,

Thank you so much for reaching out to us. We're sorry to hear you need to cancel.

Our cancellation policy allows free cancellation up to 3 days before check-in. Since your reservation is for March 10th, you can cancel without any charges. We hope to welcome you on a future visit!

Would you like to proceed with the cancellation?

Warm regards''',
          // Variant 3: With discount
          '''Dear John,

Thank you for contacting us.

Our cancellation policy allows free cancellation up to 3 days before check-in. Since your reservation is for March 10th, you can cancel without any charges.

If you'd like to reschedule instead, we're offering a 15% discount for your next stay!

Would you like to proceed with the cancellation or reschedule?

Best regards'''
        ],
      ),
      Inquiry(
        id: '3',
        customerName: 'Wei Chen',
        customerLanguage: 'zh',
        subject: '设施咨询',
        subjectKo: '시설 문의',
        content: '请问有免费的停车位吗？另外附近有便利店吗？',
        contentKo: '무료 주차장이 있나요? 그리고 근처에 편의점이 있나요?',
        receivedAt: now.subtract(const Duration(hours: 8)),
        status: InquiryStatus.pending,
        aiResponse: '''陈先生您好，

感谢您的咨询。

我们提供免费停车位，先到先得。
从我们这里步行2分钟就有一家24小时营业的便利店（FamilyMart）。

还有其他需要帮助的吗？

祝您旅途愉快''',
        appliedPolicy: null,
        responseVariants: [
          // Variant 1: Standard
          '''陈先生您好，

感谢您的咨询。

我们提供免费停车位，先到先得。
从我们这里步行2分钟就有一家24小时营业的便利店（FamilyMart）。

还有其他需要帮助的吗？

祝您旅途愉快''',
          // Variant 2: Friendly
          '''陈先生您好，

非常感谢您的咨询！

我们很高兴为您提供免费停车位（先到先得）。
从我们这里步行2分钟就有一家24小时营业的便利店（FamilyMart），非常方便。如果您需要任何其他帮助，请随时联系我们。

期待您的光临，祝您旅途愉快！''',
          // Variant 3: With discount
          '''陈先生您好，

感谢您的咨询。

我们提供免费停车位，先到先得。
从我们这里步行2分钟就有一家24小时营业的便利店（FamilyMart）。

另外，我们为您准备了欢迎礼包券（便利店可用8折优惠）。

还有其他需要帮助的吗？

祝您旅途愉快'''
        ],
      ),
      Inquiry(
        id: '4',
        customerName: 'Marie Dubois',
        customerLanguage: 'fr',
        subject: 'Check-in Time',
        subjectKo: '체크인 시간 문의',
        content: 'Bonjour, je vais arriver tard vers 22h. Est-ce possible?',
        contentKo: '안녕하세요, 늦게 22시쯤 도착할 예정입니다. 가능한가요?',
        receivedAt: now.subtract(const Duration(hours: 12)),
        status: InquiryStatus.pending,
        aiResponse: '''Bonjour Marie,

Merci pour votre message.

Oui, l'arrivée à 22h est possible. Nous proposons un check-in automatique 24h/24.
Je vous enverrai les instructions détaillées la veille de votre arrivée.

Bon voyage!''',
        appliedPolicy: 'Late check-in available',
        responseVariants: [
          // Variant 1: Standard
          '''Bonjour Marie,

Merci pour votre message.

Oui, l'arrivée à 22h est possible. Nous proposons un check-in automatique 24h/24.
Je vous enverrai les instructions détaillées la veille de votre arrivée.

Bon voyage!''',
          // Variant 2: Friendly
          '''Bonjour Marie,

Merci beaucoup pour votre message et pour nous avoir prévenus.

Oui, bien sûr, l'arrivée à 22h est tout à fait possible! Nous proposons un check-in automatique 24h/24 pour votre confort.
Je vous enverrai les instructions détaillées la veille de votre arrivée. N'hésitez pas si vous avez d'autres questions.

Bon voyage et à bientôt!''',
          // Variant 3: With discount
          '''Bonjour Marie,

Merci pour votre message.

Oui, l'arrivée à 22h est possible. Nous proposons un check-in automatique 24h/24.
Je vous enverrai les instructions détaillées la veille de votre arrivée.

Pour votre arrivée tardive, nous vous offrons un bon pour le petit-déjeuner gratuit!

Bon voyage!'''
        ],
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
        responseVariants: [
          // Variant 1: Standard
          '''안녕하세요 김민수님,

문의 주셔서 감사합니다.

1명 추가 가능하며, 추가 요금은 1박당 3,000엔입니다.
최대 3명까지 숙박 가능합니다.

예약을 변경해 드릴까요?

감사합니다.''',
          // Variant 2: Friendly
          '''안녕하세요 김민수님,

문의 주셔서 감사합니다!

네, 1명 추가 가능합니다. 추가 요금은 1박당 3,000엔이며, 최대 3명까지 편안하게 숙박하실 수 있습니다.
필요하신 사항이 있으시면 언제든지 말씀해 주세요.

예약을 변경해 드릴까요?

감사합니다.''',
          // Variant 3: With discount
          '''안녕하세요 김민수님,

문의 주셔서 감사합니다.

1명 추가 가능하며, 추가 요금은 1박당 3,000엔입니다.
최대 3명까지 숙박 가능합니다.

특별히 3인 그룹 할인 쿠폰(총 금액 5% 할인)을 제공해 드리겠습니다!

예약을 변경해 드릴까요?

감사합니다.'''
        ],
      ),
    ];
  }
}
