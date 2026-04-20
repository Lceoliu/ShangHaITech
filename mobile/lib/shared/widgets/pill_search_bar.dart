import 'package:flutter/material.dart';

class PillSearchBar extends StatelessWidget {
  const PillSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onSubmitted,
    this.prefixIcon = Icons.search_rounded,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onSubmitted;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHigh,
      ),
    );
  }
}
