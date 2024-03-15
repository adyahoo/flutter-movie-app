import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  const MovieModel({required this.id, required this.title, required this.poster, required this.releaseDate, required this.overview});

  final int id;
  final String title;
  final String poster;
  final String releaseDate;
  final String overview;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        title: json['original_title'],
        poster: json['poster_path'],
        releaseDate: json['release_date'],
        overview: json['overview'],
      );

  @override
  List<Object?> get props => [id, title, poster, overview];
}
