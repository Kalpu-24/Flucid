import 'package:flutter/material.dart';
import '../utils/icons.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User Profile Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppTheme.primaryAccent.withOpacity(0.1),
                  child: const Icon(
                    AppIcons.user,
                    color: AppTheme.primaryAccent,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'User Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'user@example.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Implement edit profile
                  },
                  icon: const Icon(AppIcons.pencil),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Settings Sections
          _buildSettingsSection('General', [
            _buildSettingsItem(
              'App Mode',
              'Simple Mode',
              AppIcons.cog6Tooth,
              () {},
            ),
            _buildSettingsItem(
              'Notifications',
              'Enabled',
              AppIcons.bell,
              () {},
            ),
            _buildSettingsItem(
              'Theme',
              'Light',
              AppIcons.sun,
              () {},
            ),
          ]),
          
          const SizedBox(height: 24),
          
          _buildSettingsSection('Integrations', [
            _buildSettingsItem(
              'Gemini AI',
              'Not configured',
              AppIcons.sparkles,
              () {},
            ),
            _buildSettingsItem(
              'Google Calendar',
              'Not connected',
              AppIcons.calendar,
              () {},
            ),
          ]),
          
          const SizedBox(height: 24),
          
          _buildSettingsSection('Data', [
            _buildSettingsItem(
              'Export Data',
              'Download your data',
              AppIcons.arrowDownTray,
              () {},
            ),
            _buildSettingsItem(
              'Import Data',
              'Upload from file',
              AppIcons.arrowUpTray,
              () {},
            ),
            _buildSettingsItem(
              'Clear Data',
              'Reset all data',
              AppIcons.trash,
              () {},
            ),
          ]),
          
          const SizedBox(height: 24),
          
          _buildSettingsSection('About', [
            _buildSettingsItem(
              'Version',
              '0.1.0',
              AppIcons.informationCircle,
              () {},
            ),
            _buildSettingsItem(
              'Privacy Policy',
              'View policy',
              AppIcons.shieldCheck,
              () {},
            ),
            _buildSettingsItem(
              'Terms of Service',
              'View terms',
              AppIcons.documentText,
              () {},
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryText,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppTheme.secondaryText,
        size: 20,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.primaryText,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: AppTheme.secondaryText,
        ),
      ),
      trailing: const Icon(
        AppIcons.chevronRight,
        color: AppTheme.secondaryText,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
