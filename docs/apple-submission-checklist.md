# 옥모닝 App Store 제출 — 단계별 실행 체크리스트

> **목적**: 동료(개인사업자 등록자)를 만났을 때 한 번에 끝낼 수 있도록 순서·필수 정보·예상 시간을 정리.
> **선행 조건**: Apple Developer Program ($99/년) 가입 완료 (이미 Team ID `68ZV6L82DK` 확인됨).

## 사전 준비물 (동료에게 받을 정보)

이 작업 전에 한 번에 모아두면 좋습니다:

| 정보 | 어디서 받음 | 용도 |
|---|---|---|
| 사업자등록증 PDF 또는 사업자등록번호 (또는 개인 주민번호) | 동료 | Apple Tax Forms (W-9 한국 변형 또는 W-8BEN) |
| 정산 받을 한국 계좌번호 + 은행명 + 예금주명 | 동료 | Apple Banking |
| 사업체 주소 (한글 + 영문) | 동료 | App Store Connect 회사 정보 |
| 사업체 전화번호 | 동료 | App Store Connect |
| 동료 본인 Apple ID 이메일 | 동료 | 필요 시 팀 멤버 추가 |

---

## Phase 1. Bundle ID 등록 (10분, 결제 정보 없이도 가능)

본인 Apple ID로 진행. 동료 정보 불필요.

1. <https://developer.apple.com/account/resources/identifiers/list> 접속 → Sign in
2. 우상단 **+** 버튼 → **App IDs** 선택 → Continue
3. Type: **App** → Continue
4. 입력:
   - **Description**: `옥모닝` (또는 OK-Morning)
   - **Bundle ID**: ⚪ Explicit → `com.wakeup.english.wakeupEnglish` (⚠️ Flutter 프로젝트와 정확히 일치 필수)
   - **Capabilities** 체크할 것:
     - ☑ **In-App Purchase** (구독)
     - ☑ **Push Notifications** (선택, 향후 streak 알림)
5. Continue → Register

---

## Phase 2. App Store Connect 앱 레코드 생성 (10분, 결제 없이 가능)

1. <https://appstoreconnect.apple.com/apps> 접속
2. **My Apps** → 좌상단 **+** → **New App**
3. 입력:
   - **Platforms**: ☑ iOS
   - **Name**: `옥모닝 - 영어 퀴즈 알람` (Play와 동일)
   - **Primary Language**: Korean
   - **Bundle ID**: 방금 만든 `com.wakeup.english.wakeupEnglish` 선택
   - **SKU**: `okmorning-ios-001` (자유, 내부 식별자)
   - **User Access**: Full Access
4. Create

---

## Phase 3. Agreements, Tax, and Banking (30~60분, **동료 정보 필요**)

⚠️ 구독 등록과 출시에 필수. 가장 시간 걸리는 단계.

### 3-1. Paid Apps Agreement 활성화

1. App Store Connect → **Business** (좌상단 메뉴) → **Agreements, Tax, and Banking**
2. "Paid Apps" 행에서 **Request** 또는 **Get Started**
3. Master Agreement 동의

### 3-2. Tax Forms

한국에서 가장 자주 쓰이는 양식:
- **W-8BEN-E** (사업체) 또는 **W-8BEN** (개인)
- 사업자등록번호가 있다면 W-8BEN-E
- 동료가 한국 거주 + 한국 사업자 → W-8BEN-E의 **Treaty Benefit** 섹션에 Korea 선택 (15% 원천세 → 10%로 감면)

폼 필드:
| 필드 | 입력 |
|---|---|
| Legal Name | 동료 사업체 영문명 (예: "OK Morning Co., Ltd." 또는 동료 영문 이름) |
| Country | South Korea |
| TIN | 사업자등록번호 (10자리) 또는 주민번호 |
| Address | 사업체 영문 주소 |

### 3-3. Banking

| 필드 | 입력 |
|---|---|
| **Bank Account Holder Name** | 영문 (계좌 명의와 동일) |
| **Bank Country** | South Korea |
| **Bank Name** | 영문 (예: "Kookmin Bank") |
| **Bank Account Number** | 계좌번호 |
| **SWIFT Code** | 한국 은행 SWIFT 자동 검색 (예: KB CZNBKRSEXXX) |

### 3-4. Contact 정보

