import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants/app_constants.dart';
import 'package:movies_app/views/widgets/custom_text.dart';

import '../../../bloc/moive_genre_bloc.dart';
import '../../../repo/movie_repo.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MovieGenreBloc(movieRepository: MovieRepository())
          ..add(FetchMoviesGenre()),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
            automaticallyImplyLeading: false,
            elevation: 1,
            shadowColor: AppColors.grayishWhite,
            leadingWidth: 200,
            title: TextField(
              decoration: InputDecoration(
                fillColor: AppColors.grey,
                suffixIcon: Icon(Icons.close),
                hintText: "TV shows, movies and more",
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                prefixIcon: Icon(CupertinoIcons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: BlocBuilder<MovieGenreBloc, MovieGenreState>(
            builder: (context, state) {
              if (state is MovieGenreLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MovieGenreLoaded) {
                final movies = state.genre;
                return ListView(
                  children: [
                    Wrap(
                        children: movies
                            .map(
                              (movie) => MovieCard(
                                  url: movie.image, title: movie.name),
                            )
                            .toList())
                  ],
                );
              } else if (state is MovieError) {
                return Center(child: Text('Error: ${state.error}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}

class MovieCard extends StatelessWidget {
  final String url;
  final String title;
  const MovieCard({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 90,
      width: 160,
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(left: 12, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              image: NetworkImage(AppConst.imageUrl + url), fit: BoxFit.fill)),
      child: CustomText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.white),
    );
  }
}
