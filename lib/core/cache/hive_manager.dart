import 'package:hive_flutter/hive_flutter.dart';

class HiveManager<E> {
  final String boxName;

  HiveManager(this.boxName);

  late Box<E> box;

  Future<void> createBox() async {
    box = await Hive.openBox<E>(boxName);
  }

  Future<void> setBox(String key, E value) async {
    await box.put(key, value);
  }

  E? getBox(String key) {
    var data = box.get(key);
    if (data != null) {
      return data;
    } else {
      return null;
    }
  }
}
