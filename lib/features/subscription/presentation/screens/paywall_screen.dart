import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/subscription_provider.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  Offerings? _offerings;
  bool _isLoading = true;
  bool _isPurchasing = false;

  @override
  void initState() {
    super.initState();
    _loadOfferings();
  }

  Future<void> _loadOfferings() async {
    final service = ref.read(subscriptionServiceProvider);
    final offerings = await service.getOfferings();
    if (mounted) {
      setState(() {
        _offerings = offerings;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subState = ref.watch(subscriptionProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // Premium icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryLight],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.workspace_premium,
                        size: 44,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      '프리미엄 잠금 해제',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '영어 알람의 모든 기능을 이용해 보세요',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Feature list
                    _buildFeatureItem(
                      context,
                      Icons.library_books,
                      '120개 퀴즈 문제',
                      '모든 카테고리와 난이도의 전체 라이브러리',
                    ),
                    _buildFeatureItem(
                      context,
                      Icons.music_note,
                      '10가지 알람 소리',
                      '파도 소리, 피아노, 재즈 등 프리미엄 사운드',
                    ),
                    _buildFeatureItem(
                      context,
                      Icons.trending_up,
                      '고급 학습 기능',
                      '취약 부분에 집중하는 맞춤형 퀴즈',
                    ),
                    _buildFeatureItem(
                      context,
                      Icons.auto_awesome,
                      '새로운 콘텐츠 업데이트',
                      '정기적인 새 문제 및 소리 추가',
                    ),
                    const SizedBox(height: 32),

                    // Price section
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      _buildPriceSection(context),

                    const SizedBox(height: 16),

                    // CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: _isPurchasing ? null : _handlePurchase,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _isPurchasing
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                subState.isTrialActive
                                    ? '지금 구독하기'
                                    : '무료 체험 시작',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Restore purchases
                    TextButton(
                      onPressed: _isPurchasing ? null : _handleRestore,
                      child: const Text('구매 복원'),
                    ),
                    const SizedBox(height: 16),

                    // Terms & privacy
                    Text(
                      '구독은 현재 기간 종료 최소 24시간 전에 해지하지 않으면 자동으로 갱신됩니다. 기기 설정에서 구독을 관리할 수 있습니다.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // TODO: Open terms URL
                          },
                          child: Text(
                            '이용약관',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        Text(' | ', style: theme.textTheme.bodySmall),
                        TextButton(
                          onPressed: () {
                            // TODO: Open privacy URL
                          },
                          child: Text(
                            '개인정보 처리방침',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(BuildContext context) {
    final theme = Theme.of(context);
    final offering = _offerings?.current;
    final monthlyPackage = offering?.monthly;

    if (monthlyPackage == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Column(
          children: [
            Text(
              '프리미엄 월간',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '가격 정보 없음',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      child: Column(
        children: [
          Text(
            '프리미엄 월간',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${monthlyPackage.storeProduct.priceString}/월',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '7일 무료 체험 포함',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePurchase() async {
    final offering = _offerings?.current;
    final monthlyPackage = offering?.monthly;
    if (monthlyPackage == null) return;

    setState(() => _isPurchasing = true);

    try {
      final service = ref.read(subscriptionServiceProvider);
      final success = await service.purchasePackage(monthlyPackage);

      if (success) {
        ref.read(subscriptionProvider.notifier).refresh();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('프리미엄에 오신 것을 환영합니다!')),
          );
          context.pop();
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isPurchasing = false);
      }
    }
  }

  Future<void> _handleRestore() async {
    setState(() => _isPurchasing = true);

    try {
      final service = ref.read(subscriptionServiceProvider);
      final success = await service.restorePurchases();

      if (mounted) {
        if (success) {
          ref.read(subscriptionProvider.notifier).refresh();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('구매가 복원되었습니다!')),
          );
          context.pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('복원할 구매 내역이 없습니다')),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isPurchasing = false);
      }
    }
  }
}
