import 'dart:developer';

import 'package:background_sms/background_sms.dart';
import 'package:dio/dio.dart';
import 'package:on_otp_sender/db_services.dart';

class ApiServices {
  Future<void> sendMessages(String post, String get) async {
    await getOts(get).then((list) async {
      for (final item in list) {
        await BackgroundSms.sendMessage(
                phoneNumber: item.phone, message: item.code)
            .then((_) async => await setSuccess(item.phone, post));
      }
    });
  }

  Future<List<Otp>> getOts(String url) async {
    final token = await UniversalDatabase.getData("headers");
    final headers = {"Authorization": "Bearer $token"};
    List<Otp> list = [];
    try {
      Dio dio = Dio(BaseOptions(headers: headers));
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        log("get status 200");
        for (final item in response.data) {
          list.add(Otp("${item['code']}", item['phone']));
        }
      }
    } catch (error) {
      log(error.toString());
    }

    return list;
  }

  Future<void> setSuccess(String phone, String url) async {
    final fp = phone.replaceAll("+", "");
    final token = await UniversalDatabase.getData("headers");
    final headers = {"Authorization": "Bearer $token"};
    try {
      Dio dio = Dio(BaseOptions(headers: headers));
      await dio.post("$url%2B$fp").then((value) {
        log(value.data.toString());
        log("delete status ${value.statusCode}");
      });
    } catch (error) {
      log(error.toString());
    }
  }
}

class Otp {
  String code;
  String phone;

  Otp(this.code, this.phone);
}
