import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/injection.dart';
import '../../domain/repositories/movie_repository.dart';
import '../widgets/movie_card.dart';
import '../widgets/section_skeleton.dart';
import 'search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool grid = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(getIt<MovieRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          actions: [
            IconButton(
              tooltip: 'Toggle layout',
              onPressed: () => setState(() => grid = !grid),
              icon: Icon(grid ? Icons.view_list_outlined : Icons.grid_view),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: 1,
          onDestinationSelected: (i) {
            switch (i) {
              case 0: context.go('/'); break;
              case 1: context.go('/search'); break;
              case 2: context.go('/saved'); break;
            }
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
            NavigationDestination(icon: Icon(Icons.bookmark_border), label: 'Saved'),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (innerContext) => TextField(
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search movies...'),
                  onChanged: (q) => innerContext.read<SearchBloc>().add(SearchQueryChanged(q)),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.loading && state.results.isEmpty && state.query.isNotEmpty) {
                      return const HorizontalCardsSkeleton();
                    }
                    if (state.results.isEmpty) {
                      return const Center(child: Text('Start typing to search...'));
                    }
                    if (grid) {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 2 / 3, crossAxisSpacing: 12, mainAxisSpacing: 12,
                        ),
                        itemCount: state.results.length,
                        itemBuilder: (_, i) => MovieCard(
                          movie: state.results[i],
                          onTap: () => context.push('/movie/${state.results[i].id}'),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: state.results.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) {
                        final movie = state.results[i];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          leading: SizedBox(width: 56, child: MovieCard(movie: movie, onTap: () => context.push('/movie/${movie.id}'))),
                          title: Text(movie.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                          subtitle: Text(movie.releaseDate ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push('/movie/${movie.id}'),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
