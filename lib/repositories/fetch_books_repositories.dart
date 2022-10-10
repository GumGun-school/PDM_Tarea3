import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class FetchBooksRepositories{

  static Future<http.Response> getBooks(String title) async {
    
    var url = Uri.https(
      'www.googleapis.com',
      '/books/v1/volumes',
      {'q': '${title}'},
    );
    
    return await http.get(url);
  }
}