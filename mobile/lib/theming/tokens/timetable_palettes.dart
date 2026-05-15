import 'package:flutter/material.dart';

typedef TimetablePalette = ({Color bg, Color text, Color accent});

// Fixed visual language for odd/even week indicators in the timetable view.
const kOddWeekDotColor = Color(0xFFEA580C);
const kEvenWeekDotColor = Color(0xFF0284C7);

const _kLight = <TimetablePalette>[
  (bg: Color(0xFFFFEDD5), text: Color(0xFF6B2F00), accent: Color(0xFF9F4E00)), // amber
  (bg: Color(0xFFFEF3C7), text: Color(0xFF5F3A00), accent: Color(0xFF78620E)), // golden
  (bg: Color(0xFFD1FAE5), text: Color(0xFF064E3B), accent: Color(0xFF059669)), // emerald
  (bg: Color(0xFFDCFCE7), text: Color(0xFF14532D), accent: Color(0xFF16A34A)), // green
  (bg: Color(0xFFE0F2FE), text: Color(0xFF0C4A6E), accent: Color(0xFF0284C7)), // sky
  (bg: Color(0xFFEDE9FE), text: Color(0xFF2E1065), accent: Color(0xFF7C3AED)), // violet
  (bg: Color(0xFFFCE7F3), text: Color(0xFF831843), accent: Color(0xFFDB2777)), // pink
  (bg: Color(0xFFFFF1E6), text: Color(0xFF431407), accent: Color(0xFFEA580C)), // orange
  (bg: Color(0xFFE0F7FA), text: Color(0xFF01354A), accent: Color(0xFF0288D1)), // cyan
  (bg: Color(0xFFF3E8FF), text: Color(0xFF3B0764), accent: Color(0xFF9333EA)), // purple
];

const _kDark = <TimetablePalette>[
  (bg: Color(0xFF2D1A0A), text: Color(0xFFFFD8A8), accent: Color(0xFFFFB45C)),
  (bg: Color(0xFF292207), text: Color(0xFFF4DF94), accent: Color(0xFFD8C36D)),
  (bg: Color(0xFF0D251A), text: Color(0xFFB7E6C8), accent: Color(0xFF5AC584)),
  (bg: Color(0xFF10251B), text: Color(0xFFC4E8CC), accent: Color(0xFF78D18B)),
  (bg: Color(0xFF0B2230), text: Color(0xFFB7DBF0), accent: Color(0xFF5AB3E0)),
  (bg: Color(0xFF211A35), text: Color(0xFFD8C8F4), accent: Color(0xFFA98CE8)),
  (bg: Color(0xFF301624), text: Color(0xFFF0BDD5), accent: Color(0xFFE879AC)),
  (bg: Color(0xFF301A0F), text: Color(0xFFF7C9A8), accent: Color(0xFFFF8A4C)),
  (bg: Color(0xFF0C2630), text: Color(0xFFB7E8EF), accent: Color(0xFF5BC8D8)),
  (bg: Color(0xFF261832), text: Color(0xFFE0C5F4), accent: Color(0xFFC084FC)),
];

TimetablePalette timetablePalette(String courseCode, {required bool isDark}) {
  final base =
      courseCode.contains('.') ? courseCode.split('.').first : courseCode;
  final hash = base.codeUnits.fold(0, (h, c) => (h * 31 + c) & 0x7FFFFFFF);
  final palettes = isDark ? _kDark : _kLight;
  return palettes[hash % palettes.length];
}
