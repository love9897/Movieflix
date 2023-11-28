import 'dart:convert';

import 'package:netflix_copy/others/data_model.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

class SearchScreenState {
  final List<Movie> searchResults;

  SearchScreenState({required this.searchResults});

  SearchScreenState.initial() : searchResults = [];

  SearchScreenState copyWith({List<Movie>? searchResults}) {
    return SearchScreenState(
      searchResults: searchResults ?? this.searchResults,
    );
  }
}

abstract class SearchScreenEvent {}

class SearchScreenTextChanged extends SearchScreenEvent {
  final String searchText;

  SearchScreenTextChanged({required this.searchText});
}

class SearchScreenResultsUpdated extends SearchScreenEvent {
  final List<Movie> results;

  SearchScreenResultsUpdated({required this.results});
}

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  SearchScreenBloc() : super(SearchScreenState.initial()) {
    on<SearchScreenTextChanged>(_onSearchScreenTextChanged);
  }
  void _onSearchScreenTextChanged(
      SearchScreenTextChanged event, Emitter<SearchScreenState> emit) async {
    final results = await searchData(event.searchText);
    emit(state.copyWith(searchResults: results));
  }

  Stream<SearchScreenState> mapEventToState(SearchScreenEvent event) async* {
    if (event is SearchScreenTextChanged) {
      final results = await searchData(event.searchText);
      yield state.copyWith(searchResults: results);
    }
  }

  Future<List<Movie>> searchData(String searchText) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$searchText'));
    if (response.statusCode == 200) {
      final shows = jsonDecode(response.body.toString());
      List<Movie> searchList = [];
      for (Map<String, dynamic> index in shows) {
        searchList.add(Movie.fromJson(index));
      }
      return searchList;
    } else {
      throw Exception('Failed to load Movie');
    }
  }
}
