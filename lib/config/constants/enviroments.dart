import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
    print('API_URL: ${dotenv.env['API_URL_DEVELOPMENT']}');
  }

  static String apiUrl =
      dotenv.env['API_URL_DEVELOPMENT'] ?? 'No está configurado el API_URL';
}
