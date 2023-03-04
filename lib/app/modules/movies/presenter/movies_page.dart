import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lumiere/app/core/styles/core.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';
import 'package:lumiere/app/modules/movies/presenter/movies_bloc.dart';
import 'package:lumiere/app/modules/movies/presenter/movies_state.dart';
import 'package:lumiere/app/shared/widgets/input.dart';
import 'package:lumiere/app/utils/debounce.dart';
import 'package:lumiere/app/utils/responsive.dart';

class MoviesPage extends StatefulWidget {
  final String title;
  const MoviesPage({Key? key, this.title = 'MoviesPage'}) : super(key: key);
  @override
  MoviesPageState createState() => MoviesPageState();
}

class MoviesPageState extends State<MoviesPage> {
  final MoviesBloc blocMovie = Modular.get();
  final debunce = Debounce(milliseconds: 700);
  Timer? _debounce;

  FocusNode myfocus = FocusNode();
  bool showMovies = false;

  int? indexMovie;
  bool description = false;

  @override
  void dispose() {
    super.dispose();
    _debounce!.cancel();
  }

  void _sendRequest(String value) {
    debunce.run(() async {
      if (value != '' && value.length > 2) {
        await blocMovie.searchMovies(value);
      }
      myfocus.unfocus();
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        showMovies = true;
      });
    });
  }

  Future<void> selectedMovie(index) async {
    await blocMovie.getMovieProvider(index);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return SafeArea(
      top: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SizedBox(
          width: responsive.width,
          height: responsive.height,
          child: Stack(
            children: [
              Opacity(
                opacity: 0.1,
                child: SvgPicture.asset(
                  AppImages.cineDoodle,
                  color: Theme.of(context).colorScheme.onBackground,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      children: [
                        Text("Busque por um filme", style: AppTextStyles.textSemiBoldH16,),
                        const SizedBox(height: 12,),
                        InputWidget(
                          setValue: (value) => _sendRequest(value),
                          setValidate: () {},
                          myFocous: myfocus,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ValueListenableBuilder<MoviesStates>(
                    valueListenable: blocMovie,
                    builder: (context, state, child){
                      if (state is InitialState) {
                        return Center(
                            child: Container(),
                          );
                      }
                      if (state is MoviesList) {
                        return SizedBox(
                            width: responsive.width,
                            height: 500,
                            child: ListView.separated(
                              itemCount: state.movies.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 12,
                                );
                              },
                              itemBuilder: (context, index) {
                                final movie = state.movies[index];
                                return InkWell(
                                  onTap: () {
                                    //await selectedMovie(index);
                                    Modular.to.pushNamed('/detail',
                                        arguments: [state.movies, index]);
                                  },
                                  child: SizedBox(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: responsive.wp(45),
                                          height: 100,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Hero(
                                              tag: 'movie$index',
                                              child: Image.network(
                                                'https://image.tmdb.org/t/p/w300${movie!.poster}',
                                                fit: BoxFit.cover,
                                                alignment: Alignment.center,
                                                errorBuilder: (context, err,
                                                    stackTrace) {
                                                  return SizedBox();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        SizedBox(
                                          width: responsive.wp(40),
                                          child: Text(
                                            movie!.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                      }
                      if (state is EmptyState) {
                        return Center(
                            child: Container(),
                          );
                      }
                      if (state is ErrorState) {
                        return Center(
                            child: Container(),
                          );
                      }
                      
                      return Center(
                            child: Container(),
                          );
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
