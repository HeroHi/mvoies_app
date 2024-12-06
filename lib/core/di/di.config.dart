// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/main_layout/data/ds/api_services.dart' as _i835;
import '../../features/main_layout/data/repos/layout_repo_impl.dart' as _i251;
import '../../features/main_layout/domain/repos/layout_repo.dart' as _i349;
import '../../features/main_layout/ui/screens/lay_out/home/cubit/home_cubit.dart'
    as _i217;
import 'dio_module.dart' as _i1045;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.provideDio());
    gh.singleton<_i835.ApiServices>(() => _i835.ApiServices(gh<_i361.Dio>()));
    gh.singleton<_i349.LayoutRepo>(
        () => _i251.LayoutRepoImpl(gh<_i835.ApiServices>()));
    gh.factory<_i217.HomeCubit>(() => _i217.HomeCubit(gh<_i349.LayoutRepo>()));
    return this;
  }
}

class _$DioModule extends _i1045.DioModule {}
