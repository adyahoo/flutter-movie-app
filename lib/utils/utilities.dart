import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/data/model/picker_model.dart';
import 'package:movie_app/presentation/widget/movie_button.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/config/app_color.dart';
import 'package:movie_app/utils/constants.dart';

import '../config/exception/api_exception.dart';
import '../config/navigation/router.dart';
import '../data/model/api_model.dart';

void errorHandler(ApiException e) {
  ApiResponse? errorResponse;

  showSnackBar(
    SnackBar(
      content: Text(
        e.response?.message ?? "",
        style: Theme.of(rootScaffoldKey.currentContext!).textTheme.labelMedium?.copyWith(color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(rootScaffoldKey.currentContext!).colorScheme.error,
    ),
  );
}

void showSnackBar(SnackBar snackbar) {
  rootScaffoldKey.currentState!
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);
}

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(
          color: PrimaryColor.main,
        ),
      );
    },
  );
}

void hideLoading(BuildContext context) {
  context.pop();
}

void showRateBS(
  BuildContext context, {
  required String title,
  required String poster,
  required double initialRate,
  required Function(double value) onRateClicked,
}) {
  double rateValue = 0;

  showModalBottomSheet(
    context: context,
    backgroundColor: const Color.fromARGB(1, 255, 255, 255),
    builder: (context) {
      return BottomSheet(
        onClosing: () {},
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -150,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Container(
                      width: 140,
                      height: 210,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider("${Constants.IMAGE_BASE_URL}$poster"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      "How would you rate $title?",
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(color: TextColor.primary),
                    ),
                    const SizedBox(height: 16),
                    RatingBar(
                      initialRating: initialRate,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      onRatingUpdate: (value) {
                        rateValue = value;
                      },
                      ratingWidget: RatingWidget(
                        full: Image.asset(
                          "assets/images/ic_star_movie.png",
                          color: const Color(0xFFF2C94C),
                        ),
                        half: Image.asset(
                          "assets/images/ic_star_movie_half.png",
                          color: const Color(0xFFF2C94C),
                          width: 40,
                          height: 40,
                        ),
                        empty: Image.asset(
                          "assets/images/ic_star_movie_gray.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    MovieButton.filled(
                      text: "Rate",
                      isLoading: false,
                      onPress: () {
                        goRouter.pop();
                        onRateClicked(rateValue);
                      },
                    ),
                    const SizedBox(height: 12),
                    MovieButton.outline(
                      text: "Cancel",
                      isLoading: false,
                      onPress: () {
                        goRouter.pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

String translateReleaseDate(String releaseDate) {
  final inputFormat = DateFormat("yyyy-MM-dd");
  final inputDate = inputFormat.parse(releaseDate);

  final outputFormat = DateFormat("MMM dd, yyyy");
  return outputFormat.format(inputDate);
}

void showOptionBS(BuildContext context, List<PickerModel> data, Function(int menuId) onTap) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(top: 12, right: 16, bottom: 32, left: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Option", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TextColor.primary)),
                InkWell(
                  onTap: () {
                    goRouter.pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: OtherColor.lineDivider,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: TextColor.primary,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Column(
              children: data.map((e) {
                return InkWell(
                  onTap: () {
                    onTap(e.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(border: Border(top: BorderSide(width: 1, color: OtherColor.lineDivider))),
                    child: Row(
                      children: [
                        Icon(
                          e.prefixIcon,
                          size: 20,
                          color: TextColor.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(e.label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: TextColor.primary)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      );
    },
  );
}
