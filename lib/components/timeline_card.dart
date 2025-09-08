import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/icons.dart';

class TimelineCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String timeRange;
  final String? subtaskTitle;
  final List<Widget>? participants;
  final VoidCallback? onTap;
  final VoidCallback? onMorePressed;
  final Color? backgroundColor;
  final EdgeInsets? margin;

  const TimelineCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.timeRange,
    this.subtaskTitle,
    this.participants,
    this.onTap,
    this.onMorePressed,
    this.backgroundColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: backgroundColor ?? Colors.white,
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
                  const SizedBox(height: 4),
                  _buildSubtitle(),
                ],
                const SizedBox(height: 8),
                _buildTimeRange(),
                if (subtaskTitle != null) ...[
                  const SizedBox(height: 12),
                  _buildSubtaskChip(),
                ],
                if (participants != null && participants!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildFooter(),
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
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryText,
            ),
          ),
        ),
        if (onMorePressed != null)
          IconButton(
            onPressed: onMorePressed,
            icon: const Icon(
              AppIcons.ellipsisVertical,
              color: AppTheme.secondaryText,
              size: 20,
            ),
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      subtitle!,
      style: const TextStyle(
        fontSize: 14,
        color: AppTheme.primaryText,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildTimeRange() {
    return Text(
      timeRange,
      style: const TextStyle(
        fontSize: 12,
        color: AppTheme.secondaryText,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSubtaskChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.borderColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        subtaskTitle!,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.primaryText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: participants!,
          ),
        ),
        const Icon(
          AppIcons.chevronRight,
          color: AppTheme.secondaryText,
          size: 16,
        ),
      ],
    );
  }
}
