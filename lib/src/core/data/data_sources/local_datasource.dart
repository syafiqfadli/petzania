import 'package:get_storage/get_storage.dart';

abstract class LocalDataSource {
  T? get<T>(String key);
  Future<void> store<T>(String key, T data);
  bool has(String key);
  Future<void> remove(String key);
  Future<void> reset();
}

class LocalDataSourceImpl implements LocalDataSource {
  final GetStorage storage;

  LocalDataSourceImpl({required this.storage});

  @override
  T? get<T>(String key) {
    return storage.read<T>(key);
  }

  @override
  Future<void> store<T>(String key, T data) async {
    await storage.write(key, data);
  }

  @override
  Future<void> remove(String key) async {
    await storage.remove(key);
  }

  @override
  bool has(String key) {
    return storage.hasData(key);
  }

  @override
  Future<void> reset() async {
    await storage.erase();
  }
}
