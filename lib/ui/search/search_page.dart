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
        body: const SearchContent(),
      ),
    );
  }
}
