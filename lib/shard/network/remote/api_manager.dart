import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/models/SourceResponse.dart';
import 'package:news/models/newsResponse.dart';

class ApiManager {
  static Future<SourceResponse> getSources(String category) async {
    Uri url = Uri.https(
      "newsapi.org",
      "/v2/top-headlines/sources",
      {"apiKey": "1a86229d4d5e448787eaa74230eb8462", "category": category},
    );
    http.Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    SourceResponse sourceResponse = SourceResponse.fromJson(jsonData);
    return sourceResponse;
  }

  static Future<NewsResponse> getNews(
      {required String source, required bool inSearch, required String? searchTitle}) async {
    if (!inSearch) {
      Uri url = Uri.parse(
          "https://newsapi.org/v2/everything?apiKey=1a86229d4d5e448787eaa74230eb8462&sources=$source");
      http.Response response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      NewsResponse newsResponse = NewsResponse.fromJson(jsonData);
      return newsResponse;
    } else {
      Uri url = Uri.parse(
          "https://newsapi.org/v2/everything?q=$searchTitle&apiKey=1a86229d4d5e448787eaa74230eb8462&sources=$source");
      http.Response response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      NewsResponse newsResponse = NewsResponse.fromJson(jsonData);
      return newsResponse;
    }
  }
}
