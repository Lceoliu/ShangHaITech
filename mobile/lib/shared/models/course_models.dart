class TimetableEntry {
  const TimetableEntry({
    required this.id,
    required this.courseId,
    required this.courseCode,
    required this.courseName,
    required this.teacherNames,
    required this.roomName,
    required this.validWeeks,
    required this.validWeeksLabel,
    required this.weekday,
    required this.weekdayLabel,
    required this.startUnit,
    required this.endUnit,
    required this.unitLabel,
    required this.startTime,
    required this.endTime,
    required this.timeLabel,
  });

  final String id;
  final String courseId;
  final String courseCode;
  final String courseName;
  final List<String> teacherNames;
  final String roomName;
  final List<int> validWeeks;
  final String validWeeksLabel;
  final int weekday;
  final String weekdayLabel;
  final int startUnit;
  final int endUnit;
  final String unitLabel;
  final String startTime;
  final String endTime;
  final String timeLabel;

  factory TimetableEntry.fromJson(Map<String, dynamic> json) => TimetableEntry(
        id: json["id"] as String? ?? "",
        courseId: json["course_id"] as String? ?? "",
        courseCode: json["course_code"] as String? ?? "",
        courseName: json["course_name"] as String? ?? "Unknown Course",
        teacherNames: [
          ...(((json["teacher_names"] as List?) ?? const [])
              .map((item) => item.toString())
              .where((item) => item.isNotEmpty)),
          if ((((json["teacher_names"] as List?) ?? const []).isEmpty) &&
              (json["teacher_name"] as String?)?.isNotEmpty == true)
            json["teacher_name"] as String,
        ],
        roomName: json["room_name"] as String? ?? "",
        validWeeks: ((json["valid_weeks"] as List?) ?? const [])
            .map((item) => (item as num?)?.toInt() ?? 0)
            .where((item) => item > 0)
            .toList(),
        validWeeksLabel: json["valid_weeks_label"] as String? ?? "",
        weekday: (json["weekday"] as num? ?? 1).toInt(),
        weekdayLabel: json["weekday_label"] as String? ?? "",
        startUnit: (json["start_unit"] as num? ?? 1).toInt(),
        endUnit: (json["end_unit"] as num? ?? 2).toInt(),
        unitLabel: json["unit_label"] as String? ?? "",
        startTime: json["start_time"] as String? ?? "",
        endTime: json["end_time"] as String? ?? "",
        timeLabel: json["time_label"] as String? ?? "",
      );
}

class TimetableSnapshot {
  const TimetableSnapshot({
    required this.fetchedAtEpochSeconds,
    required this.academicYear,
    required this.semesterLabel,
    required this.unitCount,
    required this.entryCount,
    required this.maxWeek,
    required this.exportRequiresFirstMonday,
    required this.entries,
  });

  final int fetchedAtEpochSeconds;
  final int? academicYear;
  final String? semesterLabel;
  final int unitCount;
  final int entryCount;
  final int maxWeek;
  final bool exportRequiresFirstMonday;
  final List<TimetableEntry> entries;

