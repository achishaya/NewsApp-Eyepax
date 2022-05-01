import 'package:flutter/material.dart';

import 'article_view.dart';

class NewsPage extends StatefulWidget {

  final String imgUrl, title, desc, content, postUrl;
  NewsPage({@required this.imgUrl, @required this.title, @required this.desc, @required this.content, @required this.postUrl});

  @override
  _NewsPageState createState() => _NewsPageState(imgUrl: imgUrl, title: title, desc: desc, content: content, postUrl: postUrl);
}

class _NewsPageState extends State<NewsPage> {
  final String imgUrl, title, desc, content, postUrl;
  _NewsPageState({@required this.imgUrl, @required this.title, @required this.desc, @required this.content, @required this.postUrl});
  @override
  Widget build(BuildContext context) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    print(content);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: _height,
            width: _width,
            child: Stack(
              children: [
                Container(
                  height: 350,
                  width: _width,
                  child: Image.network(imgUrl, fit: BoxFit.cover,),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 350,
                  width: _width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black26
                  ),),
                Positioned(
                  top: 300,
                  child: Container(
                    height: _height-300,
                    width: _width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50),),
                      color: Colors.white
                    ),
                    padding: EdgeInsets.only(top: 90, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(desc, style: TextStyle(fontSize: 18),),
                        SizedBox(height: 10,),
                        Text(content, style: TextStyle(fontSize: 18),),
                        SizedBox(height: 10,),
                        Row(children: [
                          Container(child: Text('Read More : ')),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ArticleView(
                                    postUrl: postUrl,
                                  )
                              ));
                            },
                            child: Container(
                              width: _width-118,
                                child: Text(
                                  postUrl,
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.blue),
                                )
                            ),
                          )
                        ],),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 225,
              left: 50,
              height: 150,
              width: _width - 100,
              child: Card(
                color: Colors.white.withOpacity(0.5),
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Center(child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                ),
              )
          )
        ],
      ),
    );
  }
}
