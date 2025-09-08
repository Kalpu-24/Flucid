import 'package:flutter/material.dart';
import '../utils/icons.dart';
import '../theme/app_theme.dart';
import '../components/components.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement calendar navigation
            },
            icon: const Icon(AppIcons.chevronLeft),
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement calendar navigation
            },
            icon: const Icon(AppIcons.chevronRight),
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement more options
            },
            icon: const Icon(AppIcons.ellipsisVertical),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Wednesday, 17 January 2024',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryText,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Implement date picker
                    },
                    icon: const Icon(AppIcons.chevronDown),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Timeline Events
            _buildTimelineEvents(),
            
            const SizedBox(height: 16),
            
            // Add Subtask Input
            SubtaskInput(
              placeholder: 'Add new subtask',
              onSubmitted: (value) {
                // TODO: Implement add subtask
                print('Added subtask: $value');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineEvents() {
    return Column(
      children: [
        TimelineCard(
          title: 'Optimize server response time',
          timeRange: '09.00 am - 10.15 am',
          onMorePressed: () {
            // TODO: Implement more options
          },
        ),
        TimelineCard(
          title: 'Team Meeting',
          subtitle: '(Designer and Developer)',
          timeRange: '10.45 am - 11.45 am',
          subtaskTitle: 'Optimization Website for Rune.io',
          participants: [
            AvatarGroup(
              avatars: [
                AvatarData.fromName('John Doe'),
                AvatarData.fromName('Jane Smith'),
                AvatarData.fromName('Mike Johnson'),
              ],
              size: 24,
            ),
          ],
          onMorePressed: () {
            // TODO: Implement more options
          },
        ),
        TimelineCard(
          title: 'Optimize Homepage Design',
          timeRange: '03.00 pm - 04.15 pm',
          onMorePressed: () {
            // TODO: Implement more options
          },
        ),
      ],
    );
  }
}
