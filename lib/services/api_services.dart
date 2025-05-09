import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app/models/article.dart';

class ApiServices {
  Future<List<Article>> fetchNews() async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=84e7977b5b114fc992a7750350d02e5c'));
    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body)['articles'];
    return data.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }

  } 
  }


