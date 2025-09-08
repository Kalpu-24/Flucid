# Contributing to Flucid

Thank you for your interest in contributing to Flucid! This document provides guidelines and information for contributors.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Git
- Android Studio / VS Code with Flutter extensions

### Development Setup
1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/yourusername/flucid.git
   cd flucid
   ```
3. Add the upstream repository:
   ```bash
   git remote add upstream https://github.com/originalusername/flucid.git
   ```
4. Install dependencies:
   ```bash
   flutter pub get
   ```
5. Run the app to ensure everything works:
   ```bash
   flutter run
   ```

## 📋 How to Contribute

### Reporting Issues
- Use the GitHub issue tracker
- Search existing issues before creating new ones
- Provide clear, detailed descriptions
- Include steps to reproduce bugs
- Specify your environment (OS, Flutter version, etc.)

### Suggesting Features
- Use the GitHub issue tracker with the "enhancement" label
- Describe the feature clearly
- Explain why it would be useful
- Consider the impact on existing users

### Code Contributions
1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**:
   - Follow the coding standards (see below)
   - Add tests for new functionality
   - Update documentation if needed

3. **Test your changes**:
   ```bash
   flutter test
   flutter analyze
   ```

4. **Commit your changes**:
   ```bash
   git add .
   git commit -m "Add: brief description of your changes"
   ```

5. **Push and create a Pull Request**:
   ```bash
   git push origin feature/your-feature-name
   ```

## 📝 Coding Standards

### Dart/Flutter Conventions
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain consistent formatting (use `dart format`)

### File Organization
```
lib/
├── components/        # Reusable UI components
├── models/           # Data models
├── screens/          # Screen widgets
├── services/         # Business logic and data services
├── theme/            # App theming
├── utils/            # Utility functions and constants
└── main.dart         # App entry point
```

### Component Guidelines
- Create reusable components in `lib/components/`
- Follow OOP principles and modular design
- Use proper documentation comments
- Export components through `lib/components/components.dart`

### Naming Conventions
- **Files**: Use snake_case (e.g., `task_card.dart`)
- **Classes**: Use PascalCase (e.g., `TaskCard`)
- **Variables/Functions**: Use camelCase (e.g., `taskTitle`)
- **Constants**: Use SCREAMING_SNAKE_CASE (e.g., `MAX_TASK_LENGTH`)

## 🧪 Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Test Guidelines
- Write unit tests for business logic
- Write widget tests for UI components
- Aim for good test coverage
- Test edge cases and error conditions

## 📚 Documentation

### Code Documentation
- Use Dart doc comments for public APIs
- Include examples for complex functions
- Document parameters and return values
- Keep documentation up to date

### README Updates
- Update README.md when adding new features
- Include screenshots for UI changes
- Update installation instructions if needed
- Keep the feature list current

## 🔄 Pull Request Process

### Before Submitting
- [ ] Code follows project conventions
- [ ] Tests pass (`flutter test`)
- [ ] Code analysis passes (`flutter analyze`)
- [ ] Documentation updated
- [ ] No merge conflicts

### PR Description
- Clearly describe what the PR does
- Reference related issues
- Include screenshots for UI changes
- List any breaking changes

### Review Process
- Maintainers will review your PR
- Address feedback promptly
- Keep PRs focused and atomic
- Be patient during review process

## 🏷️ Issue Labels

- **bug**: Something isn't working
- **enhancement**: New feature or request
- **documentation**: Documentation improvements
- **good first issue**: Good for newcomers
- **help wanted**: Extra attention needed
- **question**: Further information is requested

## 🎯 Areas for Contribution

### High Priority
- [ ] Inbox screen implementation
- [ ] Timeline screen with drag-and-drop
- [ ] Task CRUD operations
- [ ] Settings screen with API key management
- [ ] Analytics and progress tracking

### Medium Priority
- [ ] Gemini AI integration
- [ ] Calendar integration
- [ ] Import/export functionality
- [ ] Advanced filtering and search
- [ ] Keyboard shortcuts

### Low Priority
- [ ] Performance optimizations
- [ ] Accessibility improvements
- [ ] Internationalization
- [ ] Advanced theming options

## 🤝 Community Guidelines

### Be Respectful
- Use welcoming and inclusive language
- Be respectful of differing viewpoints
- Accept constructive criticism gracefully
- Focus on what's best for the community

### Be Patient
- Maintainers are volunteers
- Response times may vary
- Be patient with newcomers
- Help others when you can

## 📞 Getting Help

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and general discussion
- **Discord/Slack**: (if available) For real-time chat
- **Email**: For sensitive issues

## 📄 License

By contributing to Flucid, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Flucid! 🎉
