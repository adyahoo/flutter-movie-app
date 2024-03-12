import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/app/blocs/api_result_state.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, ApiResultState> {


  MovieBloc() : super(MovieInitial()) {
    on<GetPopularMovie>((event, emit) {
      emit(Loading<Popular>());


    });
  }
}
