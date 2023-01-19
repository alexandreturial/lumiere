
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment{

  static String get filename {

    if(kReleaseMode){
      return '.env';
    }else if(kDebugMode){
      return '.env';
    }

    return '.env';
  }

  static String get apiUrl {
    
    return dotenv.get('API_URL');
  }

  static String get apiKey {
    return dotenv.get('API_KEY');
  }

}