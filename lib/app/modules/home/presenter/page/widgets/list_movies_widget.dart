import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/modules/home/presenter/page/widgets/movieTile/movie_tile.dart';
import 'package:lumiere/app/utils/responsive.dart';

class ListMoviesWidget extends StatefulWidget {
  final List<HomeMovieEntity> movies;
  final ScrollController scrollController;
  const ListMoviesWidget(
      {super.key, required this.movies, required this.scrollController});

  @override
  State<ListMoviesWidget> createState() => _ListMoviesWidgetState();
}

void doNothing(BuildContext context) {}

class _ListMoviesWidgetState extends State<ListMoviesWidget> {
  

  @override
  Widget build(BuildContext context) {
    final Responsive responseive = Responsive(context);

    return ListView.builder(
      shrinkWrap: true,
      controller: widget.scrollController,
      itemCount: widget.movies.length,
      itemBuilder: (BuildContext context, int index) {
        final HomeMovieEntity movie = widget.movies[index];
        return SizedBox(
          width: responseive.width,
          height: 60,
          child: MovieTile(movie: movie,)
        );
      },
    );
  }
}
