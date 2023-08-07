import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/modules/home/presenter/controller/home_bloc.dart';
import 'package:lumiere/app/modules/home/presenter/page/widgets/carrousel_movies.dart';
import 'package:lumiere/app/modules/home/presenter/page/widgets/list_movies_widget.dart';
import 'package:lumiere/app/modules/home/presenter/page/widgets/scrollable/active_btn_widget.dart';
import 'package:lumiere/app/modules/home/presenter/states/home_state.dart';
import 'package:lumiere/app/shared/core/styles/core.dart';
import 'package:lumiere/app/shared/database/realm_database/models/movie_model.dart';
import 'package:lumiere/app/shared/interfaces/movie_provider.dart';
import 'package:lumiere/app/shared/widgets/buttons/floating_button.dart';
import 'package:lumiere/app/shared/widgets/skeletton/shimmer_provider.dart';
import 'package:lumiere/app/shared/widgets/text/Text.dart';
import 'package:lumiere/app/utils/formart_date.dart';
import 'package:lumiere/app/utils/responsive.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lumiere/app/shared/database/adapter_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final HomeBloc homeBloc = Modular.get();

  DateTime _selectedDay = DateTime.now();
  late DraggableScrollableController controllerScrollable;
  CalendarFormat format = CalendarFormat.twoWeeks;
  List<MovieModel> filmes = [];
  List<HomeMovieEntity> moviePerDay = [];
  int tab = 1;

  @override
  void initState() {
    controllerScrollable = DraggableScrollableController();
    controllerScrollable.addListener(() {
      getCalendarSize();
    });
    loadMovieSaved();

    super.initState();
  }

  loadMovieSaved() async {
    await homeBloc.getAllMoviesSaved();
    moviePerDay = homeBloc.loadMovies(_selectedDay);
    homeBloc.getProvidersByMonth();
    getMoviesByDaySelected(_selectedDay);

  }

  List<HomeMovieEntity> setMoviesInCalendar(DateTime date) {
    return homeBloc.loadMovies(date);
  }

  void getMoviesByDaySelected(DateTime selectedDay) {
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

  final itemSize = 300;

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
        title: Text(
          'Lumiere',
          style: AppTextStyles.textMediumH20,
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              Modular.to.pushNamed("/search").then((value) => loadMovieSaved());
            },
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: SizedBox(
        width: responsive.width,
        height: responsive.height,
        child: handleBuildPage(context),
      ),
    );
  }

  Widget handleBuildPage(BuildContext context) {
    return ValueListenableBuilder<HomeStates>(
      valueListenable: homeBloc,
      builder: (contexts, state, child) {
        switch (state.runtimeType) {
          case InitialState:
            final Responsive responsive = Responsive(context);
            return ListView(
              children: [
                buildBannerHome(responsive, true),
                buildProviderMovies(responsive, true),
              ],
            );
          case HomeList:
            final Responsive responsive = Responsive(context);
            return Column(
              children: [
                buildBannerHome(responsive, false, state: state as HomeList),
                buildProviderMovies(responsive, false, state: state as HomeList),
              ],
            );
          default:
            final Responsive responsive = Responsive(context);
            return Column(
              children: [
                buildBannerHome(responsive, false),
                buildProviderMovies(responsive, false),
              ],
            );
        }
      },
    );
  }

  Widget buildBannerHome(Responsive responsive, bool isLoading, {HomeList? state}) {
    String getDate(){
     return convertFromString(state!.selectedDay.toString());
    }
    return ShimmerProvider(
      isLoading: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child:  TextWidget(
              isLoading: isLoading,
              size: 150,
              textComponentWidget: Text(
                state != null ? "Filmes de ${getDate()}": "",
                style: AppTextStyles.textMediumH16,
                textAlign: TextAlign.left,
              ),
            )
          ),
          const SizedBox(
            height: 8,
          ),
          Container (
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: responsive.width,
            height: 180,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: 'movieDetail',

                  child: Material(
                    color: Colors.transparent,
                    child: CarrouselMovies(
                      cardSize: responsive.wp(90),
                      movies: state != null ? state.moviesPerDay : [],
                      actionMovie: (HomeMovieEntity movie){
                        Modular.to.pushNamed('detail', arguments: movie);
                      }
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.9, 0.8),
                  child: FloatingButtonWidget(
                    icon: Icons.calendar_month,
                    action: () async{
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(2101),
                        currentDate: DateTime.now(),
                      );
                      
                      if(pickedDate != null){
                        getMoviesByDaySelected(pickedDate);
                      }
                    }
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProviderMovies(Responsive responsive, bool isLoading, {HomeList? state}) {
    List<IMovieProvider?> providers = state?.moviesCurrentMonth ?? [];
    return ShimmerProvider(
      isLoading: isLoading,
      child: SizedBox(
        height: responsive.hp(35),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    isLoading: isLoading,
                    size: 150,
                    textComponentWidget: Text(
                      "Streamings do mês",
                      style: AppTextStyles.textMediumH16,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextWidget(
                    isLoading: isLoading,
                    size: 70,
                    textComponentWidget: Text(
                      "ver todos",
                      style: AppTextStyles.textMediumH12,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: providers.length,
                  itemBuilder: (BuildContext context, int index) {
                    IMovieProvider provider = providers[index]!;
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/original${provider.logoPath}',
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text("4 mídias")
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }


  Widget getScrollableSheet(Responsive responsive) {
    return DraggableScrollableSheet(
      controller: controllerScrollable,
      maxChildSize: 1,
      minChildSize: 0.9,
      snapSizes: const [0.9, 1],
      initialChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return contentScrollableSheet(responsive);
      },
    );
  }

  Widget contentScrollableSheet(Responsive responsive) {
    return Container(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      child: ValueListenableBuilder<HomeStates>(
        valueListenable: homeBloc,
        builder: (context, state, child) {
          switch (state.runtimeType) {
            case HomeList:
              state as HomeList;
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (format == CalendarFormat.month) {
                          format = CalendarFormat.twoWeeks;
                        } else {
                          format = CalendarFormat.month;
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(
                        size: 28,
                        color: Theme.of(context).colorScheme.onBackground,
                        format == CalendarFormat.twoWeeks
                            ? Icons.keyboard_arrow_down_sharp
                            : Icons.keyboard_arrow_up_sharp,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: ActiveBtnWidget(
                          title: "Não Vistos",
                          isActive: tab == 1,
                          action: () {
                            setState(() {
                              tab = 1;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: ActiveBtnWidget(
                          title: "Vistos",
                          isActive: tab == 2,
                          action: () {
                            setState(() {
                              tab = 2;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 2),
                          width: tab == 1 ? responsive.width : 0,
                          curve: Curves.fastOutSlowIn,
                          child: ListMoviesWidget(
                            movies: state.getMovieByViwer(false),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(seconds: 2),
                          width: tab == 2 ? responsive.width : 0,
                          curve: Curves.fastOutSlowIn,
                          child: ListMoviesWidget(
                            movies: state.getMovieByViwer(true),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );

            default:
              return Container();
          }
        },
      ),
    );
  }
}
