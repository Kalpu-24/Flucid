import 'package:flutter/material.dart';
import '../utils/icons.dart';
import '../theme/app_theme.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement date range picker
            },
            icon: const Icon(AppIcons.calendar),
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement more options
            },
            icon: const Icon(AppIcons.ellipsisVertical),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.chartBar,
              size: 64,
              color: AppTheme.secondaryText,
            ),
            SizedBox(height: 16),
            Text(
              'No analytics data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppTheme.secondaryText,
              ),
            ),
            SizedBox(height: 8),
                Text(
              'Complete some tasks to see insights',
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
