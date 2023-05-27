import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/modules/home/presenter/controller/home_bloc.dart';
import 'package:lumiere/app/modules/home/presenter/page/widgets/calendar_widget.dart';
import 'package:lumiere/app/modules/home/presenter/page/widgets/list_movies_widget.dart';
import 'package:lumiere/app/modules/home/presenter/states/home_state.dart';
import 'package:lumiere/app/shared/database/realm_database/models/movie_model.dart';
import 'package:lumiere/app/utils/responsive.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lumiere/app/shared/database/adapter_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = Modular.get();
  final LumiereDatabase realm = Modular.get();

  DateTime _selectedDay = DateTime.now();
  late DraggableScrollableController controllerScrollable;
  CalendarFormat format = CalendarFormat.twoWeeks;
  List<MovieModel> filmes = [];
  List<HomeMovieEntity> moviePerDay = [];

  @override
  void initState() {
    controllerScrollable = DraggableScrollableController();
    controllerScrollable.addListener(() {
      getCalendarSize();
    });
    loadMovieSaved();
    getMoviesByDaySelected(DateTime.now(), DateTime.now());
    super.initState();
  }

  loadMovieSaved() async {
    await homeBloc.getAllMoviesSaved();
    moviePerDay = homeBloc.loadMovies(_selectedDay);
  }

  List<HomeMovieEntity> setMoviesInCalendar(DateTime date) {
    return homeBloc.loadMovies(date);
  }

  void getMoviesByDaySelected(DateTime selectedDay, DateTime focusedDay) {
    homeBloc.showMoviesPerDay(selectedDay);

    setState(() {
      _selectedDay = selectedDay;
    });
  }

  void getCalendarSize() {
    if (controllerScrollable.size == 1) {
      setState(() {
        format = CalendarFormat.twoWeeks;
      });
    } else {
      setState(() {
        format = CalendarFormat.month;
      });
    }
  }

  @override
  void dispose() {
    // _counterCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Lumiere'),
      ),
      body: SizedBox(
        width: responsive.width,
        height: responsive.height,
        child: Column(
          children: [
            SizedBox(
              width: responsive.wp(80),
              child: ElevatedButton(
                onPressed: () async {
                  Modular.to
                      .pushNamed("/search")
                      .then((value) => loadMovieSaved());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Adicionar filme'),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder<HomeStates>(
                valueListenable: homeBloc,
                builder: (context, state, child) {
                  switch (state.runtimeType) {
                    case InitialState:
                      return Container(
                        width: 90,
                        height: 90,
                        color: Colors.red,
                      );
                    default:
                      return CalendarWidget(
                        format: format,
                        selectedDay: _selectedDay,
                        loaderEvent: setMoviesInCalendar,
                        onDaySelected: getMoviesByDaySelected,
                      );
                  }
                }),
            Expanded(
              child: SizedBox(
                height: responsive
                    .hp(format == CalendarFormat.twoWeeks ? 64.3 : 43.5),
                width: responsive.width,
                child: DraggableScrollableSheet(
                  controller: controllerScrollable,
                  maxChildSize: 1,
                  minChildSize: 0.9,
                  snapSizes: const [0.9, 1],
                  initialChildSize: 0.9,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      child: ValueListenableBuilder<HomeStates>(
                        valueListenable: homeBloc,
                        builder: (context, state, child) {
                          switch (state.runtimeType) {
                            case HomeList:
                              state as HomeList;
                              return ListMoviesWidget(
                                movies: state.moviesPerDay,
                                scrollController: scrollController,
                              );
                            default:
                              return Container();
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
