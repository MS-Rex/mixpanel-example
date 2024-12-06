import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mixpanel_example/monitoring/analytics_client.dart';
import 'package:mixpanel_example/monitoring/mixpanel_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await MixpanelManager.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Mainpage());
  }
}

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final AnalyticsClient _mixpanel = AnalyticsClient(MixpanelManager.instance);
  bool isEnable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Mixpanel Example...'),
          ),
          Switch(
              value: isEnable,
              onChanged: (val) {
                isEnable = !isEnable;
                _onSwitchChanged(val);
              }),
          ElevatedButton(
            onPressed: () {
              unawaited(_mixpanel.track('Button Test', params: {
                'page': "MainPage",
              }));
            },
            child: const Text('Track Event'),
          ),
        ],
      ),
    );
  }

  void _onSwitchChanged(bool value) {
    if (value) {
      _handleOptIn();
    } else {
      _handleOptOut();
    }
    setState(() {
      isEnable = value;
    });
  }
}

void _handleOptIn() {
  MixpanelManager.instance.optInTracking();
}

void _handleOptOut() {
  MixpanelManager.instance.optOutTracking();
}
