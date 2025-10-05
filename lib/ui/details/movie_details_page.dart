import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/injection.dart';
import '../../core/util/images_urls.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../core/constants/constants.dart';
import 'details_cubit.dart';

/// Movie details page that displays comprehensive information about a selected movie.
/// 
/// This page shows:
/// - Movie poster with hero animation for smooth transitions
/// - Title, rating, and basic information
/// - Runtime, release date, and genres
/// - Overview/synopsis
/// - Action buttons (Save, Share, Trailer)
/// 
/// The page integrates with the deep link system to allow users to share
/// movies with friends using custom deep links.
class MovieDetailsPage extends StatelessWidget {
  /// The unique identifier of the movie to display.
  final int id;
  
  /// Creates a new MovieDetailsPage instance.
  /// 
  /// [id] - The unique identifier of the movie to display.
  const MovieDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailsCubit(getIt<MovieRepository>(), id),
      child: WillPopScope(
        onWillPop: () async {
          if (context.canPop()) return true;
          context.go('/');
          return false;
        },
        child: SafeArea(
          top: false,
          bottom: true,
          child: Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.details),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/');
                }
              },
            ),
          ),
          body: BlocBuilder<DetailsCubit, DetailsState>(
            builder: (context, state) {
              final m = state.movie;

              print(m?.id.toString());

              // Show loading indicator while fetching movie data
              if (state.loading && m == null) return const Center(child: CircularProgressIndicator());

              // Show error state if movie data couldn't be loaded
              if (m == null) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(AppStrings.notFound),
                  ),
                );
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Movie poster with hero animation for smooth transitions
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: HeroListUtils.createMoviePosterHero(
                      movieId: m.id.toString(),
                      index: 2, // Fixed index for MovieDetailsPage to ensure unique hero tags
                      child: SizedBox(
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: posterUrl(m.posterPath, size: 'w1280'),
                          fit: BoxFit.contain,
                          placeholder: (context, _) => Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white,
                            child: const ColoredBox(color: Colors.black12),
                          ),
                          errorWidget: (context, _, __) => const ColoredBox(color: Colors.black12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Movie title with bold styling
                  Text(
                    m.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Visual rating bar (only shown if rating exists)
                  if (m.voteAverage != null) _RatingBar(rating10: m.voteAverage!),
                  const SizedBox(height: 8),

                  // Information chips showing rating, runtime, and release date
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (m.voteAverage != null)
                        Chip(
                          avatar: const Icon(Icons.star, size: 18, color: Colors.amber),
                          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                          label: Text('${m.voteAverage!.toStringAsFixed(1)}/10'),
                        ),
                      if (m.runtime != null)
                        Chip(
                          avatar: const Icon(Icons.timer_outlined, size: 18),
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          label: Text('${m.runtime} ${AppStrings.minutes}'),
                        ),
                      if (m.releaseDate != null)
                        Chip(
                          avatar: const Icon(Icons.event, size: 18),
                          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                          label: Text(m.releaseDate!),
                        ),
                    ],
                  ),
                  // Movie overview/synopsis (only shown if available)
                  if (m.overview?.isNotEmpty == true) Text(m.overview!),
                  const SizedBox(height: 12),

                  // Genre chips (only shown if genres exist)
                  if (m.genres.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: m.genres
                          .map((g) => Chip(
                                label: Text(g),
                                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                              ))
                          .toList(),
                    ),
                  const SizedBox(height: 24),

                  // Action buttons (wrap to avoid overflow on small screens)
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      // Save/Unsave button with dynamic icon and text
                      FilledButton.icon(
                        onPressed: () => context.read<DetailsCubit>().toggle(),
                        icon: Icon(state.isSaved ? Icons.bookmark : Icons.bookmark_border),
                        label: Text(state.isSaved ? AppStrings.saved : AppStrings.save),
                      ),

                      // Share button that creates deep links for sharing
                      OutlinedButton.icon(
                        onPressed: () => Share.share(
                          DeepLinkUtils.createShareMessage(m.id),
                          subject: AppStrings.shareMovieSubject,
                        ),
                        icon: const Icon(Icons.share),
                        label: Text(AppStrings.share),
                      ),

                      // Trailer button that searches YouTube for movie trailers
                      OutlinedButton.icon(
                        onPressed: () async {
                          // Create search query with movie title and "trailer" keyword
                          final q = Uri.encodeComponent('${m.title} ${AppStrings.trailer.toLowerCase()}');
                          final url = Uri.parse('https://www.youtube.com/results?search_query=$q');

                          // Launch YouTube search in external browser
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        },
                        icon: const Icon(Icons.ondemand_video),
                        label: Text(AppStrings.trailer),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
                ),
        ),
      ),
    );
  }
}

/// A visual rating bar that displays movie ratings using star icons.
/// 
/// This widget converts a 10-point rating scale to a 5-star visual representation.
/// It shows filled stars, half stars, and empty stars based on the rating value.
/// 
/// Example:
/// - Rating 8.5/10 → 4 filled stars + 1 half star
/// - Rating 6.0/10 → 3 filled stars + 2 empty stars
class _RatingBar extends StatelessWidget {
  /// The movie rating on a 10-point scale (e.g., 8.5, 7.0).
  final double rating10;
  
  /// Creates a new RatingBar instance.
  /// 
  /// [rating10] - The movie rating on a 10-point scale.
  const _RatingBar({required this.rating10});

  @override
  Widget build(BuildContext context) {
    // Convert 10-point rating to 5-star scale and clamp to valid range
    final rating5 = (rating10 / 2).clamp(0, 5);
    
    return Row(
      children: List.generate(5, (i) {
        // Determine which star icon to show based on the rating
        final icon = rating5 >= i + 1
            ? Icons.star                    // Full star for complete ratings
            : (rating5 > i && rating5 < i + 1 
                ? Icons.star_half           // Half star for partial ratings
                : Icons.star_border);       // Empty star for no rating
        
        return Icon(
          icon, 
          color: Colors.amber, 
          size: 20,
        );
      }),
    );
  }
}

// Removed placeholder widget; runtime/genres are now persisted and shown inline.
