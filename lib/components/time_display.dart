import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';

class TimeDisplay extends StatelessWidget {
  final DateTime? time;
  final String? timeString;
  final TimeDisplayFormat format;
  final TextStyle? style;
  final bool showIcon;
  final IconData? icon;

  const TimeDisplay({
    super.key,
    this.time,
    this.timeString,
    this.format = TimeDisplayFormat.timeRange,
    this.style,
    this.showIcon = false,
    this.icon,
  }) : assert(time != null || timeString != null, 'Either time or timeString must be provided');

  @override
  Widget build(BuildContext context) {
    final displayText = _getDisplayText();
    final effectiveStyle = style ?? _getDefaultStyle();

    if (showIcon) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon ?? Icons.access_time,
            size: 16,
            color: effectiveStyle.color ?? AppTheme.secondaryText,
          ),
          const SizedBox(width: 4),
          Text(displayText, style: effectiveStyle),
        ],
      );
    }

    return Text(displayText, style: effectiveStyle);
  }

  String _getDisplayText() {
    if (timeString != null) return timeString!;

    final dateTime = time!;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final taskDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    switch (format) {
      case TimeDisplayFormat.timeRange:
        return _formatTimeRange(dateTime);
      case TimeDisplayFormat.timeOnly:
        return DateFormat('h:mm a').format(dateTime);
      case TimeDisplayFormat.dateOnly:
        return DateFormat('MMM d, yyyy').format(dateTime);
      case TimeDisplayFormat.relative:
        return _formatRelative(dateTime, now, today, yesterday, taskDate);
      case TimeDisplayFormat.full:
        return DateFormat('MMM d, yyyy h:mm a').format(dateTime);
    }
  }

  String _formatTimeRange(DateTime dateTime) {
    // For time ranges, we'll format as "9:00 AM - 10:15 AM"
    // This is a simplified version - in real implementation, you'd have start and end times
    return DateFormat('h:mm a').format(dateTime);
  }

  String _formatRelative(DateTime dateTime, DateTime now, DateTime today, DateTime yesterday, DateTime taskDate) {
    if (taskDate == today) {
      return 'Today';
    } else if (taskDate == yesterday) {
      return 'Yesterday';
    } else {
      final difference = today.difference(taskDate).inDays;
      if (difference < 7) {
        return '${difference}d ago';
      } else if (difference < 30) {
        final weeks = (difference / 7).floor();
        return '${weeks}w ago';
      } else {
        return DateFormat('MMM d').format(dateTime);
      }
    }
  }

  TextStyle _getDefaultStyle() {
    switch (format) {
      case TimeDisplayFormat.timeRange:
        return const TextStyle(
          fontSize: 12,
          color: AppTheme.secondaryText,
          fontWeight: FontWeight.w500,
        );
      case TimeDisplayFormat.timeOnly:
        return const TextStyle(
          fontSize: 12,
          color: AppTheme.secondaryText,
        );
      case TimeDisplayFormat.dateOnly:
        return const TextStyle(
          fontSize: 12,
          color: AppTheme.secondaryText,
        );
      case TimeDisplayFormat.relative:
        return const TextStyle(
          fontSize: 12,
          color: AppTheme.secondaryText,
        );
      case TimeDisplayFormat.full:
        return const TextStyle(
          fontSize: 12,
          color: AppTheme.secondaryText,
        );
    }
  }
}

enum TimeDisplayFormat {
  timeRange,    // "9:00 AM - 10:15 AM"
  timeOnly,     // "9:00 AM"
  dateOnly,     // "Jan 15, 2024"
  relative,     // "Today", "Yesterday", "2d ago"
  full,         // "Jan 15, 2024 9:00 AM"
}
