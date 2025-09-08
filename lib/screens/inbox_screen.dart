import 'package:flutter/material.dart';
import '../utils/icons.dart';
import '../theme/app_theme.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement filters
            },
            icon: const Icon(AppIcons.filter),
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement view options
            },
            icon: const Icon(AppIcons.grid),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.inbox,
              size: 64,
              color: AppTheme.secondaryText,
            ),
            SizedBox(height: 16),
            Text(
              'No unplanned tasks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppTheme.secondaryText,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Add tasks to get started',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
