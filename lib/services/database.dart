import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

typedef Json = Map<String, dynamic>;

abstract class NoSQLDB {
  Future<void> open();
  Future<bool> save(String key, Json item);
  Future<bool> delete(String key);
  Future<Json?> get(String key);
  Future<Json?> findOne(EqualQuery query);
  void close();
  Future<int> getCount();
  Future<List<Json>> find({int? offset, int? limit});
}

class SembastDB extends NoSQLDB {
  late Database _database;
  final StoreRef<String, Json> _storeRef;
  final String path;

  SembastDB(this.path) : _storeRef = StoreRef.main();

  @override
  Future<void> open() async {
    late DatabaseFactory dbFactory;
    if (kIsWeb) {
      dbFactory = databaseFactoryWeb;
    } else {
      dbFactory = databaseFactoryIo;
    }
    String dbPath = path;
    if (!kIsWeb) {
      Directory directory = await getApplicationDocumentsDirectory();
      dbPath = join(directory.path, path);
    }
    _database = await dbFactory.openDatabase(dbPath);
  }

  @override
  Future<bool> save(String key, Json item) async {
    await _storeRef.record(key).put(_database, item);
    return true;
  }

  @override
  Future<Json?> get(String key) async {
    return _storeRef.record(key).get(_database);
  }

  @override
  Future<bool> delete(String key) async {
    await _storeRef.record(key).delete(_database);
    return true;
  }

  @override
  Future<List<Json>> find({int? offset, int? limit}) async {
    final data = await _storeRef.find(_database,
        finder: Finder(limit: limit, offset: offset));
    return data.map((e) => e.value).toList();
  }

  @override
  Future<int> getCount() async {
    return await _storeRef.count(_database);
  }

  @override
  void close() {
    _database.close();
  }

  @override
  Future<Json?> findOne(EqualQuery query) async {
    final snapshot = await _storeRef.findFirst(_database,
        finder: Finder(filter: Filter.equals(query.key, query.value)));
    if (snapshot != null) {
      return snapshot.value;
    }
    return null;
  }
}

class MockDB extends NoSQLDB {
  final Map<String, Json> _items = {};

  @override
  void close() {}

  @override
  Future<bool> delete(String key) async {
    _items.remove(key);
    return true;
  }

  @override
  Future<List<Json>> find({int? offset, int? limit}) async {
    return _items.values.skip(offset ?? 0).take(limit ?? 0).toList();
  }

  @override
  Future<Json?> get(String key) async {
    return _items[key];
  }

  @override
  Future<int> getCount() async {
    return _items.keys.length;
  }

  @override
  Future<void> open() async {}

  @override
  Future<bool> save(String key, Json item) async {
    _items[key] = item;
    return true;
  }

  @override
  Future<Json?> findOne(EqualQuery query) async {
    for (Json value in _items.values) {
      if (value[query.key] == query.value) {
        return value;
      }
    }
    return null;
  }
}

class EqualQuery {
  final String key;
  final Object value;

  EqualQuery(this.key, this.value);
}
