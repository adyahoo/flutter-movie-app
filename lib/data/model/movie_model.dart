import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class MovieModel extends Equatable {
  const MovieModel({required this.id, required this.title, this.poster, required this.releaseDate, required this.overview});

  final int id;
  final String title;
  final String? poster;
  final String releaseDate;
  final String overview;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        title: json['original_title'],
        poster: json['poster_path'],
        releaseDate: (json['release_date'] != "") ? json['release_date'] : "-",
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
    required this.country,
    required this.poster,
  });

  final int id;
  final String title;
  final List<GenreModel> listGenres;
  final String overview;
  final String releaseDate;
  final int runtime;
  final double voteAverage;
  final int voteCount;
  final String country;
  final String poster;

  String get genre => listGenres.map((e) => e.name).join(", ");

  String get year {
    final date = DateTime.parse(releaseDate);

    return date.year.toString();
  }

  String get description {
    final releaseDate = DateTime.parse(this.releaseDate);
    final date = DateFormat("dd/MM/yyyy").format(releaseDate);

    return date.toString();
  }

  String get duration {
    final hour = runtime / 60;
    final minutes = runtime % 60;

    return "${hour.floor()}h ${minutes}m";
  }

  factory MovieDetailModel.fromJson(Map<String, dynamic> map) {
    return MovieDetailModel(
        id: map['id'],
        title: map['original_title'],
        listGenres: (map['genres'] as Iterable).map((e) => GenreModel.fromJson(e)).toList(),
        overview: map['overview'],
        releaseDate: map['release_date'],
        runtime: map['runtime'],
        voteAverage: map['vote_average'],
        voteCount: map['vote_count'],
        country: MovieProductionCountryModel.fromJson((map['production_countries'] as Iterable).first).country,
        poster: map['poster_path']);
  }

  @override
  List<Object> get props => [id, title, listGenres, overview, releaseDate, runtime, voteAverage, voteCount, country, poster];
}

class MovieProductionCountryModel extends Equatable {
  const MovieProductionCountryModel({
    required this.country,
    required this.name,
  });

  final String country;
  final String name;

  factory MovieProductionCountryModel.fromJson(Map<String, dynamic> map) {
    return MovieProductionCountryModel(
      country: map['iso_3166_1'],
      name: map['name'],
    );
  }

  @override
  List<Object> get props => [country, name];
}

class GenreModel extends Equatable {
  const GenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenreModel.fromJson(Map<String, dynamic> map) {
    return GenreModel(
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

class MovieCreditModel extends Equatable {
  const MovieCreditModel({
    required this.cast,
    required this.crew,
  });

  final List<CastModel> cast;
  final List<CrewModel> crew;

  String get director => _filterCrew("Director");

  String get screenplay => _filterCrew("Screenplay");

  String get character => _filterCrew("Characters");

  String _filterCrew(String job) {
    final data = crew.where((e) => e.job == job).toList();

    if (data.isNotEmpty) {
      return data.map((e) => e.name).join(", ");
    } else {
      return "-";
    }
  }

  factory MovieCreditModel.fromJson(Map<String, dynamic> map) {
    return MovieCreditModel(
      cast: (map['cast'] as Iterable).map((e) => CastModel.fromJson(e)).toList(),
      crew: (map['crew'] as Iterable).map((e) => CrewModel.fromJson(e)).toList(),
    );
  }

  @override
  List<Object> get props => [cast, crew];
}

class CrewModel extends Equatable {
  const CrewModel({
    required this.id,
    required this.name,
    required this.department,
    required this.job,
    this.profilePicture,
  });

  final int id;
  final String name;
  final String department;
  final String job;
  final String? profilePicture;

  factory CrewModel.fromJson(Map<String, dynamic> map) {
    return CrewModel(
      id: map['id'],
      name: map['original_name'],
      profilePicture: map['profile_path'],
      department: map['known_for_department'],
      job: map['job'],
    );
  }

  @override
  List<Object?> get props => [id, name, profilePicture, department, job];
}

class CastModel extends Equatable {
  const CastModel({
    required this.id,
    required this.name,
    required this.department,
    required this.character,
    this.profilePicture,
  });

  final int id;
  final String name;
  final String department;
  final String character;
  final String? profilePicture;

  factory CastModel.fromJson(Map<String, dynamic> map) {
    return CastModel(
      id: map['id'],
      name: map['original_name'],
      profilePicture: map['profile_path'],
      department: map['known_for_department'],
      character: map['character'],
    );
  }

  @override
  List<Object?> get props => [id, name, profilePicture, department, character];
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

class AccountStatesModel extends Equatable {
  const AccountStatesModel({required this.favorite, required this.rated});

  final bool favorite;
  final dynamic rated;

  factory AccountStatesModel.fromJson(Map<String, dynamic> map) {
    return AccountStatesModel(
      favorite: map['favorite'],
      rated: (map['rated'] is bool) ? map['rated'] : map['rated']['value'],
    );
  }

  AccountStatesModel copyWith({
    bool? favorite,
    dynamic? rated,
  }) {
    return AccountStatesModel(
      favorite: favorite ?? this.favorite,
      rated: rated ?? this.rated,
    );
  }

  @override
  List<Object> get props => [favorite, rated];
}

class MovieListModel extends Equatable {
  const MovieListModel({required this.id, required this.name, required this.description, required this.itemCount, this.poster});

  final int id;
  final String name;
  final String description;
  final int itemCount;
  final String? poster;

  factory MovieListModel.fromJson(Map<String, dynamic> map) {
    return MovieListModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      itemCount: map['item_count'],
      poster: map['poster_path'],
    );
  }

  @override
  List<Object?> get props => [id, name, description, itemCount, poster];
}
