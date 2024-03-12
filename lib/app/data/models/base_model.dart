import 'package:equatable/equatable.dart';

class BaseListModel extends Equatable {
  const BaseListModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List results;
  final int totalPages;
  final int totalResults;

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}
