// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_db.dart';

// ignore_for_file: type=lint
class $MoviesTable extends Movies with TableInfo<$MoviesTable, DbMovie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoviesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _overviewMeta =
      const VerificationMeta('overview');
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
      'overview', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _posterPathMeta =
      const VerificationMeta('posterPath');
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
      'poster_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _backdropPathMeta =
      const VerificationMeta('backdropPath');
  @override
  late final GeneratedColumn<String> backdropPath = GeneratedColumn<String>(
      'backdrop_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _voteAverageMeta =
      const VerificationMeta('voteAverage');
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
      'vote_average', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
      'release_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _runtimeMeta =
      const VerificationMeta('runtime');
  @override
  late final GeneratedColumn<int> runtime = GeneratedColumn<int>(
      'runtime', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _genresCsvMeta =
      const VerificationMeta('genresCsv');
  @override
  late final GeneratedColumn<String> genresCsv = GeneratedColumn<String>(
      'genres_csv', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        overview,
        posterPath,
        backdropPath,
        voteAverage,
        releaseDate,
        runtime,
        genresCsv
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movies';
  @override
  VerificationContext validateIntegrity(Insertable<DbMovie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    }
    if (data.containsKey('poster_path')) {
      context.handle(
          _posterPathMeta,
          posterPath.isAcceptableOrUnknown(
              data['poster_path']!, _posterPathMeta));
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
          _backdropPathMeta,
          backdropPath.isAcceptableOrUnknown(
              data['backdrop_path']!, _backdropPathMeta));
    }
    if (data.containsKey('vote_average')) {
      context.handle(
          _voteAverageMeta,
          voteAverage.isAcceptableOrUnknown(
              data['vote_average']!, _voteAverageMeta));
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    }
    if (data.containsKey('runtime')) {
      context.handle(_runtimeMeta,
          runtime.isAcceptableOrUnknown(data['runtime']!, _runtimeMeta));
    }
    if (data.containsKey('genres_csv')) {
      context.handle(_genresCsvMeta,
          genresCsv.isAcceptableOrUnknown(data['genres_csv']!, _genresCsvMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbMovie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbMovie(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      overview: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}overview']),
      posterPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}poster_path']),
      backdropPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}backdrop_path']),
      voteAverage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}vote_average']),
      releaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}release_date']),
      runtime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}runtime']),
      genresCsv: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genres_csv']),
    );
  }

  @override
  $MoviesTable createAlias(String alias) {
    return $MoviesTable(attachedDatabase, alias);
  }
}

