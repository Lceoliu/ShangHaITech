class ApiEnvelope<T> {
  const ApiEnvelope({
    required this.ok,
    required this.message,
    required this.data,
  });

  final bool ok;
  final String message;
  final T data;
}

class ApiPaginationMeta {
  const ApiPaginationMeta({
    required this.total,
    required this.limit,
    required this.offset,
    required this.returned,
    required this.hasMore,
    required this.nextOffset,
  });

  final int total;
  final int limit;
  final int offset;
  final int returned;
  final bool hasMore;
  final int? nextOffset;

  factory ApiPaginationMeta.fromJson(Map<String, dynamic> json) =>
      ApiPaginationMeta(
        total: (json["total"] as num? ?? 0).toInt(),
        limit: (json["limit"] as num? ?? 0).toInt(),
        offset: (json["offset"] as num? ?? 0).toInt(),
        returned: (json["returned"] as num? ?? 0).toInt(),
        hasMore: json["has_more"] as bool? ?? false,
        nextOffset: (json["next_offset"] as num?)?.toInt(),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "offset": offset,
        "returned": returned,
        "has_more": hasMore,
        "next_offset": nextOffset,
      };
}

class PaginatedApiData<T> {
  const PaginatedApiData({
    required this.items,
    required this.pagination,
  });

  final List<T> items;
  final ApiPaginationMeta pagination;
}
