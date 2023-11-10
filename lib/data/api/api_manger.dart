import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app/model/sources_response.dart';

abstract class ApiManger {
  static const String baseUrl = "newsapi.org";
  static const String apiKey = "236686adfb2647ac85458193848a56ed";
  static const String sourcseEndPoint = "/v2/top-headlines/sources";

  static Future<List<Source>> getSources() async {
    Uri url = Uri.parse("https://${baseUrl}$sourcseEndPoint?apiKey=$apiKey");
    Response response = await get(url);
    Map json = jsonDecode(response.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        sourcesResponse.sources?.isNotEmpty == true) {
      return sourcesResponse.sources!;
    }
    throw Exception(sourcesResponse.message);
  }

  static getArticles() {}
}
