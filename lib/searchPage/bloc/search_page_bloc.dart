import 'dart:async';
import 'dart:convert' as convert;

import 'package:bloc/bloc.dart';
import 'package:book_library/repositories/fetch_books_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  SearchPageBloc() : super(SearchPageInitial()) {
    on<SearchBookEvent>(_GetBooks);
  }

  FutureOr<void> _GetBooks(SearchBookEvent event, emit) async {

    emit(BooksLoading());
    
    http.Response response = await FetchBooksRepositories.getBooks(event.title);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['totalItems'];
      List<Map<String, String>> list = parseResponse(jsonResponse);
      if (itemCount == 0) {
        emit(BooksError(error: SearchPageError.notFound));
      } else {
        emit(BooksLoaded(bookList: list));
      }
      ;
    } else {
      emit(BooksError(error: SearchPageError.noInternet));
    }
  }

  List<Map<String, String>> parseResponse(Map<String, dynamic> raw) {
    List<Map<String, String>> list = [];
    String holder;
    var itemCount = raw['totalItems'];
    for (int iter = 0; iter < itemCount && iter < 10; iter++) {
      Map<String, String> tmp = {};
      try {
        holder = raw["items"][iter]["volumeInfo"]["imageLinks"]["thumbnail"];
        tmp["image"] = (holder.isEmpty)
            ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/495px-No-Image-Placeholder.svg.png?20200912122019"
            : holder;
      } catch (error) {
        print(error);
        tmp["image"] =
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/495px-No-Image-Placeholder.svg.png?20200912122019";
      }
      try {
        holder = raw["items"][iter]["volumeInfo"]["title"];
        tmp["title"] = (holder.isEmpty) ? "no Title" : holder;
      } catch (error) {
        tmp["title"] = "no Title";
      }
      try {
        holder = raw["items"][iter]["volumeInfo"]["publishedDate"];
        tmp["date"] = (holder.isEmpty) ? "no published Date" : holder;
      } catch (error) {
        tmp["date"] = "no published Date";
      }
      try {
        holder = raw["items"][iter]["volumeInfo"]["description"];
        tmp["description"] = (holder.isEmpty) ? "----" : holder;
      } catch (error) {
        tmp["description"] = "----";
      }
      try {
        holder = "${raw['items'][iter]['volumeInfo']['pageCount']}";
        tmp["pageCount"] = (holder.isEmpty) ? "no pages" : holder;
      } catch (error) {
        tmp["pageCount"] = "no pages asdf";
      }
      
      list.add(tmp);
    }
    return list;
  }
}
