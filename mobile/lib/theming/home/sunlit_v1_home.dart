import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/home/home_content_scope.dart';
import '../../features/home/home_repository.dart';
import '../../features/home/swipe_complete_plan.dart';
import '../../shared/models/session_models.dart';
import '../../theming/context_extensions.dart';
import 'home_slot_bundle.dart';

HomeSlotBundle sunlitV1HomeBundle() => const HomeSlotBundle(
      topBanner: _sunlitTopBanner,
      greeting: _sunlitGreeting,
      nextClass: _sunlitNextClass,
      weeklyDdl: _sunlitWeeklyDdl,
      todayTodos: _sunlitTodayTodos,
      weeklySchedule: _sunlitWeeklySchedule,
      quickActions: null,
    );

// ── Slot builders ─────────────────────────────────────────────────────────────

Widget _sunlitTopBanner(BuildContext _) => const SizedBox.shrink();

Widget _sunlitGreeting(BuildContext context) {
  final data = HomeContentScope.of(context).data;
  return _EditorialHero(
    user: data.session.user,
    binding: data.session.campusBinding,
    deadlineCount: data.todayDeadlines.length + data.upcomingPlans.length,
    courseCount: data.courses.length,
  );
}

Widget _sunlitNextClass(BuildContext context) {
  final scope = HomeContentScope.of(context);
  final data = scope.data;
  final nextCourse = data.courses.isNotEmpty ? data.courses.first : null;
  final urgentDdl =
      data.todayDeadlines.isNotEmpty ? data.todayDeadlines.first : null;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _SectionLabel(title: '今日安排'),
      const SizedBox(height: 14),
      _ScheduleGrid(
        nextCourse: nextCourse,
        urgentDdl: urgentDdl,
        onOpen: scope.onOpenPlan,
        onComplete: scope.onCompletePlan,
      ),
      if (data.courses.length > 1) ...[
        const SizedBox(height: 10),
        _CoursePills(
          courses: data.courses.skip(1).take(3).toList(),
          onOpen: scope.onOpenPlan,
        ),
      ],
    ],
  );
}

Widget _sunlitWeeklyDdl(BuildContext _) => const SizedBox.shrink();

Widget _sunlitTodayTodos(BuildContext context) {
  final scope = HomeContentScope.of(context);
  final data = scope.data;
  return _UpcomingPlanSection(
    items: data.upcomingPlans,
    onAdd: scope.onAddPlan,
    onManage: scope.onManagePlans,
    onDelete: scope.onDeletePlan,
    onComplete: scope.onCompletePlan,
    onOpen: scope.onOpenPlan,
  );
}

Widget _sunlitWeeklySchedule(BuildContext _) => const SizedBox.shrink();

// ── Helpers ───────────────────────────────────────────────────────────────────

String _timeGreeting() {
  final h = DateTime.now().hour;
  if (h < 6) return '夜深了';
  if (h < 12) return '早上好';
  if (h < 18) return '下午好';
  return '晚上好';
}

const _weekdays = ['', '周一', '周二', '周三', '周四', '周五', '周六', '周日'];
String _weekdayChinese(int wd) => _weekdays[wd.clamp(1, 7)];

enum _Urgency { overdue, today, soon, normal }

enum _DdlPressure { urgent, week, later }

_Urgency _urgency(DateTime? dueAt) {
  if (dueAt == null) return _Urgency.normal;
  final diff = dueAt.difference(DateTime.now());
  if (diff.isNegative) return _Urgency.overdue;
  if (diff.inHours <= 24) return _Urgency.today;
  if (diff.inDays <= 3) return _Urgency.soon;
  return _Urgency.normal;
}

String _formatDue(DateTime? dueAt) {
  if (dueAt == null) return '无截止';
  final diff = dueAt.difference(DateTime.now());
  if (diff.isNegative) return '已逾期';
  if (diff.inMinutes < 60) return '剩 ${diff.inMinutes} 分钟';
  if (diff.inHours < 24) return '剩 ${diff.inHours} 小时';
  if (diff.inDays <= 7) return '剩 ${diff.inDays} 天';
  return DateFormat('MM-dd HH:mm').format(dueAt.toLocal());
}

Color _urgencyColor(ColorScheme cs, _Urgency u) => switch (u) {
      _Urgency.overdue => cs.error,
      _Urgency.today => cs.primary,
      _Urgency.soon => cs.secondary,
      _Urgency.normal => cs.onSurfaceVariant,
    };

