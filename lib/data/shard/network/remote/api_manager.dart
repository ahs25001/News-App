import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/SourceResponse.dart';
import '../../../models/newsResponse.dart';

class ApiManager {
  Future<SourceResponse> getSources(String category) async {
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

  Future<NewsResponse> getNews(
      {required String source,
      required bool inSearch,
      required String? searchTitle,
      required int pageNumber,
      required String language}) async {
    if (!inSearch) {
      Uri url = Uri.parse(
          "https://newsapi.org/v2/everything?apiKey=1a86229d4d5e448787eaa74230eb8462&language=$language&sources=$source&pageSize=10&page=$pageNumber");
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
