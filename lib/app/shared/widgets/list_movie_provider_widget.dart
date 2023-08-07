import 'package:flutter/material.dart';
import 'package:lumiere/app/shared/interfaces/movie_provider.dart';

class ListMovieProviderWidget extends StatefulWidget {
  final List<IMovieProvider?> providers;
  const ListMovieProviderWidget({Key? key, this.providers = const []}) : super(key: key);

  @override
  State<ListMovieProviderWidget> createState() => _ListMovieProviderWidgetState();
}

class _ListMovieProviderWidgetState extends State<ListMovieProviderWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: widget.providers.length,
      itemBuilder: (context, item) {
        final logoItem = widget.providers[item]!.logoPath;
        return SizedBox(
          width: 45,
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
    );
  }
}
