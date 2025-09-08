import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;

class VaultManager {
  static VaultManager? _instance;
  static VaultManager get instance => _instance ??= VaultManager._();
  
  VaultManager._();
  
  Directory? _vaultDirectory;
  Directory? _configDirectory;
  Directory? _tasksDirectory;
  Directory? _journalDirectory;
  Directory? _projectsDirectory;
  Directory? _analyticsDirectory;
  Directory? _attachmentsDirectory;

  // Getters for directory paths
  Directory? get vaultDirectory => _vaultDirectory;
  Directory? get configDirectory => _configDirectory;
  Directory? get tasksDirectory => _tasksDirectory;
  Directory? get journalDirectory => _journalDirectory;
  Directory? get projectsDirectory => _projectsDirectory;
  Directory? get analyticsDirectory => _analyticsDirectory;
  Directory? get attachmentsDirectory => _attachmentsDirectory;

  /// Initialize vault with user-selected directory
  Future<bool> initializeVault(String vaultPath) async {
    try {
      _vaultDirectory = Directory(vaultPath);
      
      // Create directory structure
      await _createDirectoryStructure();
      
      // Initialize configuration files
      await _initializeConfigFiles();
      
      return true;
    } catch (e) {
      print('Error initializing vault: $e');
      return false;
    }
  }

  /// Create the complete directory structure
  Future<void> _createDirectoryStructure() async {
    if (_vaultDirectory == null) throw Exception('Vault not initialized');

    // Main directories
    _configDirectory = Directory(path.join(_vaultDirectory!.path, '.flucid'));
    _tasksDirectory = Directory(path.join(_vaultDirectory!.path, 'tasks'));
    _journalDirectory = Directory(path.join(_vaultDirectory!.path, 'journal'));
    _projectsDirectory = Directory(path.join(_vaultDirectory!.path, 'projects'));
    _analyticsDirectory = Directory(path.join(_vaultDirectory!.path, 'analytics'));
    _attachmentsDirectory = Directory(path.join(_vaultDirectory!.path, 'attachments'));

    // Create all directories
    await _configDirectory!.create(recursive: true);
    await _tasksDirectory!.create(recursive: true);
    await _journalDirectory!.create(recursive: true);
    await _projectsDirectory!.create(recursive: true);
    await _analyticsDirectory!.create(recursive: true);
    await _attachmentsDirectory!.create(recursive: true);

    // Create subdirectories
    await Directory(path.join(_tasksDirectory!.path, 'inbox')).create(recursive: true);
    await Directory(path.join(_tasksDirectory!.path, 'planned')).create(recursive: true);
    await Directory(path.join(_tasksDirectory!.path, 'completed')).create(recursive: true);
    
    await Directory(path.join(_configDirectory!.path, 'sync')).create(recursive: true);
    await Directory(path.join(_configDirectory!.path, 'sync', 'conflicts')).create(recursive: true);
    
    await Directory(path.join(_attachmentsDirectory!.path, 'images')).create(recursive: true);
    await Directory(path.join(_attachmentsDirectory!.path, 'documents')).create(recursive: true);
    await Directory(path.join(_attachmentsDirectory!.path, 'audio')).create(recursive: true);
  }

  /// Initialize default configuration files
  Future<void> _initializeConfigFiles() async {
    if (_configDirectory == null) throw Exception('Config directory not initialized');

    // App configuration
    final configFile = File(path.join(_configDirectory!.path, 'config.json'));
    if (!await configFile.exists()) {
      final defaultConfig = {
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'lastModified': DateTime.now().toIso8601String(),
        'settings': {
          'theme': 'light',
          'defaultView': 'dashboard',
          'autoSync': true,
          'backupEnabled': true,
          'encryptionEnabled': false,
        },
        'user': {
          'name': '',
          'email': '',
          'timezone': 'UTC',
        }
      };
      await configFile.writeAsString(jsonEncode(defaultConfig));
    }

    // Categories configuration
    final categoriesFile = File(path.join(_configDirectory!.path, 'categories.json'));
    if (!await categoriesFile.exists()) {
      final defaultCategories = {
        'categories': [
          {
            'id': 'misc',
            'name': 'Misc',
            'color': '#6366f1',
            'createdAt': DateTime.now().toIso8601String(),
            'subcategories': []
          }
        ]
      };
      await categoriesFile.writeAsString(jsonEncode(defaultCategories));
    }

    // Sync metadata
    final syncFile = File(path.join(_configDirectory!.path, 'sync', 'last_sync.json'));
    if (!await syncFile.exists()) {
      final syncData = {
        'lastSync': null,
        'deviceId': _generateDeviceId(),
        'version': '1.0.0',
        'checksums': {},
        'conflicts': [],
        'pendingChanges': []
      };
      await syncFile.writeAsString(jsonEncode(syncData));
    }
  }

  /// Generate unique device ID
  String _generateDeviceId() {
    return 'device_${DateTime.now().millisecondsSinceEpoch}_${(1000 + (999 * (DateTime.now().microsecond / 1000000))).round()}';
  }

  /// Check if vault is properly initialized
  bool get isInitialized => _vaultDirectory != null && _configDirectory != null;

