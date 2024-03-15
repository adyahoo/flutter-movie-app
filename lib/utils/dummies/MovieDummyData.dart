import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../app/data/models/movie_model.dart';
import '../../app/data/models/picker_model.dart';

class MovieDummyData {
  static List<PickerModel> getAccountMenu() => [
        PickerModel(id: 1, label: translate("ratings"), prefixIcon: Icons.book_outlined),
        PickerModel(id: 2, label: translate("favorite"), prefixIcon: Icons.favorite_border_rounded),
        PickerModel(id: 3, label: translate("list"), prefixIcon: Icons.list),
        PickerModel(id: 4, label: translate("logout"), prefixIcon: Icons.login_outlined),
      ];

  static List<PickerModel> getGuestAccountMenu() => [
    PickerModel(id: 1, label: translate("ratings"), prefixIcon: Icons.book_outlined),
    PickerModel(id: 2, label: translate("favorite"), prefixIcon: Icons.favorite_border_rounded),
    PickerModel(id: 3, label: translate("list"), prefixIcon: Icons.list),
  ];
}
