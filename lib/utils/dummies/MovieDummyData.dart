import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:movie_app/data/model/movie_model.dart';

import '../../data/model/picker_model.dart';

enum MenuType { RATING, FAVORITE, LIST, LOGOUT, DELETE, EDIT }

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

  static List<PickerModel> getListOptionMenu() => const [
        PickerModel(id: 1, label: "Edit List", type: MenuType.EDIT, prefixIcon: Icons.mode_edit_outline_outlined),
        PickerModel(id: 2, label: "Delete List", type: MenuType.DELETE, prefixIcon: Icons.delete_rounded),
      ];

  static List<MovieModel> getMovies() => const [
        MovieModel(
          id: 1,
          title: "title",
          poster: "https://static.wikia.nocookie.net/kda-league-of-legends/images/b/be/Chaeyoung.jpg/revision/latest?cb=20210330180327",
          releaseDate: "1212-12-12",
          overview: "asdjfhasdk",
        ),
        MovieModel(
          id: 1,
          title: "title asjdfgasdjfjkasdgfjkasdgfjkasdgflasdhlfjkahsdklf",
          poster: "https://static.wikia.nocookie.net/kda-league-of-legends/images/b/be/Chaeyoung.jpg/revision/latest?cb=20210330180327",
          releaseDate: "1212-12-12",
          overview: "asdjfhasdk",
        ),
        MovieModel(
          id: 1,
          title: "title",
          poster: "https://static.wikia.nocookie.net/kda-league-of-legends/images/b/be/Chaeyoung.jpg/revision/latest?cb=20210330180327",
          releaseDate: "1212-12-12",
          overview: "asdjfhasdk",
        ),
        MovieModel(
          id: 1,
          title: "title asjdfgasdjfjkasdgfjkasdgfjkasdgflasdhlfjkahsdklf",
          poster: "https://static.wikia.nocookie.net/kda-league-of-legends/images/b/be/Chaeyoung.jpg/revision/latest?cb=20210330180327",
          releaseDate: "1212-12-12",
          overview: "asdjfhasdk",
        ),
        MovieModel(
          id: 1,
          title: "title asjdfgasdjfjkasdgfjkasdgfjkasdgflasdhlfjkahsdklf",
          poster: "https://static.wikia.nocookie.net/kda-league-of-legends/images/b/be/Chaeyoung.jpg/revision/latest?cb=20210330180327",
          releaseDate: "1212-12-12",
          overview: "asdjfhasdk",
        ),
      ];
}
