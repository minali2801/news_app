import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';

class BookmarksProvider with ChangeNotifier {
  List<Article> _bookmarkedArticles = [];
  List<String> _bookmarkedUrls = [];

  List<Article> get bookmarkedArticles => _bookmarkedArticles;

  BookmarksProvider() {
    _loadBookmarks();
  }

  void toggleBookmark(Article article) async {
    if (_bookmarkedUrls.contains(article.url)) {
      _bookmarkedArticles.removeWhere((a) => a.url == article.url);
      _bookmarkedUrls.remove(article.url);
    } else {
      _bookmarkedArticles.add(article);
      _bookmarkedUrls.add(article.url);
    }
    await _saveBookmarks();
    notifyListeners();
  }

  bool isBookmarked(Article article) {
    return _bookmarkedUrls.contains(article.url);
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('bookmarkedUrls', _bookmarkedUrls);
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    _bookmarkedUrls = prefs.getStringList('bookmarkedUrls') ?? [];
    // You must refetch full article data from your API to rebuild _bookmarkedArticles
    notifyListeners();
  }

  // Call this after fetching news
  void setAvailableArticles(List<Article> allArticles) {
    _bookmarkedArticles = allArticles
        .where((article) => _bookmarkedUrls.contains(article.url))
        .toList();
    notifyListeners();
  }
}
