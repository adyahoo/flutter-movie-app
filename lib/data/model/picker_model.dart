import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/utils/dummies/MovieDummyData.dart';

class PickerModel extends Equatable {
  const PickerModel({required this.id, required this.label, required this.type, this.prefixIcon});

  final int id;
  final String label;
  final MenuType type;
  final IconData? prefixIcon;

  @override
  List<Object?> get props => [id, label, prefixIcon, type];
}
