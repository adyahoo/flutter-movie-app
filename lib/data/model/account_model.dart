import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class AccountModel extends Equatable {
  const AccountModel({required this.id, required this.name, required this.username, this.avatar});

  final int id;
  final String name;
  final String username;
  final String? avatar;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        avatar: json['avatar']['tmdb']['avatar_path'],
      );

  @override
  List<Object?> get props => [id, name, username, avatar];
}

class AddFavoriteModel extends Equatable {
  const AddFavoriteModel({required this.movieId, required this.isFavorite, this.type = "movie"});

  final String type;
  final int movieId;
  final bool isFavorite;

  Map<String, dynamic> toJson() {
    return {
      'media_type': type,
      'media_id': movieId,
      'favorite': isFavorite,
    };
  }

  @override
  List<Object> get props => [type, movieId, isFavorite];
}

class MyListModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String? poster;

  const MyListModel({
    required this.id,
    required this.name,
    required this.description,
    this.poster,
  });

  factory MyListModel.fromJson(Map<String, dynamic> map) {
    return MyListModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      poster: map['poster_path'],
    );
  }

  @override
  List<Object?> get props => [id, name, description, poster];
}
