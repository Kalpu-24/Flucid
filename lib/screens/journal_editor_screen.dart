import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../theme/app_theme.dart';
import '../utils/icons.dart';
import '../services/file_manager.dart';

class JournalEditorScreen extends StatefulWidget {
  final DateTime date;
  final String? initialContent;

  const JournalEditorScreen({
    super.key,
    required this.date,
    this.initialContent,
  });

  @override
  State<JournalEditorScreen> createState() => _JournalEditorScreenState();
}

class _JournalEditorScreenState extends State<JournalEditorScreen>
    with TickerProviderStateMixin {
  late TextEditingController _controller;
  late TabController _tabController;
  bool _isPreview = false;
  bool _isSaving = false;
  String _statusMessage = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialContent ?? '');
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _isPreview = _tabController.index == 1;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: AppBar(
        title: Text(_formatDate(widget.date)),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryText,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _isSaving ? null : _saveEntry,
            icon: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(AppIcons.download),
            tooltip: 'Save Entry',
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'template',
                child: Row(
                  children: [
                    Icon(AppIcons.document, size: 16),
                    SizedBox(width: 8),
                    Text('Insert Template'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(AppIcons.arrowDownTray, size: 16),
                    SizedBox(width: 8),
                    Text('Export'),
                  ],
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(AppIcons.pencil),
              text: 'Write',
            ),
            Tab(
              icon: Icon(AppIcons.eye),
              text: 'Preview',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (_statusMessage.isNotEmpty) _buildStatusMessage(),
          Expanded(
            child: _isPreview ? _buildPreview() : _buildEditor(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isSaving ? null : _saveEntry,
        backgroundColor: AppTheme.primaryAccent,
        child: _isSaving
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Icon(AppIcons.download, color: Colors.white),
      ),
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

  Widget _buildEditor() {
    return Container(
      margin: const EdgeInsets.all(16),
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
      child: TextField(
        controller: _controller,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
          fontFamily: 'monospace',
        ),
        decoration: const InputDecoration(
          hintText: 'Start writing your journal entry...\n\nUse Markdown syntax:\n# Heading\n**Bold** *Italic*\n- List item\n\n## Daily Review\n- [x] Completed task\n- [ ] Pending task',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      margin: const EdgeInsets.all(16),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Markdown(
          data: _controller.text.isEmpty ? '*No content to preview*' : _controller.text,
          selectable: true,
          styleSheet: MarkdownStyleSheet(
            h1: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryText,
            ),
            h2: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryText,
            ),
            h3: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryText,
            ),
            p: const TextStyle(
              fontSize: 16,
              color: AppTheme.primaryText,
              height: 1.5,
            ),
            listBullet: const TextStyle(
              fontSize: 16,
              color: AppTheme.primaryText,
            ),
            code: const TextStyle(
              fontSize: 14,
              fontFamily: 'monospace',
              backgroundColor: AppTheme.borderColor,
            ),
            codeblockDecoration: BoxDecoration(
              color: AppTheme.borderColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);
    
    if (targetDate == today) {
      return 'Today';
    } else if (targetDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Future<void> _saveEntry() async {
    if (_controller.text.trim().isEmpty) {
      setState(() {
        _statusMessage = 'Error: Cannot save empty entry';
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _statusMessage = '';
    });

    try {
      final success = await FileManager.instance.saveJournalEntry(
        _controller.text,
        widget.date,
      );

      if (success) {
        setState(() {
          _statusMessage = 'Entry saved successfully!';
        });
      } else {
        setState(() {
          _statusMessage = 'Error: Failed to save entry';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'template':
        _insertTemplate();
        break;
      case 'export':
        _exportEntry();
        break;
    }
  }

  void _insertTemplate() {
    final template = '''
# ${_formatDate(widget.date)}

## Daily Review
- [x] 
- [ ] 

## Highlights
- 

## Challenges
- 

## Mood & Energy
- **Mood**: /10
- **Energy**: /10
- **Focus**: /10

## Notes
- 

## Categories
- **Work**:  hours
- **Personal**:  hours
- **Learning**:  hours

## Tomorrow's Focus
- 
''';

    final currentText = _controller.text;
    final newText = currentText.isEmpty ? template : '$currentText\n\n$template';
    _controller.text = newText;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: newText.length),
    );
  }

  void _exportEntry() {
    // TODO: Implement export functionality
    setState(() {
      _statusMessage = 'Export functionality coming soon!';
    });
  }
}
