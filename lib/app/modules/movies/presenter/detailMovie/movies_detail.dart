import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:lumiere/app/core/styles/app_colors.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';
import 'package:lumiere/app/modules/movies/presenter/detailMovie/movie_detail_bloc.dart';
import 'package:lumiere/app/utils/responsive.dart';

class MovieDetail extends StatefulWidget {
  final List<MovieEntity?> movies;
  final int selectedIndex;
  const MovieDetail(
      {Key? key, required this.movies, required this.selectedIndex})
      : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final MovieDetailBloc blocMovie = Modular.get();
  bool showDetail = false;
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    super.initState();

    dateinput.text = "";
    selectedMovie(widget.selectedIndex);
    setState(() {
      showDetail = true;
    });
  }

  Future<void> selectedMovie(index) async {
    await blocMovie.getMovieProvider(
        widget.movies[widget.selectedIndex]!, widget.movies[index]!.id);
  }



  @override
  void dispose() {
    super.dispose();
  }

 

  // BlocBuilder<MovieDetailBloc, MovieEntity>(
  //                   builder: (context, movie)

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return SafeArea(
      top: true,
      child: Scaffold(
        body: SizedBox(
          width: responsive.width,
          height: responsive.height,
          child: Column(
            children: [
              Hero(
                tag: 'movie${widget.selectedIndex}',
                child: Container(
                  height: 250,
                  width: responsive.width,
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0.1, 0.5],
                    ),
                  ),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${widget.movies[widget.selectedIndex]!.poster}',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      return Image.network(
                        'https://image.tmdb.org/t/p/w500${widget.movies[widget.selectedIndex]!.poster}',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              AnimatedContainer(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                duration: const Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                child: ValueListenableBuilder<MovieEntity>(
                    valueListenable: blocMovie,
                    builder: (context, state, child) => Opacity(
                    opacity: showDetail ? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.movies[widget.selectedIndex]!.name),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.movies[widget.selectedIndex]!.overview,
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.textSecundary.withOpacity(.7)),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("Onde assistir"),
                        state.providerList.isNotEmpty
                            ? SizedBox(
                                width: responsive.width,
                                height: 45,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      state.providerList.length,
                                  itemBuilder: (context, item) {
                                    final logoItem = state.providerList[item]!.logoPath;
                                    return SizedBox(
                                      width: 45,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8),
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/original$logoItem',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, item) {
                                    return const SizedBox(
                                      width: 4,
                                    );
                                  },
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: dateinput,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              labelText: "Enter Date"),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                              setState(() {
                                dateinput.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
