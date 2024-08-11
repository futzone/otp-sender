import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_otp_sender/api_services.dart';
import 'package:on_otp_sender/db_services.dart';

import 'main_page.dart';

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  await Hive.initFlutter();

  final dur = await UniversalDatabase.getData("time");
  final post = await UniversalDatabase.getData("post") ?? "";
  final get = await UniversalDatabase.getData("get") ?? "";
  final duration = int.parse(dur ?? "30");
  Timer.periodic(Duration(seconds: duration), (timer) async {
    await ApiServices().sendMessages(post, get);
  });
}

Future<void> initServices() async {
  log("Flutter background services initialized!");
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTP sender',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
