import 'package:flutter/material.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/modules/home/presenter/page/widgets/movieTile/movie_tile.dart';

class ListMoviesWidget extends StatefulWidget {
  final List<HomeMovieEntity> movies;
  const ListMoviesWidget({
    super.key,
    required this.movies,
  });

  @override
  State<ListMoviesWidget> createState() => _ListMoviesWidgetState();
}

void doNothing(BuildContext context) {}

class _ListMoviesWidgetState extends State<ListMoviesWidget> {
 
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.movies.length,
      itemBuilder: (BuildContext context, int index) {
        final HomeMovieEntity movie = widget.movies[index];
        return SizedBox(
          child: MovieTile(
            movie: movie,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 8,
        );
      },
    );
  }
}
