import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/injection.dart';
import '../../domain/repositories/movie_repository.dart';
import '../widgets/movie_card.dart';
import 'saved_cubit.dart';
import 'saved_content.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SavedCubit(getIt<MovieRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Saved'),
          actions: [
            Builder(
              builder: (inner) => IconButton(
                tooltip: 'Toggle layout',
                onPressed: () => inner.read<SavedCubit>().toggleLayout(),
                icon: BlocBuilder<SavedCubit, SavedState>(
                  builder: (context, state) => Icon(state.grid ? Icons.view_list_outlined : Icons.grid_view),
                ),
              ),
            ),
            Builder(
              builder: (inner) => PopupMenuButton<String>(
                onSelected: (v) async {
                  final cubit = inner.read<SavedCubit>();
                  if (v == 'title') cubit.setSort(SavedSort.titleAsc);
                  else if (v == 'date') cubit.setSort(SavedSort.dateDesc);
                  else if (v == 'clear') {
                    final ok = await showDialog<bool>(
                      context: inner,
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
                      if (inner.mounted) {
                        ScaffoldMessenger.of(inner).showSnackBar(const SnackBar(content: Text('Cleared saved movies')));
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
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: 2,
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
            NavigationDestination(icon: Icon(Icons.bookmark), label: 'Saved'),
          ],
        ),
        body: const SavedContent(),
      ),
    );
  }
}
