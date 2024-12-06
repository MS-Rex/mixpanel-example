import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class AnalyticsClient {
  const AnalyticsClient(this._mixpanel);
  final Mixpanel _mixpanel;

  Future<void> track(
    String name, {
    Map<String, dynamic> params = const {},
  }) async {
    if (kReleaseMode) {
      await _mixpanel.track(name, properties: params);
    } else {
      //If you want to try out and see it works, You can Uncomment below
      // await _mixpanel.track(name, properties: params);
      log('$name $params', name: 'Event');
    }
  }
}
