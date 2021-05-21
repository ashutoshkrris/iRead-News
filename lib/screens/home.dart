import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/components/article_tile.dart';
import 'package:news_app/components/category_tile.dart';
import 'package:news_app/utils/news_fetcher.dart';
import '../models/article_model.dart';
import '../utils/data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> categories = [];
  List<Article> articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = CategoryData.categoryList;
    getTopHeadlines();
  }

  getTopHeadlines() async {
    News newsObj = News();
    await newsObj.getHeadlines();
    articles = newsObj.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "iRead",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: _loading
          ? Center(child: Container(child: CircularProgressIndicator()))
          : buildBody(),
    );
  }

  SingleChildScrollView buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    imageUrl: categories[index]["imageURL"].toString(),
                    categoryName: categories[index]["name"].toString(),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              child: ListView.builder(
                itemCount: articles.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ArticleTile(
                    imageUrl: articles[index].urlToImage,
                    title: articles[index].title,
                    desc: articles[index].description,
                    url: articles[index].articleUrl,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
