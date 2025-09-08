import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'vault_manager.dart';

class VaultSwitcher {
  static VaultSwitcher? _instance;
  static VaultSwitcher get instance => _instance ??= VaultSwitcher._();
  
  VaultSwitcher._();
  
  static const String _vaultsKey = 'saved_vaults';
  static const String _currentVaultKey = 'current_vault';

  /// Get list of saved vaults
  Future<List<VaultInfo>> getSavedVaults() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final vaultsJson = prefs.getStringList(_vaultsKey) ?? [];
      
      return vaultsJson.map((json) {
        final data = jsonDecode(json);
        return VaultInfo.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error loading saved vaults: $e');
      return [];
    }
  }

  /// Save vault to list
  Future<bool> saveVault(VaultInfo vaultInfo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final vaults = await getSavedVaults();
      
      // Remove existing vault with same path
      vaults.removeWhere((v) => v.path == vaultInfo.path);
      
      // Add new vault
      vaults.add(vaultInfo);
      
      // Save to preferences
      final vaultsJson = vaults.map((v) => jsonEncode(v.toJson())).toList();
      await prefs.setStringList(_vaultsKey, vaultsJson);
      
      return true;
    } catch (e) {
      print('Error saving vault: $e');
      return false;
    }
  }

  /// Remove vault from list
  Future<bool> removeVault(String vaultPath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final vaults = await getSavedVaults();
      
      vaults.removeWhere((v) => v.path == vaultPath);
      
      final vaultsJson = vaults.map((v) => jsonEncode(v.toJson())).toList();
      await prefs.setStringList(_vaultsKey, vaultsJson);
      
      return true;
    } catch (e) {
      print('Error removing vault: $e');
      return false;
    }
  }

  /// Get current vault
  Future<VaultInfo?> getCurrentVault() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentVaultJson = prefs.getString(_currentVaultKey);
      
      if (currentVaultJson != null) {
        final data = jsonDecode(currentVaultJson);
        return VaultInfo.fromJson(data);
      }
    } catch (e) {
      print('Error loading current vault: $e');
    }
    return null;
  }

  /// Set current vault
  Future<bool> setCurrentVault(VaultInfo vaultInfo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final vaultJson = jsonEncode(vaultInfo.toJson());
      await prefs.setString(_currentVaultKey, vaultJson);
      
      // Initialize vault manager with new path
      return await VaultManager.instance.initializeVault(vaultInfo.path);
    } catch (e) {
      print('Error setting current vault: $e');
      return false;
    }
  }

  /// Switch to different vault
  Future<bool> switchVault(VaultInfo vaultInfo) async {
    try {
      // Check if vault exists and is valid
      final vaultDir = Directory(vaultInfo.path);
      if (!await vaultDir.exists()) {
        throw Exception('Vault directory does not exist');
      }

      // Check if it's a valid Flucid vault
      final configDir = Directory(path.join(vaultInfo.path, '.flucid'));
      if (!await configDir.exists()) {
        throw Exception('Not a valid Flucid vault');
      }

      // Switch to the vault
      final success = await setCurrentVault(vaultInfo);
      if (success) {
        // Update vault info with current stats
        await _updateVaultInfo(vaultInfo);
      }
      
      return success;
    } catch (e) {
      print('Error switching vault: $e');
      return false;
    }
  }

  /// Create new vault
  Future<bool> createNewVault(String vaultPath, String vaultName) async {
    try {
      // Initialize vault
      final success = await VaultManager.instance.initializeVault(vaultPath);
      if (!success) return false;

      // Create vault info
      final vaultInfo = VaultInfo(
        name: vaultName,
        path: vaultPath,
        createdAt: DateTime.now(),
        lastAccessed: DateTime.now(),
      );

      // Save vault
      await saveVault(vaultInfo);
      await setCurrentVault(vaultInfo);

      return true;
    } catch (e) {
      print('Error creating new vault: $e');
      return false;
    }
  }

  /// Update vault info with current stats
  Future<void> _updateVaultInfo(VaultInfo vaultInfo) async {
    try {
      final stats = await VaultManager.instance.getVaultStats();
      vaultInfo.lastAccessed = DateTime.now();
      vaultInfo.fileCount = stats['totalFiles'] as int? ?? 0;
      vaultInfo.sizeBytes = stats['totalSize'] as int? ?? 0;
      
      await saveVault(vaultInfo);
    } catch (e) {
      print('Error updating vault info: $e');
    }
  }

  /// Get vault info for a path
  Future<VaultInfo?> getVaultInfo(String vaultPath) async {
    try {
      final vaults = await getSavedVaults();
      return vaults.firstWhere(
        (v) => v.path == vaultPath,
        orElse: () => VaultInfo(
          name: path.basename(vaultPath),
          path: vaultPath,
          createdAt: DateTime.now(),
          lastAccessed: DateTime.now(),
        ),
      );
    } catch (e) {
      print('Error getting vault info: $e');
      return null;
    }
  }

  /// Validate vault
  Future<bool> validateVault(String vaultPath) async {
    try {
      final vaultDir = Directory(vaultPath);
      if (!await vaultDir.exists()) return false;

      final configDir = Directory(path.join(vaultPath, '.flucid'));
      if (!await configDir.exists()) return false;

      final configFile = File(path.join(configDir.path, 'config.json'));
      if (!await configFile.exists()) return false;

      return true;
    } catch (e) {
      print('Error validating vault: $e');
      return false;
    }
  }
}

class VaultInfo {
  final String name;
  final String path;
  final DateTime createdAt;
  DateTime lastAccessed;
  int? fileCount;
  int? sizeBytes;

  VaultInfo({
    required this.name,
    required this.path,
    required this.createdAt,
    required this.lastAccessed,
    this.fileCount,
    this.sizeBytes,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'path': path,
      'createdAt': createdAt.toIso8601String(),
      'lastAccessed': lastAccessed.toIso8601String(),
      'fileCount': fileCount,
      'sizeBytes': sizeBytes,
    };
  }

  factory VaultInfo.fromJson(Map<String, dynamic> json) {
    return VaultInfo(
      name: json['name'],
      path: json['path'],
      createdAt: DateTime.parse(json['createdAt']),
      lastAccessed: DateTime.parse(json['lastAccessed']),
      fileCount: json['fileCount'],
      sizeBytes: json['sizeBytes'],
    );
  }

  String get sizeFormatted {
    if (sizeBytes == null) return 'Unknown';
    
    const units = ['B', 'KB', 'MB', 'GB'];
    int size = sizeBytes!;
    int unitIndex = 0;
    
    while (size >= 1024 && unitIndex < units.length - 1) {
      size ~/= 1024;
      unitIndex++;
    }
    
    return '$size ${units[unitIndex]}';
  }

  String get lastAccessedFormatted {
    final now = DateTime.now();
    final difference = now.difference(lastAccessed);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
