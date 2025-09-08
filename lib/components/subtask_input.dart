import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/icons.dart';

class SubtaskInput extends StatefulWidget {
  final String placeholder;
  final VoidCallback? onAddPressed;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final bool enabled;
  final EdgeInsets? margin;

  const SubtaskInput({
    super.key,
    this.placeholder = 'Add new subtask',
    this.onAddPressed,
    this.onSubmitted,
    this.controller,
    this.enabled = true,
    this.margin,
  });

  @override
  State<SubtaskInput> createState() => _SubtaskInputState();
}

class _SubtaskInputState extends State<SubtaskInput> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmitted(String value) {
    if (value.trim().isNotEmpty) {
      widget.onSubmitted?.call(value.trim());
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.borderColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: const TextStyle(
                      color: AppTheme.secondaryText,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.primaryText,
                  ),
                  onSubmitted: _handleSubmitted,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: widget.enabled
                    ? () {
                        if (_controller.text.trim().isNotEmpty) {
                          _handleSubmitted(_controller.text);
                        } else {
                          widget.onAddPressed?.call();
                        }
                      }
                    : null,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    AppIcons.plus,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
