# 옥모닝 영어 학습 앱 레퍼런스 분석 및 고도화 계획

검토일: 2026-05-15

## 결론

옥모닝은 말해보카나 Duolingo처럼 단독 학습 시간을 많이 뺏는 앱으로 경쟁하면 불리하다. 대신 "아침 알람을 끄려면 검증된 영어 표현을 풀어야 한다"는 강제성과 습관 트리거가 명확하므로, 성공 앱의 학습 루프를 그대로 복제하기보다 다음 방향으로 좁히는 것이 맞다.

1. 핵심 콘텐츠는 Reel 기반 검증 표현을 유지한다. 공개 병렬 말뭉치는 보조 문제 풀로만 쓰고, 출처/라이선스/품질 필터를 통과한 문장만 별도 source로 분리한다.
2. 무료 사용자는 "매일 아침 1회 학습 습관"을 충분히 경험하게 하고, 프리미엄은 더 많은 알람음/전체 표현/성장 기록/맞춤 복습을 여는 구조가 좋다.
3. 과금은 월간보다 연간을 우선 노출한다. 대형 앱들은 월간 가격을 높게 두고 연간 구독을 상대적으로 매력적으로 보이게 만든다.
4. 디자인은 학습 앱보다 알람 앱의 신뢰감이 우선이다. 홈 첫 화면은 오늘의 알람, 오늘 목표, 연속 기상, 레벨 진행이 즉시 보여야 한다.

## 레퍼런스 요약

| 앱 | 규모/신뢰 신호 | 핵심 루프 | 과금 구조 | 옥모닝 적용 판단 |
| --- | --- | --- | --- | --- |
| 말해보카 | Google Play 기준 100만+ 다운로드, 4.8점, 리뷰 11.5만+; 회사 뉴스룸 기준 누적 500만 다운로드 돌파. 출처: https://play.google.com/store/apps/details?hl=ko&id=kr.epopsoft.word / https://epop.ai/newsroom/4 | 20문제 진단, 수준 맞춤 퀴즈, 망각곡선 복습, 리그/캐릭터/다이아, 문법/리스닝/표현/회화 확장 | 인앱 구매 기반 구독. 공개 스토어에는 상세 가격보다 구독 존재와 랭킹/리뷰가 더 강하게 보임 | 옥모닝은 "20문제 진단"보다 첫 알람 후 난이도 적응이 자연스럽다. 약점 복습과 반복 노출은 반드시 도입 |
| Duolingo | FY2025 발표 기준 5천만+ DAU, $1B+ bookings. App Store 4.7점, 520만 Ratings. 출처: https://investors.duolingo.com/news-releases/news-release-details/duolingo-reports-fourth-quarter-and-full-year-2025-results / https://apps.apple.com/us/app/duolingo-language-lessons/id570060128 | 짧은 문제, streak, hearts, league, XP, 무료 접근성, Super/Max 업셀 | App Store IAP 예시: Super Duolingo $9.99, $83.99, $95.99 등. 무료+광고+하트 제한+구독 | 일일 목표, streak, XP는 그대로 유효. 단, 알람 해제 상황에서는 hearts처럼 실패 제한을 두면 UX가 위험하므로 성장 기록/복습 잠금을 프리미엄 가치로 둔다 |
| Cake | Google Play 100M+ 다운로드, 1.22M+ reviews, Editors' Choice. 출처: https://play.google.com/store/apps/details?id=me.mycake | 숏폼/셀럽/드라마 기반 실전 표현, daily updates, 10분 목표, 저장/복습, 퀴즈 | Cake Plus: 무제한 hearts, 광고 제거, Plus 전용 콘텐츠, 무제한 저장. App Store IAP 예시: 월 $13.99, 연 $74.99, Family $119.99 | Reel 기반 실전 표현 전략과 가장 잘 맞음. 다만 저작권이 걸린 영상 자체를 앱 안에 복제하지 말고, 검증된 표현/상황/출처 링크 중심으로 유지 |
| Speak | App Store 4.8점, 44K Ratings. 출처: https://apps.apple.com/us/app/speak-language-learning/id1286609883 | AI 회화, 실전 상황, 즉시 피드백, 북마크 | App Store IAP 예시: Annual Premium $83.99, Monthly Premium $17.99, Premium Plus $164.99/$39.99 | 말하기 미션은 프리미엄 차별화 가능성이 높다. 다만 알람 해제 안정성이 우선이므로 음성 인식 실패 시 입력 대체 경로를 유지 |
| ELSA Speak | App Store 4.8점, 109K Ratings. 출처: https://apps.apple.com/us/app/elsa-speak-english-learning/id1083804886 | 발음/억양/유창성 점수화, 시험/업무 상황별 코스, AI 피드백 | App Store IAP 예시: 월 $19.99, 3개월 $39.99-$47.99, 연 $71-$129.99 | 옥모닝의 스피킹은 "정밀 발음 코치"가 아니라 "깨어 있는지 확인하는 영어 말하기"로 포지셔닝해야 함 |
| Babbel | 25M subscriptions sold, 1.5M 5-star ratings 주장. 출처: https://apps.apple.com/us/app/babbel-language-learning/id829587759 | 10분 레슨, 실생활 회화, 스마트 리뷰, 전문가 제작 커리큘럼 | 구독형. 단기/장기 구독 및 웹 결제 할인 구조가 흔함 | 콘텐츠 품질과 커리큘럼 신뢰를 배워야 한다. 옥모닝도 "검증된 표현" 배지를 명확히 보여야 함 |
| Busuu | App Store 4.7점, 98K Ratings. 출처: https://apps.apple.com/us/app/busuu-language-learning/id379968583 | 무료로도 완결감 있는 레슨, 커뮤니티 피드백, 의미 중심 문제 | App Store IAP 예시: 월 $23.49, 연 $79.99. 무료 기능 다수, 전체 기능은 구독 | 무료 앱이 너무 빈약하면 이탈한다. 무료에서도 매일 알람 1개와 일부 표현 학습은 온전히 동작해야 함 |

