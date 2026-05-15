# 옥모닝 비주얼 리프레시 — 디자인 스펙

검토일: 2026-05-15
범위: 아이콘 + 브랜드 자산 + 4개 핵심 화면 (Home / Alarm Edit / Paywall / Settings)
타깃: v1.0 출시와 함께 적용 (현재 출시 준비 중)

---

## 1. 결정 사항 요약

| 항목 | 결정 | 비고 |
|---|---|---|
| 비주얼 방향 | Modern Playful | Duolingo / 캐치잇 계열, 마스코트 중심 |
| 1차 컬러 | Sunrise Orange `#FF6B1A` | 일출 컨셉, 현재 브랜드의 채도 강화 |
| 마스코트 | Sunny — 해님 캐릭터 | 5종 표정 변주 |
| 마스코트 표정 | Smile / Wink / Sad / Sleepy / Excited | 각 표정의 사용 컨텍스트 §3.2 참조 |
| 앱 아이콘 | Sunny Centered + 햇살 + 그라데이션 BG | 단순·강력, 작은 사이즈에서도 식별 |
| 타이포그래피 | Jua (display) + Pretendard (body) | 한글 가독성 + 친근감 |
| 실행 방식 | 프로그래매틱 SVG/PNG | 재현 가능, AI 이미지 미사용 |

---

## 2. 디자인 시스템

### 2.1 컬러 토큰

기존 `lib/core/constants/app_colors.dart`의 `AppColors` 클래스를 다음 값으로 교체.

```dart
class AppColors {
  // Primary — Sunrise Orange 계열
  static const Color primary       = Color(0xFFFF6B1A);  // 메인 액션·강조
  static const Color primaryLight  = Color(0xFFFFB347);  // 그라데이션 상단
  static const Color primaryDark   = Color(0xFFD9531A);  // pressed/hover
  static const Color primarySurface= Color(0xFFFFF1E0);  // 카드 배경

  // Action — 성공/완료 (Duo Green 유지)
  static const Color action        = Color(0xFF58CC02);
  static const Color actionLight   = Color(0xFFD7FFB8);
  static const Color actionDark    = Color(0xFF43A800);

  // Background — warmer cream
  static const Color backgroundLight = Color(0xFFFFFCF7);  // 거의 흰색 + 미세한 따뜻함
  static const Color surfaceLight    = Color(0xFFFFFFFF);
  static const Color surfaceSoftLight= Color(0xFFFFF1E0);  // 카드 강조 배경

  // Text
  static const Color textPrimaryLight   = Color(0xFF1F1108);  // 거의 검정 + 따뜻한 톤
  static const Color textSecondaryLight = Color(0xFF6E5E42);
  static const Color textTertiaryLight  = Color(0xFFB59B7A);

  // Mascot face palette (애플리케이션 코드와는 별도, SVG 안에만 등장)
  // Smile/Wink/Excited: #FF6B1A 본체 + #FFE066 highlight
  // Sad:                #D9663F 본체 + tear #4FA5D4
  // Sleepy:             #E8A14F 본체

  // Semantic
  static const Color warning = Color(0xFFFFC800);
  static const Color error   = Color(0xFFE63946);
  static const Color info    = Color(0xFF4FA5D4);  // = Sad의 눈물색과 동일

  // Gradient endpoints
  static const Color gradientStart = primaryLight;  // #FFB347
  static const Color gradientEnd   = primary;       // #FF6B1A
}
```

기존 코드에서 `AppColors.action`/`accent` alias 등은 그대로 유지해서 호출처 깨지지 않게 한다.

### 2.2 타이포그래피

`lib/app.dart`의 텍스트 테마를 다음과 같이 확장.

