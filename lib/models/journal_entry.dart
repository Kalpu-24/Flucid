import 'package:uuid/uuid.dart';

class JournalEntry {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String? category;
  final String? subcategory;
  final String? mood;
  final int? energyLevel; // 1-10 scale
  final List<String> tags;
  final List<String> linkedTaskIds;
  final List<String> attachments; // File paths or URLs
  final DateTime createdAt;
  final DateTime updatedAt;

  JournalEntry({
    String? id,
    required this.title,
    required this.content,
    required this.date,
    this.category,
    this.subcategory,
    this.mood,
    this.energyLevel,
    this.tags = const [],
    this.linkedTaskIds = const [],
    this.attachments = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  JournalEntry copyWith({
    String? title,
    String? content,
    DateTime? date,
    String? category,
    String? subcategory,
    String? mood,
    int? energyLevel,
    List<String>? tags,
    List<String>? linkedTaskIds,
    List<String>? attachments,
    DateTime? updatedAt,
  }) {
    return JournalEntry(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      mood: mood ?? this.mood,
      energyLevel: energyLevel ?? this.energyLevel,
      tags: tags ?? this.tags,
      linkedTaskIds: linkedTaskIds ?? this.linkedTaskIds,
      attachments: attachments ?? this.attachments,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'category': category,
      'subcategory': subcategory,
      'mood': mood,
      'energyLevel': energyLevel,
      'tags': tags,
      'linkedTaskIds': linkedTaskIds,
      'attachments': attachments,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: DateTime.parse(json['date']),
      category: json['category'],
      subcategory: json['subcategory'],
      mood: json['mood'],
      energyLevel: json['energyLevel'],
      tags: List<String>.from(json['tags'] ?? []),
      linkedTaskIds: List<String>.from(json['linkedTaskIds'] ?? []),
      attachments: List<String>.from(json['attachments'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
