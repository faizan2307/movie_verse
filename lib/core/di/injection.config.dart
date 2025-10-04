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
import 'package:movie_verse/core/db/drift_db.dart' as _i918;
import 'package:movie_verse/core/di/core_module.dart' as _i576;
import 'package:movie_verse/core/network/tmdb_api.dart' as _i307;
import 'package:movie_verse/data/repositories/movie_repository_impl.dart' as _i501;
import 'package:movie_verse/domain/repositories/movie_repository.dart' as _i755;

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
    final coreModule = _$CoreModule();
    gh.lazySingleton<_i361.Dio>(() => coreModule.dio());
    gh.lazySingleton<_i918.AppDatabase>(() => coreModule.db());
    gh.lazySingleton<_i307.TmdbApi>(() => coreModule.api(gh<_i361.Dio>()));
    gh.lazySingleton<_i755.MovieRepository>(() => _i501.MovieRepositoryImpl(
          gh<_i918.AppDatabase>(),
          gh<_i307.TmdbApi>(),
        ));
    return this;
  }
}

class _$CoreModule extends _i576.CoreModule {}
