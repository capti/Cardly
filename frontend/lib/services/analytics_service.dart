import 'package:appmetrica_plugin/appmetrica_plugin.dart';

class AnalyticsService {
  static const String _apiKey = '9b0749c4-7f6c-4b03-a593-caef66f15f41';
  
  static Future<void> initialize() async {
    await AppMetrica.activate(AppMetricaConfig(_apiKey));
  }

  static void trackScreenView(String screenName) {
    AppMetrica.reportEvent('screen_view_$screenName');
  }

  static void trackCardGeneration() {
    AppMetrica.reportEvent('card_generation_started');
  }

  static void trackCardGenerationComplete() {
    AppMetrica.reportEvent('card_generation_complete');
  }

  static void trackExchange() {
    AppMetrica.reportEvent('exchange_started');
  }

  static void trackExchangeComplete() {
    AppMetrica.reportEvent('exchange_complete');
  }

  static void reportError(String errorName, Object error, [StackTrace? stackTrace]) {
    AppMetrica.reportError(
      message: errorName,
      errorDescription: AppMetricaErrorDescription.fromObjectAndStackTrace(
        error,
        stackTrace ?? StackTrace.current,
      ),
    );
  }
} 