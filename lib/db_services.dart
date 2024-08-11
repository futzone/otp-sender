import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

class UniversalDatabase {
  static const String boxName = 'app_data';

  static Future<dynamic> getData(String key) async {
    var box = await Hive.openBox(boxName);
    final data = box.get(key);
    return data;
  }

  static Future<void> saveData(String key, dynamic data) async {
    var box = await Hive.openBox(boxName);
    await box.put(key, data);
    log("$key saved");
  }

  static Future<void> deleteData(String key) async {
    var box = await Hive.openBox(boxName);
    await box.delete(key);
  }
}
