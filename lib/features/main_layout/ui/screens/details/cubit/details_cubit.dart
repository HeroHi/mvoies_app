
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/main_layout/domain/entities/cast_entity.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_details_entity.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';
import 'package:movies_app/features/main_layout/domain/repos/layout_repo.dart';

import 'details_state.dart';

@injectable
class DetailsCubit extends Cubit<DetailsState> {
  final LayoutRepo _layoutRepo;
  DetailsCubit(this._layoutRepo) : super(const DetailsState.initial());
  void getMovie(int movieId)async{
    emit(const DetailsState.movieLoading());
    var response = await _layoutRepo.getMovie(movieId);
    response.when(success: (movie) {
      emit(DetailsState<MovieDetailsEntity>.movieSuccess(movie));
    }, failure: (error) {
      emit(DetailsState.movieFailure(error));
    },);
  }
  void getCast(int movieId)async{
    emit(const DetailsState.castLoading());
    var response = await _layoutRepo.getCast(movieId);
    response.when(success: (cast) {
      emit(DetailsState<List<CastEntity>>.movieSuccess(cast));
    }, failure: (error) {
      emit(DetailsState.movieFailure(error));
    },);
  }

  void getSimilarMovies(int movieId)async{
    emit(const DetailsState.castLoading());
    var response = await _layoutRepo.getSimilarMovies(movieId);
    response.when(success: (movies) {
      emit(DetailsState<List<MovieEntity>>.movieSuccess(movies));
    }, failure: (error) {
      emit(DetailsState.movieFailure(error));
    },);
  }

}
