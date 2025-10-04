import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/injection.dart';
import '../../domain/repositories/movie_repository.dart';
import '../widgets/movie_card.dart';
import '../widgets/section_skeleton.dart';
import 'search_bloc.dart';
import 'search_content.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(getIt<MovieRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
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
        body: const SearchContent(),
      ),
    );
  }
}
