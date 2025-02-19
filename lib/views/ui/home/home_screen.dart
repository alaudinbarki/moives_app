import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants/app_constants.dart';
import 'package:movies_app/views/widgets/custom_text.dart';

import '../../../bloc/movie_bloc.dart';
import '../../../repo/movie_repo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            MovieBloc(movieRepository: MovieRepository())..add(FetchMovies()),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
            automaticallyImplyLeading: false,
            elevation: 1,
            shadowColor: AppColors.grayishWhite,
            leadingWidth: 200,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: CustomText(
                text: "Watch",
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(CupertinoIcons.search),
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MovieLoaded) {
                final movies = state.movies;
                return Column(
                  children: [
                    Expanded(
                      child: ColoredBox(
                        color: AppColors.grayishWhite,
                        child: ListView.builder(
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return MovieCard(
                                url: movie.posterPath, title: movie.title);
                          },
                        ),
                      ),
                    ),
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
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      height: 200,
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
