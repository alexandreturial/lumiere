import 'package:flutter/material.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/shared/widgets/skeletton/shimmer_provider.dart';
import 'package:lumiere/app/utils/responsive.dart';

class CarrouselMovies extends StatefulWidget {
  final double cardSize;
  final List<HomeMovieEntity> movies;
  final Function actionMovie;
  const CarrouselMovies(
      {super.key, required this.cardSize, required this.movies, required this.actionMovie});

  @override
  State<CarrouselMovies> createState() => _CarrouselMoviesState();
}

class _CarrouselMoviesState extends State<CarrouselMovies>
    with SingleTickerProviderStateMixin {
  late ScrollController _controller;

  int cardIndexPosition = 0;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    int integerPosition = _controller.offset ~/ widget.cardSize;
    double position = _controller.offset / widget.cardSize;

    if (position - integerPosition >= 0.6) {
      setState(() {
        cardIndexPosition = integerPosition + 1;
      });
    } else {
      setState(() {
        cardIndexPosition = integerPosition;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Column(
      children: [
        SizedBox(
          width: responsive.width,
          height: 150,
          child: ListView.separated(
              shrinkWrap: true,
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 12,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                HomeMovieEntity movie = widget.movies[index];
                return InkWell(
                  onTap: ()=> widget.actionMovie(movie),
                  child: SizedBox(
                      width: widget.cardSize,
                      height: 150,
                      child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/original${movie.poster}',
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object object,
                                  StackTrace? stackTrace) {
                                return Container(
                                  color: Theme.of(context).colorScheme.error,
                                );
                              },
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return ShimmerProvider(
                                  isLoading: true,
                                  child: Container(
                                    width: widget.cardSize,
                                    height: 150,
                                    color: Colors.black,
                                  ),
                                );
                              },
                            ),
                          ),),
                );
              },),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: responsive.width,
          height: 16,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 12,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: index == cardIndexPosition ? 24 : 8,
                  decoration: BoxDecoration(
                      color: index == cardIndexPosition
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      borderRadius: BorderRadius.circular(20)),
                );
              }),
        ),
      ],
    );
  }
}
