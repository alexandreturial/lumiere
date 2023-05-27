import 'package:flutter/material.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/modules/home/presenter/page/widgets/movieTile/movie_item.dart';
import 'package:lumiere/app/utils/responsive.dart';
import 'dart:async';

class MovieTile extends StatefulWidget {
  final HomeMovieEntity movie;

  const MovieTile({super.key, required this.movie});

  @override
  State<MovieTile> createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  late ScrollController scrollController;
  bool isOpenOptions = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  void _scrollListener() async {
    scrollController
        .animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(seconds: 1), curve: Curves.easeIn);
    setState(() {
      isOpenOptions = true;
    });
  }

  void _closeListener() async {
    scrollController
        .animateTo(scrollController.position.minScrollExtent,
            duration: const Duration(seconds: 1), curve: Curves.easeIn);
    setState(() {
      isOpenOptions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responseive = Responsive(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      physics: BouncingScrollPhysics(),
      child: Row(
        // scrollDirection: Axis.horizontal,
        // physics: BouncingScrollPhysics(),
        children: [
          GestureDetector(
            onHorizontalDragStart: (details) {
              print(details.localPosition.direction);
             

              if (details.localPosition.direction >= 0.07 && isOpenOptions) {
                _closeListener();
              }else if(details.localPosition.direction >= 0.07 && !isOpenOptions) {
                _scrollListener();
              }
            },
            child: SizedBox(
              width: responseive.width,
              height: 60,
              child: MovieItem(movie: widget.movie),
            ),
          ),
          Container(
            height: 60,
            width: 70,
            color: Colors.red,
          ),
          Container(
            height: 60,
            width: 90,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
