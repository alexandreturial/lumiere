import 'package:lumiere/app/shared/database/realm_database/models/movie_model.dart';
import 'package:realm/realm.dart';

LocalConfiguration config = Configuration.local(
  [MovieModel.schema],
  initialDataCallback: (realm){},
  schemaVersion: 2,
);


