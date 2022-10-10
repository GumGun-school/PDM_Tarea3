import 'dart:ffi';

import 'package:book_library/searchPage/book_entry.dart';
import 'package:book_library/searchPage/shimer_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'bloc/search_page_bloc.dart';

class SearchPage extends StatelessWidget {
  SearchPage({
    Key? key,
  }) : super(key: key);
  final String image =
      "https://i.pinimg.com/originals/78/a5/da/78a5dac5e6b17cc75722b30c9bfa6df9.png";
  final String title = "title";

  var _txtBook = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchPageBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Libreria free to play'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<SearchPageBloc, SearchPageState>(
            listener: (context, state) => {},
            builder: (context, state) {
              if (state is SearchPageInitial) {
                return _defaultView(context);
              } else if (state is BooksLoading) {
                return _Loading(context);
              } else if (state is BooksError) {
                if (state.error == SearchPageError.notFound) {
                  return _PlainMessage(context, "not Found");
                } else {
                  return _PlainMessage(context, "no internet");
                }
              } else if (state is BooksLoaded) {
                return _serchedBooks(
                    context, state.bookList, state.bookList.length);
              } else {
                /*
                  to change
                */
                return _defaultView(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _TextField(BuildContext context) {
    return TextField(
      controller: _txtBook,
      keyboardType: TextInputType.url,
      decoration: InputDecoration(
        labelText: "Ingresa Titulo",
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            print(_txtBook.text);
            _textFieldBlocCall(context, _txtBook.text);
          },
          icon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _defaultView(BuildContext context) {
    return Column(
      children: [
        _TextField(context),
        Spacer(),
        Center(
          child: Text(
            "Enter word to search movie",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget _serchedBooks(
      BuildContext context, List<Map<String, String>> bookList, int size) {
    print(bookList);
    return Column(
      children: [
        _TextField(context),
        Expanded(
          child: GridView.builder(
            itemCount: size,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 40.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return BookEntry(
                element: bookList[index],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _Loading(BuildContext context) {
    return Column(
      children: [
        _TextField(context),
        Expanded(
          child: GridView.builder(
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 40.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: ShimmerEntry(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _PlainMessage(BuildContext context, String plainMessage) {
    return Column(
      children: [
        _TextField(context),
        Center(
          child: Text(plainMessage),
        )
      ],
    );
  }

  void _textFieldBlocCall(BuildContext context, String title) {
    BlocProvider.of<SearchPageBloc>(context).add(
      SearchBookEvent(title: title),
    );
  }
}
