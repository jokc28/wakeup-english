# 옥모닝 유료화 설정 체크리스트

검토일: 2026-05-15

## 현재 앱 구현 상태

- RevenueCat SDK 초기화는 구현되어 있다.
- 앱은 `premium` entitlement가 활성화되면 프리미엄으로 판단한다.
- Paywall은 RevenueCat current offering에서 annual package가 있으면 연간 상품을 추천으로 먼저 보여준다.
- RevenueCat API key는 빌드 타임 환경값으로 주입한다.
- 실제 결제 활성화는 App Store Connect / Play Console / RevenueCat 설정이 끝나야 가능하다.

## 상품 구조

| 구분 | Product ID | 목표 가격 | 역할 |
| --- | --- | --- | --- |
| 월간 | `okmorning_premium_monthly` | 5,900원 | 진입 장벽 낮은 보조 옵션 |
| 연간 | `okmorning_premium_annual` | 49,000원 | 기본 추천 상품 |
| 가족 연간 | `okmorning_premium_family_annual` | 79,000원 | 2차 실험 후보 |

첫 출시에서는 월간/연간만 열고, 가족 플랜은 리뷰/수요가 생긴 뒤 붙이는 편이 안전하다.

## RevenueCat 설정

1. iOS app과 Android app을 RevenueCat 프로젝트에 연결한다.
2. Entitlement ID를 `premium`으로 만든다.
3. Products에 월간/연간 상품을 추가한다.
4. Offering ID는 `default`로 만들고, monthly package와 annual package를 연결한다.
5. annual package가 추천으로 보이도록 앱 UI는 이미 annual 우선 선택으로 구현되어 있다.
6. RevenueCat API key를 빌드 시 `--dart-define`으로 넣는다.

예시:

```sh
flutter build ios --release \
  --dart-define=REVENUECAT_IOS_API_KEY=appl_xxx

flutter build appbundle --release \
  --dart-define=REVENUECAT_ANDROID_API_KEY=goog_xxx
```

## App Store / Play Store 설정

- App Store Connect에서 auto-renewable subscription group을 만든다.
- 월간/연간 상품 ID를 코드의 Product ID와 동일하게 만든다.
- 7일 무료 체험은 스토어 상품 설정에서 구성한다.
- 개인정보 처리방침과 이용약관 URL은 출시 전에 실제 URL로 교체한다.
- Play Console에서도 동일한 상품 ID와 가격대를 구성한다.

## 출시 전 확인

- sandbox 계정으로 월간 구매가 성공하는지 확인한다.
- sandbox 계정으로 연간 구매가 성공하는지 확인한다.
- 구매 복원이 동작하는지 확인한다.
- 구독 해지/만료 후 프리미엄 기능이 잠기는지 확인한다.
- RevenueCat customer dashboard에서 entitlement가 `premium`으로 활성화되는지 확인한다.

## 유료화 원칙

알람 해제 자체를 과금으로 막지 않는다. 유료화는 전체 검증 표현, 프리미엄 알람음, 성장 기록, 취약 표현 복습, 말하기 미션 강화에 걸어야 한다. 옥모닝은 아침 실패 경험이 생기면 이탈 위험이 커지므로, 결제 압박보다 루틴의 누적 가치를 보여주는 방식이 맞다.
