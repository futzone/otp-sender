import 'package:flutter/material.dart';
import 'package:on_otp_sender/db_services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final durationController = TextEditingController();
  final getController = TextEditingController();
  final postController = TextEditingController();
  final headersController = TextEditingController();

  void getSMSPermission() async {
    final status = await Permission.sms.status;
    if (!status.isGranted) await Permission.sms.request();
  }

  void getInitialData() async {
    getController.text = await UniversalDatabase.getData("get") ?? "";
    postController.text = await UniversalDatabase.getData("post") ?? "";
    durationController.text = await UniversalDatabase.getData("time") ?? "";
  }

  @override
  void initState() {
    super.initState();
    getSMSPermission();
    getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "OTP sender",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await launchUrlString("urlString");
            },
            icon: const Icon(Icons.help_outline),
            color: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
        child: Column(
          children: [
            TextField(
              controller: durationController,
              decoration: const InputDecoration(
                labelText: 'Interval (seconds)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: getController,
              decoration: const InputDecoration(
                labelText: 'Get request url',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: postController,
              decoration: const InputDecoration(
                labelText: 'Post result url',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: headersController,
              decoration: const InputDecoration(
                labelText: 'Headers (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  UniversalDatabase.saveData("get", getController.text);
                  UniversalDatabase.saveData("post", postController.text);
                  UniversalDatabase.saveData("time", durationController.text);
                  UniversalDatabase.saveData("headers", headersController.text);
                },
                child: const Text("Save"),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "NOTE: After saved changes, restart app: remove from opened apps list and open app again!",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