_DdlPressure _ddlPressure(DateTime relevantAt) {
  final diff = relevantAt.difference(DateTime.now());
  if (diff.inDays < 3) return _DdlPressure.urgent;
  if (diff.inDays < 7) return _DdlPressure.week;
  return _DdlPressure.later;
}

Color _ddlPressureColor(ColorScheme cs, _DdlPressure pressure) =>
    switch (pressure) {
      _DdlPressure.urgent => cs.error,
      _DdlPressure.week => cs.tertiary,
      _DdlPressure.later => cs.secondary,
    };

String _ddlPressureLabel(_DdlPressure pressure) => switch (pressure) {
      _DdlPressure.urgent => '3 天内',
      _DdlPressure.week => '一周内',
      _DdlPressure.later => '更远',
    };

Color _planKindColor(ColorScheme cs, String kind) => switch (kind) {
      "ddl" => cs.primary,
      "event" => cs.secondary,
      "task" => cs.primary,
      _ => cs.onSurfaceVariant,
    };

String _planKindLabel(String kind) => switch (kind) {
      "ddl" => "DDL",
      "event" => "日程",
      "task" => "待办",
      _ => "计划",
    };

String _planRelevantLabel(String kind) => switch (kind) {
      "event" => "开始时间",
      _ => "截止时间",
    };

// ── Section Label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.title,
    this.action,
  });
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
            color: cs.onSurface,
          ),
        ),
        if (action != null) ...[
          const Spacer(),
          action!,
        ],
      ],
    );
  }
}

// ── Editorial Hero ────────────────────────────────────────────────────────────

class _EditorialHero extends StatelessWidget {
  const _EditorialHero({
    required this.user,
    required this.binding,
    required this.deadlineCount,
    required this.courseCount,
  });
  final SessionUserSummary? user;
  final CampusBindingSummary? binding;
  final int deadlineCount;
  final int courseCount;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final name = binding?.studentName ?? user?.displayName ?? '同学';
    final now = DateTime.now();
    final greeting = '${_timeGreeting()}，${_weekdayChinese(now.weekday)}';
    final dept = (binding?.bound == true)
        ? (binding?.department ?? '校园账号已连接')
        : '未绑定校园账号';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: TextStyle(
            color: cs.onSurfaceVariant,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(
            color: cs.onSurface,
            fontSize: 50,
            fontWeight: FontWeight.w800,
            letterSpacing: -2.5,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.apartment_rounded, size: 13),
            const SizedBox(width: 4),
            Text(
              dept,
              style: TextStyle(
                color: cs.onSurfaceVariant,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            _StatTag(
              label: '近期计划',
              value: deadlineCount > 0 ? '$deadlineCount 项' : '暂无',
            ),
            const SizedBox(width: 8),
            _StatTag(
              label: '今日课程',
              value: courseCount > 0 ? '$courseCount 节' : '休息',
            ),
          ],
        ),
      ],
    );
  }
}

class _StatTag extends StatelessWidget {
  const _StatTag({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(context.tokens.radii.pill),
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(fontSize: 12),
          children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(color: cs.onSurfaceVariant),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Schedule Grid ─────────────────────────────────────────────────────────────

class _ScheduleGrid extends StatelessWidget {
  const _ScheduleGrid({
    required this.nextCourse,
    required this.urgentDdl,
    required this.onOpen,
    required this.onComplete,
  });
  final HomePlanCourse? nextCourse;
  final HomePlanDeadline? urgentDdl;
  final void Function(PlanScheduleItem) onOpen;
  final Future<void> Function(PlanScheduleItem) onComplete;

  @override
  Widget build(BuildContext context) {
    if (nextCourse == null && urgentDdl == null) {
      return const _AllClearTile();
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: nextCourse != null
                ? _NextClassTile(
                    course: nextCourse!,
                    onTap: () => onOpen(nextCourse!.item),
                  )
                : const _NoCourseNotice(),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: urgentDdl != null
                ? _UrgentDdlTile(
                    ddl: urgentDdl!,
                    onTap: () => onOpen(urgentDdl!.item),
                    onComplete: () => onComplete(urgentDdl!.item),
                  )
                : const _NoDdlNotice(),
          ),
        ],
      ),
    );
  }
}

