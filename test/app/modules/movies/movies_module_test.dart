import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumiere/app/modules/movies/movies_module.dart';
 
void main() {

  setUpAll(() {
    initModule(MoviesModule());
  });
}