class DbMovie extends DataClass implements Insertable<DbMovie> {
  final int id;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final String? releaseDate;
  final int? runtime;
  final String? genresCsv;
  const DbMovie(
      {required this.id,
      this.title,
      this.overview,
      this.posterPath,
      this.backdropPath,
      this.voteAverage,
      this.releaseDate,
      this.runtime,
      this.genresCsv});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || overview != null) {
      map['overview'] = Variable<String>(overview);
    }
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String>(posterPath);
    }
    if (!nullToAbsent || backdropPath != null) {
      map['backdrop_path'] = Variable<String>(backdropPath);
    }
    if (!nullToAbsent || voteAverage != null) {
      map['vote_average'] = Variable<double>(voteAverage);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<String>(releaseDate);
    }
    if (!nullToAbsent || runtime != null) {
      map['runtime'] = Variable<int>(runtime);
    }
    if (!nullToAbsent || genresCsv != null) {
      map['genres_csv'] = Variable<String>(genresCsv);
    }
    return map;
  }

  MoviesCompanion toCompanion(bool nullToAbsent) {
    return MoviesCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      overview: overview == null && nullToAbsent
          ? const Value.absent()
          : Value(overview),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      backdropPath: backdropPath == null && nullToAbsent
          ? const Value.absent()
          : Value(backdropPath),
      voteAverage: voteAverage == null && nullToAbsent
          ? const Value.absent()
          : Value(voteAverage),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      runtime: runtime == null && nullToAbsent
          ? const Value.absent()
          : Value(runtime),
      genresCsv: genresCsv == null && nullToAbsent
          ? const Value.absent()
          : Value(genresCsv),
    );
  }

  factory DbMovie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbMovie(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      overview: serializer.fromJson<String?>(json['overview']),
      posterPath: serializer.fromJson<String?>(json['posterPath']),
      backdropPath: serializer.fromJson<String?>(json['backdropPath']),
      voteAverage: serializer.fromJson<double?>(json['voteAverage']),
      releaseDate: serializer.fromJson<String?>(json['releaseDate']),
      runtime: serializer.fromJson<int?>(json['runtime']),
      genresCsv: serializer.fromJson<String?>(json['genresCsv']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'overview': serializer.toJson<String?>(overview),
      'posterPath': serializer.toJson<String?>(posterPath),
      'backdropPath': serializer.toJson<String?>(backdropPath),
      'voteAverage': serializer.toJson<double?>(voteAverage),
      'releaseDate': serializer.toJson<String?>(releaseDate),
      'runtime': serializer.toJson<int?>(runtime),
      'genresCsv': serializer.toJson<String?>(genresCsv),
    };
  }

  DbMovie copyWith(
          {int? id,
          Value<String?> title = const Value.absent(),
          Value<String?> overview = const Value.absent(),
          Value<String?> posterPath = const Value.absent(),
          Value<String?> backdropPath = const Value.absent(),
          Value<double?> voteAverage = const Value.absent(),
          Value<String?> releaseDate = const Value.absent(),
          Value<int?> runtime = const Value.absent(),
          Value<String?> genresCsv = const Value.absent()}) =>
      DbMovie(
        id: id ?? this.id,
        title: title.present ? title.value : this.title,
        overview: overview.present ? overview.value : this.overview,
        posterPath: posterPath.present ? posterPath.value : this.posterPath,
        backdropPath:
            backdropPath.present ? backdropPath.value : this.backdropPath,
        voteAverage: voteAverage.present ? voteAverage.value : this.voteAverage,
        releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
        runtime: runtime.present ? runtime.value : this.runtime,
        genresCsv: genresCsv.present ? genresCsv.value : this.genresCsv,
      );
  DbMovie copyWithCompanion(MoviesCompanion data) {
    return DbMovie(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      overview: data.overview.present ? data.overview.value : this.overview,
      posterPath:
          data.posterPath.present ? data.posterPath.value : this.posterPath,
      backdropPath: data.backdropPath.present
          ? data.backdropPath.value
          : this.backdropPath,
      voteAverage:
          data.voteAverage.present ? data.voteAverage.value : this.voteAverage,
      releaseDate:
          data.releaseDate.present ? data.releaseDate.value : this.releaseDate,
      runtime: data.runtime.present ? data.runtime.value : this.runtime,
      genresCsv: data.genresCsv.present ? data.genresCsv.value : this.genresCsv,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbMovie(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('runtime: $runtime, ')
          ..write('genresCsv: $genresCsv')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, overview, posterPath, backdropPath,
      voteAverage, releaseDate, runtime, genresCsv);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbMovie &&
          other.id == this.id &&
          other.title == this.title &&
          other.overview == this.overview &&
          other.posterPath == this.posterPath &&
          other.backdropPath == this.backdropPath &&
          other.voteAverage == this.voteAverage &&
          other.releaseDate == this.releaseDate &&
          other.runtime == this.runtime &&
          other.genresCsv == this.genresCsv);
}

