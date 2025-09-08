import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import 'vault_manager.dart';

class FileManager {
  static FileManager? _instance;
  static FileManager get instance => _instance ??= FileManager._();
  
  FileManager._();
  
  final _uuid = const Uuid();

  /// Save task to file
  Future<bool> saveTask(Map<String, dynamic> taskData, {String? customId}) async {
    if (!VaultManager.instance.isInitialized) return false;

    try {
      final taskId = customId ?? _uuid.v4();
      final now = DateTime.now();
      final dateStr = now.toIso8601String().split('T')[0];
      
      // Determine directory based on status
      String subDir = 'inbox';
      if (taskData['status'] == 'planned') {
        subDir = 'planned';
      } else if (taskData['status'] == 'completed') {
        subDir = 'completed';
      }

      final fileName = '${dateStr}_task_$taskId.json';
      final filePath = path.join(
        VaultManager.instance.tasksDirectory!.path,
        subDir,
        fileName,
      );

      // Add metadata
      taskData['id'] = taskId;
      taskData['createdAt'] = taskData['createdAt'] ?? now.toIso8601String();
      taskData['updatedAt'] = now.toIso8601String();

      final file = File(filePath);
      await file.writeAsString(jsonEncode(taskData));
      
      return true;
    } catch (e) {
      print('Error saving task: $e');
      return false;
    }
  }

  /// Load task from file
  Future<Map<String, dynamic>?> loadTask(String taskId) async {
    if (!VaultManager.instance.isInitialized) return null;

    try {
      final tasksDir = VaultManager.instance.tasksDirectory!;
      
      // Search in all subdirectories
      for (final subDir in ['inbox', 'planned', 'completed']) {
        final subDirPath = Directory(path.join(tasksDir.path, subDir));
        if (await subDirPath.exists()) {
          await for (final entity in subDirPath.list()) {
            if (entity is File && entity.path.contains(taskId)) {
              final content = await entity.readAsString();
              return jsonDecode(content);
            }
          }
        }
      }
    } catch (e) {
      print('Error loading task: $e');
    }
    return null;
  }

  /// Load all tasks
  Future<List<Map<String, dynamic>>> loadAllTasks() async {
    if (!VaultManager.instance.isInitialized) return [];

    final tasks = <Map<String, dynamic>>[];

    try {
      final tasksDir = VaultManager.instance.tasksDirectory!;
      
      for (final subDir in ['inbox', 'planned', 'completed']) {
        final subDirPath = Directory(path.join(tasksDir.path, subDir));
        if (await subDirPath.exists()) {
          await for (final entity in subDirPath.list()) {
            if (entity is File && entity.path.endsWith('.json')) {
              try {
                final content = await entity.readAsString();
                final taskData = jsonDecode(content);
                tasks.add(taskData);
              } catch (e) {
                print('Error loading task from ${entity.path}: $e');
              }
            }
          }
        }
      }
    } catch (e) {
      print('Error loading tasks: $e');
    }

    return tasks;
  }

  /// Delete task file
  Future<bool> deleteTask(String taskId) async {
    if (!VaultManager.instance.isInitialized) return false;

    try {
      final tasksDir = VaultManager.instance.tasksDirectory!;
      
      for (final subDir in ['inbox', 'planned', 'completed']) {
        final subDirPath = Directory(path.join(tasksDir.path, subDir));
        if (await subDirPath.exists()) {
          await for (final entity in subDirPath.list()) {
            if (entity is File && entity.path.contains(taskId)) {
              await entity.delete();
              return true;
            }
          }
        }
      }
    } catch (e) {
      print('Error deleting task: $e');
    }
    return false;
  }

  /// Save journal entry
  Future<bool> saveJournalEntry(String content, DateTime date) async {
    if (!VaultManager.instance.isInitialized) return false;

    try {
      final year = date.year.toString();
      final month = date.month.toString().padLeft(2, '0');
      final dateStr = date.toIso8601String().split('T')[0];
      
      final journalDir = Directory(path.join(
        VaultManager.instance.journalDirectory!.path,
        year,
        month,
      ));
      
      await journalDir.create(recursive: true);
      
      final fileName = '$dateStr.md';
      final filePath = path.join(journalDir.path, fileName);
      
      final file = File(filePath);
      await file.writeAsString(content);
      
      return true;
    } catch (e) {
      print('Error saving journal entry: $e');
      return false;
    }
  }

  /// Load journal entry
  Future<String?> loadJournalEntry(DateTime date) async {
    if (!VaultManager.instance.isInitialized) return null;

    try {
      final year = date.year.toString();
      final month = date.month.toString().padLeft(2, '0');
      final dateStr = date.toIso8601String().split('T')[0];
      
      final filePath = path.join(
        VaultManager.instance.journalDirectory!.path,
        year,
        month,
        '$dateStr.md',
      );
      
      final file = File(filePath);
      if (await file.exists()) {
        return await file.readAsString();
      }
    } catch (e) {
      print('Error loading journal entry: $e');
    }
    return null;
  }

