import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';

/// Settings screen for app configuration
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language Section
          _buildSectionHeader(context, 'Language'),
          _buildSettingsTile(
            context,
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English',
            onTap: () => _showLanguageDialog(context),
          ),
          const SizedBox(height: 24),

          // Default Alarm Settings
          _buildSectionHeader(context, 'Default Alarm Settings'),
          _buildSettingsTile(
            context,
            icon: Icons.quiz_outlined,
            title: 'Default Quiz Count',
            subtitle: '3 questions',
            onTap: () => _showQuizCountDialog(context),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.speed_outlined,
            title: 'Default Difficulty',
            subtitle: 'Medium',
            onTap: () => _showDifficultyDialog(context),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.snooze_outlined,
            title: 'Default Snooze Duration',
            subtitle: '5 minutes',
            onTap: () => _showSnoozeDialog(context),
          ),
          const SizedBox(height: 24),

          // Sound Settings
          _buildSectionHeader(context, 'Sound & Vibration'),
          _buildSwitchTile(
            context,
            icon: Icons.vibration,
            title: 'Vibration',
            subtitle: 'Vibrate when alarm rings',
            value: true,
            onChanged: (value) {
              // TODO: Implement preference saving
            },
          ),
          _buildSwitchTile(
            context,
            icon: Icons.volume_up_outlined,
            title: 'Gradual Volume',
            subtitle: 'Gradually increase alarm volume',
            value: false,
            onChanged: (value) {
              // TODO: Implement preference saving
            },
          ),
          const SizedBox(height: 24),

          // About Section
          _buildSectionHeader(context, 'About'),
          _buildSettingsTile(
            context,
            icon: Icons.info_outline,
            title: 'Version',
            subtitle: '1.0.0',
            onTap: null,
          ),
          _buildSettingsTile(
            context,
            icon: Icons.description_outlined,
            title: 'Licenses',
            subtitle: 'Open source licenses',
            onTap: () => _showLicenses(context),
          ),
          const SizedBox(height: 24),

          // Danger Zone
          _buildSectionHeader(context, 'Data'),
          _buildSettingsTile(
            context,
            icon: Icons.delete_outline,
            title: 'Clear Quiz Progress',
            subtitle: 'Reset all learning progress',
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

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
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
        title: const Text('Default Quiz Count'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [1, 3, 5, 7, 10].map((count) {
            return ListTile(
              title: Text('$count questions'),
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
        title: const Text('Default Difficulty'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Easy'),
              subtitle: const Text('Basic vocabulary and grammar'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Medium'),
              trailing: const Icon(Icons.check, color: AppColors.primary),
              subtitle: const Text('Intermediate level'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Hard'),
              subtitle: const Text('Advanced vocabulary and idioms'),
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
        title: const Text('Default Snooze Duration'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [5, 10, 15, 20, 30].map((minutes) {
            return ListTile(
              title: Text('$minutes minutes'),
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
      applicationName: 'WakeUp English',
      applicationVersion: '1.0.0',
    );
  }

  void _showClearProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Progress?'),
        content: const Text(
          'This will reset all your quiz learning progress. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Clear progress
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Progress cleared')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
