import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/models/SourceResponse.dart';

class ApiManager{
  static Future<SourceResponse> getSources()async{
    Uri url=Uri.https("newsapi.org","/v2/top-headlines/sources",{"apiKey":"1a86229d4d5e448787eaa74230eb8462"});
     http.Response response= await http.get(url);
     var jsonData=jsonDecode(response.body);
     SourceResponse sourceResponse =SourceResponse.fromJson(jsonData);
     return sourceResponse;
  }
}