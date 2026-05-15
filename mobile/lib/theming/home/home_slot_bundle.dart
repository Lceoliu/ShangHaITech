import 'package:flutter/widgets.dart';

enum HomeStyleId { sunlitV1, terminalV1 }

class HomeSlotBundle {
  const HomeSlotBundle({
    required this.topBanner,
    required this.greeting,
    required this.nextClass,
    required this.weeklyDdl,
    required this.todayTodos,
    required this.weeklySchedule,
    this.quickActions,
  });

  final WidgetBuilder topBanner;
  final WidgetBuilder greeting;
  final WidgetBuilder nextClass;
  final WidgetBuilder weeklyDdl;
  final WidgetBuilder todayTodos;
  final WidgetBuilder weeklySchedule;
  final WidgetBuilder? quickActions;
}
