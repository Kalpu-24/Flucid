import 'package:flutter/material.dart';
import '../utils/icons.dart';
import '../theme/app_theme.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement filters
            },
            icon: const Icon(AppIcons.funnel),
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement view options
            },
            icon: const Icon(AppIcons.squares2x2),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.folder,
              size: 64,
              color: AppTheme.secondaryText,
            ),
            SizedBox(height: 16),
            Text(
              'No projects',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppTheme.secondaryText,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Create your first project',
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
