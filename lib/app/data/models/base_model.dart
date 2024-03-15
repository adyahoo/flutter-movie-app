import 'package:equatable/equatable.dart';

class ListApiResponse<T> extends Equatable {
  const ListApiResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  factory ListApiResponse.fromJson(Map<String, dynamic> json, Function(Iterable map) create) =>
      ListApiResponse(
        page: json['page'],
        results: create(json['results'] as Iterable),
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
      );

  List<Object?> get props => [page, results, totalPages, totalResults];
}
