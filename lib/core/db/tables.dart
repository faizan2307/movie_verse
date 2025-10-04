import 'package:drift/drift.dart';

@DataClassName('DbMovie')
class Movies extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text().nullable()();
  TextColumn get overview => text().nullable()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get backdropPath => text().nullable()();
  RealColumn get voteAverage => real().nullable()();
  TextColumn get releaseDate => text().nullable()();
  IntColumn get runtime => integer().nullable()();
  TextColumn get genresCsv => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class Trending extends Table {
  IntColumn get position => integer()();
  IntColumn get page => integer()();
  IntColumn get movieId => integer()();
}

class NowPlaying extends Table {
  IntColumn get position => integer()();
  IntColumn get page => integer()();
  IntColumn get movieId => integer()();
}

class Bookmarks extends Table {
  IntColumn get movieId => integer()();
  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column> get primaryKey => {movieId};
}

class SearchResults extends Table {
  TextColumn get query => text()();
  IntColumn get position => integer()();
  IntColumn get movieId => integer()();
}
