import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../app/data/models/movie_model.dart';
import '../../app/data/models/picker_model.dart';

class MovieDummyData {
  static List<MovieModel> getDummyPopular() => [
        const MovieModel(
          id: 1,
          title: "Chaeyoung",
          poster: "https://upload.wikimedia.org/wikipedia/commons/5/52/Chaeyoung_at_Gaon_Awards_red_carpet_on_January_23%2C_2019.jpg",
        ),
        const MovieModel(
          id: 2,
          title: "Chaeyoung",
          poster: "https://upload.wikimedia.org/wikipedia/commons/5/52/Chaeyoung_at_Gaon_Awards_red_carpet_on_January_23%2C_2019.jpg",
        ),
        const MovieModel(
          id: 3,
          title: "Chaeyoung",
          poster: "https://upload.wikimedia.org/wikipedia/commons/5/52/Chaeyoung_at_Gaon_Awards_red_carpet_on_January_23%2C_2019.jpg",
        ),
        const MovieModel(
          id: 4,
          title: "Chaeyoung",
          poster: "https://upload.wikimedia.org/wikipedia/commons/5/52/Chaeyoung_at_Gaon_Awards_red_carpet_on_January_23%2C_2019.jpg",
        ),
        const MovieModel(
          id: 5,
          title: "Chaeyoung",
          poster: "https://upload.wikimedia.org/wikipedia/commons/5/52/Chaeyoung_at_Gaon_Awards_red_carpet_on_January_23%2C_2019.jpg",
        ),
        const MovieModel(
          id: 6,
          title: "Chaeyoung",
          poster: "https://upload.wikimedia.org/wikipedia/commons/5/52/Chaeyoung_at_Gaon_Awards_red_carpet_on_January_23%2C_2019.jpg",
        ),
        const MovieModel(
          id: 7,
          title: "Chaeyoung",
          poster: "https://upload.wikimedia.org/wikipedia/commons/5/52/Chaeyoung_at_Gaon_Awards_red_carpet_on_January_23%2C_2019.jpg",
        ),
        const MovieModel(
          id: 8,
          title: "Chaeyoung",
          poster: "https://upload.wikimedia.org/wikipedia/commons/5/52/Chaeyoung_at_Gaon_Awards_red_carpet_on_January_23%2C_2019.jpg",
        ),
        const MovieModel(
          id: 9,
          title: "Chaeyoung",
          poster: "https://upload.wikimedia.org/wikipedia/commons/5/52/Chaeyoung_at_Gaon_Awards_red_carpet_on_January_23%2C_2019.jpg",
        ),
        const MovieModel(
          id: 10,
          title: "Chaeyoung",
          poster: "https://upload.wikimedia.org/wikipedia/commons/5/52/Chaeyoung_at_Gaon_Awards_red_carpet_on_January_23%2C_2019.jpg",
        ),
      ];

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
