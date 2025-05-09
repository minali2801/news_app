import 'package:flutter/material.dart';
import 'package:news_app/providers/bookmarks_provider.dart';
import 'package:news_app/screens/articleweb_view_page.dart';
import 'package:news_app/screens/login_page.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import 'package:intl/intl.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  String formatDate(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      return DateFormat('dd MMMM, yyyy').format(dateTime); // 16 April, 2025
    } catch (e) {
      return 'Invalid Date';
    }
  }

  // Function to refresh the news list when pull-to-refresh is triggered
  Future<void> _refreshNews() async {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    await newsProvider.fetchNews();
    // After news is fetched, update bookmarks with current articles
    Provider.of<BookmarksProvider>(
      context,
      listen: false,
    ).setAvailableArticles(newsProvider.newsArticles);
  }

  @override
  void initState() {
    super.initState();

       // Safe way to call Provider inside initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
       // Fetch news data initially
      Provider.of<NewsProvider>(context, listen: false).fetchNews().then((_) {
      // After news is fetched, update bookmarks with current articles
        Provider.of<BookmarksProvider>(
          context,
          listen: false,
        ).setAvailableArticles(
          Provider.of<NewsProvider>(context, listen: false).newsArticles,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final bookProvider = Provider.of<BookmarksProvider>(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshNews, 
        child:
            newsProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : newsProvider.errorMessage != null
                ? Center(child: Text(newsProvider.errorMessage!))
                : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: newsProvider.newsArticles.length,
                  itemBuilder: (context, index) {
                    final article = newsProvider.newsArticles[index];
                    

                    return Card(
                      margin: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      ArticleWebViewPage(url: article.url),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                article.urlToImage.isNotEmpty
                                    ? article.urlToImage
                                    : 'https://via.placeholder.com/150',
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => Container(
                                      height: 200,
                                      color: Colors.grey[300],
                                      child: Icon(Icons.broken_image),
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    article.description,
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Source: ${article.sourceName}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          formatDate(article.publishedDate),
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Icon(
                                        bookProvider.isBookmarked(article)
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                      ),
                                      onPressed: () {
                                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                        bookProvider.toggleBookmark(article);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
