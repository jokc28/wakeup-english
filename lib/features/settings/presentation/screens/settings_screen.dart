import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/mission_type_provider.dart';
import '../../../../core/services/subscription_provider.dart';

/// Settings screen for app configuration
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final subState = ref.watch(subscriptionProvider);
    final missionState = ref.watch(missionTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Subscription Status Card
          _buildSubscriptionCard(context, subState),
          const SizedBox(height: 24),

          // Language Section
          _buildSectionHeader(context, '언어'),
          _buildSettingsTile(
            context,
            icon: Icons.language,
            title: '언어',
            subtitle: '한국어',
            onTap: () => _showLanguageDialog(context),
          ),
          const SizedBox(height: 24),

          // Default Alarm Settings
          _buildSectionHeader(context, '기본 알람 설정'),
          _buildSettingsTile(
            context,
            icon: Icons.quiz_outlined,
            title: '기본 문제 수',
            subtitle: '3문제',
            onTap: () => _showQuizCountDialog(context),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.speed_outlined,
            title: '기본 난이도',
            subtitle: '보통',
            onTap: () => _showDifficultyDialog(context),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.snooze_outlined,
            title: '기본 미루기 시간',
            subtitle: '5분',
            onTap: () => _showSnoozeDialog(context),
          ),
          const SizedBox(height: 24),

          // Mission Type Selector
          _buildSectionHeader(context, '미션 유형'),
          _buildSwitchTile(
            context,
            icon: Icons.shuffle,
            title: '철자 맞추기',
            subtitle: '영어 단어의 철자를 맞추는 미션',
            value: missionState.wordScrambleEnabled,
            onChanged: (value) {
              ref.read(missionTypeProvider.notifier).toggleWordScramble(value);
            },
          ),
          _buildSwitchTile(
            context,
            icon: Icons.mic,
            title: '말하기 도전',
            subtitle: '영어 문장을 소리 내어 말하는 미션',
            value: missionState.speakingChallengeEnabled,
            onChanged: (value) {
              ref.read(missionTypeProvider.notifier).toggleSpeakingChallenge(value);
            },
          ),
          const SizedBox(height: 24),

          // Sound Settings
          _buildSectionHeader(context, '소리 및 진동'),
          _buildSwitchTile(
            context,
            icon: Icons.vibration,
            title: '진동',
            subtitle: '알람 울릴 때 진동',
            value: true,
            onChanged: (value) {
              // TODO: Implement preference saving
            },
          ),
          _buildSwitchTile(
            context,
            icon: Icons.volume_up_outlined,
            title: '점진적 볼륨',
            subtitle: '알람 볼륨을 점진적으로 높이기',
            value: false,
            onChanged: (value) {
              // TODO: Implement preference saving
            },
          ),
          const SizedBox(height: 24),

          // Subscription Section
          _buildSectionHeader(context, '구독'),
          if (!subState.isPremium)
            _buildSettingsTile(
              context,
              icon: Icons.workspace_premium,
              title: '프리미엄으로 업그레이드',
              subtitle: '모든 소리 및 문제 잠금 해제',
              onTap: () => AppRouter.navigateToPaywall(),
            ),
          _buildSettingsTile(
            context,
            icon: Icons.restore,
            title: '구매 복원',
            subtitle: '이전 구매 내역 복원',
            onTap: () => _handleRestore(context, ref),
          ),
          if (kDebugMode)
            _buildSettingsTile(
              context,
              icon: subState.isPremium ? Icons.toggle_on : Icons.toggle_off,
              title: '[Debug] 프리미엄 모드',
              subtitle: subState.isPremium ? '활성화됨 - 탭하여 해제' : '비활성화됨 - 탭하여 활성화',
              titleColor: Colors.deepOrange,
              onTap: () {
                ref.read(subscriptionProvider.notifier).debugTogglePremium();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      subState.isPremium
                          ? '프리미엄 모드 해제됨'
                          : '프리미엄 모드 활성화됨',
                    ),
                  ),
                );
              },
            ),
          const SizedBox(height: 24),

          // About Section
          _buildSectionHeader(context, '정보'),
          _buildSettingsTile(
            context,
            icon: Icons.info_outline,
            title: '버전',
            subtitle: '1.0.0',
            onTap: null,
          ),
          _buildSettingsTile(
            context,
            icon: Icons.description_outlined,
            title: '오픈소스 라이선스',
            subtitle: '사용된 오픈소스 라이선스',
            onTap: () => _showLicenses(context),
          ),
          const SizedBox(height: 24),

          // Danger Zone
          _buildSectionHeader(context, '데이터'),
          _buildSettingsTile(
            context,
            icon: Icons.delete_outline,
            title: '퀴즈 진행 기록 초기화',
            subtitle: '모든 학습 기록 초기화',
            titleColor: AppColors.error,
            onTap: () => _showClearProgressDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: titleColor ?? theme.colorScheme.onSurfaceVariant,
        ),
        title: Text(
          title,
          style: TextStyle(color: titleColor),
        ),
        subtitle: Text(subtitle),
        trailing: onTap != null
            ? const Icon(Icons.chevron_right)
            : null,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        secondary: Icon(
          icon,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(BuildContext context, SubscriptionState subState) {
    final theme = Theme.of(context);

    String statusText;
    String subtitleText;
    IconData statusIcon;
    Color statusColor;

    if (subState.isPremium) {
      statusText = '프리미엄';
      subtitleText = '모든 콘텐츠 이용 가능';
      statusIcon = Icons.workspace_premium;
      statusColor = AppColors.accent;
    } else if (subState.isTrialActive) {
      statusText = '무료 체험';
      subtitleText = '${subState.daysRemaining}일 남음';
      statusIcon = Icons.timer;
      statusColor = AppColors.warning;
    } else {
      statusText = '무료 플랜';
      subtitleText = '30문제, 3개 소리';
      statusIcon = Icons.lock_outline;
      statusColor = theme.colorScheme.onSurfaceVariant;
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: statusColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(statusIcon, color: statusColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusText,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                  ),
                  Text(
                    subtitleText,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            if (!subState.isPremium)
              FilledButton(
                onPressed: () => AppRouter.navigateToPaywall(),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  minimumSize: const Size(0, 36),
                ),
                child: const Text('업그레이드'),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRestore(BuildContext context, WidgetRef ref) async {
    final service = ref.read(subscriptionServiceProvider);
    final success = await service.restorePurchases();

    if (context.mounted) {
      if (success) {
        ref.read(subscriptionProvider.notifier).refresh();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('구매가 복원되었습니다!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('복원할 구매 내역이 없습니다')),
        );
      }
    }
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('언어 선택'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇺🇸'),
              title: const Text('English'),
              trailing: const Icon(Icons.check, color: AppColors.primary),
              onTap: () {
                Navigator.pop(context);
                // TODO: Change language
              },
            ),
            ListTile(
              leading: const Text('🇰🇷'),
              title: const Text('한국어'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Change language
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showQuizCountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('기본 문제 수'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [1, 3, 5, 7, 10].map((count) {
            return ListTile(
              title: Text('$count문제'),
              trailing: count == 3
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                Navigator.pop(context);
                // TODO: Save preference
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showDifficultyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('기본 난이도'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('쉬움'),
              subtitle: const Text('기본 어휘 및 문법'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('보통'),
              trailing: const Icon(Icons.check, color: AppColors.primary),
              subtitle: const Text('중급 수준'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('어려움'),
              subtitle: const Text('고급 어휘 및 관용어'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSnoozeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('기본 미루기 시간'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [5, 10, 15, 20, 30].map((minutes) {
            return ListTile(
              title: Text('$minutes분'),
              trailing: minutes == 5
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showLicenses(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: '영어 알람',
      applicationVersion: '1.0.0',
    );
  }

  void _showClearProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('진행 기록 초기화'),
        content: const Text(
          '모든 퀴즈 학습 기록이 초기화됩니다. 이 작업은 되돌릴 수 없습니다.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Clear progress
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('기록이 초기화되었습니다')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('초기화'),
          ),
        ],
      ),
    );
  }
}
