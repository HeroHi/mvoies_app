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
import '../../features/main_layout/ui/screens/details/cubit/details_cubit.dart'
    as _i548;
import '../../features/main_layout/ui/screens/lay_out/browse/cubit/browse_cubit.dart'
    as _i146;
import '../../features/main_layout/ui/screens/lay_out/home/cubit/home_cubit.dart'
    as _i217;
import '../../features/main_layout/ui/screens/lay_out/search/cubit/search_cubit.dart'
    as _i41;
import '../../features/profile/data/repos/profile_repo_impl.dart' as _i1072;
import '../../features/profile/domain/repos/profile_repo.dart' as _i1007;
import '../../features/profile/ui/screens/profile/cubit/profile_cubit.dart'
    as _i921;
import '../../features/profile/ui/screens/update_profile/cubit/update_profile_cubit.dart'
    as _i282;
import '../services/auth_service.dart' as _i745;
import '../services/database_service.dart' as _i665;
import '../services/firebase/firestore_service.dart' as _i939;
import '../services/supabase/supabase_auth_service.dart' as _i917;
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
    gh.singleton<_i665.DatabaseService>(() => _i939.FirestoreService());
    gh.singleton<_i835.ApiServices>(() => _i835.ApiServices(gh<_i361.Dio>()));
    gh.singleton<_i349.LayoutRepo>(() => _i251.LayoutRepoImpl(
          gh<_i835.ApiServices>(),
          gh<_i665.DatabaseService>(),
        ));
    gh.singleton<_i745.AuthService>(() => _i917.SupabaseAuthService());
    gh.factory<_i146.BrowseCubit>(
        () => _i146.BrowseCubit(gh<_i349.LayoutRepo>()));
    gh.factory<_i217.HomeCubit>(() => _i217.HomeCubit(gh<_i349.LayoutRepo>()));
    gh.factory<_i548.DetailsCubit>(
        () => _i548.DetailsCubit(gh<_i349.LayoutRepo>()));
    gh.factory<_i41.SearchCubit>(
        () => _i41.SearchCubit(gh<_i349.LayoutRepo>()));
    gh.singleton<_i1007.ProfileRepo>(() => _i1072.ProfileRepoImpl(
          gh<_i665.DatabaseService>(),
          gh<_i745.AuthService>(),
        ));
    gh.factory<_i921.ProfileCubit>(
        () => _i921.ProfileCubit(gh<_i1007.ProfileRepo>()));
    gh.factory<_i282.UpdateProfileCubit>(
        () => _i282.UpdateProfileCubit(gh<_i1007.ProfileRepo>()));
    return this;
  }
}

class _$DioModule extends _i1045.DioModule {}
