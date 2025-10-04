import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/db/drift_db.dart';
import '../../core/di/injection.dart';
import '../../domain/repositories/movie_repository.dart';
import '../widgets/movie_card.dart';
import '../widgets/section_skeleton.dart';
import 'now_playing_cubit.dart';
import 'trending_cubit.dart';

enum SectionType { trending, nowPlaying }

class SectionListPage extends StatefulWidget {
  final SectionType type;
  const SectionListPage({super.key, required this.type});

  @override
  State<SectionListPage> createState() => _SectionListPageState();
}

class _SectionListPageState extends State<SectionListPage> {
  String sort = 'default'; // default | title | date
  int? year; // release year filter
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 300) {
      if (widget.type == SectionType.trending) {
        if (mounted) context.read<TrendingCubit>().loadMore();
      } else {
        if (mounted) context.read<NowPlayingCubit>().loadMore();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.type == SectionType.trending ? 'Trending' : 'Now Playing';
    return MultiBlocProvider(
      providers: [
        if (widget.type == SectionType.trending) BlocProvider(create: (_) => TrendingCubit(getIt<MovieRepository>())),
        if (widget.type == SectionType.nowPlaying) BlocProvider(create: (_) => NowPlayingCubit(getIt<MovieRepository>())),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: RefreshIndicator(
          onRefresh: () async {
            if (widget.type == SectionType.trending) {
              await context.read<TrendingCubit>().refresh();
            } else {
              await context.read<NowPlayingCubit>().refresh();
            }
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _FilterBarDelegate(
                  child: _FilterBar(
                    sort: sort,
                    year: year,
                    onSortChanged: (v) => setState(() => sort = v),
                    onYearChanged: (y) => setState(() => year = y),
                    onClearYear: () => setState(() => year = null),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: widget.type == SectionType.trending
                    ? _TrendingList(sort: sort, year: year)
                    : _NowPlayingList(sort: sort, year: year),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrendingList extends StatelessWidget {
  final String sort;
  final int? year;
  const _TrendingList({this.sort = 'default', this.year});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingCubit, TrendingState>(
      builder: (context, state) {
        if (state.loading && state.movies.isEmpty) return const SliverToBoxAdapter(child: HorizontalCardsSkeleton());
        final filtered = _filterAndSort(state.movies, sort, year);
        return SliverGrid(
          delegate: SliverChildBuilderDelegate((_, i) {
            if (i >= filtered.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final m = filtered[i];
            return MovieCard(movie: m, onTap: () => context.push('/movie/${m.id}'));
          }, childCount: filtered.length + (state.loading ? 1 : 0)),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 2 / 3, crossAxisSpacing: 12, mainAxisSpacing: 12,
          ),
        );
      },
    );
  }
}

class _NowPlayingList extends StatelessWidget {
  final String sort;
  final int? year;
  const _NowPlayingList({this.sort = 'default', this.year});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        if (state.loading && state.movies.isEmpty) return const SliverToBoxAdapter(child: HorizontalCardsSkeleton());
        final filtered = _filterAndSort(state.movies, sort, year);
        return SliverGrid(
          delegate: SliverChildBuilderDelegate((_, i) {
            if (i >= filtered.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final m = filtered[i];
            return MovieCard(movie: m, onTap: () => context.push('/movie/${m.id}'));
          }, childCount: filtered.length + (state.loading ? 1 : 0)),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 2 / 3, crossAxisSpacing: 12, mainAxisSpacing: 12,
          ),
        );
      },
    );
  }
}

List<MovieRow> _filterAndSort(List<MovieRow> input, String sort, int? year) {
  var list = input;
  if (year != null) {
    list = list.where((m) => (m.releaseDate ?? '').startsWith(year.toString())).toList();
  }
  if (sort == 'title') {
    list.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  } else if (sort == 'date') {
    list.sort((a, b) => (b.releaseDate ?? '').compareTo(a.releaseDate ?? ''));
  }
  return list;
}

class _FilterBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _FilterBarDelegate({required this.child});
  @override
  double get minExtent => 48;
  @override
  double get maxExtent => 48;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => Material(
    color: Theme.of(context).scaffoldBackgroundColor,
    elevation: overlapsContent ? 1 : 0,
    child: child,
  );
  @override
  bool shouldRebuild(covariant _FilterBarDelegate oldDelegate) => false;
}

class _FilterBar extends StatelessWidget {
  final String sort;
  final int? year;
  final ValueChanged<String> onSortChanged;
  final ValueChanged<int?> onYearChanged;
  final VoidCallback onClearYear;
  const _FilterBar({required this.sort, required this.year, required this.onSortChanged, required this.onYearChanged, required this.onClearYear});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            PopupMenuButton<String>(
              tooltip: 'Sort',
              onSelected: onSortChanged,
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'default', child: Text('Default')),
                PopupMenuItem(value: 'title', child: Text('Title A-Z')),
                PopupMenuItem(value: 'date', child: Text('Release date')),
              ],
              child: Chip(avatar: const Icon(Icons.sort), label: Text(_sortLabel(sort))),
            ),
            const SizedBox(width: 8),
            ActionChip(
              avatar: const Icon(Icons.event),
              label: Text(year?.toString() ?? 'Year'),
              onPressed: () async {
                final y = await _pickYear(context, initialYear: year);
                onYearChanged(y);
              },
            ),
            if (year != null) ...[
              const SizedBox(width: 4),
              IconButton(tooltip: 'Clear year', icon: const Icon(Icons.clear), onPressed: onClearYear),
            ],
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

String _sortLabel(String s) => s == 'title' ? 'Title A-Z' : s == 'date' ? 'Release date' : 'Default';

Future<int?> _pickYear(BuildContext context, {int? initialYear}) async {
  final now = DateTime.now().year;
  final years = List.generate(30, (i) => now - i);
  return showModalBottomSheet<int>(
    context: context,
    builder: (context) => SafeArea(
      child: ListView.builder(
        itemCount: years.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(years[i].toString()),
          onTap: () => Navigator.pop(context, years[i]),
        ),
      ),
    ),
  );
}


