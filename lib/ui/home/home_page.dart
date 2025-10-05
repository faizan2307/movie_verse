import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/di/injection.dart';
import '../../domain/repositories/movie_repository.dart';
import 'trending_cubit.dart';
import 'now_playing_cubit.dart';
import 'home_content.dart';

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
            shaderCallback:
                (bounds) => AppColors.primaryGradient.createShader(bounds),
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
        body: const HomeContent(),
      ),
    );
  }
}
