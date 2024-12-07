
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/networking/api_result.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';
import 'package:movies_app/features/main_layout/domain/repos/layout_repo.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/search/cubit/search_state.dart';


@injectable
class SearchCubit extends Cubit<SearchState> {
  final LayoutRepo _layoutRepo;
  SearchCubit(this._layoutRepo) : super(const SearchState.initial());
  void searchForMovies({required String q, required int page})async{
    emit(const SearchState.moviesLoading());
    var response = await _layoutRepo.search(q: q,page: page);
    response.when(success: (movies) {
      emit(SearchState.moviesSuccess(movies));
    }, failure: (error) {
      emit(SearchState.moviesFailure(error));
    },);
  }
}
