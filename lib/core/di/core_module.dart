import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import '../network/dio_client.dart';
import '../network/tmdb_api.dart';
import '../db/drift_db.dart';

@module
abstract class CoreModule {
  @lazySingleton
  Dio dio() => buildDio();

  @lazySingleton
  TmdbApi api(Dio dio) => TmdbApi(dio);

  @lazySingleton
  AppDatabase db() => AppDatabase.instance;
}