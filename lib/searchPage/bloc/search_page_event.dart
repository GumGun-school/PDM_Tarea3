part of 'search_page_bloc.dart';

abstract class SearchPageEvent extends Equatable {
  const SearchPageEvent();

  @override
  List<Object> get props => [];
}


class SearchBookEvent extends SearchPageEvent {
  final String title;

  SearchBookEvent({
    required this.title,
  });

  @override
  List<Object> get props => [title];
}


class ClickOnMovieEvent extends SearchPageEvent {
  final int index;

  ClickOnMovieEvent({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}


