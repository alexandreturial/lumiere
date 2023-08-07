import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/modules/movies/presenter/detailMovie/movie_detail_state.dart';
import 'package:lumiere/app/shared/widgets/list_movie_provider_widget.dart';
import 'package:lumiere/app/modules/movies/presenter/detailMovie/movie_detail_bloc.dart';
import 'package:lumiere/app/shared/core/styles/core.dart';
import 'package:lumiere/app/shared/interfaces/movie.dart';
import 'package:lumiere/app/shared/interfaces/movie_provider.dart';
import 'package:lumiere/app/shared/widgets/dialogs/dialogs_types.dart';
import 'package:lumiere/app/shared/widgets/dialogs/dialogs_widget.dart';
import 'package:lumiere/app/shared/widgets/modals/modal_bottom_widget.dart';
import 'package:lumiere/app/utils/responsive.dart';

class MovieDetail extends StatefulWidget {
  final IMovie movie;
  final int selectedIndex;
  const MovieDetail(
      {Key? key, required this.movie, required this.selectedIndex})
      : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final MovieDetailBloc blocMovie = Modular.get();
  final _formKey = GlobalKey<FormState>();
  final Dialogs dialog = const Dialogs();

  bool showDetail = false;

  @override
  void initState() {
    super.initState();

    blocMovie.dateinput.text = "";
    blocMovie.setMovie(widget.movie);
    initialMovieDetail(widget.selectedIndex);

    setState(() {
      showDetail = true;
    });
  }

  Future<void> initialMovieDetail(index) async {
    await blocMovie.getMovieProvider(widget.movie.id);
  }

  Future<void> saveMovie() async {
    bool result = await blocMovie.saveMovieInSchedule(widget.movie);

    if (result) {
      Dialogs.handleDilalog(
        context,
        type: DialogsTypes.SucessDialog,
        title: "Filme salvo com sucesso!",
        message: "codigo: 200",
        actions: [
          dialog.secundaryButtton(
            DialogsTypes.SucessDialog,
            context,
            title: "Salvo com sucesso!",
            action: () {
              Modular.to.popUntil(ModalRoute.withName('/search'));
            },
          ),
          dialog.primaryButton(DialogsTypes.SucessDialog, context,
              title: "Voltar", action: () {
            Modular.to.popUntil(ModalRoute.withName('/'));
          })
        ],
      );
    } else {
      Dialogs.handleDilalog(
        context,
        type: DialogsTypes.ErrorDialog,
        title: "Infelizmente não conseguimos salvar seu filme",
        message: "codigo: 400",
        actions: [
          dialog.secundaryButtton(DialogsTypes.ErrorDialog, context,
              title: "Tentar novamente", action: () {
            saveMovie();
          }),
          dialog.primaryButton(DialogsTypes.ErrorDialog, context,
              title: "cancelar", action: () {
            print("teste");
            Modular.to.popUntil(ModalRoute.withName('/search/'));
          })
        ],
      );
    }
  }

  void showModalAction(result) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      builder: (BuildContext context) {
        return ModalBottomWidget(
          isSucceeded: result,
          errorAction: () {
            Modular.to.popUntil(ModalRoute.withName('/'));
          },
          retryAction: () {
            Modular.to.pop();
            saveMovie();
          },
          succeededAction: () {
            Modular.to.popUntil(ModalRoute.withName('/'));
          },
        );
      },
    );
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
            mainAxisSize: MainAxisSize.min,
            children: [
              bannerMovie(responsive),
              SizedBox(
                height: responsive.hp(50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ValueListenableBuilder<MovieDetailStates>(
                    valueListenable: blocMovie,
                    builder: (context, state, child) {
                      if (state is MovieDetailState) {
                        final MovieDetailState movieDetail = state;
                        return detailMovie(responsive,
                            movieProviders: movieDetail.movie.providerList);
                      }

                      if (state is LoadingState) {
                        return detailMovie(responsive);
                      } else {
                        return detailMovie(responsive, movieProviders: []);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bannerMovie(Responsive responsive) {
    return Hero(
      tag: 'movie${widget.selectedIndex}',
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          height: responsive.hp(45),
          width: responsive.width,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.1, 0.8],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/original${widget.movie.poster}',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  loadingBuilder: (context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Image.network(
                      'https://image.tmdb.org/t/p/w200${widget.movie.poster}',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    );
                  },
                  errorBuilder: (context, err, stackTrace) {
                    return Image.asset(
                      AppImages.bannerNotFound,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    );
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Modular.to.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailMovie(Responsive responsive,
      {List<IMovieProvider?> movieProviders = const []}) {
    return Opacity(
      opacity: showDetail ? 1 : 0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.movie.name,
              style: AppTextStyles.textMediumH18,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.movie.overview,
              maxLines: 5,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppColors.textSecundary.withOpacity(.7)),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Onde assistir",
              style: AppTextStyles.textMediumH16,
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              width: responsive.width,
              height: 45,
              child: movieProviders.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Text(
                        "Nenhum local encontrado",
                        style: AppTextStyles.textRegularH14,
                      ),
                    )
                  : ListMovieProviderWidget(
                      providers: movieProviders,
                    ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Adicionar a agenda",
              style: AppTextStyles.textMediumH16,
            ),
            const SizedBox(
              height: 8,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: blocMovie.dateinput,
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "insira uma data"),
                readOnly: true,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Selecione uma data';
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    blocMovie.setDate(pickedDate);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              width: responsive.width,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    saveMovie();
                  }
                },
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
