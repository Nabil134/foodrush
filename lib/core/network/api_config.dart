
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig{
  ApiConfig._();
  static String get apiKey{
    return dotenv.env["STRIPE_PUBLISHABLE_KEY"]??"";
  }
}