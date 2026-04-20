import 'package:flutter/material.dart';

import '../../core/theme.dart';

/// Canonical course-card palette shared by CoursePage and CourseDetailPage.
///
/// Returns (bg, text, accent) colours adapted to the current [isDark] flag.
/// Pass `context.isDark` at call site so the widget adapts automatically.
typedef CoursePalette = ({Color bg, Color text, Color accent});

CoursePalette coursePalette(String? dept, {bool isDark = false}) {
  final d = (dept ?? '').toLowerCase();

  // ── Computer science / EE / Software ─────────────────────────────────────
  if (d.contains('计算机') ||
      d.contains('信息') ||
      d.contains('软件') ||
      d.contains('cs') ||
      d.contains('ee')) {
    return isDark
        ? (
            bg: const Color(0xFF0D2030),
            text: const Color(0xFFAAD4F0),
            accent: const Color(0xFF4BA8D8),
          )
        : (
            bg: const Color(0xFFE6F2FF),
            text: const Color(0xFF0D3A6B),
            accent: const Color(0xFF2B6CB0),
          );
  }

  // ── Life sciences / Bio / Medicine ───────────────────────────────────────
  if (d.contains('生命') ||
      d.contains('生物') ||
      d.contains('医') ||
      d.contains('bio')) {
    return isDark
        ? (
            bg: const Color(0xFF0B2016),
            text: const Color(0xFF9FCDB0),
            accent: const Color(0xFF3FA060),
          )
        : (
            bg: const Color(0xFFE8F8EE),
            text: const Color(0xFF1A4A2E),
            accent: const Color(0xFF2D6A4F),
          );
  }

  // ── Creative / Design / Arts / Humanities ────────────────────────────────
  if (d.contains('创意') ||
      d.contains('设计') ||
      d.contains('艺') ||
      d.contains('人文') ||
      d.contains('语言') ||
      d.contains('社会')) {
    return isDark
        ? (
            bg: const Color(0xFF2C1008),
            text: const Color(0xFFE0B090),
            accent: const Color(0xFFCC6830),
          )
        : (
            bg: const Color(0xFFFFEBE3),
            text: const Color(0xFF4A1E00),
            accent: const Color(0xFF9A3412),
          );
  }

  // ── Chemistry / Materials ────────────────────────────────────────────────
  if (d.contains('物质') || d.contains('化学') || d.contains('材料')) {
    return isDark
        ? (
            bg: const Color(0xFF22122C),
            text: const Color(0xFFD0A8E8),
            accent: const Color(0xFF9860C0),
          )
        : (
            bg: const Color(0xFFF3E8FF),
            text: const Color(0xFF3B1A6B),
            accent: const Color(0xFF6B21A8),
          );
  }

  // ── Physics / Mechanics ──────────────────────────────────────────────────
  if (d.contains('物理') || d.contains('力学')) {
    return isDark
        ? (
            bg: const Color(0xFF101828),
            text: const Color(0xFFB0C4E8),
            accent: const Color(0xFF5070C0),
          )
        : (
            bg: const Color(0xFFEEF2FF),
            text: const Color(0xFF1E3A8A),
            accent: const Color(0xFF3730A3),
          );
  }

  // ── Mathematics / Statistics ─────────────────────────────────────────────
  if (d.contains('数学') || d.contains('统计') || d.contains('math')) {
    return isDark
        ? (
            bg: const Color(0xFF1E1A08),
            text: const Color(0xFFE0D098),
            accent: const Color(0xFFB89840),
          )
        : (
            bg: const Color(0xFFFFF4CC),
            text: const Color(0xFF4A3500),
            accent: const Color(0xFF92651A),
          );
  }

  // ── Economics / Management ───────────────────────────────────────────────
  if (d.contains('经济') || d.contains('管理') || d.contains('商')) {
    return isDark
        ? (
            bg: const Color(0xFF280E18),
            text: const Color(0xFFE0A8C0),
            accent: const Color(0xFFC06080),
          )
        : (
            bg: const Color(0xFFFFF0F3),
            text: const Color(0xFF4A0020),
            accent: const Color(0xFF9D174D),
          );
  }

  // ── Engineering / Mechanics ──────────────────────────────────────────────
  if (d.contains('机械') || d.contains('工程')) {
    return isDark
        ? (
            bg: const Color(0xFF221408),
            text: const Color(0xFFE0C098),
            accent: const Color(0xFFD07830),
          )
        : (
            bg: const Color(0xFFFFF7ED),
            text: const Color(0xFF431407),
            accent: const Color(0xFFEA580C),
          );
  }

  // ── Default: Sunlit Commons warm neutral ─────────────────────────────────
  return isDark
      ? (
          bg: const Color(0xFF1E1B14),
          text: const Color(0xFFE9E2D5),
          accent: const Color(0xFFFFB45C),
        )
      : (
          bg: kColorSurfaceContainerLow,
          text: kColorOnSurface,
          accent: kColorPrimary,
        );
}
