import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app_api/helper/data.dart';
import 'package:news_app_api/helper/widgets.dart';
import 'package:news_app_api/models/article.dart';
import 'package:news_app_api/models/categorie_model.dart';
import 'package:news_app_api/views/SplashScreen.dart';
import 'package:news_app_api/views/categorie_news.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/news.dart';
import 'news_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _loading;
  var newslist;
  var topNewsList;
  var newsTitle = [];
  String title;
  SharedPreferences sharedPreferences;

  List<CategorieModel> categories = List<CategorieModel>();

  Future<void> getValues() async{
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    _loading = true;
    getValues();
    setState(() {

    });
    super.initState();
    categories = getCategories();
    getNews();
  }

  void getNews() async {
    News news = News();
    await news.getNews();
    await news.getTopNews();
    newslist = news.news;
    topNewsList = news.topNews;
    for (int i = 0; i < newslist.length; i++) {
      newsTitle.add(newslist[i].title);
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: (){
              sharedPreferences.setString('loggedUser', 'false');
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => SplashScreen()));
            },
            child: Container(
                padding: EdgeInsets.only(right: 30),
                child: Icon(Icons.person, color: Colors.blueGrey,)
            ),
          )
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 2, top: 5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blueGrey),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: SearchField(
                        suggestions: newsTitle.cast<String>(),
                        searchInputDecoration: InputDecoration(
                          hintText: 'Search',
                          suffixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                        itemHeight: 60,
                        onTap: (value){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => NewsPage(
                                imgUrl: newslist[newsTitle.indexOf(value)].urlToImage,
                                title: value,
                                desc: newslist[newsTitle.indexOf(value)].description,
                                content: newslist[newsTitle.indexOf(value)].content,
                                postUrl: newslist[newsTitle.indexOf(value)].articleUrl,
                              )
                          ));
                        },
                      ),
                    ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Container(
                              width: 70,
                              margin: EdgeInsets.only(left: 10, right: 2, bottom: 2),
                              padding: EdgeInsets.only(left: 5),
                              child: Text('Top News', style: TextStyle(color: Colors.blueGrey),)
                          ),
                          Container(
                            height: 1,
                              margin: EdgeInsets.only(bottom: 0),
                              width: MediaQuery.of(context).size.width - 90,
                              color: Colors.blueGrey
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 120,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: topNewsList.length,
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              return NewsTileTopHeadLines(
                                imgUrl: topNewsList[index].urlToImage ?? "",
                                title: topNewsList[index].title ?? "",
                                desc: topNewsList[index].description ?? "",
                                content: topNewsList[index].content ?? "",
                                posturl: topNewsList[index].articleUrl ?? "",
                              );
                            }),
                      ),
                      Container(
                          height: 1,
                          margin: EdgeInsets.only(bottom: 6, top: 6),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.blueGrey
                      ),
                      /// Categories
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 65,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                imageAssetUrl: categories[index].imageAssetUrl,
                                categoryName: categories[index].categorieName,
                              );
                            }),
                      ),
                      /// News Article
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        width: MediaQuery.of(context).size.width - 40,
                        child: ListView.builder(
                            itemCount: newslist.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return NewsTile(
                                imgUrl: newslist[index].urlToImage ?? "",
                                title: newslist[index].title ?? "",
                                desc: newslist[index].description ?? "",
                                content: newslist[index].content ?? "",
                                posturl: newslist[index].articleUrl ?? "",
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            newsCategory: categoryName.toLowerCase(),
          )
        ));
      },
      child: Card(
        elevation: 4,
//        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                color: Colors.black26
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
