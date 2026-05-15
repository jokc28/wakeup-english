# 옥모닝 — App Store 출시 런북

검토일: 2026-05-15. Apple App Store(`com.wakeup.english.wakeupEnglish`)에 처음
제출할 때 따르는 작업 순서이다. iOS 코드는 비교적 잘 준비되어 있으며 남은 일은
대부분 App Store Connect / Xcode 측 작업이다.

## A. 코드/리포지토리에 이미 준비된 것

| 항목 | 위치 / 값 |
|---|---|
| Bundle ID | `com.wakeup.english.wakeupEnglish` (`ios/Runner.xcodeproj/project.pbxproj`) |
| Development Team | `68ZV6L82DK` |
| 코드 사인 | Automatic |
| iOS deployment target | 14.0 (`ios/Podfile`, `Info.plist`) |
| 표시 이름 | 옥모닝 (`CFBundleDisplayName`) |
| 권한 문구 (한국어) | `NSMicrophoneUsageDescription`, `NSSpeechRecognitionUsageDescription`, `NSUserNotificationUsageDescription` |
| 백그라운드 모드 | `audio`, `fetch`, `processing` |
| 앱 아이콘 셋 | `ios/Runner/Assets.xcassets/AppIcon.appiconset/` 1024×1024 포함 완비 |
| Background task ID | `com.wakeup.wakeup_english.alarm` |
| RevenueCat 통합 | `lib/core/services/subscription_service.dart` |
| 상품 ID | `okmorning_premium_monthly`, `okmorning_premium_annual` (`iap_constants.dart`) |
| IPA 빌드 스크립트 | `scripts/build-release-ipa.sh` |

## B. 사용자가 직접 해야 하는 작업

> 양 스토어 공통 의존성(법무 페이지 게재, RevenueCat 셋업, 디자인 자산)이 끝났다는
> 전제로 작성되었다. 공통 의존성은 `docs/play-launch-runbook.md` 의 B-2~3 단계와
> 동일하므로 중복 작업하지 말 것.

### 1단계. App Store Connect 앱 레코드 생성

1. <https://appstoreconnect.apple.com> 접속 → My Apps → "+".
2. Platform: iOS, Name: **옥모닝**, Primary Language: Korean, Bundle ID: `com.wakeup.english.wakeupEnglish` (먼저 Developer Portal의 Certificates, Identifiers & Profiles에서 등록되어 있어야 함).
3. SKU: 임의(`okmorning-ios-001` 등).
4. User Access: Full Access.

### 2단계. 자동갱신 구독 등록

1. App Store Connect → 앱 → **App Store** 탭 → 가격 및 출시 가능성 (Pricing & Availability).
2. App Store → **In-App Purchases & Subscriptions** → Subscription Group 생성: `okmorning_premium` (이름은 자유롭게).
3. 그룹 안에 자동갱신 구독 2개 생성:
   - Product ID: `okmorning_premium_monthly`, Reference Name: "프리미엄 월간", 기간: 1개월, 가격: 5,900원 (KRW)
   - Product ID: `okmorning_premium_annual`, Reference Name: "프리미엄 연간", 기간: 1년, 가격: 49,000원 (KRW)
4. 두 상품 모두 Introductory Offer → Free Trial → 7일 설정.
5. Localization → 한국어 → display name / description 입력 ("프리미엄 월간" / 학습 데이터/프리미엄 알람음/취약 표현 복습 잠금해제 안내문).
6. Review screenshot 1장 첨부(페이월 화면 캡쳐).

### 3단계. RevenueCat ↔ App Store Connect 연결

1. RevenueCat 대시보드 → 옥모닝 프로젝트 → iOS 앱.
2. **App-Specific Shared Secret**: App Store Connect → 앱 → App Information → App-Specific Shared Secret 생성 → RevenueCat에 붙여넣기.
3. (권장) **In-App Purchase Key**: App Store Connect → Users and Access → Keys → In-App Purchase → Generate API Key → `.p8` 다운로드 → RevenueCat에 업로드. (Server-to-Server 알림 수신용)
4. Products import → Offering `default` 에 두 패키지 매핑.

### 4단계. App Store 메타데이터 입력

1. **앱 정보**:
   - 카테고리: 교육
   - 콘텐츠 권리: 본인 소유
   - 연령 등급 설문 (4+ 예상)
