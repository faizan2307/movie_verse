import 'package:go_router/go_router.dart';
import '../../ui/details/movie_details_page.dart';
import '../../ui/main_tab_page.dart';
import '../../ui/home/section_list_page.dart';
import '../../ui/splash/splash_page.dart';
import '../../core/constants/app_strings.dart';

final router = GoRouter(
  initialLocation: '/splash',
  redirect: (context, state) {
    final uri = state.uri;
    // Map full deep links like visionmovies://movie/123 to in-app routes
    if (uri.scheme == AppStrings.deepLinkScheme) {
      final isMovie = uri.host == AppStrings.deepLinkHost ||
          (uri.pathSegments.isNotEmpty && uri.pathSegments.first == AppStrings.deepLinkHost);
      if (isMovie) {
        String? idStr;
        if (uri.host == AppStrings.deepLinkHost && uri.pathSegments.isNotEmpty) {
          idStr = uri.pathSegments.first;
        } else if (uri.pathSegments.length >= 2 && uri.pathSegments.first == AppStrings.deepLinkHost) {
          idStr = uri.pathSegments[1];
        }
        if (idStr != null) {
          final id = int.tryParse(idStr);
          if (id != null) {
            return '/movie/$id';
          }
        }
      }
      // If scheme matches but pattern doesn't, fall through to home
      return '/';
    }
    return null; // no redirect
  },
  routes: [
    GoRoute(path: '/splash', builder: (c, s) => const SplashPage()),
    GoRoute(path: '/', builder: (c, s) => const MainTabPage()),
    GoRoute(path: '/movie/:id', builder: (c, s) => MovieDetailsPage(id: int.parse(s.pathParameters['id']!))),
    GoRoute(path: '/list/:type', builder: (c, s) {
      final type = s.pathParameters['type'];
      return SectionListPage(type: type == 'now' ? SectionType.nowPlaying : SectionType.trending);
    }),
  ],
);
