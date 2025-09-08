# Changelog

All notable changes to Flucid will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project setup with Flutter
- File-based vault system (Obsidian-like)
- Vault switching functionality
- Markdown journaling with live preview
- Reusable component library
- Material Design theming system
- Cross-platform support (iOS, Android, Web, Windows, macOS, Linux)

### Changed
- Migrated from heroicons to Material Design icons
- Updated file_picker package for better compatibility

### Fixed
- Resolved compilation errors in vault manager
- Fixed type casting issues in statistics calculation
- Corrected CardTheme vs CardThemeData type mismatch
- Fixed missing icon definitions

## [0.1.0] - 2024-01-XX

### Added
- **Core Infrastructure**
  - Flutter project setup with cross-platform support
  - File-based vault system with local storage
  - Vault management and switching capabilities
  - File system abstraction layer

- **UI Components**
  - `TaskCard` - Reusable task display component
  - `TimelineCard` - Timeline entry component
  - `SubtaskInput` - Subtask input widget
  - `ProgressCircle` - Progress indicator component
  - `TimeDisplay` - Time formatting component
  - `AvatarGroup` - User avatar display component

- **Screens & Navigation**
  - Main navigation with bottom navigation bar
  - Dashboard screen with task status overview
  - Vault setup screen for initial configuration
  - Vault switcher screen for managing multiple vaults
  - Journal editor with Markdown support
  - Placeholder screens for all main sections

- **Data Models**
  - `Task` model with comprehensive task properties
  - `Category` model for task categorization
  - `JournalEntry` model for journaling functionality
  - JSON serialization for data persistence

- **Services**
  - `VaultManager` - Vault initialization and health monitoring
  - `FileManager` - File system operations abstraction
  - `VaultSwitcher` - Multi-vault management service

- **Design System**
  - Custom `AppIcons` class with Material Design icons
  - `AppTheme` with defined color palette
  - Consistent theming across all components
  - Responsive UI design

- **Documentation**
  - Comprehensive README with project overview
  - Contributing guidelines for open-source development
  - MIT License for open-source distribution
  - Changelog for tracking project progress

### Technical Details
- **Dependencies**: Flutter, Dart, shared_preferences, uuid, intl, path_provider, path, file_picker, flutter_markdown, markdown
- **Architecture**: File-based storage system similar to Obsidian
- **Platform Support**: iOS, Android, Web, Windows, macOS, Linux
- **Storage**: Local file system with JSON and Markdown files
- **Privacy**: Complete offline functionality with no cloud dependencies

### Known Issues
- Android build warnings for file_picker package (non-blocking)
- Some placeholder screens need implementation
- Task CRUD operations not yet implemented

### Roadmap
- [ ] Implement Inbox screen for unplanned tasks
- [ ] Build Timeline screen with drag-and-drop functionality
- [ ] Add Settings screen with API key management
- [ ] Create Analytics screen with activity heatmap
- [ ] Develop Projects screen for project management
- [ ] Integrate Gemini AI for natural language task processing
- [ ] Add Google Calendar integration
- [ ] Implement notification and reminder system
