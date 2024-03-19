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

class MovieDetailModel extends Equatable {
  const MovieDetailModel({
    required this.id,
    required this.title,
    required this.listGenres,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
  });

  final int id;
  final String title;
  final List<MovieGenreModel> listGenres;
  final String overview;
  final String releaseDate;
  final int runtime;
  final double voteAverage;
  final int voteCount;

  String get genre => listGenres.map((e) => e.name).join(", ");

  String get year {
    final date = DateTime.parse(releaseDate);

    return date.year.toString();
  }

  factory MovieDetailModel.fromJson(Map<String, dynamic> map) {
    return MovieDetailModel(
      id: map['id'],
      title: map['original_title'],
      listGenres: (map['genres'] as Iterable).map((e) => MovieGenreModel.fromJson(e)).toList(),
      overview: map['overview'],
      releaseDate: map['release_date'],
      runtime: map['runtime'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
    );
  }

  @override
  List<Object> get props => [id, title, listGenres, overview, releaseDate, runtime, voteAverage, voteCount];
}

class MovieGenreModel extends Equatable {
  const MovieGenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory MovieGenreModel.fromJson(Map<String, dynamic> map) {
    return MovieGenreModel(
      id: map['id'],
      name: map['name'],
    );
  }

  @override
  List<Object> get props => [id, name];
}

class MovieTrailerModel extends Equatable {
  const MovieTrailerModel({
    required this.id,
    required this.type,
    required this.key,
  });

  final String id;
  final String type;
  final String key;

  factory MovieTrailerModel.fromJson(Map<String, dynamic> json) => MovieTrailerModel(
        id: json['id'],
        type: json['type'],
        key: json['key'],
      );

  @override
  List<Object?> get props => [id, type, key];
}

class MovieImagesModel extends Equatable {
  const MovieImagesModel({
    required this.backdrops,
    required this.logos,
    required this.posters,
  });

  final List<ImageModel> backdrops;
  final List<ImageModel> logos;
  final List<ImageModel> posters;

  factory MovieImagesModel.fromJson(Map<String, dynamic> json) => MovieImagesModel(
        backdrops: (json['backdrops'] as Iterable).map((e) => ImageModel.fromJson(e)).toList(),
        logos: (json['logos'] as Iterable).map((e) => ImageModel.fromJson(e)).toList(),
        posters: (json['posters'] as Iterable).map((e) => ImageModel.fromJson(e)).toList(),
      );

  @override
  List<Object?> get props => [backdrops, logos, posters];
}

class ImageModel extends Equatable {
  const ImageModel({
    required this.path,
    required this.aspectRatio,
  });

  final String path;
  final double aspectRatio;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        path: json['file_path'],
        aspectRatio: json['aspect_ratio'],
      );

  @override
  List<Object?> get props => [path, aspectRatio];
}
