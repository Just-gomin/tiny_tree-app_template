# Tiny Tree App Template - 문서

Auth 패키지 설계 및 구현 문서입니다.

## 📚 목차

### 아키텍처

- [전체 아키텍처](./architecture/overview.md) - 프로젝트 전체 구조 및 설계 원칙
- [Clean Architecture](./architecture/clean-architecture.md) - Domain/Data/Presentation 계층 설명
- [의존성 관계](./architecture/dependencies.md) - 패키지 간 의존성 그래프

### 패키지별 가이드

- [Core Storage](./packages/core-storage.md) - 로컬 저장소 추상화 패키지
- [Auth Feature](./packages/auth-feature.md) - 인증 기능 패키지
- [Firebase Integration](./packages/firebase-integration.md) - Firebase 통합 패키지 (예정)
- [Supabase Integration](./packages/supabase-integration.md) - Supabase 통합 패키지 (예정)

### 개발 가이드

- [시작하기](./guides/getting-started.md) - 프로젝트 설정 및 시작
- [새 패키지 생성](./guides/creating-packages.md) - 패키지 생성 가이드
- [테스트 작성](./guides/testing.md) - 테스트 전략 및 작성법
- [Freezed 사용법](./guides/freezed.md) - Freezed를 활용한 모델 작성

### API 레퍼런스

- [Domain API](./api/domain.md) - Domain 계층 API
- [Data API](./api/data.md) - Data 계층 API

## 🎯 빠른 시작

### 1. 의존성 설치

```bash
# Melos를 사용한 전체 의존성 설치
melos bootstrap

# 또는 개별 패키지 설치
cd packages/core/storage && flutter pub get
cd packages/features/auth && flutter pub get
```

### 2. 코드 생성 (Freezed)

```bash
cd packages/features/auth
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. 분석 및 테스트

```bash
# 전체 분석
flutter analyze

# 개별 패키지 분석
cd packages/features/auth && flutter analyze

# 테스트 실행
cd packages/features/auth && flutter test
```

## 📊 구현 상태

### ✅ 완료

- **Phase 1**: Core Storage 패키지
- **Phase 2**: Auth Domain 계층
- **Phase 3**: Auth Data 계층

### 🚧 진행 예정

- **Phase 4**: Firebase Integration 패키지
- **Phase 5**: Supabase Integration 패키지
- **Phase 6**: Auth Presentation 계층 (UI)
- **Phase 7**: 테스트 작성 및 검증

## 🔗 관련 링크

- [프로젝트 README](../README.md)
- [CLAUDE.md](../CLAUDE.md) - AI 개발 가이드
- [구현 계획](../.claude/plans/cheerful-fluttering-robin.md)

## 📝 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.
