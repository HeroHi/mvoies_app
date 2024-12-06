
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/main_layout/domain/repos/layout_repo.dart';
import 'home_state.dart';
@injectable
class HomeCubit extends Cubit<HomeState> {
  LayoutRepo layoutRepo;
  HomeCubit(this.layoutRepo) : super(const HomeState.initial());
  void getPopMovies() async{
    emit(const HomeState.popularLoading());
     var response = await layoutRepo.getPopularMovies();
     response.when(success: (movies) {
       emit(HomeState.popularSuccess(movies));
     }, failure: (error) {
       emit(HomeState.popularFailure(error));
     },);
  }
  void getMoviesByCategory(String categoryId) async{
    emit(const HomeState.byGenreLoading());
    var response = await layoutRepo.getMoviesByCategory(categoryId);
    response.when(success: (movies) {
      emit(HomeState.byGenreSuccess(movies));
    }, failure: (error) {
      emit(HomeState.byGenreFailure(error));
    },);
  }
}
