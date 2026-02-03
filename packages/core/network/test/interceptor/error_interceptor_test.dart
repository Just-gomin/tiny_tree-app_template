import 'package:network/src/interceptor/error_interceptor.dart';
import 'package:test/test.dart';

void main() {
  group('ErrorInterceptor', () {
    test('인스턴스를 생성할 수 있다', () {
      // Act
      final ErrorInterceptor interceptor = ErrorInterceptor();

      // Assert
      expect(interceptor, isA<ErrorInterceptor>());
    });
  });
}
