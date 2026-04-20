import 'package:flutter/foundation.dart';

const kMainTabMoreIndex = 0;
const kMainTabForumIndex = 1;
const kMainTabHomeIndex = 2;
const kMainTabCourseIndex = 3;
const kMainTabProfileIndex = 4;

final ValueNotifier<int> mainTabIndexNotifier = ValueNotifier<int>(
  kMainTabHomeIndex,
);
