# Flucid

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)

## Overview
Flucid is a structured Todo and planning app with a **file-based storage system** similar to Obsidian. It features Material Design icons, dual modes (Simple/Complex), and complete offline functionality with privacy-first design.

## ✨ Key Features

### 🗂️ **File-Based Vault System** (✅ Implemented)
- **Obsidian-like storage**: All data stored in user-specified folder
- **Complete offline functionality** - No internet required
- **Privacy-first design** - All data stays on your device
- **Zero server costs** - No cloud dependencies or subscriptions
- **Easy synchronization** - Use Syncthing or similar tools to sync between devices
- **Data portability** - Your data is always accessible and exportable

### 🏗️ **Core Architecture** (✅ Implemented)
- **Vault Management**: Create, switch, and manage multiple vaults
- **File System**: JSON-based task storage, Markdown journal entries
- **Cross-Platform**: Flutter app targeting iOS, Android, Web, Windows, macOS, and Linux
- **Modular Design**: Reusable components following OOP principles

### 📝 **Journaling with Markdown** (✅ Implemented)
- **Live Markdown Preview**: Real-time rendering of Markdown content
- **Rich Text Support**: Headings, lists, code blocks, and more
- **File-based Storage**: Each journal entry as a separate Markdown file
- **Template Support**: Ready for daily/weekly templates

### 🎨 **Design System** (✅ Implemented)
- **Material Design Icons**: Custom `AppIcons` class with comprehensive icon set
- **Consistent Theming**: `AppTheme` with defined color palette
- **Responsive UI**: Works across all screen sizes
- **Modern Aesthetics**: Rounded corners, soft shadows, clean typography

## 🚀 Current Status

### ✅ **Completed Features**

#### **Core Infrastructure**
- [x] Flutter project setup with cross-platform support
- [x] File-based vault system (Obsidian-like)
- [x] Vault switching functionality
- [x] Vault health monitoring and statistics
- [x] File system abstraction layer

#### **UI Components**
- [x] Reusable component library:
  - [x] `TaskCard` - Task display component
  - [x] `TimelineCard` - Timeline entry component
  - [x] `SubtaskInput` - Subtask input widget
  - [x] `ProgressCircle` - Progress indicator
  - [x] `TimeDisplay` - Time formatting component
  - [x] `AvatarGroup` - User avatar display

#### **Screens & Navigation**
- [x] Main navigation with bottom navigation bar
- [x] Dashboard screen with task status overview
- [x] Vault setup screen for initial configuration
- [x] Vault switcher screen for managing multiple vaults
- [x] Journal editor with Markdown support
- [x] Placeholder screens for all main sections

#### **Data Models**
- [x] `Task` model with full task properties
- [x] `Category` model for task categorization
- [x] `JournalEntry` model for journaling
- [x] JSON serialization for data persistence

#### **Services**
- [x] `VaultManager` - Vault initialization and health checks
- [x] `FileManager` - File system operations
- [x] `VaultSwitcher` - Multi-vault management

### 🔄 **In Progress**
- [ ] **Inbox Screen**: Unplanned tasks management
- [ ] **Timeline Screen**: Planned tasks with timeline view
- [ ] **Settings Screen**: App configuration and API keys
- [ ] **Analytics Screen**: Activity heatmap and progress tracking
- [ ] **Projects Screen**: Project management interface

### 📋 **Planned Features**

#### **Core Todo Management**
- [ ] Create, edit, complete, and delete tasks
- [ ] Subtasks and checklists
- [ ] Due dates, reminders, and recurring tasks
- [ ] Priority levels and tags/labels
- [ ] Quick add (global capture)

#### **Planner & Timelines**
- [ ] Daily/weekly/monthly views
- [ ] Time-blocking and agenda view
- [ ] Drag-and-drop task scheduling
- [ ] Project timelines/Gantt-like view
- [ ] Milestones and dependencies

#### **Categories & Organization**
- [ ] Custom categories with subcategories
- [ ] Default "Misc" category fallback
- [ ] Create/rename/merge/delete categories
- [ ] AI-assisted category suggestions

#### **Analytics & Insights**
- [ ] Activity heatmap (GitHub-style)
- [ ] Progress tracking over time
- [ ] Productivity insights and trends
- [ ] Category-based analytics

#### **Advanced Features**
- [ ] **Gemini AI Integration**: User-provided API key
  - [ ] Natural-language task capture
  - [ ] Smart scheduling and prioritization
  - [ ] Task breakdown into subtasks
  - [ ] Custom intents system
- [ ] **Calendar Integration**: Google Calendar OAuth
- [ ] **Notifications & Reminders**: Smart scheduling
- [ ] **Import/Export**: JSON/CSV support

## 🏗️ **System Architecture**

### Vault Structure
```
FlucidVault/
├── .flucid/           # App configuration and metadata
├── tasks/             # Task files (inbox, planned, completed)
├── journal/           # Daily journal entries (Markdown)
├── projects/          # Project definitions and files
├── analytics/         # Usage statistics and heatmaps
└── attachments/       # Images, documents, audio files
```

### Key Benefits
- **Local-first**: All data stored in user-specified folder
- **Sync-ready**: Compatible with Syncthing, Dropbox, Google Drive
- **Backup-friendly**: Simple folder backup and restore
- **Future-proof**: Not dependent on external services
- **GDPR compliant**: Complete data control and privacy

## 🎨 **Design System**

### Color Palette
- **Primary Background**: Very light gray/off-white (#F8F9FA)
- **Content Areas**: Pure white with subtle shadows
- **Primary Text**: Dark gray/black (#1F2937)
- **Secondary Text**: Medium gray (#6B7280)
- **Borders/Separators**: Light gray (#E5E7EB)
- **Accent Colors**:
  - Primary Red-Orange: #F87171 (buttons, selected states)
  - Blue: #60A5FA (ongoing tasks, progress)
  - Yellow/Orange: #FBBF24 (in-progress tasks)
  - Teal/Green: #34D399 (completed tasks)
  - Red: #F87171 (canceled tasks)

### Design Principles
- **Clarity first**: Information-dense but legible
- **Structured by default**: Sensible organization without heavy setup
- **Fast interactions**: Keyboard-first and low-friction flows
- **Progressive complexity**: Simple Mode by default; unlock power in Complex Mode

## 🚀 **Getting Started**

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/flucid.git
   cd flucid
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### First Run
1. **Vault Setup**: Choose or create a folder for your Flucid vault
2. **Vault Switching**: Access vault management from the dashboard
3. **Journaling**: Start writing with Markdown support
4. **Task Management**: Coming soon in upcoming releases

## 🤝 **Contributing**

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Setup
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Run tests: `flutter test`
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

### Code Style
- Follow Dart/Flutter conventions
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain consistent formatting

## 📝 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 **Acknowledgments**

- **Flutter Team** for the amazing framework
- **Material Design** for the design system
- **Obsidian** for inspiration on file-based storage
- **Contributors** who help make this project better

## 📞 **Support**

- **Issues**: [GitHub Issues](https://github.com/yourusername/flucid/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/flucid/discussions)
- **Documentation**: [Wiki](https://github.com/yourusername/flucid/wiki)

---

**Made with ❤️ by the Flucid Team**