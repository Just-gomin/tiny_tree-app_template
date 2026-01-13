# Tiny Tree App Template

## 목표

AI를 활용해 MVP 를 검증하기 위한 프로젝트를 생성하는 프로젝트.
아이디어 입력부터 배포까지 1시간 이내 완료를 목표로 하는 자동화 시스템 입니다.

## 기술 스택

- Dart: 코어 패키지 제작
- Flutter: 앱 및 패키지 제작
- Firebase: 서버리스 운영

## 방식

### `packages`

도메인, 비즈니스, 프레젠테이션 레이어를 비롯해 서드 파티 API를 지원하는 Dart/Flutter 패키지 디렉토리.

### `apps`

`packages`에 정의된 패키지를 이용해 사용자의 주문에 맞게 작성되는 APP 들이 모인 디렉토리.

## MVP 제작 과정

### 1. 아이디어 입력 (Slack Bot)

동명의 프로젝트 [Tiny Tree의 Slack Bot](https://github.com/Just-gomin/tiny_tree-slack_bot) 프로젝트를 통해 슬랙으로 아이디어 혹은 기획서, 회의의 녹음본을 전달 받습니다.

### 2. 계획 세우기 (Claude Code)

입력으로 부터 최소 기능을 구현하기 위한 계획을 세웁니다.

### 3. 기능 개발 (Claude Code)

위 2단계에서 작성된 계획서를 통해 MVP 프로젝트를 제작합니다.

### 4. 배포 (Firebase)

3단계에서 제작된 MVP를 Firebase 를 이용해 배포 합니다.

- 웹: Firebase Hosting
- 모바일: Firebase Distribution

### 5. 검수 및 수정 (Slack Bot, Claude)

4단계에서 배포된 앱을 사람이 직접 조작해 본 뒤, 수정 요청을 입력 합니다.
다시 2단계로 돌아가 과정을 반복합니다.

## 고도화 계획

### 계획 및 할 일(Task) 운영 고도화

할 일을 데이터 베이스로 관리해, 큰 규모의 앱을 제작할 수 있도록 확장할 예정입니다.

### 결제 등 다양한 써드파티 기능 연결

상업용 앱을 만들기 위해 다양한 결제 서비스등 써드파티들을 이용할 수 있도록 패키지를 지속 개발합니다.
