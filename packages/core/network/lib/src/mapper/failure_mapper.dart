import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

/// DioException을 NetworkFailure로 변환하는 매퍼.
///
/// Dio의 다양한 에러 타입을 domain 레이어의 NetworkFailure로 변환합니다.
class FailureMapper {
  /// FailureMapper를 생성합니다.
  const FailureMapper();

  /// DioException을 NetworkFailure로 매핑합니다.
  ///
  /// [exception]: 변환할 DioException
  /// Returns: NetworkFailure 인스턴스
  NetworkFailure map(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return const NetworkFailure('서버 연결 시간이 초과되었습니다.');

      case DioExceptionType.sendTimeout:
        return const NetworkFailure('요청 전송 시간이 초과되었습니다.');

      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('응답 수신 시간이 초과되었습니다.');

      case DioExceptionType.badResponse:
        return _handleBadResponse(exception);

      case DioExceptionType.cancel:
        return const NetworkFailure('요청이 취소되었습니다.');

      case DioExceptionType.connectionError:
        return const NetworkFailure(
          '네트워크 연결에 실패했습니다. 인터넷 연결을 확인해주세요.',
        );

      case DioExceptionType.badCertificate:
        return const NetworkFailure('SSL 인증서 검증에 실패했습니다.');

      case DioExceptionType.unknown:
        return NetworkFailure(
          '알 수 없는 네트워크 오류가 발생했습니다: ${exception.message ?? ''}',
        );
    }
  }

  /// HTTP 상태 코드별 NetworkFailure 생성
  NetworkFailure _handleBadResponse(DioException exception) {
    final int? statusCode = exception.response?.statusCode;
    final dynamic responseData = exception.response?.data;

    // 서버에서 제공한 에러 메시지 추출 (있는 경우)
    final String message = _extractErrorMessage(responseData, statusCode);

    return NetworkFailure(message, statusCode: statusCode);
  }

  /// 응답 데이터에서 에러 메시지 추출
  String _extractErrorMessage(dynamic responseData, int? statusCode) {
    // 1. 서버가 JSON으로 에러 메시지를 제공한 경우
    if (responseData is Map<String, dynamic>) {
      // 일반적인 API 에러 응답 패턴들
      if (responseData.containsKey('message')) {
        return responseData['message'] as String;
      }
      if (responseData.containsKey('error')) {
        final dynamic error = responseData['error'];
        if (error is String) {
          return error;
        }
        if (error is Map && error.containsKey('message')) {
          return error['message'] as String;
        }
      }
    }

    // 2. 서버가 문자열로 에러를 제공한 경우
    if (responseData is String && responseData.isNotEmpty) {
      return responseData;
    }

    // 3. 기본 메시지 (HTTP 상태 코드 기반)
    return _getDefaultMessageForStatusCode(statusCode);
  }

  /// HTTP 상태 코드별 기본 메시지
  String _getDefaultMessageForStatusCode(int? statusCode) {
    if (statusCode == null) {
      return '서버 응답 처리 중 오류가 발생했습니다.';
    }

    // 4xx Client Errors
    if (statusCode >= 400 && statusCode < 500) {
      switch (statusCode) {
        case 400:
          return '잘못된 요청입니다. (400 Bad Request)';
        case 401:
          return '인증이 필요합니다. (401 Unauthorized)';
        case 403:
          return '접근 권한이 없습니다. (403 Forbidden)';
        case 404:
          return '요청한 리소스를 찾을 수 없습니다. (404 Not Found)';
        case 408:
          return '요청 시간이 초과되었습니다. (408 Request Timeout)';
        case 409:
          return '리소스 충돌이 발생했습니다. (409 Conflict)';
        case 422:
          return '요청 데이터를 처리할 수 없습니다. (422 Unprocessable Entity)';
        case 429:
          return '너무 많은 요청을 보냈습니다. 잠시 후 다시 시도해주세요. (429 Too Many Requests)';
        default:
          return '클라이언트 오류가 발생했습니다. (HTTP $statusCode)';
      }
    }

    // 5xx Server Errors
    if (statusCode >= 500 && statusCode < 600) {
      switch (statusCode) {
        case 500:
          return '서버 내부 오류가 발생했습니다. (500 Internal Server Error)';
        case 502:
          return '게이트웨이 오류가 발생했습니다. (502 Bad Gateway)';
        case 503:
          return '서비스를 일시적으로 사용할 수 없습니다. (503 Service Unavailable)';
        case 504:
          return '게이트웨이 시간 초과가 발생했습니다. (504 Gateway Timeout)';
        default:
          return '서버 오류가 발생했습니다. (HTTP $statusCode)';
      }
    }

    return '알 수 없는 HTTP 오류가 발생했습니다. (HTTP $statusCode)';
  }
}
