import 'package:flutter/material.dart';
import '../utils/icons.dart';
import '../theme/app_theme.dart';
import '../components/components.dart';
import 'vault_switcher_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VaultSwitcherScreen(),
                ),
              );
            },
            icon: const Icon(AppIcons.folder),
            tooltip: 'Switch Vault',
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement menu functionality
            },
            icon: const Icon(AppIcons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
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
                          'Hi, User',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your daily adventure starts now',
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
                      // TODO: Implement grid view toggle
                    },
                    icon: const Icon(AppIcons.grid),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Task Status Cards
            const Text(
              'Task Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryText,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildStatusCard(
                  'Ongoing',
                  '24 Tasks',
                  AppTheme.ongoingTask,
                  AppIcons.arrowPath,
                ),
                _buildStatusCard(
                  'In Process',
                  '12 Tasks',
                  AppTheme.inProgressTask,
                  AppIcons.clock,
                ),
                _buildStatusCard(
                  'Completed',
                  '42 Tasks',
                  AppTheme.completedTask,
                  AppIcons.checkCircle,
                ),
                _buildStatusCard(
                  'Canceled',
                  '8 Tasks',
                  AppTheme.canceledTask,
                  AppIcons.xCircle,
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Recent Tasks Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Tasks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryText,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to all tasks
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Recent Task Cards
            TaskCard(
              title: 'Website for Rune.io',
              subtitle: 'Digital Product Design',
              taskCount: '3/5',
              commentCount: '3',
              dueDate: '22 Jun, 2023',
              progress: 0.4,
              progressColor: AppTheme.primaryAccent,
              category: 'Development',
              categoryColor: AppTheme.primaryAccent,
            ),
            TaskCard(
              title: 'Dashboard for ProSavvy',
              subtitle: 'UI/UX Design',
              taskCount: '4/7',
              commentCount: '8',
              dueDate: '12 Feb, 2023',
              progress: 0.75,
              progressColor: AppTheme.tealAccent,
              category: 'Design',
              categoryColor: AppTheme.tealAccent,
            ),
            TaskCard(
              title: 'Mobile Apps for Track.id',
              subtitle: 'Mobile Development',
              taskCount: '1/4',
              commentCount: '5',
              dueDate: '08 Jan, 2023',
              progress: 0.5,
              progressColor: AppTheme.yellowAccent,
              category: 'Development',
              categoryColor: AppTheme.yellowAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String count, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          const Spacer(),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

}
