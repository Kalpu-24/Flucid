import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AvatarGroup extends StatelessWidget {
  final List<AvatarData> avatars;
  final double size;
  final double spacing;
  final int maxVisible;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final bool showOverflowCount;

  const AvatarGroup({
    super.key,
    required this.avatars,
    this.size = 32.0,
    this.spacing = -8.0,
    this.maxVisible = 3,
    this.backgroundColor,
    this.textStyle,
    this.showOverflowCount = true,
  });

  @override
  Widget build(BuildContext context) {
    if (avatars.isEmpty) return const SizedBox.shrink();

    final visibleAvatars = avatars.take(maxVisible).toList();
    final overflowCount = avatars.length - maxVisible;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...visibleAvatars.asMap().entries.map((entry) {
          final index = entry.key;
          final avatar = entry.value;
          
          return Container(
            margin: EdgeInsets.only(
              left: index > 0 ? spacing : 0,
            ),
            child: _buildAvatar(avatar),
          );
        }),
        if (showOverflowCount && overflowCount > 0) ...[
          Container(
            margin: EdgeInsets.only(left: spacing),
            child: _buildOverflowAvatar(overflowCount),
          ),
        ],
      ],
    );
  }

  Widget _buildAvatar(AvatarData avatar) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: avatar.backgroundColor ?? AppTheme.primaryAccent,
        backgroundImage: avatar.imageUrl != null ? NetworkImage(avatar.imageUrl!) : null,
        child: avatar.imageUrl == null
            ? Text(
                avatar.initials,
                style: textStyle ??
                    TextStyle(
                      color: Colors.white,
                      fontSize: size * 0.4,
                      fontWeight: FontWeight.w600,
                    ),
              )
            : null,
      ),
    );
  }

  Widget _buildOverflowAvatar(int count) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.borderColor,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '+$count',
          style: textStyle ??
              TextStyle(
                color: AppTheme.secondaryText,
                fontSize: size * 0.3,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

class AvatarData {
  final String initials;
  final String? imageUrl;
  final Color? backgroundColor;

  const AvatarData({
    required this.initials,
    this.imageUrl,
    this.backgroundColor,
  });

  factory AvatarData.fromName(String name) {
    final parts = name.trim().split(' ');
    final initials = parts.length > 1
        ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
        : parts[0][0].toUpperCase();
    
    return AvatarData(
      initials: initials,
      backgroundColor: _getColorFromName(name),
    );
  }

  static Color _getColorFromName(String name) {
    final colors = [
      AppTheme.primaryAccent,
      AppTheme.blueAccent,
      AppTheme.tealAccent,
      AppTheme.yellowAccent,
      const Color(0xFF9F7AEA), // Purple
      const Color(0xFFED8936), // Orange
      const Color(0xFF38B2AC), // Teal
      const Color(0xFFE53E3E), // Red
    ];
    
    final hash = name.hashCode;
    return colors[hash.abs() % colors.length];
  }
}
