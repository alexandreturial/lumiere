import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/modules/home/presenter/controller/home_bloc.dart';

import 'package:lumiere/app/shared/core/styles/core.dart';
import 'package:lumiere/app/shared/widgets/dialogs/dialogs_types.dart';
import 'package:lumiere/app/shared/widgets/dialogs/dialogs_widget.dart';
import 'package:lumiere/app/shared/widgets/list_movie_provider_widget.dart';
import 'package:lumiere/app/utils/responsive.dart';


class DetailMoviePage extends StatefulWidget {
  final HomeMovieEntity movie;
  const DetailMoviePage({super.key, required this.movie});

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  final HomeBloc homeBloc = Modular.get();

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
                  child: detailMovie(responsive,),
                  
                  // ValueListenableBuilder<HomeStates>(
                  //   valueListenable: homeBloc,
                  //   builder: (context, state, child) {
                  //     switch (state.runtimeType) {
                  //       case InitialState:
                  //         final Responsive responsive = Responsive(context);
                  //         return Column(
                  //           children: [
                              
                  //           ],
                  //         );
                  //       case HomeList:
                  //         final Responsive responsive = Responsive(context);
                  //         return Column(
                  //           children: [
                              
                  //           ],
                  //         );
                  //       default:
                  //         final Responsive responsive = Responsive(context);
                  //         return Column(
                  //           children: [
                              
                  //           ],
                  //         );
                  //     }
                  //   },
                  // ),
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
      tag: 'movieDetail',
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

  Widget detailMovie(Responsive responsive,) {
    return SingleChildScrollView(
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
            child: widget.movie.providerList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16),
                    child: Text(
                      "Nenhum local encontrado",
                      style: AppTextStyles.textRegularH14,
                    ),
                  )
                : ListMovieProviderWidget(
                    providers: widget.movie.providerList,
                  ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: [
              SizedBox(
                child: TextButton(
                  onPressed: ()async{
                    bool result = await homeBloc.deleteMovieById(widget.movie.id);
                    if(result){
                      Dialogs.handleDilalog(context, type: DialogsTypes.ErrorDialog, title: "Não foi possível remover o filme", message: "codigo: 400");
                    }else{
                      Dialogs.handleDilalog(context, type: DialogsTypes.SucessDialog, title: "Filme removido com sucesso", message: "codigo: 200");
                    }
                  },
                  child: Text(
                    "Remover",
                    style: AppTextStyles.textMediumH14,
                  ),
                ),
              ),
              SizedBox(
                child: ElevatedButton(
                  onPressed: ()  async{
                    bool result = await homeBloc.viewerMovie(widget.movie.id);
                    if(result){
                      Dialogs.handleDilalog(context, type: DialogsTypes.ErrorDialog, title: "Não foi possível concluir o filme", message: "codigo: 400");
                    }else{
                      Dialogs.handleDilalog(context, type: DialogsTypes.SucessDialog, title: "Filme concluido com sucesso", message: "codigo: 200");

                    }

                  },
                  child: Text('Assistido',
                    style: AppTextStyles.textMediumH14,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}