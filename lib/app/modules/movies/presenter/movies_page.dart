import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:lumiere/app/core/styles/app_animated.dart';
import 'package:lumiere/app/modules/movies/presenter/movies_bloc.dart';
import 'package:lumiere/app/shared/widgets/input.dart';
import 'package:lumiere/app/utils/debounce.dart';
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
  String _output = "";
  FocusNode myfocus = FocusNode();
  bool showMovies = false;

  int? indexMovie;
  bool description = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    debunce.disponse();
  }

  void _sendRequest(String value) {
    debunce.run(() async {
      setState(() {
        _output = value;
      });
      await blocMovie.searchMovies(value);

      myfocus.unfocus();
      setState(() {
        showMovies = !showMovies;
      });
    });
  }

  void selectedMovie(index){
    setState(() {
      description = false;
      indexMovie = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: InputWidget(
              setValue: (value) => _sendRequest(value),
              setValidate: () {},
              myFocous: myfocus,
            ),
          ),
          blocMovie.state.isNotEmpty
              ? AnimatedContainer(
                  margin: const EdgeInsets.only(top: 16),
                  width: showMovies ? 500 : 0,
                  height: showMovies ? 500 : 0,
                  color: Colors.blue,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  child: SingleChildScrollView(
                    child: Wrap(
                        children:
                            List.generate(blocMovie.state.length, (index) {
                      final movie = blocMovie.state[index];
                      return InkWell(
                        onTap: () => selectedMovie(index),
                        child: AnimatedContainer(
                          width: index == indexMovie ? 330 : 150,
                          height: index == indexMovie ? 250 : 200,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInCirc,
                          onEnd: (){
                            setState(() {
                              description = true;
                            });
                          },
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInCirc,
                                padding: const EdgeInsets.all(8.0),
                                width: index == indexMovie ? 150 : 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500${movie!.poster}',
                                    fit: BoxFit.cover,
                                    
                                    // height: 250,
                                  ),
                                ),
                              ),
                              index == indexMovie && description ? SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(movie.name)
                                  ],
                                ),
                              ): SizedBox(),
                            ],
                          ),
                        ),
                      );
                    })),
                  ),
                )
              : Center(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: RiveAnimation.asset(AppAnimated.moonLoading),
                  ),
                ),
        ],
      ),
    );
  }
}
