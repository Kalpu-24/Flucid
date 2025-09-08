import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_theme.dart';
import '../utils/icons.dart';
import '../services/vault_switcher.dart';

class VaultSwitcherScreen extends StatefulWidget {
  const VaultSwitcherScreen({super.key});

  @override
  State<VaultSwitcherScreen> createState() => _VaultSwitcherScreenState();
}

class _VaultSwitcherScreenState extends State<VaultSwitcherScreen> {
  List<VaultInfo> _vaults = [];
  bool _isLoading = true;
  String _statusMessage = '';

  @override
  void initState() {
    super.initState();
    _loadVaults();
  }

  Future<void> _loadVaults() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final vaults = await VaultSwitcher.instance.getSavedVaults();
      setState(() {
        _vaults = vaults;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error loading vaults: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: AppBar(
        title: const Text('Vault Manager'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryText,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _openExistingVault,
            icon: const Icon(AppIcons.folder),
            tooltip: 'Open Existing Vault',
          ),
          IconButton(
            onPressed: _createNewVault,
            icon: const Icon(AppIcons.plus),
            tooltip: 'Create New Vault',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryAccent),
              ),
            )
          : _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        if (_statusMessage.isNotEmpty) _buildStatusMessage(),
        Expanded(
          child: _vaults.isEmpty ? _buildEmptyState() : _buildVaultList(),
        ),
      ],
    );
  }

  Widget _buildStatusMessage() {
    return Container(
      margin: const EdgeInsets.all(16),
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
          IconButton(
            onPressed: () {
              setState(() {
                _statusMessage = '';
              });
            },
            icon: const Icon(Icons.close, size: 16),
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              'No Vaults Found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryText,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Create a new vault or open an existing one to get started',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _createNewVault,
                  icon: const Icon(AppIcons.plus),
                  label: const Text('Create New'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: _openExistingVault,
                  icon: const Icon(AppIcons.folder),
                  label: const Text('Open Existing'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryAccent,
                    side: const BorderSide(color: AppTheme.primaryAccent),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVaultList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _vaults.length,
      itemBuilder: (context, index) {
        final vault = _vaults[index];
        return _buildVaultCard(vault);
      },
    );
  }

  Widget _buildVaultCard(VaultInfo vault) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () => _switchToVault(vault),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    AppIcons.folder,
                    color: AppTheme.primaryAccent,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vault.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        vault.path,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.secondaryText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          if (vault.fileCount != null) ...[
                            Icon(
                              AppIcons.document,
                              size: 14,
                              color: AppTheme.secondaryText,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${vault.fileCount} files',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.secondaryText,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                          Icon(
                            AppIcons.clock,
                            size: 14,
                            color: AppTheme.secondaryText,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            vault.lastAccessedFormatted,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'switch':
                        _switchToVault(vault);
                        break;
                      case 'remove':
                        _removeVault(vault);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'switch',
                      child: Row(
                        children: [
                          Icon(AppIcons.chevronRight, size: 16),
                          SizedBox(width: 8),
                          Text('Switch to this vault'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'remove',
                      child: Row(
                        children: [
                          Icon(AppIcons.trash, size: 16, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Remove from list', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createNewVault() async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      
      if (selectedDirectory != null) {
        // Show dialog for vault name
        final name = await _showVaultNameDialog();
        if (name != null && name.isNotEmpty) {
          final success = await VaultSwitcher.instance.createNewVault(
            selectedDirectory,
            name,
          );
          
          if (success) {
            setState(() {
              _statusMessage = 'Vault created successfully!';
            });
            await _loadVaults();
            
            // Navigate to main app
            if (mounted) {
              Navigator.of(context).pushReplacementNamed('/main');
            }
          } else {
            setState(() {
              _statusMessage = 'Error: Failed to create vault';
            });
          }
        }
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error creating vault: $e';
      });
    }
  }

  Future<void> _openExistingVault() async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      
      if (selectedDirectory != null) {
        // Validate vault
        final isValid = await VaultSwitcher.instance.validateVault(selectedDirectory);
        if (!isValid) {
          setState(() {
            _statusMessage = 'Error: Not a valid Flucid vault';
          });
          return;
        }

        // Get vault info
        final vaultInfo = await VaultSwitcher.instance.getVaultInfo(selectedDirectory);
        if (vaultInfo != null) {
          await VaultSwitcher.instance.saveVault(vaultInfo);
          await _loadVaults();
          
          setState(() {
            _statusMessage = 'Vault added successfully!';
          });
        }
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error opening vault: $e';
      });
    }
  }

  Future<void> _switchToVault(VaultInfo vault) async {
    try {
      final success = await VaultSwitcher.instance.switchVault(vault);
      if (success) {
        setState(() {
          _statusMessage = 'Switched to ${vault.name}';
        });
        
        // Navigate to main app
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/main');
        }
      } else {
        setState(() {
          _statusMessage = 'Error: Failed to switch vault';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error switching vault: $e';
      });
    }
  }

  Future<void> _removeVault(VaultInfo vault) async {
    try {
      final success = await VaultSwitcher.instance.removeVault(vault.path);
      if (success) {
        setState(() {
          _statusMessage = 'Vault removed from list';
        });
        await _loadVaults();
      } else {
        setState(() {
          _statusMessage = 'Error: Failed to remove vault';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error removing vault: $e';
      });
    }
  }

  Future<String?> _showVaultNameDialog() async {
    final controller = TextEditingController();
    
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Vault Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter vault name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