  /// Get vault configuration
  Future<Map<String, dynamic>?> getConfig() async {
    if (_configDirectory == null) return null;
    
    try {
      final configFile = File(path.join(_configDirectory!.path, 'config.json'));
      if (await configFile.exists()) {
        final content = await configFile.readAsString();
        return jsonDecode(content);
      }
    } catch (e) {
      print('Error reading config: $e');
    }
    return null;
  }

  /// Update vault configuration
  Future<bool> updateConfig(Map<String, dynamic> config) async {
    if (_configDirectory == null) return false;
    
    try {
      final configFile = File(path.join(_configDirectory!.path, 'config.json'));
      config['lastModified'] = DateTime.now().toIso8601String();
      await configFile.writeAsString(jsonEncode(config));
      return true;
    } catch (e) {
      print('Error updating config: $e');
      return false;
    }
  }

  /// Get vault health status
  Future<Map<String, dynamic>> getVaultHealth() async {
    final health = <String, dynamic>{
      'isHealthy': true,
      'issues': <String>[],
      'lastChecked': DateTime.now().toIso8601String(),
    };

    if (!isInitialized) {
      health['isHealthy'] = false;
      (health['issues'] as List<String>).add('Vault not initialized');
      return health;
    }

    // Check if all required directories exist
    final requiredDirs = [
      _configDirectory,
      _tasksDirectory,
      _journalDirectory,
      _projectsDirectory,
      _analyticsDirectory,
      _attachmentsDirectory,
    ];

    for (final dir in requiredDirs) {
      if (dir == null || !await dir.exists()) {
        health['isHealthy'] = false;
        (health['issues'] as List<String>).add('Missing directory: ${dir?.path}');
      }
    }

    // Check config file
    if (_configDirectory != null) {
      final configFile = File(path.join(_configDirectory!.path, 'config.json'));
      if (!await configFile.exists()) {
        health['isHealthy'] = false;
        (health['issues'] as List<String>).add('Missing config file');
      }
    }

    return health;
  }

  /// Get vault statistics
  Future<Map<String, dynamic>> getVaultStats() async {
    if (!isInitialized) return {};

    final stats = <String, dynamic>{
      'totalFiles': 0,
      'totalSize': 0,
      'tasksCount': 0,
      'journalEntriesCount': 0,
      'projectsCount': 0,
      'lastModified': null as String?,
    };

    try {
      // Count files in each directory
      if (_tasksDirectory != null) {
        final taskFiles = await _countFilesInDirectory(_tasksDirectory!);
        stats['tasksCount'] = taskFiles['count'];
        stats['totalFiles'] = (stats['totalFiles'] as int) + (taskFiles['count'] as int);
        stats['totalSize'] = (stats['totalSize'] as int) + (taskFiles['size'] as int);
      }

      if (_journalDirectory != null) {
        final journalFiles = await _countFilesInDirectory(_journalDirectory!);
        stats['journalEntriesCount'] = journalFiles['count'];
        stats['totalFiles'] = (stats['totalFiles'] as int) + (journalFiles['count'] as int);
        stats['totalSize'] = (stats['totalSize'] as int) + (journalFiles['size'] as int);
      }

      if (_projectsDirectory != null) {
        final projectFiles = await _countFilesInDirectory(_projectsDirectory!);
        stats['projectsCount'] = projectFiles['count'];
        stats['totalFiles'] = (stats['totalFiles'] as int) + (projectFiles['count'] as int);
        stats['totalSize'] = (stats['totalSize'] as int) + (projectFiles['size'] as int);
      }

      // Find last modified file
      stats['lastModified'] = await _getLastModifiedTime();
    } catch (e) {
      print('Error getting vault stats: $e');
    }

    return stats;
  }

  /// Count files in directory recursively
  Future<Map<String, dynamic>> _countFilesInDirectory(Directory dir) async {
    int count = 0;
    int size = 0;

    try {
      await for (final entity in dir.list(recursive: true)) {
        if (entity is File) {
          count++;
          size += await entity.length();
        }
      }
    } catch (e) {
      print('Error counting files in ${dir.path}: $e');
    }

    return {'count': count, 'size': size};
  }

  /// Get last modified time across all files
  Future<String?> _getLastModifiedTime() async {
    DateTime? lastModified;
    
    final dirs = [
      _configDirectory,
      _tasksDirectory,
      _journalDirectory,
      _projectsDirectory,
      _analyticsDirectory,
    ];

    for (final dir in dirs) {
      if (dir != null) {
        try {
          await for (final entity in dir.list(recursive: true)) {
            if (entity is File) {
              final stat = await entity.stat();
              if (lastModified == null || stat.modified.isAfter(lastModified)) {
                lastModified = stat.modified;
              }
            }
          }
        } catch (e) {
          // Continue with other directories
        }
      }
    }

    return lastModified?.toIso8601String();
  }

  /// Clean up vault (remove all data)
  Future<bool> cleanupVault() async {
    if (_vaultDirectory == null) return false;
    
    try {
      await _vaultDirectory!.delete(recursive: true);
      _vaultDirectory = null;
      _configDirectory = null;
      _tasksDirectory = null;
      _journalDirectory = null;
      _projectsDirectory = null;
      _analyticsDirectory = null;
      _attachmentsDirectory = null;
      return true;
    } catch (e) {
      print('Error cleaning up vault: $e');
      return false;
    }
  }
}
