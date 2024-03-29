import 'package:lumiere/app/modules/movies/data/models/movie_model.dart';

final movies = {
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg",
      "genre_ids": [12, 878, 28],
      "id": 299534,
      "original_language": "en",
      "original_title": "Avengers: Endgame",
      "overview":
          "After the devastating events of Avengers: Infinity War, the universe is in ruins due to the efforts of the Mad Titan, Thanos. With the help of remaining allies, the Avengers must assemble once more in order to undo Thanos' actions and restore order to the universe once and for all, no matter what consequences may be in store.",
      "popularity": 187.059,
      "poster_path": "/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
      "release_date": "2019-04-24",
      "title": "Avengers: Endgame",
      "video": false,
      "vote_average": 8.3,
      "vote_count": 22350
    }
  ],
  "total_pages": 3,
  "total_results": 55
};

final moviesModel = [MovieModel(id: 299534, name: 'Avengers: Endgame', poster: '/or06FN3Dka5tukK1e9sl16pB3iy.jpg', date: '', overview: '')];