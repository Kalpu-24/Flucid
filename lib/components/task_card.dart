import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/icons.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? timeRange;
  final double? progress;
  final Color? progressColor;
  final String? taskCount;
  final String? commentCount;
  final String? dueDate;
  final String? category;
  final Color? categoryColor;
  final VoidCallback? onTap;
  final VoidCallback? onMorePressed;
  final List<Widget>? actions;
  final EdgeInsets? padding;
  final bool showProgress;
  final bool showActions;

  const TaskCard({
    super.key,
    required this.title,
    this.subtitle,
    this.timeRange,
    this.progress,
    this.progressColor,
    this.taskCount,
    this.commentCount,
    this.dueDate,
    this.category,
    this.categoryColor,
    this.onTap,
    this.onMorePressed,
    this.actions,
    this.padding,
    this.showProgress = true,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding ?? const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.borderColor,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  _buildSubtitle(),
                ],
                if (timeRange != null) ...[
                  const SizedBox(height: 8),
                  _buildTimeRange(),
                ],
                const SizedBox(height: 12),
                _buildFooter(),
                if (showProgress && progress != null) ...[
                  const SizedBox(height: 12),
                  _buildProgress(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        if (category != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: (categoryColor ?? AppTheme.primaryAccent).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              category!,
              style: TextStyle(
                color: categoryColor ?? AppTheme.primaryAccent,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryText,
            ),
          ),
        ),
        if (showActions) ...[
          if (onMorePressed != null)
            IconButton(
              onPressed: onMorePressed,
              icon: const Icon(
                AppIcons.ellipsisVertical,
                color: AppTheme.secondaryText,
                size: 16,
              ),
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
          if (actions != null) ...actions!,
        ],
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      subtitle!,
      style: const TextStyle(
        fontSize: 14,
        color: AppTheme.secondaryText,
      ),
    );
  }

  Widget _buildTimeRange() {
    return Text(
      timeRange!,
      style: const TextStyle(
        fontSize: 12,
        color: AppTheme.secondaryText,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        if (taskCount != null) ...[
          const Icon(
            AppIcons.checkCircle,
            color: AppTheme.secondaryText,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            taskCount!,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(width: 16),
        ],
        if (commentCount != null) ...[
          const Icon(
            AppIcons.chat,
            color: AppTheme.secondaryText,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            commentCount!,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(width: 16),
        ],
        if (dueDate != null) ...[
          const Icon(
            AppIcons.calendar,
            color: AppTheme.secondaryText,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            dueDate!,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.secondaryText,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildProgress() {
    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: progress!,
            backgroundColor: AppTheme.borderColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              progressColor ?? AppTheme.primaryAccent,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${(progress! * 100).toInt()}%',
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.secondaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
