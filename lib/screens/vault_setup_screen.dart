import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';
import '../utils/icons.dart';
import '../services/vault_manager.dart';

class VaultSetupScreen extends StatefulWidget {
  const VaultSetupScreen({super.key});

  @override
  State<VaultSetupScreen> createState() => _VaultSetupScreenState();
}

class _VaultSetupScreenState extends State<VaultSetupScreen> {
  String? _selectedVaultPath;
  bool _isInitializing = false;
  String _statusMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and Title
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        AppIcons.folder,
                        size: 40,
                        color: AppTheme.primaryAccent,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Welcome to Flucid',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Set up your personal productivity vault',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.secondaryText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Vault Selection
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose Vault Location',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Select a folder where all your data will be stored. This folder will contain your tasks, journals, projects, and settings.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Selected Path Display
                    if (_selectedVaultPath != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.primaryAccent.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              AppIcons.folder,
                              color: AppTheme.primaryAccent,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _selectedVaultPath!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.primaryText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    
                    // Select Folder Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isInitializing ? null : _selectVaultFolder,
                        icon: const Icon(AppIcons.folder),
                        label: Text(_selectedVaultPath == null ? 'Select Folder' : 'Change Folder'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Benefits Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primaryAccent.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryAccent.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          AppIcons.shield,
                          color: AppTheme.primaryAccent,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Privacy & Control',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '• All data stays on your device\n'
                      '• No cloud dependencies\n'
                      '• Sync with Syncthing or similar tools\n'
                      '• Complete offline functionality',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondaryText,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Initialize Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedVaultPath != null && !_isInitializing
                      ? _initializeVault
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedVaultPath != null
                        ? AppTheme.primaryAccent
                        : AppTheme.borderColor,
                    foregroundColor: _selectedVaultPath != null
                        ? Colors.white
                        : AppTheme.secondaryText,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isInitializing
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text('Initializing...'),
                          ],
                        )
                      : const Text(
                          'Initialize Vault',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              
              if (_statusMessage.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _statusMessage.contains('Error')
                        ? Colors.red.withOpacity(0.1)
                        : Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _statusMessage.contains('Error')
                          ? Colors.red.withOpacity(0.3)
                          : Colors.green.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _statusMessage.contains('Error')
                            ? Icons.error_outline
                            : Icons.check_circle_outline,
                        color: _statusMessage.contains('Error')
                            ? Colors.red
                            : Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _statusMessage,
                          style: TextStyle(
                            fontSize: 14,
                            color: _statusMessage.contains('Error')
                                ? Colors.red[700]
                                : Colors.green[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectVaultFolder() async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      
      if (selectedDirectory != null) {
        setState(() {
          _selectedVaultPath = selectedDirectory;
          _statusMessage = '';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error selecting folder: $e';
      });
    }
  }

  Future<void> _initializeVault() async {
    if (_selectedVaultPath == null) return;

    setState(() {
      _isInitializing = true;
      _statusMessage = '';
    });

    try {
      // Check if directory exists and is writable
      final directory = Directory(_selectedVaultPath!);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Test write permissions
      final testFile = File('${_selectedVaultPath!}/.flucid_test');
      await testFile.writeAsString('test');
      await testFile.delete();

      // Initialize vault
      final success = await VaultManager.instance.initializeVault(_selectedVaultPath!);
      
      if (success) {
        setState(() {
          _statusMessage = 'Vault initialized successfully!';
        });
        
        // Navigate to main app after a short delay
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/main');
        }
      } else {
        setState(() {
          _statusMessage = 'Error: Failed to initialize vault';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isInitializing = false;
      });
    }
  }
}
