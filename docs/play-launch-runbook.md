# 옥모닝 — Play Store 출시 런북

검토일: 2026-05-15. 본 문서는 옥모닝(`com.wakeup.english.wakeup_english`)을 Google
Play 스토어에 처음 출시할 때 따르는 작업 순서이다. 코드 수준에서 가능한 준비는
끝났고, 남은 작업은 외부 시스템(Play Console / RevenueCat / 정책 페이지 호스팅)에서
진행해야 한다.

## A. 코드/리포지토리에 이미 준비된 것

| 항목 | 위치 |
|---|---|
| 릴리즈 서명 분기 | `android/app/build.gradle.kts` (`hasReleaseSigning` 조건문) |
| 키 properties 템플릿 | `android/key.properties.example` |
| 키스토어 생성 스크립트 | `scripts/generate-upload-keystore.sh` |
| AAB 빌드 스크립트 | `scripts/build-release-aab.sh` |
| RevenueCat SDK 통합 | `lib/core/services/subscription_service.dart` |
| Paywall UI | `lib/features/subscription/presentation/screens/paywall_screen.dart` |
| 상품 ID/가격 상수 | `lib/core/constants/iap_constants.dart` |
| 스토어 등록 카피 | `docs/play-store-listing.md` |
| 데이터 안전 양식 답안 | `docs/data-safety.md` |
| 권한 사유서 | `docs/permission-justifications.md` |
| 개인정보처리방침 초안 | `docs/privacy-policy-draft.md` |
| 이용약관 초안 | `docs/terms-of-service-draft.md` |
| targetSdk | Flutter 3.38.9 기본값 = API 35 ✓ (2026년 신규 출시 요건 충족) |

## B. 사용자가 직접 해야 하는 작업 (체크리스트 순서)

### 1단계. 키스토어 생성 (한 번만)

```sh
./scripts/generate-upload-keystore.sh
# 프롬프트에 따라 storePassword / keyPassword / DN(이름·조직·국가코드) 입력
# 생성된 ~/.android-keystores/wakeup-english/upload-keystore.jks 백업 필수
```

```sh
cp android/key.properties.example android/key.properties
# android/key.properties 수정:
#   storePassword=실제값
#   keyPassword=실제값
#   keyAlias=upload
#   storeFile=/Users/<you>/.android-keystores/wakeup-english/upload-keystore.jks
```

> ❗ `android/key.properties`와 `.jks` 파일은 절대 git에 커밋하지 말 것.
> `.gitignore`에 이미 포함되어 있는지 출시 전 확인.

### 2단계. 개인정보처리방침 / 이용약관 공개 URL 확보

- 도메인은 **필수가 아님**. 다음 중 하나를 골라 무료로 호스팅하면 된다:
  - **GitHub Pages**: 공개 repo → `Settings → Pages` → md 파일 그대로 표시
  - **Notion 공개 페이지**: 워크스페이스 → Share → Publish to web
  - **Vercel / Netlify**: `*.vercel.app` / `*.netlify.app` 서브도메인
  - **Google Sites**: `sites.google.com/view/<slug>`
- `docs/privacy-policy-draft.md` → 변호사 검토 → 실제 페이지 게재.
- `docs/terms-of-service-draft.md` → 변호사 검토 → 실제 페이지 게재.
- 게재 완료 후 `lib/core/constants/iap_constants.dart`의 두 URL 상수를 실제
  URL로 교체.

### 3단계. RevenueCat 셋업

1. <https://app.revenuecat.com> 가입.
2. Project 생성: 이름 `okmorning`.
3. Android 앱 추가: package name `com.wakeup.english.wakeup_english`.
4. iOS 앱 추가: bundle ID `com.wakeup.english.wakeupEnglish` (출시 시).
5. Entitlement 생성: `premium`.
6. Products 생성: `okmorning_premium_monthly`, `okmorning_premium_annual`.
7. Offering 생성: `default` (monthly + annual package 연결).
8. API 키 확인 (Android `goog_*`, iOS `appl_*`).

### 4단계. Play Console 셋업

1. <https://play.google.com/console> 개발자 등록 ($25).
2. 새 앱 생성:
   - 이름: 옥모닝
   - 기본 언어: 한국어
   - 유료/무료: 무료 (앱 내 구매 있음)
3. **앱 콘텐츠** 메뉴:
   - 개인정보 처리방침 URL 입력 (2단계에서 게재한 URL)
   - 광고 포함 여부: 아니오
   - 앱 액세스 (로그인 필요 여부): 로그인 없이 모든 기능 접근 가능
   - 콘텐츠 등급 설문 (IARC)
   - 타겟 대상층: 만 13세 이상
   - 데이터 안전: `docs/data-safety.md` 참고해서 입력
   - 정부 앱 여부: 아니오
4. **앱 카테고리**: 교육 → 어학
5. **메인 스토어 등록정보**: `docs/play-store-listing.md` 본문 복사
6. **그래픽 자산 업로드**: 디자이너 작업 결과물 업로드
7. **인앱 상품 → 구독** 생성:
   - 상품 ID: `okmorning_premium_monthly`, 가격: 5,900원, 청구 기간: 매월
   - 상품 ID: `okmorning_premium_annual`, 가격: 49,000원, 청구 기간: 매년
   - 두 상품 모두 7일 무료 체험 추가
8. Play Console과 RevenueCat 연결 (서비스 계정 JSON 키 업로드).

### 5단계. 내부 테스트 트랙 업로드 + Sandbox 검증

```sh
export REVENUECAT_ANDROID_API_KEY=goog_실제키
./scripts/build-release-aab.sh
# → build/app/outputs/bundle/release/app-release.aab
```

Play Console → 테스트 → 내부 테스트 → 새 버전 만들기 → AAB 업로드 → 테스터
이메일 추가 → 검토 시작.

테스터 단말에서 검증할 항목:
- [ ] 월간 sandbox 구매 성공
- [ ] 연간 sandbox 구매 성공
- [ ] 구매 복원 성공
- [ ] 구독 해지 후 프리미엄 기능 잠금 확인
- [ ] 7일 무료 체험 종료 후 자동 결제 안내 (한국 규정 2025-02-14 시행)
- [ ] RevenueCat 대시보드에서 `premium` entitlement 활성화 확인

### 6단계. 프로덕션 출시

내부 테스트 통과 후 → 프로덕션 트랙으로 승격 → 검토 신청.
Google Play 검토 기간: 보통 1~3일, 신규 계정/구독 앱은 더 걸릴 수 있음.
