import 'package:flutter/material.dart';

enum AppToastTone { info, success, warning, error }

class AppToast {
  static void show(
    BuildContext context,
    String message, {
    AppToastTone tone = AppToastTone.info,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final (icon, background, foreground) = switch (tone) {
      AppToastTone.success => (
          Icons.check_circle_rounded,
          colorScheme.primaryContainer,
          colorScheme.onPrimaryContainer,
        ),
      AppToastTone.warning => (
          Icons.warning_rounded,
          colorScheme.tertiaryContainer,
          colorScheme.onTertiaryContainer,
        ),
      AppToastTone.error => (
          Icons.error_rounded,
          colorScheme.errorContainer,
          colorScheme.onErrorContainer,
        ),
      AppToastTone.info => (
          Icons.info_rounded,
          colorScheme.surfaceContainerHighest,
          colorScheme.onSurface,
        ),
    };
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: background,
          content: Row(
            children: [
              Icon(icon, size: 18, color: foreground),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: foreground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
