import 'package:flutter/material.dart';
import '../utils/icons.dart';
import 'dashboard_screen.dart';
import 'inbox_screen.dart';
import 'timeline_screen.dart';
import 'journal_screen.dart';
import 'analytics_screen.dart';
import 'projects_screen.dart';
import 'settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const InboxScreen(),
    const TimelineScreen(),
    const JournalScreen(),
    const AnalyticsScreen(),
    const ProjectsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFFF87171),
          unselectedItemColor: const Color(0xFF6B7280),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(AppIcons.home),
              activeIcon: Icon(AppIcons.homeSolid),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.inbox),
              activeIcon: Icon(AppIcons.inboxSolid),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.calendar),
              activeIcon: Icon(AppIcons.calendarSolid),
              label: 'Timeline',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.document),
              activeIcon: Icon(AppIcons.documentSolid),
              label: 'Journal',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.chart),
              activeIcon: Icon(AppIcons.chartSolid),
              label: 'Analytics',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.folder),
              activeIcon: Icon(AppIcons.folderSolid),
              label: 'Projects',
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.settings),
              activeIcon: Icon(AppIcons.settingsSolid),
              label: 'Settings',
            ),
          ],
        ),
      ),
      floatingActionButton: _currentIndex == 1 || _currentIndex == 2
          ? FloatingActionButton(
              onPressed: () {
                // TODO: Implement add task functionality
              },
              backgroundColor: const Color(0xFFF87171),
              child: const Icon(
                AppIcons.plus,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