class MoviesCompanion extends UpdateCompanion<DbMovie> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> overview;
  final Value<String?> posterPath;
  final Value<String?> backdropPath;
  final Value<double?> voteAverage;
  final Value<String?> releaseDate;
  final Value<int?> runtime;
  final Value<String?> genresCsv;
  const MoviesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.overview = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.runtime = const Value.absent(),
    this.genresCsv = const Value.absent(),
  });
  MoviesCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.overview = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.runtime = const Value.absent(),
    this.genresCsv = const Value.absent(),
  });
  static Insertable<DbMovie> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? overview,
    Expression<String>? posterPath,
    Expression<String>? backdropPath,
    Expression<double>? voteAverage,
    Expression<String>? releaseDate,
    Expression<int>? runtime,
    Expression<String>? genresCsv,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (overview != null) 'overview': overview,
      if (posterPath != null) 'poster_path': posterPath,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (releaseDate != null) 'release_date': releaseDate,
      if (runtime != null) 'runtime': runtime,
      if (genresCsv != null) 'genres_csv': genresCsv,
    });
  }

  MoviesCompanion copyWith(
      {Value<int>? id,
      Value<String?>? title,
      Value<String?>? overview,
      Value<String?>? posterPath,
      Value<String?>? backdropPath,
      Value<double?>? voteAverage,
      Value<String?>? releaseDate,
      Value<int?>? runtime,
      Value<String?>? genresCsv}) {
    return MoviesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      voteAverage: voteAverage ?? this.voteAverage,
      releaseDate: releaseDate ?? this.releaseDate,
      runtime: runtime ?? this.runtime,
      genresCsv: genresCsv ?? this.genresCsv,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (runtime.present) {
      map['runtime'] = Variable<int>(runtime.value);
    }
    if (genresCsv.present) {
      map['genres_csv'] = Variable<String>(genresCsv.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoviesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('runtime: $runtime, ')
          ..write('genresCsv: $genresCsv')
          ..write(')'))
        .toString();
  }
}

class $TrendingTable extends Trending
    with TableInfo<$TrendingTable, TrendingData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrendingTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
      'page', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _movieIdMeta =
      const VerificationMeta('movieId');
  @override
  late final GeneratedColumn<int> movieId = GeneratedColumn<int>(
      'movie_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [position, page, movieId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trending';
  @override
  VerificationContext validateIntegrity(Insertable<TrendingData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('page')) {
      context.handle(
          _pageMeta, page.isAcceptableOrUnknown(data['page']!, _pageMeta));
    } else if (isInserting) {
      context.missing(_pageMeta);
    }
    if (data.containsKey('movie_id')) {
      context.handle(_movieIdMeta,
          movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta));
    } else if (isInserting) {
      context.missing(_movieIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TrendingData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrendingData(
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      page: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page'])!,
      movieId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}movie_id'])!,
    );
  }

  @override
  $TrendingTable createAlias(String alias) {
    return $TrendingTable(attachedDatabase, alias);
  }
}

