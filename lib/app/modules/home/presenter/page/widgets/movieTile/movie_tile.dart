import 'package:flutter/material.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/modules/home/presenter/controller/home_bloc.dart';
import 'package:lumiere/app/modules/home/presenter/page/widgets/movieTile/card_btn_action_widget.dart';
import 'package:lumiere/app/modules/home/presenter/page/widgets/movieTile/movie_item.dart';
import 'package:lumiere/app/shared/widgets/dialogs/dialogs_types.dart';
import 'package:lumiere/app/shared/widgets/dialogs/dialogs_widget.dart';
import 'package:lumiere/app/utils/responsive.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MovieTile extends StatefulWidget {
  final HomeMovieEntity movie;

  const MovieTile({super.key, required this.movie});

  @override
  State<MovieTile> createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  late ScrollController scrollController;
  bool isOpenOptions = false;

  final HomeBloc homeBloc = Modular.get();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  void _scrollListener() async {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
    setState(() {
      isOpenOptions = true;
    });
  }

  void _closeListener() async {
    scrollController.animateTo(scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
    setState(() {
      isOpenOptions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responseive = Responsive(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            cardMovie(responseive),
            const SizedBox(
              width: 4,
            ),
            cardActionMovie()
          ],
        ),
      ),
    );
  }

  Widget cardMovie(Responsive responseive) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        if (details.localPosition.direction >= 0.07 && isOpenOptions) {
          _closeListener();
        } else if (details.localPosition.direction >= 0.07 && !isOpenOptions) {
          _scrollListener();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8),
        ),
        width: responseive.width,
        height: 60,
        child: MovieItem(movie: widget.movie),
      ),
    );
  }

  Widget cardActionMovie() {
    return Row(
      children: [
        CardActionBtnWidget(
          actionBtn: () async{
            bool result = await homeBloc.deleteMovieById(widget.movie.id);
            if(result){
              Dialogs.handleDilalog(context, type: DialogsTypes.SucessDialog, title: "Filme removido com sucesso", message: "codigo: 200");
            }else{
              Dialogs.handleDilalog(context, type: DialogsTypes.ErrorDialog, title: "Não foi possível remover o filme", message: "codigo: 400");

            }
          },
          iconCard: Icons.delete_outline_outlined,
          colorCard: Theme.of(context).colorScheme.primaryContainer,
        ),
        const SizedBox(
          width: 4,
        ),
        CardActionBtnWidget(
          actionBtn: () async{
            bool result = await homeBloc.viewerMovie(widget.movie.id);
            if(result){
              Dialogs.handleDilalog(context, type: DialogsTypes.SucessDialog, title: "Filme concluido com sucesso", message: "codigo: 200");
            }else{
              Dialogs.handleDilalog(context, type: DialogsTypes.ErrorDialog, title: "Não foi possível concluir o filme", message: "codigo: 400");

            }

          },
          iconCard: Icons.check,
          colorCard: Colors.teal,
        )
      ],
    );
  }
}
