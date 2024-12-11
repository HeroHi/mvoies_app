
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/main_layout/domain/entities/backdrop_entity.dart';
import 'package:movies_app/features/main_layout/domain/entities/cast_entity.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_details_entity.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';
import 'package:movies_app/features/main_layout/domain/repos/layout_repo.dart';

import 'details_state.dart';

@injectable
class DetailsCubit extends Cubit<DetailsState> {
  final LayoutRepo _layoutRepo;
  DetailsCubit(this._layoutRepo) : super(const DetailsState.initial());
  Future<void> getMovie(int movieId)async{
    emit(const DetailsState.movieLoading());
    print("movie loading");
    var response = await _layoutRepo.getMovie(movieId);
    response.when(success: (movie) {
      emit(DetailsState<MovieDetailsEntity>.movieSuccess(movie));
      print("movie success");
    }, failure: (error) {
      emit(DetailsState.movieFailure(error));
    },);
  }
  void getCast(int movieId)async{
    emit(const DetailsState.castLoading());
    print("cast loading");
    var response = await _layoutRepo.getCast(movieId);
    response.when(success: (cast) {
      print("cast success");
      emit(DetailsState<List<CastEntity>>.castSuccess(cast));
    }, failure: (error) {
      emit(DetailsState.castFailure(error));
    },);
  }

  void getSimilarMovies(int movieId)async{
    emit(const DetailsState.similarLoading());
    var response = await _layoutRepo.getSimilarMovies(movieId);
    response.when(success: (movies) {
      emit(DetailsState<List<MovieEntity>>.similarSuccess(movies));
    }, failure: (error) {
      emit(DetailsState.similarSuccess(error));
    },);
  }

  void getImages(int movieId)async{
    emit(const DetailsState.imagesLoading());
    var response = await _layoutRepo.getScreenshots(movieId);
    response.when(success: (screenshots) {
      emit(DetailsState<List<BackdropEntity>>.imagesSuccess(screenshots));
    }, failure: (error) {
      emit(DetailsState.similarSuccess(error));
    },);
  }
  void addToWatchList(MovieEntity movie){
      emit(const DetailsState.saveMovieLoading());
    try {
      _layoutRepo.addToWatchList(movie: movie);
      emit(const DetailsState.saveMovieSuccess());
    } catch(e) {
      emit(DetailsState.saveMovieFailure(e.toString()));
    }
}

  void addToHistory(MovieEntity movie){
     _layoutRepo.addToHistory(movie: movie);
}

}
