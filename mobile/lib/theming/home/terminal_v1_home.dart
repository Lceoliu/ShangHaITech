import 'package:flutter/material.dart';

import '../../features/home/my_timeline_page.dart';
import '../../features/home/home_content_scope.dart';
import '../../features/home/home_repository.dart';
import '../../features/home/swipe_complete_plan.dart';
import '../context_extensions.dart';
import 'home_slot_bundle.dart';

HomeSlotBundle terminalV1HomeBundle() => const HomeSlotBundle(
      topBanner: _terminalTopBanner,
      greeting: _terminalGreeting,
      nextClass: _terminalNextClass,
      weeklyDdl: _terminalWeeklyDdl,
      todayTodos: _terminalTodayTodos,
      weeklySchedule: _terminalWeeklySchedule,
    );

Widget _terminalTopBanner(BuildContext _) => const SizedBox.shrink();

// ── Section header ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, this.trailing});
  final String label;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final mono = context.tokens.fontFamilies.mono;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '> $label',
            style: TextStyle(
              fontFamily: mono,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              letterSpacing: 0.5,
            ),
          ),
          if (trailing != null) ...[
            const Spacer(),
            Text(
              trailing!,
              style: TextStyle(
                fontFamily: mono,
                fontSize: 10,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Greeting ───────────────────────────────────────────────────────────────────

Widget _terminalGreeting(BuildContext context) {
  final scope = HomeContentScope.of(context);
  final data = scope.data;
  final user = data.session.user;
  final binding = data.session.campusBinding;
  final now = DateTime.now();
  final name = binding?.studentName ?? user?.displayName ?? 'Guest';
  final identity = [
    binding?.department,
    if ((binding?.studentId ?? '').trim().isNotEmpty)
      'UID ${binding!.studentId}',
  ].whereType<String>().where((s) => s.trim().isNotEmpty).join(' · ');
  final urgentDdl =
      data.todayDeadlines.isNotEmpty ? data.todayDeadlines.first : null;
  final cs = context.cs;
  final mono = context.tokens.fontFamilies.mono;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '> ${_timeGreeting(now.hour)}，${_weekdayChinese(now.weekday)}',
        style: TextStyle(
          fontFamily: mono,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: cs.onSurface,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(height: 3),
      Text(
        name,
        style: TextStyle(
          fontFamily: mono,
          fontSize: 34,
          fontWeight: FontWeight.w900,
          color: cs.onSurface,
          height: 1.1,
        ),
      ),
      if (identity.isNotEmpty) ...[
        const SizedBox(height: 3),
        Text(
          identity,
          style: TextStyle(
            fontFamily: mono,
            fontSize: 11,
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
      if (urgentDdl != null) ...[
        const SizedBox(height: 14),
        _UrgentDdlCard(
          ddl: urgentDdl,
          onTap: () => scope.onOpenPlan(urgentDdl.item),
          onComplete: () => scope.onCompletePlan(urgentDdl.item),
        ),
      ],
    ],
  );
}

class _UrgentDdlCard extends StatelessWidget {
  const _UrgentDdlCard({
    required this.ddl,
    required this.onTap,
    required this.onComplete,
  });
  final HomePlanDeadline ddl;
  final VoidCallback onTap;
  final Future<void> Function() onComplete;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final mono = context.tokens.fontFamilies.mono;
    final course = ddl.course;
    return SwipeCompletePlan(
      key: ValueKey('terminal_urgent_ddl_${ddl.item.id}'),
      itemId: ddl.item.id,
      compact: true,
      onComplete: onComplete,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: cs.surface,
            border: Border.all(color: cs.onSurface, width: 1),
            boxShadow: _hardShadow(context),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 28,
                  color: cs.error.withValues(alpha: 0.1),
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(width: 8, height: 8, color: cs.error),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '最近 DDL · ${course ?? ddl.platform}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: mono,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          ddl.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: mono,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: cs.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${ddl.platform} · 点击查看',
                          style: TextStyle(
                            fontFamily: mono,
                            fontSize: 10,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  color: cs.error,
                  alignment: Alignment.center,
                  child: Text(
                    _countdownHms(ddl.dueAt),
                    style: TextStyle(
                      fontFamily: mono,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: cs.onError,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Weekly DDL timeline ────────────────────────────────────────────────────────

Widget _terminalWeeklyDdl(BuildContext context) {
  final scope = HomeContentScope.of(context);
  final data = scope.data;
  final now = DateTime.now();
  final horizon = now.add(const Duration(days: 7));

  final ddlTimes = [
    ...data.todayDeadlines
        .where((d) => d.dueAt != null && d.dueAt!.isAfter(now))
        .map((d) => d.dueAt!),
    ...data.upcomingPlans
        .where((p) => p.kind == 'ddl' && p.relevantAt.isBefore(horizon))
        .map((p) => p.relevantAt),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _SectionHeader(
        label: '本周 Timeline',
        trailing: '${ddlTimes.length} pending · 7d horizon',
      ),
      GestureDetector(
        onTap: () => Navigator.of(context).push(
          buildMyTimelineRoute(
            deadlines: data.todayDeadlines,
            upcomingPlans: data.upcomingPlans,
            courses: data.courses,
            onOpenPlan: scope.onOpenPlan,
          ),
        ),
        child: Hero(
          tag: 'ddl-timeline-card',
          flightShuttleBuilder: (_, __, ___, ____, toHero) => toHero.widget,
          child: Container(
            height: 60,
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
            decoration: BoxDecoration(
              color: context.cs.surface,
              border: Border.all(color: context.cs.outlineVariant, width: 1),
              boxShadow: _hardShadow(context),
            ),
            child: _DdlTimeline(ddlTimes: ddlTimes),
          ),
        ),
      ),
    ],
  );
}

class _DdlTimeline extends StatelessWidget {
  const _DdlTimeline({required this.ddlTimes});
  final List<DateTime> ddlTimes;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final mono = context.tokens.fontFamilies.mono;
    return Column(
      children: [
        Expanded(
          child: CustomPaint(
            painter: _DdlTimelinePainter(
              ddlTimes: ddlTimes,
              dotColor: cs.error,
              lineColor: cs.outlineVariant,
              markerColor: cs.onSurface,
            ),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text('NOW',
                style: TextStyle(
                    fontFamily: mono,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: cs.onSurface)),
            const Spacer(),
            Text('+2d',
                style: TextStyle(
                    fontFamily: mono, fontSize: 9, color: cs.onSurfaceVariant)),
            const Spacer(),
            Text('+4d',
                style: TextStyle(
                    fontFamily: mono, fontSize: 9, color: cs.onSurfaceVariant)),
            const Spacer(),
            Text('+7d',
                style: TextStyle(
                    fontFamily: mono, fontSize: 9, color: cs.onSurfaceVariant)),
          ],
        ),
      ],
    );
  }
}

class _DdlTimelinePainter extends CustomPainter {
  _DdlTimelinePainter({
    required this.ddlTimes,
    required this.dotColor,
    required this.lineColor,
    required this.markerColor,
  });
  final List<DateTime> ddlTimes;
  final Color dotColor;
  final Color lineColor;
  final Color markerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final now = DateTime.now();
    final horizonMs = const Duration(days: 7).inMilliseconds.toDouble();
    final lineY = size.height / 2;

    canvas.drawLine(
      Offset(0, lineY),
      Offset(size.width, lineY),
      Paint()
        ..color = lineColor
        ..strokeWidth = 1,
    );

    canvas.drawLine(
      Offset(0, lineY - 7),
      Offset(0, lineY + 7),
      Paint()
        ..color = markerColor
        ..strokeWidth = 2,
    );

    final dotPaint = Paint()..color = dotColor;
    for (final dt in ddlTimes) {
      final ms = dt.difference(now).inMilliseconds.clamp(0, horizonMs.toInt());
      final x = (ms / horizonMs) * size.width;
      canvas.drawRect(
        Rect.fromCenter(center: Offset(x, lineY), width: 4, height: 10),
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DdlTimelinePainter old) =>
      old.ddlTimes != ddlTimes;
}

// ── Next class ─────────────────────────────────────────────────────────────────

Widget _terminalNextClass(BuildContext context) {
  final scope = HomeContentScope.of(context);
  final data = scope.data;
  final nextCourse = data.courses.isNotEmpty ? data.courses.first : null;
  final cs = context.cs;
  final mono = context.tokens.fontFamilies.mono;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _SectionHeader(
        label: '下一节课',
        trailing: nextCourse == null
            ? null
            : _nextClassTimeLabel(nextCourse.startsAt),
      ),
      if (nextCourse == null)
        Text(
          '> 今日暂无未结束课程',
          style: TextStyle(
              fontFamily: mono, fontSize: 12, color: cs.onSurfaceVariant),
        )
      else
        _NextClassCard(
          course: nextCourse,
          onTap: () => scope.onOpenPlan(nextCourse.item),
        ),
    ],
  );
}

class _NextClassCard extends StatelessWidget {
  const _NextClassCard({required this.course, required this.onTap});
  final HomePlanCourse course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final mono = context.tokens.fontFamilies.mono;
    final teacher =
        course.teacherNames.isNotEmpty ? course.teacherNames.first : '—';
    final location = course.location ?? '—';
    final diff = course.startsAt.difference(DateTime.now());
    final upcoming = !diff.isNegative;
    final absDiff = upcoming ? diff : -diff;
    final h = absDiff.inHours;
    final m = absDiff.inMinutes.remainder(60);
    final countdownShort = h > 0 ? '${h}h' : '${m}m';
    final fullLabel =
        upcoming ? 'T- ${h}h ${m.toString().padLeft(2, '0')}m' : 'IN PROGRESS';

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          border: Border.all(color: cs.outlineVariant, width: 1),
          boxShadow: _hardShadow(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NextClassSeparator(countdown: fullLabel),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: mono,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: cs.onSurface,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$location · $teacher',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: mono,
                              fontSize: 11,
                              color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'COUNTDOWN',
                        style: TextStyle(
                          fontFamily: mono,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurfaceVariant,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        countdownShort,
                        style: TextStyle(
                          fontFamily: mono,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: cs.error,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextClassSeparator extends StatelessWidget {
  const _NextClassSeparator({required this.countdown});
  final String countdown;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final mono = context.tokens.fontFamilies.mono;
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        border: Border(bottom: BorderSide(color: cs.outlineVariant, width: 1)),
      ),
      child: Row(
        children: [
          Text(
            '≡ NEXT_CLASS ',
            style: TextStyle(
              fontFamily: mono,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: cs.onSurface,
            ),
          ),
          Expanded(
            child: LayoutBuilder(builder: (_, c) {
              final chars = (c.maxWidth / 7.5).floor().clamp(0, 80);
              return Text(
                '═' * chars,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontFamily: mono, fontSize: 10, color: cs.outlineVariant),
              );
            }),
          ),
          Text(
            ' $countdown ≡',
            style: TextStyle(
              fontFamily: mono,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Today todos ────────────────────────────────────────────────────────────────

Widget _terminalTodayTodos(BuildContext context) {
  final scope = HomeContentScope.of(context);
  final data = scope.data;
  final cs = context.cs;
  final mono = context.tokens.fontFamilies.mono;

  final entries = [
    ...data.todayDeadlines.map(_TodoEntry.fromDeadline),
    ...data.upcomingPlans.map(_TodoEntry.fromPlan),
  ]..sort((a, b) => a.relevantAt.compareTo(b.relevantAt));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _SectionHeader(
        label: '今日待办',
        trailing: '${entries.take(5).length} of ${entries.length}',
      ),
      Container(
        decoration: BoxDecoration(
          color: cs.surface,
          border: Border.all(color: cs.outlineVariant, width: 1),
          boxShadow: _hardShadow(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (entries.isEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
                child: Text(
                  '> all clear',
                  style: TextStyle(
                      fontFamily: mono,
                      fontSize: 12,
                      color: cs.onSurfaceVariant),
                ),
              )
            else
              ...entries.take(5).toList().asMap().entries.map(
                    (entry) => _TodoRow(
                      item: entry.value,
                      index: entry.key,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 10),
              child: Row(
                children: [
                  _TextBtn(label: '+ 添加', onTap: scope.onAddPlan),
                  const SizedBox(width: 16),
                  _TextBtn(label: '管理', onTap: scope.onManagePlans),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _TodoEntry {
  const _TodoEntry({
    required this.item,
    required this.title,
    required this.kind,
    required this.subtitle,
    required this.relevantAt,
  });
  final PlanScheduleItem item;
  final String title;
  final String kind;
  final String subtitle;
  final DateTime relevantAt;

  factory _TodoEntry.fromDeadline(HomePlanDeadline d) => _TodoEntry(
        item: d.item,
        title: d.title,
        kind: 'ddl',
        subtitle: d.course ?? d.platform,
        relevantAt: d.dueAt ?? DateTime.now(),
      );

  factory _TodoEntry.fromPlan(HomeUpcomingPlanItem p) => _TodoEntry(
        item: p.item,
        title: p.title,
        kind: p.kind,
        subtitle: p.subtitle,
        relevantAt: p.relevantAt,
      );
}

class _TodoRow extends StatelessWidget {
  const _TodoRow({required this.item, required this.index});
  final _TodoEntry item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final scope = HomeContentScope.of(context);
    final cs = context.cs;
    final mono = context.tokens.fontFamilies.mono;
    final isDdl = item.kind == 'ddl';
    return SwipeCompletePlan(
      key: ValueKey('terminal_todo_${item.item.id}_$index'),
      itemId: item.item.id,
      compact: true,
      onComplete: () => scope.onCompletePlan(item.item),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => scope.onOpenPlan(item.item),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: cs.outlineVariant, width: 1)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => scope.onOpenPlan(item.item),
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: isDdl
                      ? BoxDecoration(color: cs.error)
                      : BoxDecoration(
                          border: Border.all(
                            color: cs.onSurfaceVariant,
                            width: 1.5,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: mono,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    Text(
                      '${item.subtitle} · ${_formatPlanTime(item.relevantAt)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: mono,
                        fontSize: 10,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _compactCountdown(item.relevantAt),
                style: TextStyle(
                  fontFamily: mono,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: isDdl ? cs.error : cs.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextBtn extends StatelessWidget {
  const _TextBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontFamily: context.tokens.fontFamilies.mono,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: context.cs.error,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ── Weekly schedule ────────────────────────────────────────────────────────────

Widget _terminalWeeklySchedule(BuildContext context) {
  final scope = HomeContentScope.of(context);
  final data = scope.data;
  final courses = data.courses;
  final cs = context.cs;
  final mono = context.tokens.fontFamilies.mono;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 14),
      _SectionHeader(label: '今日课表'),
      if (courses.isEmpty)
        Text(
          '> 今日暂无课程',
          style: TextStyle(
              fontFamily: mono, fontSize: 12, color: cs.onSurfaceVariant),
        )
      else
        _CourseGrid(
          courses: courses,
          onOpen: scope.onOpenPlan,
        ),
    ],
  );
}

class _CourseGrid extends StatelessWidget {
  const _CourseGrid({required this.courses, required this.onOpen});
  final List<HomePlanCourse> courses;
  final void Function(PlanScheduleItem) onOpen;

  @override
  Widget build(BuildContext context) {
    final visible = courses.take(6).toList();
    final rows = <Widget>[];
    for (var i = 0; i < visible.length; i += 2) {
      final left = visible[i];
      final right = i + 1 < visible.length ? visible[i + 1] : null;
      rows.add(IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _CourseCard(
                course: left,
                inverted: i == 0,
                onTap: () => onOpen(left.item),
              ),
            ),
            if (right != null)
              Expanded(
                child: _CourseCard(
                  course: right,
                  inverted: false,
                  onTap: () => onOpen(right.item),
                ),
              )
            else
              const Expanded(child: SizedBox()),
          ],
        ),
      ));
    }
    return Column(children: rows);
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.course,
    required this.inverted,
    required this.onTap,
  });
  final HomePlanCourse course;
  final bool inverted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final mono = context.tokens.fontFamilies.mono;
    final bg = inverted ? cs.onSurface : cs.surface;
    final fg = inverted ? cs.surface : cs.onSurface;
    final fgMuted =
        inverted ? cs.surface.withValues(alpha: 0.65) : cs.onSurfaceVariant;
    final fgAccent = inverted ? cs.surface.withValues(alpha: 0.85) : cs.error;
    final teacher =
        course.teacherNames.isNotEmpty ? course.teacherNames.first : '—';
    final code = _courseCode(course);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(color: cs.outlineVariant, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$code · ${_courseTypeShort(course)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: mono,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: fgMuted,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              course.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: mono,
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: fg,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${course.location ?? '—'} · $teacher',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontFamily: mono, fontSize: 10, color: fgMuted),
            ),
            const SizedBox(height: 2),
            Text(
              course.timeLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: mono,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: fgAccent),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Helpers ────────────────────────────────────────────────────────────────────

List<BoxShadow> _hardShadow(BuildContext context, {double depth = 3}) => [
      BoxShadow(
        color: context.cs.onSurface.withValues(alpha: 0.7),
        offset: Offset(depth, depth),
        blurRadius: 0,
      ),
    ];

String _timeGreeting(int hour) {
  if (hour < 6) return '夜深了';
  if (hour < 12) return '早上好';
  if (hour < 18) return '下午好';
  return '晚上好';
}

const _weekdays = ['', '周一', '周二', '周三', '周四', '周五', '周六', '周日'];
String _weekdayChinese(int weekday) => _weekdays[weekday.clamp(1, 7)];

String _nextClassTimeLabel(DateTime startsAt) {
  final now = DateTime.now();
  final todayStart = DateTime(now.year, now.month, now.day);
  final tomorrowStart = todayStart.add(const Duration(days: 1));
  final courseDay = DateTime(startsAt.year, startsAt.month, startsAt.day);
  final time =
      '${startsAt.hour.toString().padLeft(2, '0')}:${startsAt.minute.toString().padLeft(2, '0')}';
  if (courseDay == todayStart) return '今日 $time';
  if (courseDay == tomorrowStart) return '明日 $time';
  return '${courseDay.month}.${courseDay.day.toString().padLeft(2, '0')} $time';
}

String _countdownHms(DateTime? target) {
  if (target == null) return '--:--:--';
  final diff = target.difference(DateTime.now());
  if (diff.isNegative) return '00:00:00';
  final h = diff.inHours.toString().padLeft(2, '0');
  final m = diff.inMinutes.remainder(60).toString().padLeft(2, '0');
  final s = diff.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$h:$m:$s';
}

String _compactCountdown(DateTime target) {
  final diff = target.difference(DateTime.now());
  if (diff.isNegative) return '已到期';
  if (diff.inHours < 24) {
    return '${diff.inHours}h ${diff.inMinutes.remainder(60)}m';
  }
  return '${diff.inDays}天 ${diff.inHours.remainder(24)}h';
}

String _formatPlanTime(DateTime target) {
  final local = target.toLocal();
  final month = local.month.toString().padLeft(2, '0');
  final day = local.day.toString().padLeft(2, '0');
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '$month.$day $hour:$minute';
}

String _courseCode(HomePlanCourse course) {
  final id = course.id.trim();
  if (id.isEmpty) return 'COURSE';
  final tail = id.split(RegExp(r'[:/#]')).last.trim();
  if (tail.isEmpty || tail.length > 12) return 'COURSE';
  return tail.toUpperCase();
}

String _courseTypeShort(HomePlanCourse course) {
  final t = course.title;
  if (t.contains('实验')) return '实验';
  if (t.contains('讨论')) return '讨论';
  if (t.contains('导课')) return '导课';
  if (t.contains('习题')) return '习题';
  return '课';
}
