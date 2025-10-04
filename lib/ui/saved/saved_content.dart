import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/movie_card.dart';
import 'saved_cubit.dart';

class SavedContent extends StatelessWidget {
  const SavedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Saved Movies',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    BlocBuilder<SavedCubit, SavedState>(
                      builder: (context, state) => IconButton(
                        tooltip: 'Toggle layout',
                        onPressed: () => context.read<SavedCubit>().toggleLayout(),
                        icon: Icon(state.grid ? Icons.view_list_outlined : Icons.grid_view),
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (v) async {
                        final cubit = context.read<SavedCubit>();
                        if (v == 'title') cubit.setSort(SavedSort.titleAsc);
                        else if (v == 'date') cubit.setSort(SavedSort.dateDesc);
                        else if (v == 'clear') {
                          final ok = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Clear all saved?'),
                              content: const Text('This will remove all saved movies.'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Clear all')),
                              ],
                            ),
                          );
                          if (ok == true) {
                            await cubit.clearAll();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cleared saved movies')));
                            }
                          }
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: 'date', child: Text('Sort by date saved')),
                        PopupMenuItem(value: 'title', child: Text('Sort by title')),
                        PopupMenuDivider(),
                        PopupMenuItem(value: 'clear', child: Text('Clear all')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SavedCubit, SavedState>(
              builder: (context, state) {
                if (state.loading) return const Center(child: CircularProgressIndicator());
                if (state.movies.isEmpty) {
                  return const _EmptySavedState();
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    int columns = 3;
                    if (width < 380) columns = 2;
                    if (width > 900) columns = 4;
                    if (!state.grid) {
                      return ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.movies.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (_, i) {
                          final movie = state.movies[i];
                          return Dismissible(
                            key: ValueKey('saved_list_${movie.id}'),
                            direction: DismissDirection.endToStart,
                            background: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
                              ),
                            ),
                            onDismissed: (_) {
                              context.read<SavedCubit>().remove(movie.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Removed ${movie.title}'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () => context.read<SavedCubit>().undo(movie.id),
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                              leading: SizedBox(
                                width: 48,
                                child: MovieCard(movie: movie, onTap: () => context.push('/movie/${movie.id}')),
                              ),
                              title: Text(movie.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                              subtitle: Text(movie.releaseDate ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => context.push('/movie/${movie.id}'),
                            ),
                          );
                        },
                      );
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        childAspectRatio: 2 / 3.1,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: state.movies.length,
                      itemBuilder: (_, i) {
                        final movie = state.movies[i];
                        return Dismissible(
                          key: ValueKey('saved_${movie.id}'),
                          direction: DismissDirection.down,
                          background: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(Icons.delete_outline),
                          ),
                          onDismissed: (_) {
                            context.read<SavedCubit>().remove(movie.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Removed ${movie.title}'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () => context.read<SavedCubit>().undo(movie.id),
                                ),
                              ),
                            );
                          },
                          child: MovieCard(
                            movie: movie,
                            onTap: () => context.push('/movie/${movie.id}'),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptySavedState extends StatelessWidget {
  const _EmptySavedState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 72, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            'No saved movies yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the bookmark on a movie to save it here for later.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.outline),
          ),
        ],
      ),
    );
  }
}



