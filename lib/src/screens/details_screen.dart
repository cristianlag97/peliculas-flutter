import 'package:flutter/material.dart';
import 'package:peliculas/src/models/models.dart';
import 'package:peliculas/src/widgets/casting_card.dart';

class DetailsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

   final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

   return Scaffold(
      body: CustomScrollView(//resive unos slivers que es como un column
        physics: BouncingScrollPhysics(),
        slivers: [ //es un widget que tienen cierto comportamiento preprogramado cuando se hace scroll en el contenido del padre
          _CustomAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie),
              _Overview(movie: movie),
              CastindCard(movieId: movie.id)
            ])
          )
        ],
      )
    );
  }

}

class _CustomAppBar extends StatelessWidget{
  final Movie movie;
  const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black26,
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: Text(movie.title,
            style: const TextStyle(
              fontSize: 16
            ),
            textAlign: TextAlign.center,
          )
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(movie.fulBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle({required this.movie});

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImg),
              height: 150,
            ),
          ),

          const SizedBox(width: 20),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style:textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text(movie.originalTitle, style:textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2),
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(movie.voteCount.toString(), style: textTheme.caption),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        child: Text(movie.overview,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}

