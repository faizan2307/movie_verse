import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/di/injection.dart';
import '../../domain/repositories/movie_repository.dart';
import '../widgets/movie_card.dart';
import '../widgets/section_header.dart';
import '../widgets/carousel_card.dart';
import '../widgets/section_skeleton.dart';
import 'trending_cubit.dart';
import 'now_playing_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TrendingCubit(getIt<MovieRepository>())),
        BlocProvider(create: (_) => NowPlayingCubit(getIt<MovieRepository>())),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
            child: const Text(
              'Movie Verse',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                letterSpacing: 1,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: NavigationBar(
            selectedIndex: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            onDestinationSelected: (i) {
              switch (i) {
                case 0: context.go('/'); break;
                case 1: context.go('/search'); break;
                case 2: context.go('/saved'); break;
              }
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: AppColors.navigationBarUnselected),
                selectedIcon: Icon(Icons.home, color: AppColors.navigationBarSelected),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.search, color: AppColors.navigationBarUnselected),
                selectedIcon: Icon(Icons.search, color: AppColors.navigationBarSelected),
                label: 'Search',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmark_border, color: AppColors.navigationBarUnselected),
                selectedIcon: Icon(Icons.bookmark, color: AppColors.navigationBarSelected),
                label: 'Saved',
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundGradient,
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              await context.read<TrendingCubit>().refresh();
              await context.read<NowPlayingCubit>().refresh();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  SectionHeader(
                    title: 'Trending Today',
                    onMore: () => context.push('/list/trending'),
                  ),
                  const SizedBox(height: 16),
                BlocBuilder<TrendingCubit, TrendingState>(
                  builder: (context, state) {
                    final items = state.movies;
                    if (state.loading && items.isEmpty) {
                      return const HorizontalCardsSkeleton();
                    }
                    if (items.isEmpty) return const Text('No items');
                    return SizedBox(
                      height: 260,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (n) {
                          if (n.metrics.pixels >= n.metrics.maxScrollExtent - 200) {
                            context.read<TrendingCubit>().loadMore();
                          }
                          return false;
                        },
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: PageController(viewportFraction: 0.9),
                              itemCount: items.length,
                              padEnds: false,
                              itemBuilder: (_, i) => Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: CarouselCard(
                                  movie: items[i],
                                  onTap: () => context.push('/movie/${items[i].id}'),
                                ),
                              ),
                            ),
                            if (state.loading)
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                SectionHeader(
                  title: 'Now Playing',
                  onMore: () => context.push('/list/now'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 240,
                  child: BlocBuilder<NowPlayingCubit, NowPlayingState>(
                    builder: (context, state) {
                      final items = state.movies;
                      if (state.loading && items.isEmpty) return const HorizontalCardsSkeleton();
                      if (items.isEmpty) return const Text('No items');
                      return NotificationListener<ScrollNotification>(
                        onNotification: (n) {
                          if (n.metrics.pixels >= n.metrics.maxScrollExtent - 200) {
                            context.read<NowPlayingCubit>().loadMore();
                          }
                          return false;
                        },
                        child: Stack(
                          children: [
                            ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, i) => MovieCard(
                                movie: items[i],
                                onTap: () => context.push('/movie/${items[i].id}'),
                              ),
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemCount: items.length,
                            ),
                            if (state.loading)
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
