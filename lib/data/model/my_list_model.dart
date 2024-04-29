import 'package:equatable/equatable.dart';
import 'package:movie_app/data/model/movie_model.dart';

class CreateListModel extends Equatable {
  const CreateListModel({
    required this.name,
    required this.description,
  });

  final String name;
  final String description;
  final String lang = 'en';

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'language': lang,
    };
  }

  @override
  List<Object> get props => [name, description, lang];
}

class ListDetailModel extends Equatable {
  const ListDetailModel({required this.id, required this.name, required this.description, required this.itemCount, required this.items, this.poster});

  final int id;
  final String name;
  final String description;
  final int itemCount;
  final List<MovieModel> items;
  final String? poster;

  factory ListDetailModel.fromJson(Map<String, dynamic> map) {
    return ListDetailModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      itemCount: map['item_count'],
      items: (map['items'] as Iterable).map((e) => MovieModel.fromJson(e)).toList(),
      poster: map['poster_path'],
    );
  }

  @override
  List<Object?> get props => [id, name, description, itemCount, items, poster];
}