| 필드 | 입력 |
|---|---|
| Senior Executive | 동료 본인 |
| Legal | 동료 본인 |
| Finance | 동료 본인 |
| Marketing | 동료 또는 본인 |
| Technical | 본인 (`secalabs1@gmail.com`) |

Submit 후 **Apple 검토 1~2일**. 승인되면 Subscriptions 등록 가능.

---

## Phase 4. App Information 채우기 (15분, banking 대기 중 가능)

App Store Connect → 옥모닝 앱 → **App Information** 좌측 메뉴.

| 섹션 | 입력 |
|---|---|
| **Subtitle** (30자) | `영어 퀴즈로 깨우는 모닝콜` |
| **Privacy Policy URL** | `https://jokc28.github.io/wakeup-english/privacy/` |
| **Category Primary** | Education |
| **Category Secondary** (선택) | Lifestyle |
| **Content Rights** | ☑ Does not contain or access third-party content |
| **Age Rating** | 설문 → 모두 None / Infrequent/Mild 없음 → 4+ 등급 |

저장.

---

## Phase 5. Subscriptions 등록 (10분, **Phase 3 승인 후**)

App Store Connect → 옥모닝 앱 → **Subscriptions** (좌측 메뉴).

### 5-1. Subscription Group 만들기

**+ Subscription Group** → Reference Name: `okmorning_premium` → Create

### 5-2. 월간 구독

그룹 안에서 **+ Subscription** 클릭.

| 필드 | 입력 |
|---|---|
| **Reference Name** | `프리미엄 월간` |
| **Product ID** | `okmorning_premium_monthly` ⚠️ 정확히 일치 |
| **Subscription Duration** | 1 Month |
| **Price** | 5,900 KRW (가격표에서 South Korea Tier 선택) |

Localization (Korean):
- Display Name: `옥모닝 프리미엄 월간`
- Description: `검증된 실전 표현 라이브러리, 프리미엄 알람음, 성장 기록과 맞춤 복습, 강화된 말하기 미션을 무제한 사용할 수 있습니다.`

App Review:
- Review Screenshot: `dist/store-screenshots-69/04_paywall.png`
- Review Notes: "월간 자동 갱신 구독. 7일 무료 체험 포함. RevenueCat을 통해 처리."

### 5-3. Free Trial Introductory Offer

월간 구독 페이지 → **Subscription Prices** 아래 **+ Introductory Offer**:
- Type: Free Trial
- Duration: 7 days
- Eligibility: New Subscribers

### 5-4. 연간 구독 동일 패턴

- Product ID: `okmorning_premium_annual`
- Duration: 1 Year
- Price: 49,000 KRW
- 7-day Free Trial 포함

---

## Phase 6. App Privacy 질문지 (10분)

App Store Connect → 옥모닝 앱 → **App Privacy** → **Get Started**.

| Data Type | Collected? | Linked to User? | Used to Track? | Purpose |
|---|---|---|---|---|
| Purchases > Purchase History | Yes | Not linked | No | App Functionality |
| Identifiers > Device ID (RevenueCat anonymous) | Yes | Not linked | No | App Functionality |
| Audio Data > Microphone (말하기 미션) | Yes | Not linked | No | App Functionality |
| 그 외 (이름·이메일·위치·검색·콘텐츠 등) | No | — | — | — |

**Note**: ATT (App Tracking Transparency) 불필요 — 추적 SDK 없음.

---

## Phase 7. 메타데이터 + 스크린샷 업로드 (20분)

App Store Connect → 옥모닝 앱 → **iOS 1.0 Prepare for Submission** 화면.

### Promotional Text (170자, 출시 후 수정 가능)
```
매일 아침 영어 한 표현으로 시작하는 알람 시계. 단어와 표현을 쌓아 레벨 1→50까지 성장하세요.
```

### Description
`docs/play-store-listing.md`의 "자세한 설명" 본문 그대로 복붙.

### Keywords (100자, 콤마 구분)
```
영어,알람,영어공부,단어,영어회화,단어암기,모닝콜,어휘,말하기,학습
```

### Support URL
```
https://jokc28.github.io/wakeup-english/support/
```

### Marketing URL (선택)
```
https://jokc28.github.io/wakeup-english/
```

### Copyright
```
2026 옥모닝
```

