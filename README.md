# Tiny Tree App Template

AI 기반 소프트웨어 개발 자동화 시스템 **Tiny Tree**의 Flutter 앱 템플릿 프로젝트입니다.

## 개요

재사용 가능한 Flutter 패키지들을 Melos 모노레포로 관리하며, Claude Code가 이 패키지들을 조합하여 MVP를 자동 생성합니다.

**Phase 1 완료**: Melos 모노레포 구조, domain 패키지  
**Phase 2 진행중**: 핵심 패키지 개발 (core, app_core/auth, app_core/theme, app_core/ui_kit)

## 기술 스택

- **Language**: Dart 3.10+
- **Framework**: Flutter 3.38+
- **Package Manager**: Melos 7.0+
- **Backend**: Firebase / Supabase

## 빠른 시작

```bash
# 의존성 설치
melos bootstrap

# 모든 패키지 분석
melos run analyze

# 모든 패키지 테스트
melos run test
```

## 패키지 구조

```text
packages/
├── core/                    # 순수 Dart 패키지
│   ├── domain/              ✅ 완료
│   ├── network/             📅 계획
│   ├── storage_interface/   📅 계획
│   └── utils/               📅 계획
│
├── app_core/                # Flutter 의존 패키지
│   ├── auth/                📅 우선순위 1
│   ├── theme/               📅 우선순위 2
│   ├── ui_kit/              📅 우선순위 3
│   ├── storage_impl/        📅 계획
│   └── utils/               📅 계획
│
├── features/                # 비즈니스 기능 (Phase 3+)
├── integrations/            # 서드파티 래퍼 (Phase 3+)
└── testing/                 # 테스트 유틸리티 (Phase 3+)
```

## 문서

- [프로젝트 계획](./plans/project-plan.md) - 상세 개발 계획
- [Packages 구현 계획](./plans/packages-implementation-plan.md) - 패키지별 구현 가이드
- [CLAUDE.md](./CLAUDE.md) - Claude Code 작업 가이드

## light vs full 모드

| 측면 | light | full |
| :------: | :-------: | :------: |
| 패키지 사용 | ❌ 없음 | ✅ 활용 |
| 생성 시간 | 30분-1시간 | 2-4시간 |
| 기능 수 | 1-4개 | 5-20개 |
| 구조 | 단일 앱 | 모듈화 |

## 관련 프로젝트

- [Tiny Tree Slack Bot](https://github.com/Just-gomin/tiny_tree-slack_bot) - Slack Bot 인터페이스

## 라이선스

MIT License
