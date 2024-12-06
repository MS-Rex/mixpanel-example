import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixpanelManager {
  static Mixpanel? _instance;

  static Future<Mixpanel> init() async {
    if (_instance == null) {
      _instance = await Mixpanel.init(dotenv.env['MIXPANEL_KEY'] ?? '',
          optOutTrackingDefault: true, trackAutomaticEvents: true);
      if (!kReleaseMode) {
        _instance?.setLoggingEnabled(true);
      }
    }
    return _instance!;
  }

  static Mixpanel get instance {
    if (_instance == null) {
      throw StateError('Mixpanel must be initialized with init() first');
    }
    return _instance!;
  }
}
