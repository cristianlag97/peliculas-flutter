import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);
    //print(moviesProvider.onDisplayMovies);

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.search)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            CardSwiper(movies: moviesProvider.onDisplayMovies),
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populares',
              onNextPage: () => moviesProvider.getPopularMovies(),
            )

          ],
        ),
      )
    );
  }

}