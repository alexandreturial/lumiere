import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lumiere/app/modules/movies/presenter/pages/movies_bloc.dart';
import 'package:lumiere/app/modules/movies/presenter/pages/movies_state.dart';
import 'package:lumiere/app/modules/movies/presenter/widgets/card_movie_widget.dart';
import 'package:lumiere/app/shared/core/styles/core.dart';
import 'package:lumiere/app/shared/database/adapter_database.dart';
import 'package:lumiere/app/shared/database/realm_database/models/movie_model.dart';

import 'package:lumiere/app/shared/widgets/input.dart';
import 'package:lumiere/app/utils/debounce.dart';
import 'package:lumiere/app/utils/responsive.dart';
import 'package:rive/rive.dart';

class MoviesPage extends StatefulWidget {
  final String title;
  const MoviesPage({Key? key, this.title = 'MoviesPage'}) : super(key: key);
  @override
  MoviesPageState createState() => MoviesPageState();
}

class MoviesPageState extends State<MoviesPage> {
  final MoviesBloc blocMovie = Modular.get();
  final debunce = Debounce(milliseconds: 700);
  FocusNode myfocus = FocusNode();
  bool isShowMovie = false;
  late ScrollController _controller;

  final LumiereDatabase realm = Modular.get();

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    teste();
  }

  teste() {
    // final List<MovieModel> teste = realm.getAllMovie();
    // print(teste);
  }

  _scrollListener() async {
    if (_controller.offset >= (_controller.position.maxScrollExtent - 500) &&
        !_controller.position.outOfRange) {
      await blocMovie.getMoreMovies();
    }
  }

  void _sendRequest(String value) {
    debunce.run(() async {
      setState(() {
        isShowMovie = false;
      });
      if (value != '' && value.length > 2) {
        myfocus.unfocus();
        await blocMovie.searchMovies(value);
      }
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        isShowMovie = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
            fit: StackFit.expand,
            children: [
              Opacity(
                opacity: 0.3,
                child: SvgPicture.asset(
                  AppImages.cineDoodle,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          Text(
                            "Busque por um filme",
                            style: AppTextStyles.textSemiBoldH16,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          InputWidget(
                            setValue: (value) => _sendRequest(value),
                            setValidate: () {},
                            myFocous: myfocus,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ValueListenableBuilder<MoviesStates>(
                    valueListenable: blocMovie,
                    builder: (context, state, child) {
                      if (state is InitialState) {
                        return Center(
                          child: Container(),
                        );
                      }
                      if (state is MoviesList) {
                        return getMovieList(responsive, state);
                      }

                      if (state is EmptyState) {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
                                width: responsive.width,
                                child: RiveAnimation.asset(
                                  AppAnimated.moonEmpty,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text("Nenhum filme/serie encontrado",
                                  style: AppTextStyles.textSemiBoldH14)
                            ],
                          ),
                        );
                      }

                      if (state is ErrorState) {
                        return Center(
                          child: SizedBox(
                              height: 150,
                              width: responsive.width,
                              child: Text('ERRRO ${state.erro}')),
                        );
                      }
                      
                      if (state is LoadingState) {
                        return getLoadingState(responsive, state);
                      }
                      return Center(
                        child: Container(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getMovieList(Responsive responsive, MoviesList state) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
      height: isShowMovie ? (responsive.hp(90) - 120) : 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.separated(
          shrinkWrap: true,
          controller: _controller,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: state.movies.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 14,
            );
          },
          itemBuilder: (context, index) {
            final movie = state.movies[index];
            return InkWell(
              onTap: () {
                Modular.to
                    .pushNamed('detail', arguments: [movie, index]);
              },
              child: Hero(
                tag: 'movie$index',
                child: Material(
                  color: Colors.transparent,
                  child: CardMovie(
                    movie: movie!,
                    position: index,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getLoadingState(Responsive responsive, LoadingState state) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
      opacity: isShowMovie ? 0 : 1,
      child: Center(
        child: SizedBox(
          height: 150,
          width: responsive.width,
          child: RiveAnimation.asset(
            AppAnimated.moonLoading,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
