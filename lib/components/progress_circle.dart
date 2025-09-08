import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProgressCircle extends StatelessWidget {
  final double progress;
  final double size;
  final Color? progressColor;
  final Color? backgroundColor;
  final double strokeWidth;
  final String? label;
  final TextStyle? labelStyle;
  final bool showPercentage;

  const ProgressCircle({
    super.key,
    required this.progress,
    this.size = 60.0,
    this.progressColor,
    this.backgroundColor,
    this.strokeWidth = 4.0,
    this.label,
    this.labelStyle,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final effectiveProgressColor = progressColor ?? AppTheme.primaryAccent;
    final effectiveBackgroundColor = backgroundColor ?? AppTheme.borderColor;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Background circle
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: strokeWidth,
            backgroundColor: effectiveBackgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(effectiveBackgroundColor),
          ),
          // Progress circle
          CircularProgressIndicator(
            value: clampedProgress,
            strokeWidth: strokeWidth,
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color>(effectiveProgressColor),
          ),
          // Center content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showPercentage)
                  Text(
                    '${(clampedProgress * 100).toInt()}%',
                    style: labelStyle ??
                        const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryText,
                        ),
                  ),
                if (label != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    label!,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppTheme.secondaryText,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
