import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'subject_accents.tailor.dart';

@TailorMixinComponent()
class SubjectAccentScheme extends ThemeExtension<SubjectAccentScheme>
    with _$SubjectAccentSchemeTailorMixin {
  const SubjectAccentScheme({
    required this.computer,
    required this.bio,
    required this.design,
    required this.chemistry,
    required this.physics,
    required this.math,
    required this.economics,
    required this.engineering,
    required this.fallback,
  });

  @override
  final SubjectAccent computer;
  @override
  final SubjectAccent bio;
  @override
  final SubjectAccent design;
  @override
  final SubjectAccent chemistry;
  @override
  final SubjectAccent physics;
  @override
  final SubjectAccent math;
  @override
  final SubjectAccent economics;
  @override
  final SubjectAccent engineering;
  @override
  final SubjectAccent fallback;

  /// Dispatch logic migrated from shared/utils/course_palette.dart.
  SubjectAccent forDept(String? dept) {
    final d = (dept ?? '').toLowerCase();
    if (d.contains('计算机') ||
        d.contains('信息') ||
        d.contains('软件') ||
        d.contains('cs') ||
        d.contains('ee')) {
      return computer;
    }
    if (d.contains('生命') ||
        d.contains('生物') ||
        d.contains('医') ||
        d.contains('bio')) {
      return bio;
    }
    if (d.contains('创意') ||
        d.contains('设计') ||
        d.contains('艺') ||
        d.contains('人文') ||
        d.contains('语言') ||
        d.contains('社会')) {
      return design;
    }
    if (d.contains('物质') || d.contains('化学') || d.contains('材料')) {
      return chemistry;
    }
    if (d.contains('物理') || d.contains('力学')) {
      return physics;
    }
    if (d.contains('数学') || d.contains('统计') || d.contains('math')) {
      return math;
    }
    if (d.contains('经济') || d.contains('管理') || d.contains('商')) {
      return economics;
    }
    if (d.contains('机械') || d.contains('工程')) {
      return engineering;
    }
    return fallback;
  }
}

class SubjectAccent {
  const SubjectAccent(
      {required this.bg, required this.text, required this.accent});
  final Color bg;
  final Color text;
  final Color accent;
}