  /// Load all journal entries for a month
  Future<List<Map<String, dynamic>>> loadJournalEntries(int year, int month) async {
    if (!VaultManager.instance.isInitialized) return [];

    final entries = <Map<String, dynamic>>[];

    try {
      final yearStr = year.toString();
      final monthStr = month.toString().padLeft(2, '0');
      
      final journalDir = Directory(path.join(
        VaultManager.instance.journalDirectory!.path,
        yearStr,
        monthStr,
      ));
      
      if (await journalDir.exists()) {
        await for (final entity in journalDir.list()) {
          if (entity is File && entity.path.endsWith('.md')) {
            try {
              final content = await entity.readAsString();
              final fileName = path.basename(entity.path);
              final dateStr = fileName.replaceAll('.md', '');
              final date = DateTime.parse(dateStr);
              
              entries.add({
                'date': date,
                'content': content,
                'filePath': entity.path,
              });
            } catch (e) {
              print('Error loading journal entry from ${entity.path}: $e');
            }
          }
        }
      }
    } catch (e) {
      print('Error loading journal entries: $e');
    }

    // Sort by date
    entries.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));
    return entries;
  }

  /// Save project
  Future<bool> saveProject(Map<String, dynamic> projectData) async {
    if (!VaultManager.instance.isInitialized) return false;

    try {
      final projectId = projectData['id'] ?? _uuid.v4();
      final now = DateTime.now();
      
      final projectDir = Directory(path.join(
        VaultManager.instance.projectsDirectory!.path,
        'project_$projectId',
      ));
      
      await projectDir.create(recursive: true);
      
      // Save metadata
      projectData['id'] = projectId;
      projectData['createdAt'] = projectData['createdAt'] ?? now.toIso8601String();
      projectData['updatedAt'] = now.toIso8601String();
      
      final metadataFile = File(path.join(projectDir.path, 'metadata.json'));
      await metadataFile.writeAsString(jsonEncode(projectData));
      
      return true;
    } catch (e) {
      print('Error saving project: $e');
      return false;
    }
  }

  /// Load project
  Future<Map<String, dynamic>?> loadProject(String projectId) async {
    if (!VaultManager.instance.isInitialized) return null;

    try {
      final metadataFile = File(path.join(
        VaultManager.instance.projectsDirectory!.path,
        'project_$projectId',
        'metadata.json',
      ));
      
      if (await metadataFile.exists()) {
        final content = await metadataFile.readAsString();
        return jsonDecode(content);
      }
    } catch (e) {
      print('Error loading project: $e');
    }
    return null;
  }

  /// Load all projects
  Future<List<Map<String, dynamic>>> loadAllProjects() async {
    if (!VaultManager.instance.isInitialized) return [];

    final projects = <Map<String, dynamic>>[];

    try {
      final projectsDir = VaultManager.instance.projectsDirectory!;
      
      if (await projectsDir.exists()) {
        await for (final entity in projectsDir.list()) {
          if (entity is Directory && entity.path.contains('project_')) {
            try {
              final metadataFile = File(path.join(entity.path, 'metadata.json'));
              if (await metadataFile.exists()) {
                final content = await metadataFile.readAsString();
                final projectData = jsonDecode(content);
                projects.add(projectData);
              }
            } catch (e) {
              print('Error loading project from ${entity.path}: $e');
            }
          }
        }
      }
    } catch (e) {
      print('Error loading projects: $e');
    }

    return projects;
  }

  /// Save categories
  Future<bool> saveCategories(Map<String, dynamic> categoriesData) async {
    if (!VaultManager.instance.isInitialized) return false;

    try {
      final categoriesFile = File(path.join(
        VaultManager.instance.configDirectory!.path,
        'categories.json',
      ));
      
      await categoriesFile.writeAsString(jsonEncode(categoriesData));
      return true;
    } catch (e) {
      print('Error saving categories: $e');
      return false;
    }
  }

  /// Load categories
  Future<Map<String, dynamic>?> loadCategories() async {
    if (!VaultManager.instance.isInitialized) return null;

    try {
      final categoriesFile = File(path.join(
        VaultManager.instance.configDirectory!.path,
        'categories.json',
      ));
      
      if (await categoriesFile.exists()) {
        final content = await categoriesFile.readAsString();
        return jsonDecode(content);
      }
    } catch (e) {
      print('Error loading categories: $e');
    }
    return null;
  }

  /// Save attachment
  Future<String?> saveAttachment(File sourceFile, String fileName) async {
    if (!VaultManager.instance.isInitialized) return null;

    try {
      final attachmentsDir = VaultManager.instance.attachmentsDirectory!;
      final fileExtension = path.extension(fileName).toLowerCase();
      
      String subDir = 'documents';
      if (['.jpg', '.jpeg', '.png', '.gif', '.webp'].contains(fileExtension)) {
        subDir = 'images';
      } else if (['.mp3', '.wav', '.m4a', '.aac'].contains(fileExtension)) {
        subDir = 'audio';
      }
      
      final targetDir = Directory(path.join(attachmentsDir.path, subDir));
      await targetDir.create(recursive: true);
      
      final targetFile = File(path.join(targetDir.path, fileName));
      await sourceFile.copy(targetFile.path);
      
      return path.join('attachments', subDir, fileName);
    } catch (e) {
      print('Error saving attachment: $e');
      return null;
    }
  }

  /// Get file by relative path
  Future<File?> getFile(String relativePath) async {
    if (!VaultManager.instance.isInitialized) return null;

    try {
      final filePath = path.join(VaultManager.instance.vaultDirectory!.path, relativePath);
      final file = File(filePath);
      
      if (await file.exists()) {
        return file;
      }
    } catch (e) {
      print('Error getting file: $e');
    }
    return null;
  }

  /// Delete file
  Future<bool> deleteFile(String relativePath) async {
    if (!VaultManager.instance.isInitialized) return false;

    try {
      final filePath = path.join(VaultManager.instance.vaultDirectory!.path, relativePath);
      final file = File(filePath);
      
      if (await file.exists()) {
        await file.delete();
        return true;
      }
    } catch (e) {
      print('Error deleting file: $e');
    }
    return false;
  }

  /// Check if file exists
  Future<bool> fileExists(String relativePath) async {
    if (!VaultManager.instance.isInitialized) return false;

    try {
      final filePath = path.join(VaultManager.instance.vaultDirectory!.path, relativePath);
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      print('Error checking file existence: $e');
      return false;
    }
  }
}
