import 'package:flutter/material.dart';
import 'package:news_app/services/api_services.dart';

import '../models/article.dart';

class NewsProvider  with ChangeNotifier{
  List<Article> _newsArticles = [];
  bool _isLoading = false;
  String? _errorMessage;
  final ApiServices _apiServices = ApiServices();
  List<Article> get newsArticles => _newsArticles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Future<void> fetchNews() async{
    _isLoading=true;
    notifyListeners();
    try{
      _newsArticles = await _apiServices.fetchNews();
      _errorMessage = null;
    } catch (error){
      _errorMessage = 'Somthing went wrong $error';
    }
    _isLoading = false;
    notifyListeners();
  }
}