### Screenshots
**6.9" Display** (iPhone 17 Pro Max — 필수):
```
/Users/okchul.jung/Desktop/private/okapp/wakeup_english/dist/store-screenshots-69/
  00_onboarding.png
  01_home.png
  02_alarm_add.png
  03_settings.png
  04_paywall.png
```

**6.1" Display** (선택):
```
/Users/okchul.jung/Desktop/private/okapp/wakeup_english/dist/store-screenshots-62/
```

**iPad 12.9"** (선택):
```
/Users/okchul.jung/Desktop/private/okapp/wakeup_english/dist/store-screenshots-ipad13/
```

### App Review Information
| 필드 | 입력 |
|---|---|
| Sign-In Required | No |
| Contact First Name | 본인 |
| Contact Last Name | 본인 |
| Email | secalabs1@gmail.com |
| Phone | 본인 전화 |
| Notes | "알람 시계 + 영어 학습 게이미피케이션 앱. 모든 학습 데이터는 단말 내부에 저장됨. 결제는 RevenueCat을 통해 처리. 7일 무료 체험 후 자동 갱신." |

### Version Release
- ⚪ **Manually release this version** (검토 통과 후 수동 출시 — 권장)

### Export Compliance
이미 `Info.plist`에 `ITSAppUsesNonExemptEncryption = NO` 추가됨 → Apple이 자동으로 면제 처리. 추가 작업 없음.

---

## Phase 8. Build 업로드 (10분)

### 8-1. Xcode → Archive

이미 빌드된 archive 사용:
```
/Users/okchul.jung/Desktop/private/okapp/wakeup_english/build/ios/archive/Runner.xcarchive
```

또는 Xcode에서 직접:
1. Xcode → Open → `ios/Runner.xcworkspace`
2. 상단 device selector → "Any iOS Device (arm64)"
3. Product → Archive
4. Window → Organizer → Archives 탭에서 새 archive 선택

### 8-2. Distribute App

1. Organizer에서 archive 선택 → **Distribute App**
2. **App Store Connect** → Next
3. **Upload** → Next
4. Distribution options: 기본값 (Include bitcode = N/A, Strip Swift symbols = Yes) → Next
5. **Automatically manage signing** → Next → Apple ID 프롬프트 시 본인 로그인
6. Distribution Certificate 자동 생성 (없으면)
7. Review → **Upload**
8. 업로드 10~30분 처리 대기

### 8-3. TestFlight 처리

App Store Connect → 옥모닝 앱 → **TestFlight** → 빌드가 "Processing" → "Ready to Test"로 바뀜 (보통 30분 이내).

내부 테스트:
- TestFlight → Internal Testing → **+** → 본인 이메일 추가
- 본인 폰에서 TestFlight 앱 → 옥모닝 → Install

---

## Phase 9. Submit for Review (5분)

App Store Connect → 옥모닝 앱 → iOS 1.0 → 모든 섹션 ✓ 확인 → 우상단 **Submit for Review**.

### 검토 시간
- 초기 검토: 24~48시간 (한국 시간 기준)
- 거절 시: Resolution Center에서 사유 받기 → 수정 → 재제출

---

## 트러블슈팅 자주 나오는 거절 사유

| 사유 | 대응 |
|---|---|
| "App Privacy Section incomplete" | Phase 6 다시 확인, 모든 데이터 유형 답변 |
| "Subscription terms not visible in paywall" | 페이월에 "자동 갱신, 24시간 전 해지 가능" 문구 + 약관/개인정보 링크 (이미 있음) |
| "Bundle ID mismatch" | Phase 1의 ID = 코드의 ID 정확히 일치 확인 |
| "Microphone usage not clear" | Info.plist의 `NSMicrophoneUsageDescription` 텍스트 검토 (이미 한국어로 정확히 작성됨) |
| "Export compliance" | `ITSAppUsesNonExemptEncryption = NO` 확인 (이미 추가됨) |

---

## 예상 총 소요 시간

- 동료와 같이 있을 때: **3~4시간** (Phase 1, 2, 3, 4, 5, 6, 7 전부)
- 그 후 본인 혼자: Phase 8 (10분) + 검토 대기 1~2일 + Phase 9 (5분) + 검토 1~2일

---

## 우선순위 (시간 부족 시)

**필수**: Phase 1 → 2 → 3 → 5 → 6 → 7 → 8 → 9
**스킵 가능**: Phase 4의 Marketing URL, secondary category 등 선택 항목
