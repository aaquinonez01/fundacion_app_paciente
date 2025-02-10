import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'key_value_storage_service.dart';

class KeyValueStorageServiceImpl implements KeyValueStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    if (value is String) {
      await _storage.write(key: key, value: value);
    } else {
      throw UnimplementedError(
          'No está implementado para el tipo ${T.runtimeType}');
    }
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final value = await _storage.read(key: key);

    if (value == null) return null;

    if (T == String) {
      return value as T;
    } else {
      throw UnimplementedError(
          'No está implementado para el tipo ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    await _storage.delete(key: key);
    return true;
  }
}