## 공개 데이터셋 판단

| 데이터셋 | 장점 | 리스크 | 판단 |
| --- | --- | --- | --- |
| Tatoeba | CC BY 2.0 FR 문장/번역을 받을 수 있고, 영한 문장쌍 보강 가능. 출처: https://en.wiki.tatoeba.org/articles/show/using-the-tatoeba-corpus / https://tatoeba.org/gos/downloads | 자원봉사 기반이라 자연스러움/난이도/부적절 문장 필터가 필요. 출처 표기 필수 | 보조 문제로 적합. 앱 내 source/attribution 저장 필수 |
| AI Hub 영한 말뭉치 | 한국어-영어 병렬 자료가 크고 한국 사용자에게 맞음. 출처: https://www.aihub.or.kr/ | 계정/약관/다운로드 절차 및 상업적 사용 조건 확인 필요 | MVP 자동 탑재는 보류. 라이선스 검토 후 별도 import |
| OPUS/OpenSubtitles | 실전 대화체가 많음. 출처: https://opus.nlpl.eu/legacy/OpenSubtitles-v1.php | 자막 저작권/출처 품질/문장 정제 비용이 큼 | 상용 앱 기본 데이터로는 부적합 |

## 옥모닝 제품 원칙

1. 학습 루프: 알람 예약 -> 아침 퀴즈 -> XP/스트릭/오늘 목표 완료 -> 취약 표현 복습.
2. 무료 플랜: 기본 알람음 3개, 제한된 검증 표현, 하루 목표와 streak 표시, 알람 해제는 방해하지 않음.
3. 프리미엄: 전체 검증 표현, 고급 알람음, 성장 기록 저장, 취약 표현 맞춤 복습, 말하기 미션 강화.
4. 가격 구조: RevenueCat 상품은 월간/연간을 모두 준비하고, 앱 UI는 연간을 추천 상품으로 노출한다. 한국 시장 첫 실험가는 월 4,900-6,900원, 연 39,000-59,000원 범위를 A/B 후보로 둔다. 실제 가격은 App Store/Play Store 수수료와 RevenueCat 상품 설정 후 확정한다.
5. 콘텐츠 정책: 학습자에게 보이는 문장은 `instagram_reel` 검증 표현을 1순위로 유지한다. 공개 데이터는 `tatoeba_sentence` 같은 별도 source로 분리하고 attribution 표시가 가능할 때만 사용한다.

## 실행 계획

### 1차 적용

- 홈에 오늘 목표 진행률을 추가한다. Cake/ELSA처럼 매일 짧게 끝낼 목표를 보여주되, 옥모닝은 XP 기준으로 표시한다.
- Paywall 문구를 "문제 수 120개" 같은 고정 수량보다 "검증된 실전 표현 전체 라이브러리" 중심으로 바꾼다.
- RevenueCat offering에 annual package가 있을 때 연간 플랜을 추천으로 보여주고, 월간은 보조 선택지로 둔다.

### 2차 적용

- 표현 상세 provenance UI: Reel 출처, 상황, 난이도, 학습 상태를 보여준다. 2026-05-15 현재 `source/sourceUrl/sourceLabel` DB 필드와 퀴즈 카드 검증 출처 표시를 적용했다.
- 취약 표현 복습 큐: 틀린 표현, 오래 안 본 표현, 아직 숙달 안 된 표현을 우선 출제한다. 2026-05-15 현재 오답/미숙달/오래 미노출 항목을 우선 섞는 출제 랭킹을 적용했다.
- 공개 데이터 import 파이프라인: Tatoeba 영한 문장쌍을 받아 금칙어/길이/난이도/중복/출처 필터를 통과한 행만 별도 테이블 또는 source로 저장한다. 2026-05-15 현재 `tool/tatoeba_filter.dart`로 리뷰 후보 JSON을 생성하는 안전한 1차 도구를 추가했다. 출력물은 `review_status=needs_manual_review`이며 앱 번들에 자동 포함하지 않는다.

### 3차 적용

- 가격 실험: 월간/연간/가족 플랜 후보를 RevenueCat에 구성하고 conversion event를 기록한다. 2026-05-15 현재 상품 ID, 목표 가격, RevenueCat/App Store 설정 순서는 `docs/monetization-launch-checklist.md`에 정리했다.
- 말하기 미션 고도화: ELSA/Speak처럼 정밀 평가를 표방하기보다, 알람 해제에 안정적인 짧은 발화 체크와 입력 대체 경로를 강화한다.
- 온보딩 레벨 진단: 말해보카의 20문제 진단을 그대로 복제하지 않고, 첫 3회 알람 결과로 난이도를 자동 조정한다.
