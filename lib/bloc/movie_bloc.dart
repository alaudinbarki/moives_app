import 'package:bloc/bloc.dart';
import 'package:movies_app/models/movie_data_model.dart';

import '../repo/movie_repo.dart';

abstract class MovieEvent {}

class FetchMovies extends MovieEvent {}

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<MoiveData> movies;
  MovieLoaded({required this.movies});
}

class MovieError extends MovieState {
  final String error;
  MovieError({required this.error});
}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await movieRepository.getUpcomingMovies();
        emit(MovieLoaded(movies: movies));
      } catch (e) {
        emit(MovieError(error: e.toString()));
      }
    });
  }
}
