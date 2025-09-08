# Flucid System Design - File-Based Architecture

## Overview
Flucid uses a local file-based storage system similar to Obsidian, where all data is stored in a user-specified vault folder. This approach provides:
- **Complete offline functionality**
- **Privacy-first design** (no cloud dependencies)
- **Easy synchronization** via Syncthing or similar tools
- **Zero server costs**
- **Data portability** and backup simplicity

## Vault Structure

```
FlucidVault/
├── .flucid/
│   ├── config.json              # App configuration
│   ├── categories.json          # User-defined categories
│   ├── projects.json            # Project definitions
│   └── sync/
│       ├── last_sync.json       # Sync metadata
│       └── conflicts/            # Conflict resolution
├── tasks/
│   ├── inbox/
│   │   ├── 2024-01-15_task_001.json
│   │   └── 2024-01-15_task_002.json
│   ├── planned/
│   │   ├── 2024-01-16_task_003.json
│   │   └── 2024-01-17_task_004.json
│   └── completed/
│       └── 2024-01-14_task_005.json
├── journal/
│   ├── 2024/
│   │   ├── 01/
│   │   │   ├── 2024-01-15.md
│   │   │   └── 2024-01-16.md
│   │   └── 02/
│   └── templates/
│       ├── daily.md
│       └── weekly.md
├── projects/
│   ├── project_001/
│   │   ├── metadata.json
│   │   ├── tasks/
│   │   └── notes/
│   └── project_002/
├── analytics/
│   ├── 2024/
│   │   ├── 01/
│   │   │   └── daily_stats.json
│   │   └── 02/
│   └── heatmap_data.json
└── attachments/
    ├── images/
    ├── documents/
    └── audio/
```

## Data Models

### Task File Structure (`tasks/*/YYYY-MM-DD_task_ID.json`)
```json
{
  "id": "task_001",
  "title": "Optimize server response time",
  "description": "Improve API response times for better user experience",
  "status": "planned",
  "priority": "high",
  "category": "development",
  "subcategory": "backend",
  "dueDate": "2024-01-16T10:15:00Z",
  "createdAt": "2024-01-15T09:00:00Z",
  "updatedAt": "2024-01-15T14:30:00Z",
  "completedAt": null,
  "tags": ["api", "performance", "backend"],
  "subtasks": [
    {
      "id": "subtask_001",
      "title": "Profile current API endpoints",
      "completed": false,
      "createdAt": "2024-01-15T09:15:00Z"
    }
  ],
  "timeTracking": {
    "estimatedHours": 4,
    "actualHours": 2.5,
    "sessions": []
  },
  "attachments": [
    "attachments/documents/api_spec.pdf"
  ],
  "linkedTasks": ["task_002"],
  "projectId": "project_001"
}
```

### Journal Entry Structure (`journal/YYYY/MM/YYYY-MM-DD.md`)
```markdown
# 2024-01-15

## Daily Review
- Completed API optimization task
- Had productive team meeting
- Need to focus on frontend performance tomorrow

## Tasks Completed
- [x] Optimize server response time
- [x] Review code changes

## Mood & Energy
- **Mood**: 8/10
- **Energy**: 7/10
- **Focus**: 9/10

## Highlights
- Great progress on the API optimization
- Team collaboration was excellent

## Notes
- Consider implementing caching layer
- Schedule performance review meeting

## Categories
- **Work**: 6 hours
- **Personal**: 2 hours
- **Learning**: 1 hour

## Attachments
- [Meeting Notes](attachments/documents/meeting_notes_2024-01-15.pdf)
- [Screenshot](attachments/images/api_performance_chart.png)
```

### Project Structure (`projects/project_ID/metadata.json`)
```json
{
  "id": "project_001",
  "name": "Website for Rune.io",
  "description": "Complete website redesign and optimization",
  "status": "active",
  "startDate": "2024-01-01T00:00:00Z",
  "endDate": "2024-03-31T23:59:59Z",
  "progress": 0.4,
  "team": [
    {
      "name": "John Doe",
      "role": "Lead Developer",
      "email": "john@example.com"
    }
  ],
  "milestones": [
    {
      "id": "milestone_001",
      "title": "Design System Complete",
      "dueDate": "2024-02-15T00:00:00Z",
      "completed": false
    }
  ],
  "settings": {
    "autoArchive": true,
    "notifications": true,
    "syncEnabled": true
  }
}
```

## File Management System

### Core Components

1. **VaultManager**
   - Handles vault initialization and validation
   - Manages folder structure creation
   - Provides vault health checks

2. **FileManager**
   - CRUD operations for all file types
   - Atomic file operations for data integrity
   - File locking for concurrent access

3. **DataSerializer**
   - JSON serialization/deserialization
   - Markdown parsing and generation
   - Data validation and migration

4. **SyncManager**
   - Detects file changes
   - Manages sync metadata
   - Handles conflict resolution

5. **BackupManager**
   - Automated backups
   - Version history
   - Recovery operations

## Sync Strategy

### Syncthing Integration
- **Bidirectional sync** between devices
- **Conflict resolution** using timestamps and user choice
- **Selective sync** for large attachments
- **Bandwidth optimization** for mobile devices

### Sync Metadata (`sync/last_sync.json`)
```json
{
  "lastSync": "2024-01-15T18:30:00Z",
  "deviceId": "phone_001",
  "version": "1.0.0",
  "checksums": {
    "tasks/inbox/2024-01-15_task_001.json": "abc123...",
    "journal/2024/01/2024-01-15.md": "def456..."
  },
  "conflicts": [],
  "pendingChanges": []
}
```

## Security & Privacy

### Data Protection
- **Local encryption** for sensitive data (optional)
- **No external network calls** for core functionality
- **User-controlled data** location
- **GDPR compliant** by design

### Backup Strategy
- **Incremental backups** to prevent data loss
- **Version history** for important files
- **Export functionality** for data portability
- **Recovery tools** for corrupted files

## Performance Considerations

### File Operations
- **Lazy loading** for large datasets
- **Indexing** for fast searches
- **Caching** frequently accessed data
- **Batch operations** for bulk changes

### Mobile Optimization
- **Selective sync** to reduce storage usage
- **Compression** for large files
- **Background processing** for heavy operations
- **Offline-first** architecture

## Migration & Compatibility

### Version Management
- **Schema versioning** for data format changes
- **Migration scripts** for format updates
- **Backward compatibility** for older files
- **Data validation** on load

### Import/Export
- **Standard formats** (JSON, Markdown, CSV)
- **Third-party integrations** (Obsidian, Notion)
- **Bulk operations** for data migration
- **Format conversion** tools

## Implementation Phases

### Phase 1: Core File System
- Vault initialization and management
- Basic file CRUD operations
- JSON serialization for tasks
- Markdown support for journals

### Phase 2: Data Management
- Advanced data models
- File indexing and search
- Category and project management
- Attachment handling

### Phase 3: Sync & Backup
- Syncthing integration
- Conflict resolution
- Backup and recovery
- Performance optimization

### Phase 4: Advanced Features
- Advanced analytics
- Plugin system
- Third-party integrations
- Mobile optimizations

## Benefits of This Approach

1. **Cost Effective**: No server costs, no subscription fees
2. **Privacy First**: All data stays on user's devices
3. **Reliable**: Works completely offline
4. **Portable**: Easy to backup, migrate, or share
5. **Scalable**: Can handle unlimited data
6. **Flexible**: Easy to extend and customize
7. **Future-Proof**: Not dependent on external services

This architecture provides a solid foundation for a truly personal, private, and powerful productivity system that users can trust with their most important data.
