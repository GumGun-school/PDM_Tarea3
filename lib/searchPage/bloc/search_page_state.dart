part of 'search_page_bloc.dart';

enum SearchPageError{
  notFound,
  noInternet
}

abstract class SearchPageState extends Equatable {
  const SearchPageState();
  
  @override
  List<Object> get props => [];
}

class SearchPageInitial extends SearchPageState {}

class BooksLoading extends SearchPageState {}

class BooksLoaded extends SearchPageState {
  final List<Map<String,String>> bookList;

  BooksLoaded({required this.bookList});
  @override
  List<Object> get props => [bookList];
}

class BooksError extends SearchPageState {
  final SearchPageError error;

  BooksError({required this.error});
  @override
  List<Object> get props => [error];
}




