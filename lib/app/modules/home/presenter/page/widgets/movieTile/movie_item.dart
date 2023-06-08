import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';

class MovieItem extends StatefulWidget {
  final HomeMovieEntity movie;

  const MovieItem({super.key, required this.movie});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 8,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      onTap: () {
        Modular.to.pushNamed('/search/detail', arguments: [widget.movie, 0]);
      },
      leading: leadingTile(),
      title: Text(widget.movie.name),
      subtitle: SizedBox(
        child: Text(
          widget.movie.overview,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget leadingTile() {
    return SizedBox(
      width: 65,
      height: 45,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.movie.providerList.length,
        itemBuilder: (context, item) {
          final logoItem = widget.movie.providerList[item]!.logoPath;
          return SizedBox(
            width: 45,
            height: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://image.tmdb.org/t/p/original$logoItem',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        separatorBuilder: (context, item) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    );
  }
}
