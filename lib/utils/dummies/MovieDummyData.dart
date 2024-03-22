import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../app/data/models/picker_model.dart';

enum MenuType { RATING, FAVORITE, LIST, LOGOUT, DELETE }

class MovieDummyData {
  static List<PickerModel> getAccountMenu() => [
        PickerModel(id: 1, label: translate("ratings"), type: MenuType.RATING, prefixIcon: Icons.book_outlined),
        PickerModel(id: 2, label: translate("favorite"), type: MenuType.FAVORITE, prefixIcon: Icons.favorite_border_rounded),
        PickerModel(id: 3, label: translate("list"), type: MenuType.LIST, prefixIcon: Icons.list),
        PickerModel(id: 4, label: translate("logout"), type: MenuType.LOGOUT, prefixIcon: Icons.login_outlined),
      ];

  static List<PickerModel> getGuestAccountMenu() => [
        PickerModel(id: 1, label: translate("ratings"), type: MenuType.RATING, prefixIcon: Icons.book_outlined),
        PickerModel(id: 2, label: translate("favorite"), type: MenuType.FAVORITE, prefixIcon: Icons.favorite_border_rounded),
        PickerModel(id: 3, label: translate("list"), type: MenuType.LIST, prefixIcon: Icons.list),
      ];

  static List<PickerModel> getRatingMenu() => [
        PickerModel(id: 1, label: translate("add_to_list"), type: MenuType.LIST, prefixIcon: Icons.list),
        PickerModel(id: 2, label: translate("remove_rating"), type: MenuType.DELETE, prefixIcon: Icons.delete_rounded),
      ];
}
