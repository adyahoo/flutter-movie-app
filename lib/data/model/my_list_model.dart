import 'package:equatable/equatable.dart';

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
