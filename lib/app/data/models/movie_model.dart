import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  const MovieModel({
    required this.id,
    required this.title,
    required this.poster,
  });

  final int id;
  final String title;
  final String poster;

  @override
  List<Object?> get props => [id, title, poster];
}
