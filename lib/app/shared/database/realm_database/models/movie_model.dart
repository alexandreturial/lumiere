// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:realm/realm.dart';  // import realm package

part 'movie_model.g.dart'; // declare a part file.

@RealmModel() // define a data model class named `_Car`.
class _MovieModel {
    late int date;
    late String movie;
}
