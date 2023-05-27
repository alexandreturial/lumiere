import 'package:flutter/material.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';
import 'package:lumiere/app/utils/formart_date.dart';
import 'package:lumiere/app/utils/responsive.dart';

class CardMovie extends StatelessWidget {
  final MovieEntity movie;
  final int position;
  const CardMovie({Key? key, required this.movie, required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: responsive.wp(45),
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w300${movie.poster}',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (context, err, stackTrace) {
                      return SizedBox();
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: responsive.wp(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14,), 
                            const SizedBox(width: 4,),
                            Text(
                              movie.popularity.toStringAsFixed(1),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              
                            ),
                          ],
                        ),
                        Text(
                          convertFromString(movie.date),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.inversePrimary),
            backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
            minHeight: 2,
            value: (movie.popularity / 10),
          )
        ],
      ),
    );
  }
}