| 역할 | 폰트 | 무게 | 크기 | 용도 |
|---|---|---|---|---|
| Display | Jua (Google Font) | Regular | 32~64sp | 큰 숫자(시간), 페이월 헤드라인 |
| Heading | Pretendard | 800 | 22~28sp | 화면 제목, 카드 제목 |
| Body | Pretendard | 500 | 14~17sp | 본문, 설명 |
| Label | Pretendard | 600 | 11~13sp | 버튼, 칩 |
| Numeric | Jua | Regular | 16~28sp | XP, 레벨, 통계 숫자 |

Pretendard는 `pubspec.yaml`의 fonts 섹션으로 로컬 번들 추가 (CDN 의존 없이 오프라인에서 안정 동작).

```yaml
fonts:
  - family: Pretendard
    fonts:
      - asset: assets/fonts/Pretendard-Regular.ttf
      - asset: assets/fonts/Pretendard-Medium.ttf
        weight: 500
      - asset: assets/fonts/Pretendard-SemiBold.ttf
        weight: 600
      - asset: assets/fonts/Pretendard-Bold.ttf
        weight: 700
      - asset: assets/fonts/Pretendard-ExtraBold.ttf
        weight: 800
```

Pretendard는 SIL OFL 라이선스로 상업 사용 자유. 폰트 파일은 [Pretendard GitHub](https://github.com/orioncactus/pretendard)에서 다운.

### 2.3 모서리·그림자·간격 토큰

```dart
class AppShape {
  static const double radiusS  = 12;   // 칩, 작은 카드
  static const double radiusM  = 18;   // 표준 카드
  static const double radiusL  = 24;   // 큰 카드, 다이얼로그
  static const double radiusXL = 32;   // 마스코트 컨테이너, hero 카드
}

class AppElevation {
  static const cardSoft   = [BoxShadow(color: Color(0x0F1F1108), blurRadius: 16, offset: Offset(0,4))];
  static const cardStrong = [BoxShadow(color: Color(0x1A1F1108), blurRadius: 24, offset: Offset(0,8))];
  static const orange     = [BoxShadow(color: Color(0x55FF6B1A), blurRadius: 24, offset: Offset(0,8))];
}

class AppSpacing {
  static const double xs = 4;
  static const double s  = 8;
  static const double m  = 16;
  static const double l  = 24;
  static const double xl = 32;
  static const double xxl= 48;
}
```

---

## 3. 마스코트 Sunny

### 3.1 베이스 디자인

- 원형 본체 (지름 = 컨테이너의 56~58%)
- 햇살 8가닥 (상하좌우 4 + 대각선 4)
- 본체에 radial highlight (좌상단 30/30 위치에 옅은 노란빛)
- 입·눈은 다크 텍스트 색(`#1F1108`)으로 단일화 — 단색만으로도 표정 식별 가능
- 뺨 블러시는 옅은 살구색(`#FFAB7E`) 타원

### 3.2 표정 5종 — 사용 컨텍스트

| 표정 | 본체 색 | 사용처 |
|---|---|---|
| 😊 Smile | `#FF6B1A` | 홈 그리팅 카드, 알람 편집 헤더, 설정 화면 trial 카드 |
| 😉 Wink | `#FF6B1A` | 퀴즈 정답 직후 잠깐 등장, 알람 미션 통과 화면 |
| 😢 Sad | `#D9663F` | 오답 직후 잠깐 등장, 스트릭 끊김 알림, 무료 체험 만료 |
| 😴 Sleepy | `#E8A14F` | 스누즈 화면, 7일 무활동 푸시 알림 |
| 🤩 Excited | `#FF6B1A` + 햇살 확장 | 레벨업, 7일/30일 스트릭 달성, 첫 구독 환영 |

### 3.3 구현 형식

- 각 표정을 별도 SVG로 저장: `assets/mascot/sunny-{state}.svg` (5개)
- Flutter에선 `flutter_svg` 패키지로 로드 (이미 indirectly dependency)
- 빌드 타임 PNG 변환본도 함께 (`assets/mascot/sunny-{state}@1x.png`, `@2x`, `@3x`) — 일부 surface (notification asset 등)에서 PNG가 더 안정적

생성 스크립트: `scripts/generate-mascot-assets.py`
- 5종 표정을 매개변수화한 단일 함수로 SVG 생성
- 같은 함수로 PNG 3종 해상도 동시 생성 (Cairo or Pillow + rsvg-convert)

---

## 4. 앱 아이콘

### 4.1 마스터 디자인

- 1024×1024 정사각형
- 배경: 세로 그라데이션 `#FFB347` → `#FF6B1A`
- Sunny Smile 표정을 정중앙에 배치 (얼굴 지름 = 캔버스의 56%)
- 햇살은 본체 색(`#FFE5BD` 반투명)으로 배경에 자연스럽게 녹아듦 — 식별 방해 없이 풍부함만 더함

### 4.2 출력 자산

자동 생성 스크립트: `scripts/generate-app-icon.py`

| 플랫폼 | 사이즈 | 파일 |
|---|---|---|
| iOS | 1024×1024 | `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png` |
| iOS | 20/29/40/60/76/83.5 (×1/2/3) | `ios/.../Icon-App-Nx@Mx.png` (전체 셋) |
| Android adaptive | 108×108 dp foreground + 108×108 dp background | `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml` + foreground/background drawables |
| Android legacy | 48/72/96/144/192 | `android/app/src/main/res/mipmap-{mdpi,hdpi,xhdpi,xxhdpi,xxxhdpi}/ic_launcher.png` |
| Play Store listing | 512×512 | `dist/play-icon-512.png` |
| Feature graphic | 1024×500 | `dist/feature-graphic.png` (Sunny 추가하여 재생성) |

기존 `generate-feature-graphic.py`는 Sunny SVG를 import해서 통합.

---

## 5. 화면별 리디자인

### 5.1 Home (`/alarms`)

**현재**: AppBar + 빈 상태 또는 알람 리스트 + FAB. 그리팅 카드·레벨·스트릭은 알람이 있을 때만 노출.

**리디자인**:
1. AppBar 제거. 상단에 hero 카드 (gradient orange BG + Sunny Smile 60×60 + 그리팅 텍스트 "좋은 아침, 옥모닝!").
2. Hero 카드 안에 다음 정보 행:
   - 다음 알람 시간 (Jua 36sp)
   - 레벨 칩 + XP 진행률 바 (작게)
   - 스트릭 일수 + 🔥 이모지
3. 그 아래 알람 리스트. 각 알람 카드는 더 큰 시간 표시(Jua 40sp), 반복 요일 칩 row, 미션 난이도 컬러칩.
4. FAB는 그대로 우하단. 라벨 "+알람 추가" → 아이콘 only로 변경 (FAB는 작을수록 깔끔).
5. 빈 상태에는 Sunny Sleepy 등장 + "아직 알람이 없어요" + 큰 액션 버튼.

**컴포넌트 분리**:
- `HomeHeroCard` (재사용 가능)
- `AlarmTile` (현재 widget을 리뉴얼)
- `EmptyAlarmsState`

### 5.2 Alarm Edit (`/alarms/add`, `/alarms/edit/:id`)

**현재**: 시간 picker + 각 설정 카드 세로 나열.

**리디자인**:
1. 상단 시간을 더 크게 (Jua 88sp). 탭 시 wheel picker 모달.
2. 시간 아래 Sunny Smile 작게 + "이 시간에 깨워드릴게요!" 마이크로카피.
3. 미션 카드를 가로 스크롤 chip set으로: 쉬움/보통/어려움이 색 chip + 문제 수 stepper.
4. 알람음을 collapsed list (현재 선택만 표시 + 화살표 → 모달).
5. 저장 버튼은 화면 하단 sticky.

### 5.3 Paywall (`/paywall`)

**현재**: Premium 잠금 해제 헤드라인 + 4가지 혜택 + 가격 카드 + 구독 버튼.

**리디자인**:
1. 헤드라인 위에 Sunny Excited (햇살 확장 상태) — 페이월 진입의 보상감.
2. 혜택 4가지를 카드 그리드로 (2×2). 각 카드에 아이콘 + 짧은 제목 + 1줄 설명.
3. 가격 카드를 토글 형태 (월간/연간 segment control) — 한 화면에 둘 다 보이지 않고 사용자가 비교 클릭.
4. 연간을 기본 선택, "월 4,083원 (49,000원/년)" + "월간 대비 31% 절약" 칩.
5. CTA 버튼: "7일 무료로 시작하기" (Jua 18sp). 그 아래 작게 "언제든 해지 가능".
6. 페이지 하단에 작은 글씨로 자동갱신 안내 + 약관 링크 (한국 규정 충족).

### 5.4 Settings (`/settings`)

**현재**: 무료체험 카드 + 언어/난이도/미션 토글 등 정보 행 나열.

**리디자인**:
1. 무료체험 카드 hero 위치 유지. 안에 Sunny Smile + "체험 N일 남음" + 큰 "업그레이드" CTA.
2. 그 아래 그룹별 섹션 헤더(`SectionHeader`) + 카드 리스트 패턴.
   - 학습 (언어, 기본 난이도, 미션 유형)
   - 알람 (기본 미루기 시간, 기본 문제 수)
   - 계정 (구매 복원, 로그아웃 placeholder)
   - 정보 (이용약관, 개인정보처리방침, 버전)
3. 각 ListTile에 좌측 작은 컬러 아이콘 (학습=책 / 알람=종 / 계정=프로필 / 정보=정보).

---

## 6. 모션·인터랙션

YAGNI 원칙으로 첫 릴리스는 다음 미세 모션만 도입:

- **Sunny breathe**: hero 카드의 Sunny가 4초 주기로 99%→101% scale (`flutter_animate` 기존 사용 중).
- **퀴즈 정답 시**: 화면 위 작은 Sunny Wink가 0.6초 등장 → fade out.
- **퀴즈 오답 시**: 위 동일 자리에 Sunny Sad 0.8초 등장 → fade out.
- **레벨업**: 페이지 전체에 confetti (`confetti` 패키지 기존 사용 중) + 중앙 Sunny Excited 1.5초.

복잡한 Lottie 애니메이션은 v1.1 이후로 deferred.

---

## 7. 변경되지 않는 부분 (Out of Scope)

- 학습 로직 (퀴즈 알고리즘, 마스터리 추적, XP formula) — v1.0 그대로
- 알람 트리거 OS 통합 (서비스, 권한 처리) — 변경 없음
- 데이터 모델 (Drift schema) — 변경 없음
- RevenueCat 통합 코드 — 변경 없음
- 로컬라이제이션 키 구조 — 새 컴포넌트의 키만 추가, 기존 키 제거 없음

이 영역은 v1.1+의 "학습 로직 고도화" 별도 spec에서 다룰 예정.

---

## 8. 자산 생성·관리

### 8.1 스크립트 추가

```
scripts/
  generate-mascot-assets.py   # 5종 표정 × SVG + PNG@1x/2x/3x → assets/mascot/
  generate-app-icon.py        # 1024 마스터 → iOS/Android 전체 사이즈
  generate-feature-graphic.py # (기존, Sunny 통합 업데이트)
```

세 스크립트 모두 동일 규칙:
- 입력: 디자인 토큰 (`#FF6B1A` 등 상수)
- 출력: 결정론적 (같은 입력 → 같은 PNG, idempotent)
- 의존성: Python 3, Pillow, rsvg-convert (이미 설치됨)
- CI 자동화 가능 (옵션, v1.1)

### 8.2 디렉토리 변경

```
assets/
  fonts/
    Pretendard-Regular.ttf       (new)
    Pretendard-Medium.ttf
    Pretendard-SemiBold.ttf
    Pretendard-Bold.ttf
    Pretendard-ExtraBold.ttf
  mascot/                        (new)
    sunny-smile.svg
    sunny-wink.svg
    sunny-sad.svg
    sunny-sleepy.svg
    sunny-excited.svg
    sunny-smile@1x.png ... @3x.png
    sunny-wink@1x.png ... @3x.png
    ...
```

`pubspec.yaml`의 assets 섹션에 `assets/mascot/` 추가.

---

## 9. 검증

### 9.1 자동 검증

- `flutter analyze` — 0 issues (현재 통과 기준 유지)
- 기존 통합 테스트 (`integration_test/app_flow_test.dart`) 그대로 통과
- 스크린샷 테스트 재실행 → `dist/store-screenshots-{69,62}/` 갱신
- 새 스크린샷 5장 (00_onboarding, 01_home, 02_alarm_add, 03_settings, 04_paywall) 모두 새 시각 적용 확인

### 9.2 수동 검증

- 다크모드 호환 (Material 3 dark theme로 자동, Sunny는 단색 표정으로 인식 유지)
- 작은 디바이스 (iPhone SE 1170×2532 정도) 레이아웃 깨짐 없는지
- 한국어 IME 입력 (알람 이름 등) 정상 처리
- 페이월 자동갱신 안내 텍스트가 화면 잘림 없이 표시

---

## 10. 구현 순서 (Implementation Plan은 별도 문서)

대략적인 순서만 제시. 상세 plan은 `superpowers:writing-plans` 스킬로 별도 생성.

1. 디자인 토큰 교체 (`app_colors.dart`, 신규 `app_shape.dart`, 신규 `app_spacing.dart`)
2. Pretendard 폰트 번들 + 타이포 테마 갱신 (`app.dart`)
3. Sunny SVG 5종 생성 + asset 등록
4. 앱 아이콘 마스터 생성 + 플랫폼별 사이즈 추출
5. 4개 화면 리디자인 (Home → Alarm Edit → Paywall → Settings 순)
6. 미세 모션 추가 (퀴즈 wink/sad, 레벨업 excited)
7. 스토어 스크린샷 재캡쳐
8. Feature graphic 재생성 (Sunny 통합)

각 단계는 독립적으로 PR 가능. 1~4는 시각 자산 작업, 5~6는 Flutter UI 작업, 7~8은 출시 자산 갱신.

---

## 부록 A. 영감 reference

| 앱 | 차용 요소 |
|---|---|
| Duolingo | 마스코트 중심, 단일 채도 컬러, 큰 둥근 모서리, 게임적 피드백 |
| 캐치잇 | 한국어 학습 톤, 친근한 카피, 미션 카드 패턴 |
| Drops | premium 페이월 톤, 가격 segment 디자인 |
| Mimo | hero 카드 + 인사말 패턴 |
| Cake | 영어 학습 + 한국 타깃의 모바일 우선 레이아웃 |

## 부록 B. 변경 위험

- **Pretendard 폰트 번들 사이즈**: 5개 weight × ~250KB = ~1.2MB 추가. AAB 사이즈 53→54MB. 사용자 다운로드는 architecture split으로 영향 최소. 허용 가능.
- **기존 사용자 인식 변경**: 아이콘 + 컬러가 바뀌면 기존 사용자 일부 혼란 가능. v1.0 출시 전이므로 영향 없음.
- **SVG 렌더링 비용**: `flutter_svg`는 첫 디코드만 비싸고 캐시. Sunny 5종을 미리 warm up하면 무시 가능.

---

## 부록 C. 합의된 사항 vs. 후속 검토

**합의됨 (이 spec)**:
- 모든 §1 결정 사항
- 5종 표정, 사용 컨텍스트
- 앱 아이콘 A (Sunny Centered)
- 4개 화면 리디자인 방향

**v1.1로 deferred**:
- 학습 로직 고도화 (XP 시각화, 스트릭 캘린더, 미션 다양화)
- 사회적 기능 (친구·랭킹)
- 고급 모션 (Lottie 도입)
- 다크모드 정밀 튜닝 (v1.0은 자동 변환만)
