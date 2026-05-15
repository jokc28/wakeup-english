import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_gradients.dart';
import '../../../../core/constants/iap_constants.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/services/subscription_provider.dart';
import '../../../../core/widgets/sunny.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  Offerings? _offerings;
  Package? _selectedPackage;
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
      final currentOffering = offerings?.current;
      setState(() {
        _offerings = offerings;
        _selectedPackage = currentOffering?.annual ?? currentOffering?.monthly;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final subState = ref.watch(subscriptionProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
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
                    const SizedBox(height: 8),

                    // Mascot — Sunny Excited (the brand reward moment)
                    const Sunny(
                      expression: SunnyExpression.excited,
                      size: 132,
                      semanticLabel: 'Premium unlock',
                    )
                        .animate()
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1, 1),
                          duration: 500.ms,
                          curve: Curves.easeOutBack,
                        )
                        .fadeIn(),
                    const SizedBox(height: 24),

                    // Title in Jua font
                    Text(
                      l10n.unlockPremium,
                      style: GoogleFonts.jua(
                        fontSize: 28,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.premiumSubtitle,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Value props with green checkmark circles
                    _buildFeatureItem(
                      context,
                      l10n.feature1Title,
                      l10n.feature1Desc,
                    ),
                    _buildFeatureItem(
                      context,
                      l10n.feature2Title,
                      l10n.feature2Desc,
                    ),
                    _buildFeatureItem(
                      context,
                      l10n.feature3Title,
                      l10n.feature3Desc,
                    ),
                    _buildFeatureItem(
                      context,
                      l10n.feature4Title,
                      l10n.feature4Desc,
                    ),
                    const SizedBox(height: 32),

                    // Price section with warm gradient background
                    if (_isLoading)
                      const CircularProgressIndicator(color: AppColors.primary)
                    else
                      _buildPriceSection(context),

                    const SizedBox(height: 20),

                    // Pulsing CTA button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: _isPurchasing ? null : _handlePurchase,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.action,
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
                                    ? l10n.subscribeNowButton
                                    : l10n.startTrialButton,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    )
                        .animate(
                          onPlay: (controller) => controller.repeat(
                            reverse: true,
                          ),
                        )
                        .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.03, 1.03),
                          duration: 2.seconds,
                          curve: Curves.easeInOut,
                        ),
                    const SizedBox(height: 12),

                    // Restore purchases
                    TextButton(
                      onPressed: _isPurchasing ? null : _handleRestore,
                      child: Text(l10n.restorePurchasesLabel),
                    ),
                    const SizedBox(height: 16),

                    // Terms & privacy footer
                    Text(
                      l10n.subscriptionTerms,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            unawaited(
                              _copyPolicyUrl(IapConstants.termsOfServiceUrl),
                            );
                          },
                          child: Text(
                            l10n.termsOfService,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        Text(' | ', style: theme.textTheme.bodySmall),
                        TextButton(
                          onPressed: () {
                            unawaited(
                              _copyPolicyUrl(IapConstants.privacyPolicyUrl),
                            );
                          },
                          child: Text(
                            l10n.privacyPolicy,
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
    String title,
    String subtitle,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Green checkmark circle
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.action,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 22,
            ),
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
    final l10n = AppLocalizations.of(context)!;
    final offering = _offerings?.current;
    final monthlyPackage = offering?.monthly;
    final annualPackage = offering?.annual;

    if (monthlyPackage == null && annualPackage == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.18),
          ),
        ),
        child: Text(
          l10n.premiumNoOfferings,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryLight,
              ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppGradients.premiumCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          if (annualPackage != null)
            _buildPlanOption(
              title: l10n.premiumAnnualPlan,
              price: l10n.premiumAnnualPrice(
                annualPackage.storeProduct.priceString,
              ),
              package: annualPackage,
              badge: l10n.premiumAnnualBadge,
            ),
          if (annualPackage != null && monthlyPackage != null)
            const SizedBox(height: 10),
          if (monthlyPackage != null)
            _buildPlanOption(
              title: l10n.premiumMonthlyPlan,
              price: l10n.premiumMonthlyPrice(
                monthlyPackage.storeProduct.priceString,
              ),
              package: monthlyPackage,
            ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              l10n.trialIncluded,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanOption({
    required String title,
    required String price,
    required Package package,
    String? badge,
  }) {
    final selected = _selectedPackage?.identifier == package.identifier;
    return InkWell(
      onTap: () => setState(() => _selectedPackage = package),
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? AppColors.action
                : Colors.white.withValues(alpha: 0.35),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? AppColors.action : Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.jua(
                          fontSize: 18,
                          color: selected
                              ? AppColors.textPrimaryLight
                              : Colors.white,
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.action,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            badge,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    price,
                    style: TextStyle(
                      color: selected
                          ? AppColors.textSecondaryLight
                          : Colors.white.withValues(alpha: 0.86),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePurchase() async {
    final package = _selectedPackage;
    if (package == null) return;

    setState(() => _isPurchasing = true);

    try {
      final service = ref.read(subscriptionServiceProvider);
      final success = await service.purchasePackage(package);

      if (success) {
        unawaited(ref.read(subscriptionProvider.notifier).refresh());
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.welcomeToPremium)),
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
        final l10n = AppLocalizations.of(context)!;
        if (success) {
          unawaited(ref.read(subscriptionProvider.notifier).refresh());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.purchasesRestored)),
          );
          context.pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.noPurchasesToRestore)),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isPurchasing = false);
      }
    }
  }

  Future<void> _copyPolicyUrl(String url) async {
    await Clipboard.setData(ClipboardData(text: url));
    if (!mounted) return;

    final l10n = AppLocalizations.of(context)!;
    final message = l10n.localeName == 'ko'
        ? '링크를 클립보드에 복사했습니다: $url'
        : 'Link copied to clipboard: $url';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
