import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app/model/articles_response.dart';
import 'package:news_app/model/sources_response.dart' as source;

import '../../model/sources_response.dart';

abstract class ApiManger {
  static const String baseUrl = "newsapi.org";
  static const String apiKey = "236686adfb2647ac85458193848a56ed";
  static const String sourcseEndPoint = "/v2/top-headlines/sources";
  static const String articlesEndPoint = "/v2/everything";

  static Future<List<source.Source>> getSources(String category) async {
    Uri url = Uri.parse(
        "https://${baseUrl}$sourcseEndPoint?apiKey=$apiKey&category=$category");
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

  static Future<List<Article>> getArticles(String sourceId) async {
    Uri url = Uri.https(
        baseUrl, articlesEndPoint, {"apiKey": apiKey, "sources": sourceId});
    var serverResponse = await get(url);
    Map json = jsonDecode(serverResponse.body);
    ArticlesResponse articlesResponse = ArticlesResponse.fromJson(json);
    if (serverResponse.statusCode >= 200 &&
        serverResponse.statusCode < 300 &&
        articlesResponse.articles?.isNotEmpty == true) {
      return articlesResponse.articles!;
    }
    throw Exception("SomeThing went wrong , Please try again later");
  }
}
