/// domain - Tiny Tree의 기본 도메인 타입들
///
/// 이 패키지는 모든 앱에서 공통으로 사용하는 도메인 기본 타입을 제공합니다:
/// - [Entity]: ID 기반 도메인 객체
/// - [ValueObject]: 값 기반 불변 객체
/// - [Failure]: 비즈니스 로직 실패 표현
/// - [Result]: 타입 안전한 성공/실패 래퍼
/// - [UseCase]: 비즈니스 로직 실행 인터페이스
/// - [DomainException]: 도메인 예외
library;

// Re-export equatable for convenience
export 'package:equatable/equatable.dart';

// Core abstractions
export 'src/entity/entity.dart';
export 'src/exception/domain_exception.dart';
export 'src/failure/failure.dart';
export 'src/result/result.dart';
export 'src/usecase/usecase.dart';
export 'src/value_object/value_object.dart';