2. **가격 및 출시 가능성**: 무료(인앱 구매 있음).
3. **버전 정보**:
   - 프로모션 텍스트(170자): "매일 아침 영어 한 표현으로 시작하는 알람 시계."
   - 설명: `docs/play-store-listing.md`의 자세한 설명 본문 그대로 사용 (한국어).
   - 키워드(100자 제한): `영어,알람,영어공부,단어,영어회화,단어암기,모닝콜,어휘,말하기,학습`
   - 지원 URL: <https://okmorning.app/support> (또는 이메일 link 페이지)
   - 마케팅 URL(선택): <https://okmorning.app>
   - 저작권: `2026 <사업자명>`
4. **App Store 스크린샷** (필수):
   - 6.7" iPhone (Pro Max): 1290×2796, 최대 10장, 최소 3장
   - 6.5" iPhone: 1242×2688
   - 5.5" iPhone (선택): 1242×2208
   - iPad 12.9" (앱이 iPad 지원이면 필수): 2048×2732
   - 구성안은 `docs/play-store-listing.md`의 "스크린샷 구성안"과 동일하게 사용
5. **앱 미리보기 동영상**(선택, 후순위).
6. **앱 검토 정보**:
   - 연락처: <secalabs1@gmail.com>
   - 데모 계정: 로그인 불필요로 표기
   - 검토자 메모: "알람 시계 + 영어 학습 게이미피케이션 앱. 모든 학습 데이터는 단말 내부에 저장됨. 결제는 RevenueCat을 통해 처리. sandbox 테스터 계정으로 7일 무료 체험 검증 가능."

### 5단계. App Privacy 질문지

App Store Connect → 앱 정보 → App Privacy → "Get Started".

| 카테고리 | 수집 | 용도 | 사용자 연결 | 추적 |
|---|---|---|---|---|
| Purchases | Yes (Purchase History) | App Functionality, Analytics | Not linked to user | No tracking |
| Identifiers | Yes (Device ID 익명) | App Functionality | Not linked to user | No tracking |
| Audio Data | Yes (Microphone) | App Functionality | Not linked to user | No tracking |
| 그 외 항목 (이름·이메일·위치·검색·콘텐츠·접근가능성·헬스 등) | No | — | — | — |

> ATT(App Tracking Transparency)는 **불필요**. 추적 SDK가 없으므로
> `NSUserTrackingUsageDescription`을 추가하지 않는다.

### 6단계. 수출 규정 (Export Compliance)

- **암호화 사용**: Yes (HTTPS 통신만 사용)
- **표준 암호화만 사용**: Yes → ATS-only이므로 면제 적용 신고로 간단 처리.
- `Info.plist`에 `ITSAppUsesNonExemptEncryption = NO`를 추가해 두면 매 빌드마다 묻지 않음.
  - 추가 위치: `ios/Runner/Info.plist`
  - 키: `ITSAppUsesNonExemptEncryption`, 값: `<false/>` (불리언 NO)

### 7단계. 빌드 + TestFlight

```sh
export REVENUECAT_IOS_API_KEY=appl_실제키
./scripts/build-release-ipa.sh
# 또는 Xcode → Runner → Any iOS Device → Product → Archive → Distribute App → App Store Connect
```

Transporter.app 또는 Xcode Organizer로 업로드 → TestFlight 내부 테스터 추가 → 처리 완료 후 sandbox 검증.

### 8단계. Sandbox 검증 (6항목)

- [ ] 월간 sandbox 구매 성공
- [ ] 연간 sandbox 구매 성공
- [ ] 구매 복원 성공
- [ ] 구독 해지 후 프리미엄 기능 잠금
- [ ] 7일 무료 체험 종료 후 자동 결제 안내
- [ ] RevenueCat 대시보드에서 `premium` entitlement 활성화 확인

> Apple sandbox는 가속 갱신을 적용하므로 7일 → 3분, 1개월 → 5분 등으로
> 빠르게 검증 가능 (App Store Connect → Users and Access → Sandbox Testers 사용).

### 9단계. App Review 제출

App Store Connect → 앱 → 새 버전 → 빌드 선택 → Submit for Review.

- 검토 기간: 보통 24~48시간, 첫 제출은 더 걸릴 수 있음.
- 거절 시 Resolution Center에서 사유를 받아 수정 후 재제출.