class TrendingData extends DataClass implements Insertable<TrendingData> {
  final int position;
  final int page;
  final int movieId;
  const TrendingData(
      {required this.position, required this.page, required this.movieId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['position'] = Variable<int>(position);
    map['page'] = Variable<int>(page);
    map['movie_id'] = Variable<int>(movieId);
    return map;
  }

  TrendingCompanion toCompanion(bool nullToAbsent) {
    return TrendingCompanion(
      position: Value(position),
      page: Value(page),
      movieId: Value(movieId),
    );
  }

  factory TrendingData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrendingData(
      position: serializer.fromJson<int>(json['position']),
      page: serializer.fromJson<int>(json['page']),
      movieId: serializer.fromJson<int>(json['movieId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'position': serializer.toJson<int>(position),
      'page': serializer.toJson<int>(page),
      'movieId': serializer.toJson<int>(movieId),
    };
  }

  TrendingData copyWith({int? position, int? page, int? movieId}) =>
      TrendingData(
        position: position ?? this.position,
        page: page ?? this.page,
        movieId: movieId ?? this.movieId,
      );
  TrendingData copyWithCompanion(TrendingCompanion data) {
    return TrendingData(
      position: data.position.present ? data.position.value : this.position,
      page: data.page.present ? data.page.value : this.page,
      movieId: data.movieId.present ? data.movieId.value : this.movieId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrendingData(')
          ..write('position: $position, ')
          ..write('page: $page, ')
          ..write('movieId: $movieId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(position, page, movieId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrendingData &&
          other.position == this.position &&
          other.page == this.page &&
          other.movieId == this.movieId);
}

class TrendingCompanion extends UpdateCompanion<TrendingData> {
  final Value<int> position;
  final Value<int> page;
  final Value<int> movieId;
  final Value<int> rowid;
  const TrendingCompanion({
    this.position = const Value.absent(),
    this.page = const Value.absent(),
    this.movieId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrendingCompanion.insert({
    required int position,
    required int page,
    required int movieId,
    this.rowid = const Value.absent(),
  })  : position = Value(position),
        page = Value(page),
        movieId = Value(movieId);
  static Insertable<TrendingData> custom({
    Expression<int>? position,
    Expression<int>? page,
    Expression<int>? movieId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (position != null) 'position': position,
      if (page != null) 'page': page,
      if (movieId != null) 'movie_id': movieId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrendingCompanion copyWith(
      {Value<int>? position,
      Value<int>? page,
      Value<int>? movieId,
      Value<int>? rowid}) {
    return TrendingCompanion(
      position: position ?? this.position,
      page: page ?? this.page,
      movieId: movieId ?? this.movieId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (movieId.present) {
      map['movie_id'] = Variable<int>(movieId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrendingCompanion(')
          ..write('position: $position, ')
          ..write('page: $page, ')
          ..write('movieId: $movieId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NowPlayingTable extends NowPlaying
    with TableInfo<$NowPlayingTable, NowPlayingData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NowPlayingTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
      'page', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _movieIdMeta =
      const VerificationMeta('movieId');
  @override
  late final GeneratedColumn<int> movieId = GeneratedColumn<int>(
      'movie_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [position, page, movieId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'now_playing';
  @override
  VerificationContext validateIntegrity(Insertable<NowPlayingData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('page')) {
      context.handle(
          _pageMeta, page.isAcceptableOrUnknown(data['page']!, _pageMeta));
    } else if (isInserting) {
      context.missing(_pageMeta);
    }
    if (data.containsKey('movie_id')) {
      context.handle(_movieIdMeta,
          movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta));
    } else if (isInserting) {
      context.missing(_movieIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  NowPlayingData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NowPlayingData(
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      page: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page'])!,
      movieId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}movie_id'])!,
    );
  }

  @override
  $NowPlayingTable createAlias(String alias) {
    return $NowPlayingTable(attachedDatabase, alias);
  }
}

class NowPlayingData extends DataClass implements Insertable<NowPlayingData> {
  final int position;
  final int page;
  final int movieId;
  const NowPlayingData(
      {required this.position, required this.page, required this.movieId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['position'] = Variable<int>(position);
    map['page'] = Variable<int>(page);
    map['movie_id'] = Variable<int>(movieId);
    return map;
  }

  NowPlayingCompanion toCompanion(bool nullToAbsent) {
    return NowPlayingCompanion(
      position: Value(position),
      page: Value(page),
      movieId: Value(movieId),
    );
  }

  factory NowPlayingData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NowPlayingData(
      position: serializer.fromJson<int>(json['position']),
      page: serializer.fromJson<int>(json['page']),
      movieId: serializer.fromJson<int>(json['movieId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'position': serializer.toJson<int>(position),
      'page': serializer.toJson<int>(page),
      'movieId': serializer.toJson<int>(movieId),
    };
  }

  NowPlayingData copyWith({int? position, int? page, int? movieId}) =>
      NowPlayingData(
        position: position ?? this.position,
        page: page ?? this.page,
        movieId: movieId ?? this.movieId,
      );
  NowPlayingData copyWithCompanion(NowPlayingCompanion data) {
    return NowPlayingData(
      position: data.position.present ? data.position.value : this.position,
      page: data.page.present ? data.page.value : this.page,
      movieId: data.movieId.present ? data.movieId.value : this.movieId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NowPlayingData(')
          ..write('position: $position, ')
          ..write('page: $page, ')
          ..write('movieId: $movieId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(position, page, movieId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NowPlayingData &&
          other.position == this.position &&
          other.page == this.page &&
          other.movieId == this.movieId);
}

class NowPlayingCompanion extends UpdateCompanion<NowPlayingData> {
  final Value<int> position;
  final Value<int> page;
  final Value<int> movieId;
  final Value<int> rowid;
  const NowPlayingCompanion({
    this.position = const Value.absent(),
    this.page = const Value.absent(),
    this.movieId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NowPlayingCompanion.insert({
    required int position,
    required int page,
    required int movieId,
    this.rowid = const Value.absent(),
  })  : position = Value(position),
        page = Value(page),
        movieId = Value(movieId);
  static Insertable<NowPlayingData> custom({
    Expression<int>? position,
    Expression<int>? page,
    Expression<int>? movieId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (position != null) 'position': position,
      if (page != null) 'page': page,
      if (movieId != null) 'movie_id': movieId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NowPlayingCompanion copyWith(
      {Value<int>? position,
      Value<int>? page,
      Value<int>? movieId,
      Value<int>? rowid}) {
    return NowPlayingCompanion(
      position: position ?? this.position,
      page: page ?? this.page,
      movieId: movieId ?? this.movieId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (movieId.present) {
      map['movie_id'] = Variable<int>(movieId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NowPlayingCompanion(')
          ..write('position: $position, ')
          ..write('page: $page, ')
          ..write('movieId: $movieId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _movieIdMeta =
      const VerificationMeta('movieId');
  @override
  late final GeneratedColumn<int> movieId = GeneratedColumn<int>(
      'movie_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _savedAtMeta =
      const VerificationMeta('savedAt');
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
      'saved_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [movieId, savedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(Insertable<Bookmark> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('movie_id')) {
      context.handle(_movieIdMeta,
          movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta));
    }
    if (data.containsKey('saved_at')) {
      context.handle(_savedAtMeta,
          savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {movieId};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      movieId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}movie_id'])!,
      savedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}saved_at'])!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int movieId;
  final DateTime savedAt;
  const Bookmark({required this.movieId, required this.savedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['movie_id'] = Variable<int>(movieId);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      movieId: Value(movieId),
      savedAt: Value(savedAt),
    );
  }

  factory Bookmark.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      movieId: serializer.fromJson<int>(json['movieId']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'movieId': serializer.toJson<int>(movieId),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  Bookmark copyWith({int? movieId, DateTime? savedAt}) => Bookmark(
        movieId: movieId ?? this.movieId,
        savedAt: savedAt ?? this.savedAt,
      );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      movieId: data.movieId.present ? data.movieId.value : this.movieId,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('movieId: $movieId, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(movieId, savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.movieId == this.movieId &&
          other.savedAt == this.savedAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> movieId;
  final Value<DateTime> savedAt;
  const BookmarksCompanion({
    this.movieId = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.movieId = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  static Insertable<Bookmark> custom({
    Expression<int>? movieId,
    Expression<DateTime>? savedAt,
  }) {
    return RawValuesInsertable({
      if (movieId != null) 'movie_id': movieId,
      if (savedAt != null) 'saved_at': savedAt,
    });
  }

  BookmarksCompanion copyWith({Value<int>? movieId, Value<DateTime>? savedAt}) {
    return BookmarksCompanion(
      movieId: movieId ?? this.movieId,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (movieId.present) {
      map['movie_id'] = Variable<int>(movieId.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('movieId: $movieId, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }
}

class $SearchResultsTable extends SearchResults
    with TableInfo<$SearchResultsTable, SearchResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
      'query', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _movieIdMeta =
      const VerificationMeta('movieId');
  @override
  late final GeneratedColumn<int> movieId = GeneratedColumn<int>(
      'movie_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [query, position, movieId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_results';
  @override
  VerificationContext validateIntegrity(Insertable<SearchResult> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('query')) {
      context.handle(
          _queryMeta, query.isAcceptableOrUnknown(data['query']!, _queryMeta));
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('movie_id')) {
      context.handle(_movieIdMeta,
          movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta));
    } else if (isInserting) {
      context.missing(_movieIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SearchResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchResult(
      query: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}query'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      movieId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}movie_id'])!,
    );
  }

  @override
  $SearchResultsTable createAlias(String alias) {
    return $SearchResultsTable(attachedDatabase, alias);
  }
}

class SearchResult extends DataClass implements Insertable<SearchResult> {
  final String query;
  final int position;
  final int movieId;
  const SearchResult(
      {required this.query, required this.position, required this.movieId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['query'] = Variable<String>(query);
    map['position'] = Variable<int>(position);
    map['movie_id'] = Variable<int>(movieId);
    return map;
  }

  SearchResultsCompanion toCompanion(bool nullToAbsent) {
    return SearchResultsCompanion(
      query: Value(query),
      position: Value(position),
      movieId: Value(movieId),
    );
  }

  factory SearchResult.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchResult(
      query: serializer.fromJson<String>(json['query']),
      position: serializer.fromJson<int>(json['position']),
      movieId: serializer.fromJson<int>(json['movieId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'query': serializer.toJson<String>(query),
      'position': serializer.toJson<int>(position),
      'movieId': serializer.toJson<int>(movieId),
    };
  }

  SearchResult copyWith({String? query, int? position, int? movieId}) =>
      SearchResult(
        query: query ?? this.query,
        position: position ?? this.position,
        movieId: movieId ?? this.movieId,
      );
  SearchResult copyWithCompanion(SearchResultsCompanion data) {
    return SearchResult(
      query: data.query.present ? data.query.value : this.query,
      position: data.position.present ? data.position.value : this.position,
      movieId: data.movieId.present ? data.movieId.value : this.movieId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchResult(')
          ..write('query: $query, ')
          ..write('position: $position, ')
          ..write('movieId: $movieId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(query, position, movieId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchResult &&
          other.query == this.query &&
          other.position == this.position &&
          other.movieId == this.movieId);
}

class SearchResultsCompanion extends UpdateCompanion<SearchResult> {
  final Value<String> query;
  final Value<int> position;
  final Value<int> movieId;
  final Value<int> rowid;
  const SearchResultsCompanion({
    this.query = const Value.absent(),
    this.position = const Value.absent(),
    this.movieId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SearchResultsCompanion.insert({
    required String query,
    required int position,
    required int movieId,
    this.rowid = const Value.absent(),
  })  : query = Value(query),
        position = Value(position),
        movieId = Value(movieId);
  static Insertable<SearchResult> custom({
    Expression<String>? query,
    Expression<int>? position,
    Expression<int>? movieId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (query != null) 'query': query,
      if (position != null) 'position': position,
      if (movieId != null) 'movie_id': movieId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SearchResultsCompanion copyWith(
      {Value<String>? query,
      Value<int>? position,
      Value<int>? movieId,
      Value<int>? rowid}) {
    return SearchResultsCompanion(
      query: query ?? this.query,
      position: position ?? this.position,
      movieId: movieId ?? this.movieId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (movieId.present) {
      map['movie_id'] = Variable<int>(movieId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchResultsCompanion(')
          ..write('query: $query, ')
          ..write('position: $position, ')
          ..write('movieId: $movieId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MoviesTable movies = $MoviesTable(this);
  late final $TrendingTable trending = $TrendingTable(this);
  late final $NowPlayingTable nowPlaying = $NowPlayingTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $SearchResultsTable searchResults = $SearchResultsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [movies, trending, nowPlaying, bookmarks, searchResults];
}

typedef $$MoviesTableCreateCompanionBuilder = MoviesCompanion Function({
  Value<int> id,
  Value<String?> title,
  Value<String?> overview,
  Value<String?> posterPath,
  Value<String?> backdropPath,
  Value<double?> voteAverage,
  Value<String?> releaseDate,
  Value<int?> runtime,
  Value<String?> genresCsv,
});
typedef $$MoviesTableUpdateCompanionBuilder = MoviesCompanion Function({
  Value<int> id,
  Value<String?> title,
  Value<String?> overview,
  Value<String?> posterPath,
  Value<String?> backdropPath,
  Value<double?> voteAverage,
  Value<String?> releaseDate,
  Value<int?> runtime,
  Value<String?> genresCsv,
});

class $$MoviesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MoviesTable,
    DbMovie,
    $$MoviesTableFilterComposer,
    $$MoviesTableOrderingComposer,
    $$MoviesTableCreateCompanionBuilder,
    $$MoviesTableUpdateCompanionBuilder> {
  $$MoviesTableTableManager(_$AppDatabase db, $MoviesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MoviesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MoviesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> overview = const Value.absent(),
            Value<String?> posterPath = const Value.absent(),
            Value<String?> backdropPath = const Value.absent(),
            Value<double?> voteAverage = const Value.absent(),
            Value<String?> releaseDate = const Value.absent(),
            Value<int?> runtime = const Value.absent(),
            Value<String?> genresCsv = const Value.absent(),
          }) =>
              MoviesCompanion(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            releaseDate: releaseDate,
            runtime: runtime,
            genresCsv: genresCsv,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> overview = const Value.absent(),
            Value<String?> posterPath = const Value.absent(),
            Value<String?> backdropPath = const Value.absent(),
            Value<double?> voteAverage = const Value.absent(),
            Value<String?> releaseDate = const Value.absent(),
            Value<int?> runtime = const Value.absent(),
            Value<String?> genresCsv = const Value.absent(),
          }) =>
              MoviesCompanion.insert(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            releaseDate: releaseDate,
            runtime: runtime,
            genresCsv: genresCsv,
          ),
        ));
}

class $$MoviesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MoviesTable> {
  $$MoviesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get overview => $state.composableBuilder(
      column: $state.table.overview,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get posterPath => $state.composableBuilder(
      column: $state.table.posterPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get backdropPath => $state.composableBuilder(
      column: $state.table.backdropPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get voteAverage => $state.composableBuilder(
      column: $state.table.voteAverage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get releaseDate => $state.composableBuilder(
      column: $state.table.releaseDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get runtime => $state.composableBuilder(
      column: $state.table.runtime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get genresCsv => $state.composableBuilder(
      column: $state.table.genresCsv,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MoviesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MoviesTable> {
  $$MoviesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get overview => $state.composableBuilder(
      column: $state.table.overview,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get posterPath => $state.composableBuilder(
      column: $state.table.posterPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get backdropPath => $state.composableBuilder(
      column: $state.table.backdropPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get voteAverage => $state.composableBuilder(
      column: $state.table.voteAverage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get releaseDate => $state.composableBuilder(
      column: $state.table.releaseDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get runtime => $state.composableBuilder(
      column: $state.table.runtime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get genresCsv => $state.composableBuilder(
      column: $state.table.genresCsv,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TrendingTableCreateCompanionBuilder = TrendingCompanion Function({
  required int position,
  required int page,
  required int movieId,
  Value<int> rowid,
});
typedef $$TrendingTableUpdateCompanionBuilder = TrendingCompanion Function({
  Value<int> position,
  Value<int> page,
  Value<int> movieId,
  Value<int> rowid,
});

class $$TrendingTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrendingTable,
    TrendingData,
    $$TrendingTableFilterComposer,
    $$TrendingTableOrderingComposer,
    $$TrendingTableCreateCompanionBuilder,
    $$TrendingTableUpdateCompanionBuilder> {
  $$TrendingTableTableManager(_$AppDatabase db, $TrendingTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TrendingTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TrendingTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> position = const Value.absent(),
            Value<int> page = const Value.absent(),
            Value<int> movieId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TrendingCompanion(
            position: position,
            page: page,
            movieId: movieId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int position,
            required int page,
            required int movieId,
            Value<int> rowid = const Value.absent(),
          }) =>
              TrendingCompanion.insert(
            position: position,
            page: page,
            movieId: movieId,
            rowid: rowid,
          ),
        ));
}

class $$TrendingTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TrendingTable> {
  $$TrendingTableFilterComposer(super.$state);
  ColumnFilters<int> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get page => $state.composableBuilder(
      column: $state.table.page,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get movieId => $state.composableBuilder(
      column: $state.table.movieId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TrendingTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TrendingTable> {
  $$TrendingTableOrderingComposer(super.$state);
  ColumnOrderings<int> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get page => $state.composableBuilder(
      column: $state.table.page,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get movieId => $state.composableBuilder(
      column: $state.table.movieId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$NowPlayingTableCreateCompanionBuilder = NowPlayingCompanion Function({
  required int position,
  required int page,
  required int movieId,
  Value<int> rowid,
});
typedef $$NowPlayingTableUpdateCompanionBuilder = NowPlayingCompanion Function({
  Value<int> position,
  Value<int> page,
  Value<int> movieId,
  Value<int> rowid,
});

class $$NowPlayingTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NowPlayingTable,
    NowPlayingData,
    $$NowPlayingTableFilterComposer,
    $$NowPlayingTableOrderingComposer,
    $$NowPlayingTableCreateCompanionBuilder,
    $$NowPlayingTableUpdateCompanionBuilder> {
  $$NowPlayingTableTableManager(_$AppDatabase db, $NowPlayingTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$NowPlayingTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$NowPlayingTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> position = const Value.absent(),
            Value<int> page = const Value.absent(),
            Value<int> movieId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NowPlayingCompanion(
            position: position,
            page: page,
            movieId: movieId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int position,
            required int page,
            required int movieId,
            Value<int> rowid = const Value.absent(),
          }) =>
              NowPlayingCompanion.insert(
            position: position,
            page: page,
            movieId: movieId,
            rowid: rowid,
          ),
        ));
}

class $$NowPlayingTableFilterComposer
    extends FilterComposer<_$AppDatabase, $NowPlayingTable> {
  $$NowPlayingTableFilterComposer(super.$state);
  ColumnFilters<int> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get page => $state.composableBuilder(
      column: $state.table.page,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get movieId => $state.composableBuilder(
      column: $state.table.movieId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$NowPlayingTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $NowPlayingTable> {
  $$NowPlayingTableOrderingComposer(super.$state);
  ColumnOrderings<int> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get page => $state.composableBuilder(
      column: $state.table.page,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get movieId => $state.composableBuilder(
      column: $state.table.movieId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$BookmarksTableCreateCompanionBuilder = BookmarksCompanion Function({
  Value<int> movieId,
  Value<DateTime> savedAt,
});
typedef $$BookmarksTableUpdateCompanionBuilder = BookmarksCompanion Function({
  Value<int> movieId,
  Value<DateTime> savedAt,
});

class $$BookmarksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BookmarksTable,
    Bookmark,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder> {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BookmarksTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BookmarksTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> movieId = const Value.absent(),
            Value<DateTime> savedAt = const Value.absent(),
          }) =>
              BookmarksCompanion(
            movieId: movieId,
            savedAt: savedAt,
          ),
          createCompanionCallback: ({
            Value<int> movieId = const Value.absent(),
            Value<DateTime> savedAt = const Value.absent(),
          }) =>
              BookmarksCompanion.insert(
            movieId: movieId,
            savedAt: savedAt,
          ),
        ));
}

class $$BookmarksTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer(super.$state);
  ColumnFilters<int> get movieId => $state.composableBuilder(
      column: $state.table.movieId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get savedAt => $state.composableBuilder(
      column: $state.table.savedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$BookmarksTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer(super.$state);
  ColumnOrderings<int> get movieId => $state.composableBuilder(
      column: $state.table.movieId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get savedAt => $state.composableBuilder(
      column: $state.table.savedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SearchResultsTableCreateCompanionBuilder = SearchResultsCompanion
    Function({
  required String query,
  required int position,
  required int movieId,
  Value<int> rowid,
});
typedef $$SearchResultsTableUpdateCompanionBuilder = SearchResultsCompanion
    Function({
  Value<String> query,
  Value<int> position,
  Value<int> movieId,
  Value<int> rowid,
});

class $$SearchResultsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SearchResultsTable,
    SearchResult,
    $$SearchResultsTableFilterComposer,
    $$SearchResultsTableOrderingComposer,
    $$SearchResultsTableCreateCompanionBuilder,
    $$SearchResultsTableUpdateCompanionBuilder> {
  $$SearchResultsTableTableManager(_$AppDatabase db, $SearchResultsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SearchResultsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SearchResultsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> query = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> movieId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SearchResultsCompanion(
            query: query,
            position: position,
            movieId: movieId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String query,
            required int position,
            required int movieId,
            Value<int> rowid = const Value.absent(),
          }) =>
              SearchResultsCompanion.insert(
            query: query,
            position: position,
            movieId: movieId,
            rowid: rowid,
          ),
        ));
}

class $$SearchResultsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SearchResultsTable> {
  $$SearchResultsTableFilterComposer(super.$state);
  ColumnFilters<String> get query => $state.composableBuilder(
      column: $state.table.query,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get movieId => $state.composableBuilder(
      column: $state.table.movieId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SearchResultsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SearchResultsTable> {
  $$SearchResultsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get query => $state.composableBuilder(
      column: $state.table.query,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get movieId => $state.composableBuilder(
      column: $state.table.movieId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MoviesTableTableManager get movies =>
      $$MoviesTableTableManager(_db, _db.movies);
  $$TrendingTableTableManager get trending =>
      $$TrendingTableTableManager(_db, _db.trending);
  $$NowPlayingTableTableManager get nowPlaying =>
      $$NowPlayingTableTableManager(_db, _db.nowPlaying);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$SearchResultsTableTableManager get searchResults =>
      $$SearchResultsTableTableManager(_db, _db.searchResults);
}
