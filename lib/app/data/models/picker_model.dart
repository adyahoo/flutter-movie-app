import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PickerModel extends Equatable {
  const PickerModel({required this.id, required this.label, this.prefixIcon});

  final int id;
  final String label;
  final IconData? prefixIcon;

  @override
  List<Object?> get props => [id, label, prefixIcon];
}
