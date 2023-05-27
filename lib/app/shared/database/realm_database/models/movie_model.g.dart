// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class MovieModel extends _MovieModel
    with RealmEntity, RealmObjectBase, RealmObject {
  MovieModel(
    int date,
    String movie,
  ) {
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'movie', movie);
  }

  MovieModel._();

  @override
  int get date => RealmObjectBase.get<int>(this, 'date') as int;
  @override
  set date(int value) => RealmObjectBase.set(this, 'date', value);

  @override
  String get movie => RealmObjectBase.get<String>(this, 'movie') as String;
  @override
  set movie(String value) => RealmObjectBase.set(this, 'movie', value);

  @override
  Stream<RealmObjectChanges<MovieModel>> get changes =>
      RealmObjectBase.getChanges<MovieModel>(this);

  @override
  MovieModel freeze() => RealmObjectBase.freezeObject<MovieModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(MovieModel._);
    return const SchemaObject(
        ObjectType.realmObject, MovieModel, 'MovieModel', [
      SchemaProperty('date', RealmPropertyType.int),
      SchemaProperty('movie', RealmPropertyType.string),
    ]);
  }
}
