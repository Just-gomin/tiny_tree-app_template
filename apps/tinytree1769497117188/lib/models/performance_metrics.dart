enum PerformanceTrend { up, stable, down }

enum HealthStatus { good, warning, critical }

class PerformanceMetrics {
  final int views;
  final double clickRate;
  final double bookingRate;
  final double cancellationRate;
  final PerformanceTrend trend;
  final HealthStatus status;

  PerformanceMetrics({
    required this.views,
    required this.clickRate,
    required this.bookingRate,
    required this.cancellationRate,
    required this.trend,
    required this.status,
  });
}