class _NextClassTile extends StatelessWidget {
  const _NextClassTile({required this.course, required this.onTap});
  final HomePlanCourse course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.tokens.spacing.md),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(context.tokens.radii.sm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: cs.primary
                        .withValues(alpha: context.isDark ? 0.22 : 0.09),
                    borderRadius:
                        BorderRadius.circular(context.tokens.radii.pill),
                  ),
                  child: Text(
                    '下一节',
                    style: TextStyle(
                      color: cs.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  course.timeLabel,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: cs.primary,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              course.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
                letterSpacing: -0.3,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (course.teacherNames.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                course.teacherNames.join(' / '),
                style: TextStyle(
                  fontSize: 12,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const Spacer(),
            const SizedBox(height: 10),
            Text(
              course.location ?? '课程安排',
              style: TextStyle(
                fontSize: 11,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoCourseNotice extends StatelessWidget {
  const _NoCourseNotice();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.tokens.spacing.md),
      decoration: BoxDecoration(
        color: cs.tertiaryContainer
            .withValues(alpha: context.isDark ? 0.28 : 0.22),
        borderRadius: BorderRadius.circular(context.tokens.radii.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wb_sunny_rounded, color: cs.tertiary, size: 30),
          const SizedBox(height: 10),
          Text(
            '今天没有\n课程',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: cs.onTertiaryContainer,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '好好休息',
            style: TextStyle(fontSize: 12, color: cs.tertiary),
          ),
        ],
      ),
    );
  }
}

class _UrgentDdlTile extends StatelessWidget {
  const _UrgentDdlTile({
    required this.ddl,
    required this.onTap,
    required this.onComplete,
  });
  final HomePlanDeadline ddl;
  final VoidCallback onTap;
  final Future<void> Function() onComplete;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final u = _urgency(ddl.dueAt);
    final isHot = u == _Urgency.overdue || u == _Urgency.today;
    final accentColor = _urgencyColor(cs, u);

    return SwipeCompletePlan(
      key: ValueKey('sunlit_urgent_ddl_${ddl.item.id}'),
      itemId: ddl.item.id,
      onComplete: onComplete,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(context.tokens.spacing.sm),
          decoration: BoxDecoration(
            color: isHot
                ? cs.errorContainer
                    .withValues(alpha: context.isDark ? 0.26 : 0.10)
                : cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(context.tokens.radii.sm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isHot
                    ? Icons.assignment_late_rounded
                    : Icons.assignment_outlined,
                color: accentColor,
                size: 22,
              ),
              const SizedBox(height: 8),
              Text(
                ddl.title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                  letterSpacing: -0.1,
                  height: 1.35,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              if (ddl.course != null) ...[
                Text(
                  ddl.course!,
                  style: TextStyle(
                    fontSize: 10,
                    color: cs.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
              ],
              Text(
                _formatDue(ddl.dueAt),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoDdlNotice extends StatelessWidget {
  const _NoDdlNotice();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.tokens.spacing.sm),
      decoration: BoxDecoration(
        color: cs.tertiaryContainer
            .withValues(alpha: context.isDark ? 0.24 : 0.18),
        borderRadius: BorderRadius.circular(context.tokens.radii.sm),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline_rounded,
              color: cs.tertiary, size: 24),
          const SizedBox(height: 6),
          Text(
            '无待办',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: cs.onTertiaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class _AllClearTile extends StatelessWidget {
  const _AllClearTile();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: cs.tertiaryContainer
            .withValues(alpha: context.isDark ? 0.24 : 0.20),
        borderRadius: BorderRadius.circular(context.tokens.radii.sm),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline_rounded,
              color: cs.tertiary, size: 36),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '今日一片清净',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: cs.onTertiaryContainer,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '无课程，无截止日期',
                style: TextStyle(fontSize: 12, color: cs.tertiary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Course Pills ──────────────────────────────────────────────────────────────

class _CoursePills extends StatelessWidget {
  const _CoursePills({required this.courses, required this.onOpen});
  final List<HomePlanCourse> courses;
  final void Function(PlanScheduleItem) onOpen;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        for (int i = 0; i < courses.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onOpen(courses[i].item),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(context.tokens.radii.xs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courses[i].timeLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: cs.primary,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      courses[i].title,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ── Upcoming Plan Section ─────────────────────────────────────────────────────

class _UpcomingPlanSection extends StatelessWidget {
  const _UpcomingPlanSection({
    required this.items,
    required this.onAdd,
    required this.onManage,
    required this.onDelete,
    required this.onComplete,
    required this.onOpen,
  });

  final List<HomeUpcomingPlanItem> items;
  final VoidCallback onAdd;
  final VoidCallback onManage;
  final void Function(HomeUpcomingPlanItem) onDelete;
  final Future<void> Function(PlanScheduleItem) onComplete;
  final void Function(PlanScheduleItem) onOpen;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final urgent = items
        .where((item) => _ddlPressure(item.relevantAt) == _DdlPressure.urgent)
        .length;
    final week = items
        .where((item) => _ddlPressure(item.relevantAt) == _DdlPressure.week)
        .length;
    final later = items
        .where((item) => _ddlPressure(item.relevantAt) == _DdlPressure.later)
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(
          title: '计划日程',
          action: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${items.length} 项',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: cs.primary,
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: onManage,
                child: const Text('全部'),
              ),
              const SizedBox(width: 2),
              IconButton(
                tooltip: '添加计划',
                onPressed: onAdd,
                style: IconButton.styleFrom(
                  backgroundColor: cs.surfaceContainerHigh,
                  foregroundColor: cs.primary,
                  minimumSize: const Size(36, 36),
                  padding: EdgeInsets.zero,
                ),
                icon: const Icon(Icons.add_rounded, size: 18),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _DdlPressureStrip(
          urgent: urgent,
          week: week,
          later: later,
        ),
        const SizedBox(height: 14),
        if (items.isEmpty)
          const _NoUpcomingPlanSummary()
        else
          ...items.take(6).toList().asMap().entries.map(
                (entry) => _UpcomingPlanRow(
                  item: entry.value,
                  index: entry.key,
                  onDelete: entry.value.canDelete
                      ? () => onDelete(entry.value)
                      : null,
                  onComplete: () => onComplete(entry.value.item),
                  onOpen: () => onOpen(entry.value.item),
                ),
              ),
      ],
    );
  }
}

class _NoUpcomingPlanSummary extends StatelessWidget {
  const _NoUpcomingPlanSummary();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final accent = cs.tertiary;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: context.isDark ? 0.18 : 0.09),
        borderRadius: BorderRadius.circular(context.tokens.radii.xs),
      ),
      child: Row(
        children: [
          Icon(
            Icons.task_alt_rounded,
            color: accent,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '接下来一段时间没有待处理计划',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DdlPressureStrip extends StatelessWidget {
  const _DdlPressureStrip({
    required this.urgent,
    required this.week,
    required this.later,
  });

  final int urgent;
  final int week;
  final int later;

  @override
  Widget build(BuildContext context) {
    final items = [
      (_DdlPressure.urgent, urgent),
      (_DdlPressure.week, week),
      (_DdlPressure.later, later),
    ];
    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: _DdlPressurePill(
              pressure: items[i].$1,
              count: items[i].$2,
            ),
          ),
        ],
      ],
    );
  }
}

class _DdlPressurePill extends StatelessWidget {
  const _DdlPressurePill({
    required this.pressure,
    required this.count,
  });

  final _DdlPressure pressure;
  final int count;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = _ddlPressureColor(cs, pressure);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: count == 0 ? 0.05 : 0.11),
        borderRadius: BorderRadius.circular(context.tokens.radii.xs),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: count == 0 ? cs.onSurfaceVariant : color,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _ddlPressureLabel(pressure),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingPlanRow extends StatelessWidget {
  const _UpcomingPlanRow({
    required this.item,
    required this.index,
    required this.onOpen,
    required this.onComplete,
    this.onDelete,
  });

  final HomeUpcomingPlanItem item;
  final int index;
  final VoidCallback onOpen;
  final Future<void> Function() onComplete;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pressure = _ddlPressure(item.relevantAt);
    final urgencyColor = _ddlPressureColor(cs, pressure);
    final typeColor = _planKindColor(cs, item.kind);
    return SwipeCompletePlan(
      key: ValueKey('sunlit_plan_${item.item.id}_$index'),
      itemId: item.item.id,
      onComplete: onComplete,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onOpen,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(context.tokens.radii.xs),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 11,
                  height: 11,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: typeColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _SmallTypePill(
                            label: _planKindLabel(item.kind),
                            color: typeColor,
                          ),
                          Text(
                            item.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatDue(item.relevantAt),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: urgencyColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _planRelevantLabel(item.kind),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    if (onDelete != null) ...[
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: onDelete,
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            size: 18,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SmallTypePill extends StatelessWidget {
  const _SmallTypePill({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(context.tokens.radii.pill),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}
