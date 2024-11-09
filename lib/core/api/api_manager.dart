import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiManager {
  static ApiManager? _instance;
  static ApiManager get instance {
    return _instance ??= ApiManager();
  }
  getData(
      String url) async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    var json = jsonDecode(response.body);
    return json;
  }
}
