import 'package:bloc/bloc.dart';
import 'package:movies_app/models/genre_model.dart';

import '../repo/movie_repo.dart';

abstract class MovieGenreEvent {}

class FetchMoviesGenre extends MovieGenreEvent {}

abstract class MovieGenreState {}

class MovieGenreInitial extends MovieGenreState {}

class MovieGenreLoading extends MovieGenreState {}

class MovieGenreLoaded extends MovieGenreState {
  final List<GenreModel> genre;
  MovieGenreLoaded({required this.genre});
}

class MovieError extends MovieGenreState {
  final String error;
  MovieError({required this.error});
}

class MovieGenreBloc extends Bloc<MovieGenreEvent, MovieGenreState> {
  final MovieRepository movieRepository;

  MovieGenreBloc({required this.movieRepository}) : super(MovieGenreInitial()) {
    on<FetchMoviesGenre>((event, emit) async {
      emit(MovieGenreLoading());
      try {
        final movies = await movieRepository.fetchGenre();
        emit(MovieGenreLoaded(genre: movies));
      } catch (e) {
        emit(MovieError(error: e.toString()));
      }
    });
  }
}
