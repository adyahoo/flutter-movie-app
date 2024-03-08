import 'package:equatable/equatable.dart';

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
