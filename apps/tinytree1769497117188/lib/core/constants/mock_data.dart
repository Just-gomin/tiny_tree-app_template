import '../../models/performance_metrics.dart';
import '../../models/coaching_feedback.dart';
import '../../models/benchmark_data.dart';

class MockData {
  static final performanceMetrics = PerformanceMetrics(
    views: 1500,
    clickRate: 1.2,
    bookingRate: 0.8,
    cancellationRate: 0.5,
    trend: PerformanceTrend.down,
    status: HealthStatus.critical,
  );

  static final coachingFeedback = CoachingFeedback(
    diagnosis:
        '주요 문제: 클릭률이 카테고리 평균 대비 66% 낮습니다.\n\n'
        '원인 분석:\n'
        '• 메인 사진의 매력도가 낮아 시선을 끌지 못함\n'
        '• 가격이 경쟁 콘텐츠 대비 15% 높음\n'
        '• 제목이 구체적이지 않아 차별점이 보이지 않음',
    expectedImpact: '예상 개선: 클릭률 +40%, 예약률 +25%',
    actions: [
      ActionItem(
        title: '메인 사진 교체',
        description: '밝고 활동적인 장면으로 변경하세요 (클릭률 +25% 예상)',
        priority: Priority.high,
        category: ActionCategory.photos,
      ),
      ActionItem(
        title: '가격 재설정',
        description: '₩45,000에서 ₩38,000으로 조정 (클릭률 +15% 예상)',
        priority: Priority.high,
        category: ActionCategory.price,
      ),
      ActionItem(
        title: '제목 개선',
        description: '"특별한 체험" → "제주 올레길 선셋 투어 & 전통 음식 체험"',
        priority: Priority.medium,
        category: ActionCategory.description,
      ),
      ActionItem(
        title: '운영 시간 확대',
        description: '주말 오후 시간대 추가',
        priority: Priority.medium,
        category: ActionCategory.schedule,
      ),
      ActionItem(
        title: '취소 정책 완화',
        description: '24시간 전 → 48시간 전 무료 취소',
        priority: Priority.low,
        category: ActionCategory.operation,
      ),
    ],
  );

  static final benchmarkData = BenchmarkData(
    contentTitle: '제주 올레길 체험',
    myClickRate: 1.2,
    avgClickRate: 3.5,
    top10ClickRate: 7.2,
    myBookingRate: 0.8,
    avgBookingRate: 2.1,
    top10BookingRate: 4.5,
  );
}
