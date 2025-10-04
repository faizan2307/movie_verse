import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'models/dto_paged.dart';
import 'models/dto_movie.dart';
import 'models/dto_movie_details.dart';
part 'tmdb_api.g.dart';

@RestApi()
abstract class TmdbApi {
  factory TmdbApi(Dio dio, {String baseUrl}) = _TmdbApi;

  @GET('/trending/movie/day')
  Future<PagedResponse<MovieDto>> trending(@Query('page') int page);

  @GET('/movie/now_playing')
  Future<PagedResponse<MovieDto>> nowPlaying(@Query('page') int page);

  @GET('/search/movie')
  Future<PagedResponse<MovieDto>> search(
      @Query('query') String query,
      @Query('page') int page,
      @Query('include_adult') bool includeAdult,
      );

  @GET('/movie/{movie_id}')
  Future<MovieDetailsDto> details(@Path('movie_id') int movieId);
}
