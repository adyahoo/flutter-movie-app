import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../config/app_color.dart';
import '../../config/di.dart';
import '../../config/navigation/router.dart';
import '../../config/navigation/routes.dart';
import '../../data/model/account_model.dart';
import '../../data/model/movie_model.dart';
import '../../data/model/picker_model.dart';
import '../../data/services/service.dart';
import '../../utils/constants.dart';
import '../../utils/dummies/MovieDummyData.dart';
import '../../utils/utilities.dart';
import '../bloc/account/account_bloc.dart';
import '../bloc/api_result_state.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/movie_detail/movie_detail_bloc.dart';
import '../bloc/rating_favorite/rating_favorite_bloc.dart';
import '../widget/movie_alert_dialog.dart';
import '../widget/movie_appbar.dart';
import '../widget/movie_button.dart';
import '../widget/movie_card.dart';
import '../widget/movie_menu_item.dart';
import '../widget/movie_rating_card.dart';
import '../widget/movie_text_field.dart';
import '../widget/shimmer/shimmer_container.dart';

part 'account_screen.dart';
part 'home_screen.dart';
part 'login_screen.dart';
part 'main_tab_screen.dart';
part 'movie_detail_screen.dart';
part 'movies_screen.dart';
part 'rating_favorite_screen.dart';
part 'splash_screen.dart';
part 'welcome_screen.dart';