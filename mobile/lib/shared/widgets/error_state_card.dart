import 'package:flutter/material.dart';

class ErrorStateCard extends StatelessWidget {
  const ErrorStateCard({
    super.key,
    this.title = "请求失败",
    required this.message,
    this.hint,
    this.onRetry,
  });

  final String title;
  final String message;
  final String? hint;
  final Future<void> Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.error_outline_rounded,
                        color: theme.colorScheme.error),
                    const SizedBox(width: 10),
                    Text(title, style: theme.textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: 12),
                SelectableText(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    height: 1.35,
                  ),
                ),
                if (hint != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    hint!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                ],
                if (onRetry != null) ...[
                  const SizedBox(height: 14),
                  FilledButton.tonal(
                    onPressed: () => onRetry!.call(),
                    child: const Text("重试"),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
