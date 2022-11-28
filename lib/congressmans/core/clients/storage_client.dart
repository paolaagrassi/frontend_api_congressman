// ignore_for_file: unnecessary_await_in_return

import 'package:localstorage/localstorage.dart';

abstract class LocalStorageClient {
  Future<dynamic> get(String key);

  Future<void> set(String key, String data);
}

class StorageClientImpl implements LocalStorageClient {
  final LocalStorage storage;

  StorageClientImpl(this.storage);

  @override
  Future<dynamic> get(String key) async {
    await storage.ready;
    return await storage.getItem(key);
  }

  @override
  Future<void> set(String key, String data) async {
    await storage.ready;

    return await storage.setItem(key, data, (object) {
      return object;
    });
  }
}
