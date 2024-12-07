
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/main_layout/domain/repos/layout_repo.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/browse/cubit/browse_state.dart';

@injectable
class BrowseCubit extends Cubit<BrowseState> {
  final LayoutRepo layoutRepo;
  BrowseCubit(this.layoutRepo) : super(const BrowseState.initial());
  void getMoviesByCategory(String categoryId) async{
    emit(const BrowseState.moviesLoading());
    var response = await layoutRepo.getMoviesByCategory(categoryId);
    response.when(success: (movies) {
      emit(BrowseState.moviesSuccess(movies));
    }, failure: (error) {
      emit(BrowseState.moviesFailure(error));
    },);
  }
  void getGenres()async{
    emit(const BrowseState.genreLoading());
    var result = await layoutRepo.getGenres();
    result.when(success: (genres) {
      emit(BrowseState.genreSuccess(genres));
    }, failure: (error) {
      emit(BrowseState.genreFailure(error));
    },);
  }
}