  factory TimetableSnapshot.fromJson(Map<String, dynamic> json) =>
      TimetableSnapshot(
        fetchedAtEpochSeconds: (json["fetched_at"] as num? ?? 0).toInt(),
        academicYear: (json["academic_year"] as num?)?.toInt(),
        semesterLabel: json["semester_label"] as String?,
        unitCount: (json["unit_count"] as num? ?? 0).toInt(),
        entryCount: (json["entry_count"] as num? ?? 0).toInt(),
        maxWeek: (json["max_week"] as num? ?? 0).toInt(),
        exportRequiresFirstMonday:
            json["export_requires_first_monday"] as bool? ?? true,
        entries: ((json["entries"] as List?) ?? const [])
            .map(
                (item) => TimetableEntry.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
}

class CourseExamBatchOption {
  const CourseExamBatchOption({
    required this.id,
    required this.name,
    required this.selected,
  });

  final String id;
  final String name;
  final bool selected;

  factory CourseExamBatchOption.fromJson(Map<String, dynamic> json) =>
      CourseExamBatchOption(
        id: json["id"] as String? ?? "",
        name: json["name"] as String? ?? "",
        selected: json["selected"] as bool? ?? false,
      );
}

class CourseExamItem {
  const CourseExamItem({
    required this.id,
    required this.courseSerialNumber,
    required this.courseName,
    required this.examType,
    required this.examDate,
    required this.examSchedule,
    required this.examLocation,
    required this.examStatus,
    required this.notes,
  });

  final String id;
  final String courseSerialNumber;
  final String courseName;
  final String? examType;
  final String? examDate;
  final String? examSchedule;
  final String? examLocation;
  final String? examStatus;
  final String? notes;

  factory CourseExamItem.fromJson(Map<String, dynamic> json) => CourseExamItem(
        id: json["id"] as String? ?? "",
        courseSerialNumber: json["course_serial_number"] as String? ?? "",
        courseName: json["course_name"] as String? ?? "",
        examType: json["exam_type"] as String?,
        examDate: json["exam_date"] as String?,
        examSchedule: json["exam_schedule"] as String?,
        examLocation: json["exam_location"] as String?,
        examStatus: json["exam_status"] as String?,
        notes: json["notes"] as String?,
      );
}

class CourseExamSnapshot {
  const CourseExamSnapshot({
    required this.fetchedAtEpochSeconds,
    required this.semesterId,
    required this.examBatchId,
    required this.examBatchName,
    required this.availableExamBatches,
    required this.itemCount,
    required this.items,
  });

  final int fetchedAtEpochSeconds;
  final String? semesterId;
  final String? examBatchId;
  final String? examBatchName;
  final List<CourseExamBatchOption> availableExamBatches;
  final int itemCount;
  final List<CourseExamItem> items;

  factory CourseExamSnapshot.fromJson(Map<String, dynamic> json) =>
      CourseExamSnapshot(
        fetchedAtEpochSeconds: (json["fetched_at"] as num? ?? 0).toInt(),
        semesterId: json["semester_id"] as String?,
        examBatchId: json["exam_batch_id"] as String?,
        examBatchName: json["exam_batch_name"] as String?,
        availableExamBatches: ((json["available_exam_batches"] as List?) ??
                const [])
            .map((item) =>
                CourseExamBatchOption.fromJson(item as Map<String, dynamic>))
            .toList(),
        itemCount: (json["item_count"] as num? ?? 0).toInt(),
        items: ((json["items"] as List?) ?? const [])
            .map(
                (item) => CourseExamItem.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
}

class CatalogCourseCard {
  const CatalogCourseCard({
    required this.courseCode,
    required this.courseName,
    required this.courseNameEn,
    required this.semesterLabel,
    required this.department,
    required this.teacherNames,
    required this.credits,
    required this.overallScore,
    required this.commentCount,
  });

  final String courseCode;
  final String courseName;
  final String? courseNameEn;
  final String? semesterLabel;
  final String? department;
  final List<String> teacherNames;
  final String? credits;
  final double? overallScore;
  final int commentCount;

  factory CatalogCourseCard.fromJson(Map<String, dynamic> json) =>
      CatalogCourseCard(
        courseCode: json["course_code"] as String? ?? "",
        courseName: json["course_name"] as String? ?? "Unknown Course",
        courseNameEn: json["course_name_en"] as String?,
        semesterLabel: json["latest_semester_label"] as String?,
        department: json["latest_department"] as String?,
        teacherNames: ((json["teacher_names"] as List?) ?? const [])
            .map((item) => item.toString())
            .where((item) => item.isNotEmpty)
            .toList(),
        credits: json["credits"]?.toString(),
        overallScore: (json["overall_score"] as num?)?.toDouble() ??
            ((json["metadata"] is Map<String, dynamic>)
                ? ((json["metadata"] as Map<String, dynamic>)["overall_score"]
                        as num?)
                    ?.toDouble()
                : null),
        commentCount: (json["comment_count"] as num?)?.toInt() ??
            ((json["metadata"] is Map<String, dynamic>)
                ? (((json["metadata"] as Map<String, dynamic>)["comment_count"]
                            as num?)
                        ?.toInt() ??
                    0)
                : 0),
      );

  Map<String, dynamic> toJson() => {
        "course_code": courseCode,
        "course_name": courseName,
        "course_name_en": courseNameEn,
        "latest_semester_label": semesterLabel,
        "latest_department": department,
        "teacher_names": teacherNames,
        "credits": credits,
        "overall_score": overallScore,
        "comment_count": commentCount,
      };
}

class CourseOffering {
  const CourseOffering({
    required this.id,
    required this.courseCode,
    required this.semesterLabel,
    required this.serialNumber,
    required this.courseName,
    required this.courseNameEn,
    required this.department,
    required this.credits,
    required this.classHour,
    required this.classTimeSummary,
    required this.classWeekSummary,
    required this.campus,
    required this.classroom,
    required this.teacherNames,
    required this.collegeNames,
  });

  final String id;
  final String courseCode;
  final String semesterLabel;
  final String serialNumber;
  final String courseName;
  final String? courseNameEn;
  final String? department;
  final String? credits;
  final String? classHour;
  final String? classTimeSummary;
  final String? classWeekSummary;
  final String? campus;
  final String? classroom;
  final List<String> teacherNames;
  final List<String> collegeNames;

  factory CourseOffering.fromJson(Map<String, dynamic> json) => CourseOffering(
        id: json["id"] as String? ?? "",
        courseCode: json["course_code"] as String? ?? "",
        semesterLabel: json["semester_label"] as String? ?? "",
        serialNumber: json["serial_number"] as String? ?? "",
        courseName: json["course_name"] as String? ?? "",
        courseNameEn: json["course_name_en"] as String?,
        department: json["department"] as String?,
        credits: json["credits"]?.toString(),
        classHour: json["class_hour"]?.toString(),
        classTimeSummary: json["class_time_summary"] as String?,
        classWeekSummary: json["class_week_summary"] as String?,
        campus: json["campus"] as String?,
        classroom: json["classroom"] as String?,
        teacherNames: ((json["teacher_names"] as List?) ?? const [])
            .map((item) => item.toString())
            .where((item) => item.isNotEmpty)
            .toList(),
        collegeNames: ((json["college_names"] as List?) ?? const [])
            .map((item) => item.toString())
            .where((item) => item.isNotEmpty)
            .toList(),
      );
}

class CourseCatalogDetail {
  const CourseCatalogDetail({
    required this.courseCode,
    required this.courseName,
    required this.courseNameEn,
    required this.latestDepartment,
    required this.credits,
    required this.classHour,
    required this.latestSemesterLabel,
    required this.semesterCount,
    required this.rowCount,
    required this.teacherNames,
    required this.collegeNames,
    required this.overallScore,
    required this.commentCount,
    required this.rows,
  });

  final String courseCode;
  final String courseName;
  final String? courseNameEn;
  final String? latestDepartment;
  final String? credits;
  final String? classHour;
  final String? latestSemesterLabel;
  final int semesterCount;
  final int rowCount;
  final List<String> teacherNames;
  final List<String> collegeNames;
  final double? overallScore;
  final int commentCount;
  final List<CourseOffering> rows;

  factory CourseCatalogDetail.fromJson(Map<String, dynamic> json) =>
      CourseCatalogDetail(
        courseCode: json["course_code"] as String? ?? "",
        courseName: json["course_name"] as String? ?? "Unknown Course",
        courseNameEn: json["course_name_en"] as String?,
        latestDepartment: json["latest_department"] as String?,
        credits: json["credits"]?.toString(),
        classHour: json["class_hour"]?.toString(),
        latestSemesterLabel: json["latest_semester_label"] as String?,
        semesterCount: (json["semester_count"] as num? ?? 0).toInt(),
        rowCount: (json["row_count"] as num? ?? 0).toInt(),
        teacherNames: ((json["teacher_names"] as List?) ?? const [])
            .map((item) => item.toString())
            .where((item) => item.isNotEmpty)
            .toList(),
        collegeNames: ((json["college_names"] as List?) ?? const [])
            .map((item) => item.toString())
            .where((item) => item.isNotEmpty)
            .toList(),
        overallScore: (json["overall_score"] as num?)?.toDouble(),
        commentCount: (json["comment_count"] as num? ?? 0).toInt(),
        rows: ((json["rows"] as List?) ?? const [])
            .map(
                (item) => CourseOffering.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
}

class CourseCatalogSemesterOption {
  const CourseCatalogSemesterOption({
    required this.semesterCode,
    required this.semesterLabel,
    required this.rowCount,
    required this.courseCount,
  });

  final String semesterCode;
  final String semesterLabel;
  final int rowCount;
  final int courseCount;

  factory CourseCatalogSemesterOption.fromJson(Map<String, dynamic> json) =>
      CourseCatalogSemesterOption(
        semesterCode: json["semester_code"] as String? ?? "",
        semesterLabel: json["semester_label"] as String? ?? "",
        rowCount: (json["row_count"] as num? ?? 0).toInt(),
        courseCount: (json["course_count"] as num? ?? 0).toInt(),
      );

  Map<String, dynamic> toJson() => {
        "semester_code": semesterCode,
        "semester_label": semesterLabel,
        "row_count": rowCount,
        "course_count": courseCount,
      };
}

class CourseCatalogMeta {
  const CourseCatalogMeta({
    required this.currentSemesterCode,
    required this.currentSemesterLabel,
    required this.availableSemesters,
    required this.supportedSorts,
    required this.defaultSort,
    required this.defaultOrder,
  });

  final String? currentSemesterCode;
  final String? currentSemesterLabel;
  final List<CourseCatalogSemesterOption> availableSemesters;
  final List<String> supportedSorts;
  final String defaultSort;
  final String defaultOrder;

  factory CourseCatalogMeta.fromJson(Map<String, dynamic> json) =>
      CourseCatalogMeta(
        currentSemesterCode: json["current_semester_code"] as String?,
        currentSemesterLabel: json["current_semester_label"] as String?,
        availableSemesters: ((json["available_semesters"] as List?) ?? const [])
            .map((item) => CourseCatalogSemesterOption.fromJson(
                item as Map<String, dynamic>))
            .toList(),
        supportedSorts: ((json["supported_sorts"] as List?) ?? const [])
            .map((item) => item.toString())
            .toList(),
        defaultSort: json["default_sort"] as String? ?? "course_code",
        defaultOrder: json["default_order"] as String? ?? "asc",
      );

  Map<String, dynamic> toJson() => {
        "current_semester_code": currentSemesterCode,
        "current_semester_label": currentSemesterLabel,
        "available_semesters":
            availableSemesters.map((item) => item.toJson()).toList(),
        "supported_sorts": supportedSorts,
        "default_sort": defaultSort,
        "default_order": defaultOrder,
      };
}

class EcourseClassmate {
  const EcourseClassmate({
    required this.ecourseUserId,
    required this.personType,
    required this.name,
    required this.userNo,
    required this.email,
    required this.nickname,
    required this.gradeName,
    required this.klassName,
    required this.klassCode,
    required this.departmentName,
    required this.departmentCode,
    required this.orgName,
    required this.programName,
    required this.roles,
    required this.aliases,
    required this.retakeStatus,
    required this.seatNumber,
    required this.importedFrom,
    required this.linkedPlatformUserId,
    required this.linkedDirectoryResourceId,
    required this.directoryProfile,
  });

  final String ecourseUserId;
  final String personType;
  final String name;
  final String? userNo;
  final String? email;
  final String? nickname;
  final String? gradeName;
  final String? klassName;
  final String? klassCode;
  final String? departmentName;
  final String? departmentCode;
  final String? orgName;
  final String? programName;
  final List<String> roles;
  final List<String> aliases;
  final String? retakeStatus;
  final String? seatNumber;
  final String? importedFrom;
  final String? linkedPlatformUserId;
  final String? linkedDirectoryResourceId;
  final Map<String, dynamic>? directoryProfile;

  factory EcourseClassmate.fromJson(Map<String, dynamic> json) =>
      EcourseClassmate(
        ecourseUserId: json["ecourse_user_id"] as String? ?? "",
        personType: json["person_type"] as String? ?? "unknown",
        name: json["name"] as String? ?? "Unknown",
        userNo: json["user_no"] as String?,
        email: json["email"] as String?,
        nickname: json["nickname"] as String?,
        gradeName: json["grade_name"] as String?,
        klassName: json["klass_name"] as String?,
        klassCode: json["klass_code"] as String?,
        departmentName: json["department_name"] as String?,
        departmentCode: json["department_code"] as String?,
        orgName: json["org_name"] as String?,
        programName: json["program_name"] as String?,
        roles: ((json["roles"] as List?) ?? const [])
            .map((item) => item.toString())
            .where((item) => item.isNotEmpty)
            .toList(),
        aliases: ((json["aliases"] as List?) ?? const [])
            .map((item) => item.toString())
            .where((item) => item.isNotEmpty)
            .toList(),
        retakeStatus: json["retake_status"] as String?,
        seatNumber: json["seat_number"] as String?,
        importedFrom: json["imported_from"] as String?,
        linkedPlatformUserId: json["linked_platform_user_id"] as String?,
        linkedDirectoryResourceId:
            json["linked_directory_resource_id"] as String?,
        directoryProfile: json["directory_profile"] is Map<String, dynamic>
            ? json["directory_profile"] as Map<String, dynamic>
            : null,
      );

  bool get linkedToCampusData =>
      linkedPlatformUserId != null || linkedDirectoryResourceId != null;

  bool get isInstructor =>
      personType == "instructor" ||
      roles.any((role) {
        final value = role.toLowerCase();
        return value.contains("instructor") || value.contains("teacher");
      });

  bool get isStudent => personType == "student";
}

class EcourseMyCourse {
  const EcourseMyCourse({
    required this.ecourseCourseId,
    required this.courseCode,
    required this.courseName,
    required this.displayName,
    required this.departmentName,
    required this.gradeName,
    required this.klassName,
    required this.courseType,
    required this.academicYearId,
    required this.semesterId,
    required this.credit,
    required this.compulsory,
    required this.isStarted,
    required this.isClosed,
    required this.instructors,
    required this.lastSeenAt,
  });

  final String ecourseCourseId;
  final String? courseCode;
  final String courseName;
  final String? displayName;
  final String? departmentName;
  final String? gradeName;
  final String? klassName;
  final String? courseType;
  final String? academicYearId;
  final String semesterId;
  final String? credit;
  final bool? compulsory;
  final bool? isStarted;
  final bool? isClosed;
  final List<String> instructors;
  final DateTime? lastSeenAt;

  factory EcourseMyCourse.fromJson(Map<String, dynamic> json) =>
      EcourseMyCourse(
        ecourseCourseId: json["ecourse_course_id"] as String? ?? "",
        courseCode: json["course_code"] as String?,
        courseName: json["course_name"] as String? ?? "Unknown Course",
        displayName: json["display_name"] as String?,
        departmentName: json["department_name"] as String?,
        gradeName: json["grade_name"] as String?,
        klassName: json["klass_name"] as String?,
        courseType: json["course_type"] as String?,
        academicYearId: json["academic_year_id"] as String?,
        semesterId: json["semester_id"] as String? ?? "",
        credit: json["credit"]?.toString(),
        compulsory: json["compulsory"] as bool?,
        isStarted: json["is_started"] as bool?,
        isClosed: json["is_closed"] as bool?,
        instructors: ((json["instructors"] as List?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map((item) => item["name"]?.toString() ?? "")
            .where((item) => item.isNotEmpty)
            .toList(),
        lastSeenAt: DateTime.tryParse(json["last_seen_at"] as String? ?? ""),
      );

  String get displayTitle =>
      (displayName == null || displayName!.trim().isEmpty)
          ? courseName
          : displayName!.trim();

  String get codeLabel => (courseCode == null || courseCode!.trim().isEmpty)
      ? ecourseCourseId
      : courseCode!.trim();
}

class EcourseCourseRoster {
  const EcourseCourseRoster({
    required this.rosterId,
    required this.ecourseCourseId,
    required this.courseCode,
    required this.courseName,
    required this.displayName,
    required this.semesterId,
    required this.academicYearId,
    required this.departmentName,
    required this.gradeName,
    required this.klassName,
    required this.instructorNames,
    required this.memberCount,
    required this.sourceStatus,
    required this.fetchedAt,
    required this.cacheHit,
    required this.students,
  });

  final String rosterId;
  final String ecourseCourseId;
  final String? courseCode;
  final String courseName;
  final String? displayName;
  final String semesterId;
  final String? academicYearId;
  final String? departmentName;
  final String? gradeName;
  final String? klassName;
  final List<String> instructorNames;
  final int memberCount;
  final String sourceStatus;
  final DateTime? fetchedAt;
  final bool cacheHit;
  final List<EcourseClassmate> students;

  factory EcourseCourseRoster.fromJson(Map<String, dynamic> json) =>
      EcourseCourseRoster(
        rosterId: json["roster_id"] as String? ?? "",
        ecourseCourseId: json["ecourse_course_id"] as String? ?? "",
        courseCode: json["course_code"] as String?,
        courseName: json["course_name"] as String? ?? "",
        displayName: json["display_name"] as String?,
        semesterId: json["semester_id"] as String? ?? "",
        academicYearId: json["academic_year_id"] as String?,
        departmentName: json["department_name"] as String?,
        gradeName: json["grade_name"] as String?,
        klassName: json["klass_name"] as String?,
        instructorNames: ((json["instructor_names"] as List?) ?? const [])
            .map((item) => item.toString())
            .where((item) => item.isNotEmpty)
            .toList(),
        memberCount: (json["member_count"] as num? ?? 0).toInt(),
        sourceStatus: json["source_status"] as String? ?? "available",
        fetchedAt: DateTime.tryParse(json["fetched_at"] as String? ?? ""),
        cacheHit: json["cache_hit"] as bool? ?? false,
        students: ((json["students"] as List?) ?? const [])
            .map((item) =>
                EcourseClassmate.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
}

// ── CourseBench models ────────────────────────────────────────────────────────

const kCbDimLabels = ['课程质量', '作业用时', '考核难度', '给分情况'];

class CourseBenchTeacher {
  const CourseBenchTeacher({required this.id, required this.name});
  final int id;
  final String name;
  factory CourseBenchTeacher.fromJson(Map<String, dynamic> j) =>
      CourseBenchTeacher(
        id: (j['id'] as num? ?? 0).toInt(),
        name: j['name'] as String? ?? '',
      );
}

class CourseBenchGroup {
  const CourseBenchGroup({
    required this.id,
    required this.score,
    required this.overallScore,
    required this.commentNum,
    required this.teachers,
  });
  final int id;
  final List<double> score; // [课程质量, 作业用时, 考核难度, 给分情况]
  final double? overallScore;
  final int commentNum;
  final List<CourseBenchTeacher> teachers;

  factory CourseBenchGroup.fromJson(Map<String, dynamic> j) => CourseBenchGroup(
        id: (j['id'] as num? ?? 0).toInt(),
        score: ((j['score'] as List?) ?? [])
            .map((s) => (s as num? ?? 0).toDouble())
            .toList(),
        overallScore: (j['overall_score'] as num?)?.toDouble(),
        commentNum: (j['comment_num'] as num? ?? 0).toInt(),
        teachers: ((j['teachers'] as List?) ?? [])
            .map((t) => CourseBenchTeacher.fromJson(t as Map<String, dynamic>))
            .toList(),
      );

  static const empty = CourseBenchGroup(
    id: 0,
    score: [],
    overallScore: null,
    commentNum: 0,
    teachers: [],
  );
}

class CourseBenchComment {
  const CourseBenchComment({
    required this.id,
    required this.title,
    required this.content,
    required this.postTime,
    required this.semester,
    required this.isAnonymous,
    required this.likeCount,
    required this.dislikeCount,
    required this.score,
    required this.overallScore,
    required this.isFold,
    required this.group,
    required this.userNickname,
  });
  final int id;
  final String title;
  final String content;
  final int postTime; // epoch seconds
  final int semester; // YYYYMM  e.g. 202301 = 2023秋
  final bool isAnonymous;
  final int likeCount;
  final int dislikeCount;
  final List<double> score;
  final double? overallScore;
  final bool isFold;
  final CourseBenchGroup group;
  final String? userNickname;

  factory CourseBenchComment.fromJson(Map<String, dynamic> j) {
    final user = j['user'] as Map<String, dynamic>?;
    return CourseBenchComment(
      id: (j['id'] as num? ?? 0).toInt(),
      title: j['title'] as String? ?? '',
      content: j['content'] as String? ?? '',
      postTime: (j['post_time'] as num? ?? 0).toInt(),
      semester: (j['semester'] as num? ?? 0).toInt(),
      isAnonymous: j['is_anonymous'] as bool? ?? true,
      likeCount: (j['like_count'] as num? ?? 0).toInt(),
      dislikeCount: (j['dislike_count'] as num? ?? 0).toInt(),
      score: ((j['score'] as List?) ?? [])
          .map((s) => (s as num? ?? 0).toDouble())
          .toList(),
      overallScore: (j['overall_score'] as num?)?.toDouble(),
      isFold: j['is_fold'] as bool? ?? false,
      group: j['group'] is Map<String, dynamic>
          ? CourseBenchGroup.fromJson(j['group'] as Map<String, dynamic>)
          : CourseBenchGroup.empty,
      userNickname:
          user?['nickname'] as String? ?? user?['realname'] as String?,
    );
  }

  /// Converts the YYYYMM semester integer to a readable label.
  String get semesterLabel {
    final s = semester.toString();
    if (s.length != 6) return s.isEmpty ? '—' : s;
    final year = s.substring(0, 4);
    final term = s.substring(4);
    const termMap = {'01': '秋学期', '02': '春学期', '03': '暑学期'};
    return '$year ${termMap[term] ?? term}';
  }
}

class CourseBenchCourseSummary {
  const CourseBenchCourseSummary({
    required this.id,
    required this.code,
    required this.name,
    required this.institute,
    required this.credit,
    required this.score,
    required this.overallScore,
    required this.commentNum,
    required this.groups,
  });
  final int id;
  final String code;
  final String name;
  final String? institute;
  final double? credit;
  final List<double> score;
  final double? overallScore;
  final int commentNum;
  final List<CourseBenchGroup> groups;

  factory CourseBenchCourseSummary.fromJson(Map<String, dynamic> j) =>
      CourseBenchCourseSummary(
        id: (j['id'] as num? ?? 0).toInt(),
        code: j['code'] as String? ?? '',
        name: j['name'] as String? ?? '',
        institute: j['institute'] as String?,
        credit: (j['credit'] as num?)?.toDouble(),
        score: ((j['score'] as List?) ?? [])
            .map((s) => (s as num? ?? 0).toDouble())
            .toList(),
        overallScore: (j['overall_score'] as num?)?.toDouble(),
        commentNum: (j['comment_num'] as num? ?? 0).toInt(),
        groups: ((j['groups'] as List?) ?? [])
            .map((g) => CourseBenchGroup.fromJson(g as Map<String, dynamic>))
            .toList(),
      );
}

class CourseBenchReviews {
  const CourseBenchReviews({
    required this.course,
    required this.comments,
    required this.commentsStatus,
    required this.commentsUnavailableReason,
    required this.matchedTeacherNames,
    required this.teacherFilterApplied,
    required this.totalCommentCount,
    required this.visibleCommentCount,
    required this.overallScore,
  });
  final CourseBenchCourseSummary course;
  final List<CourseBenchComment> comments;
  final String commentsStatus;
  final String? commentsUnavailableReason;
  final List<String> matchedTeacherNames;
  final bool teacherFilterApplied;
  final int totalCommentCount;
  final int visibleCommentCount;
  final double? overallScore;

  bool get isSummaryOnly =>
      commentsStatus == 'summary_only' ||
      (comments.isEmpty && totalCommentCount > 0 && !teacherFilterApplied);

  factory CourseBenchReviews.fromJson(Map<String, dynamic> j) =>
      CourseBenchReviews(
        course: CourseBenchCourseSummary.fromJson(
            j['course'] as Map<String, dynamic>? ?? const {}),
        comments: ((j['comments'] as List?) ?? [])
            .map((c) => CourseBenchComment.fromJson(c as Map<String, dynamic>))
            .toList(),
        commentsStatus: j['comments_status'] as String? ?? 'available',
        commentsUnavailableReason: j['comments_unavailable_reason'] as String?,
        matchedTeacherNames: ((j['matched_teacher_names'] as List?) ?? [])
            .map((t) => t.toString())
            .toList(),
        teacherFilterApplied: j['teacher_filter_applied'] as bool? ?? false,
        totalCommentCount: (j['total_comment_count'] as num? ?? 0).toInt(),
        visibleCommentCount: (j['visible_comment_count'] as num? ?? 0).toInt(),
        overallScore: (j['overall_score'] as num?)?.toDouble(),
      );
}

// ── Catalog by-code detail ────────────────────────────────────────────────────

class CatalogCourseDetail {
  const CatalogCourseDetail({
    required this.courseCode,
    required this.courseName,
    required this.courseNameEn,
    required this.department,
    required this.credits,
    required this.creditHours,
    required this.description,
    required this.eamsSyllabusId,
    required this.eamsCourseInfoUrl,
    required this.eamsSyllabusPrintUrl,
    required this.teacherNames,
    required this.semesterLabel,
  });
  final String courseCode;
  final String courseName;
  final String? courseNameEn;
  final String? department;
  final String? credits;
  final String? creditHours;
  final String? description;
  final String? eamsSyllabusId;
  final String? eamsCourseInfoUrl;
  final String? eamsSyllabusPrintUrl;
  final List<String> teacherNames;
  final String? semesterLabel;

  factory CatalogCourseDetail.fromJson(Map<String, dynamic> j) {
    // The by-code endpoint may wrap under 'course' or return directly
    final c = j['course'] as Map<String, dynamic>? ?? j;
    final rows = (c['rows'] as List?)?.cast<Object?>() ?? const [];
    Map<String, dynamic>? firstRowWithSyllabus;
    for (final row in rows) {
      if (row is! Map<String, dynamic>) continue;
      final printUrl = row['eams_syllabus_print_url'] as String?;
      final printPath = row['eams_syllabus_print_path'] as String?;
      if ((printUrl != null && printUrl.isNotEmpty) ||
          (printPath != null && printPath.isNotEmpty)) {
        firstRowWithSyllabus = row;
        break;
      }
    }
    final fallbackRows = rows.whereType<Map<String, dynamic>>();
    final fallbackRow = firstRowWithSyllabus ??
        (fallbackRows.isNotEmpty ? fallbackRows.first : null);
    return CatalogCourseDetail(
      courseCode: c['course_code'] as String? ?? '',
      courseName: c['course_name'] as String? ?? '',
      courseNameEn: c['course_name_en'] as String?,
      department: c['department'] as String? ??
          c['latest_department'] as String? ??
          c['college'] as String?,
      credits: c['credits']?.toString(),
      creditHours: c['credit_hours']?.toString() ?? c['class_hour']?.toString(),
      description: c['description'] as String? ?? c['syllabus'] as String?,
      eamsSyllabusId: c['eams_syllabus_id'] as String? ??
          fallbackRow?['eams_syllabus_id'] as String?,
      eamsCourseInfoUrl: c['eams_course_info_url'] as String? ??
          fallbackRow?['eams_course_info_url'] as String?,
      eamsSyllabusPrintUrl: c['eams_syllabus_print_url'] as String? ??
          fallbackRow?['eams_syllabus_print_url'] as String?,
      teacherNames: ((c['teacher_names'] as List?) ?? [])
          .map((t) => t.toString())
          .where((t) => t.isNotEmpty)
          .toList(),
      semesterLabel: c['latest_semester_label'] as String? ??
          c['semester_label'] as String?,
    );
  }
}
