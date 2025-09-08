import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/main_navigation.dart';
import 'screens/vault_setup_screen.dart';
import 'screens/vault_switcher_screen.dart';
import 'services/vault_manager.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flucid',
      theme: AppTheme.lightTheme,
      home: const VaultCheckScreen(),
      routes: {
        '/main': (context) => const MainNavigation(),
        '/setup': (context) => const VaultSetupScreen(),
        '/vault-switcher': (context) => VaultSwitcherScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class VaultCheckScreen extends StatefulWidget {
  const VaultCheckScreen({super.key});

  @override
  State<VaultCheckScreen> createState() => _VaultCheckScreenState();
}

class _VaultCheckScreenState extends State<VaultCheckScreen> {
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkVaultStatus();
  }

  Future<void> _checkVaultStatus() async {
    // Simulate a brief loading time
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (mounted) {
      if (VaultManager.instance.isInitialized) {
        Navigator.of(context).pushReplacementNamed('/main');
      } else {
        Navigator.of(context).pushReplacementNamed('/setup');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.primaryAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.folder_outlined,
                size: 50,
                color: AppTheme.primaryAccent,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Flucid',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Checking vault status...',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.secondaryText,
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryAccent),
            ),
          ],
        ),
      ),
    );
  }
}
